Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E0F0BDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 01:40:42 +1100 (EST)
Date: Fri, 13 Feb 2009 17:40:39 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: [PATCH 02/11] sdhci: Add support for bus-specific IO memory
	accessors
Message-ID: <20090213144039.GA19572@oksana.dev.rtsoft.ru>
References: <20090206180520.GA16123@oksana.dev.rtsoft.ru>
	<20090206180645.GB11548@oksana.dev.rtsoft.ru>
	<20090208215020.46ca5724@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090208215020.46ca5724@mjolnir.drzeus.cx>
Cc: Ben Dooks <ben-linux@fluff.org>, Arnd Bergmann <arnd@arndb.de>,
	Liu Dave <DaveLiu@freescale.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sdhci-devel@list.drzeus.cx
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 08, 2009 at 09:50:20PM +0100, Pierre Ossman wrote:
> On Fri, 6 Feb 2009 21:06:45 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > Currently the SDHCI driver works with PCI accessors (write{l,b,w} and
> > read{l,b,w}).
> > 
> > With this patch drivers may change memory accessors, so that we can
> > support hosts with "weird" IO memory access requirments.
> > 
> > For example, in "FSL eSDHC" SDHCI hardware all registers are 32 bit
> > width, with big-endian addressing. That is, readb(0x2f) should turn
> > into readb(0x2c), and readw(0x2c) should be translated to
> > le16_to_cpu(readw(0x2e)).
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> I was hoping we wouldn't have to do a lot of magic in the accessors
> since the spec is rather clear on the register interface. :/
> 
> Let's see if I've understood this correctly.
> 
> 1. The CPU is big-endian but the register are little-endian (as the
> spec requires).

No, on eSDHC the registers are big-endian, 32-bit width, with, for
example, two 16-bit "logical" registers packed into it.

That is,

 0x4  0x5 0x6  0x7
|~~~~~~~~:~~~~~~~~|
| BLKCNT : BLKSZ  |
|________:________|
 31              0

( The register looks wrong, right? BLKSZ should be at 0x4. But imagine
  that you swapped bytes in this 32 bit register... then the registers
  and their byte addresses will look normal. )

So if we try to issue readw(SDHCI_BLOCK_SIZE), i.e. readw(0x4):

- We'll read BLKCNT, while we wanted BLKSZ. This is because the
  address bits should be translated before we try word or byte
  reads/writes.
- On powerpc read{l,w}() convert the read value from little-endian
  to big-endian byte order, which is wrong for our case (the
  register is big-endian already).

That means that we have to convert address, but we don't want to
convert the result of read/write ops.

> I was under the impression that the read*/write*
> accessor handled any endian conversion between the bus and the cpu? How
> do e.g. PCI work on Sparc?

read{l,w} are guaranteed to return values in CPU byte order, so
if CPU is in big-endian mode, then the PCI IO accessors should
convert values. And just as on PowerPC, Sparc's read*() accessors
swap bytes of a result:

static inline u32 __readl(const volatile void __iomem *addr)
{
        return flip_dword(*(__force volatile u32 *)addr);
}

#define readl(__addr)           __readl(__addr)

> 2. Register access must be done 32 bits at a time. Now this is just
> broken and might cause big problems as some registers cannot just be
> read and written back to.

We must only take special care when working with "triggering"
registers, and that's handled by the "sdhci: Add support for hosts
with strict 32 bit addressing" patch.

> OTOH you refer to readw() in your example,
> not readl(). What's the deal here?

readw() was just an example (most complicated one).

> > +static inline void sdhci_writel(struct sdhci_host *host, u32 val, int reg)
> > +{
> > +	host->writel(host, val, reg);
> > +}
> 
> Having to override these are worst case scenario

Hm. It's not a worst case scenario, it's a normal scenario for
eSDHC. Why should we treat eSDHC as a second-class citizen?

> as far as I'm
> concerned, so I'd prefer something like:
> 
> if (!host->ops->writel)
> 	writel(host->ioaddr + reg, val);
> else
> 	host->ops->writel(host, val, reg);

Hm.

-- What I purpose:

$ size drivers/mmc/host/sdhci.o
   text    data     bss     dec     hex filename
  15173       8       4   15185    3b51 drivers/mmc/host/sdhci.o

And there is a minimum run-time overhead (dereference + branch).

+ no first/second-class citizen separation.

-- What you purpose (inlined):

$ size drivers/mmc/host/sdhci.o
   text    data     bss     dec     hex filename
  17853       8       4   17865    45c9 drivers/mmc/host/sdhci.o

Runtime overhead: dereference + dereference + compare +
(maybe)branch + larger code.

-- What you purpose (uninlined):

$ size drivers/mmc/host/sdhci.o
   text    data     bss     dec     hex filename
  14692       8       4   14704    3970 drivers/mmc/host/sdhci.o

Better. But the runtime overhead: branch + dereference + dereference +
compare + (maybe)branch.


Surely the overhead isn't measurable... but why we purposely make
things worse?

Though, this is not something I'm going to argue about, I'll just
do it the way you prefer. ;-) For an updated patch set I took
the uninlined variant, hope this is OK.

Thanks for the review,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
