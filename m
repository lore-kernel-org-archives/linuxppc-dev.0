Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1DF3567D18
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 08:02:07 +1100 (EST)
Date: Tue, 7 Nov 2006 14:02:02 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Russell King <rmk-pci@arm.linux.org.uk>
Subject: Re: [RFC/PATCH 4/7] Powerpc MSI implementation
Message-ID: <20061107210202.GA27140@parisc-linux.org>
References: <1162884080.585336.70559261997.qpush@cradle>
	<20061107072125.68E9F67CA7@ozlabs.org>
	<20061107200730.GY27140@parisc-linux.org>
	<20061107201436.GE9533@flint.arm.linux.org.uk>
	<20061107204432.GZ27140@parisc-linux.org>
	<20061107204853.GF9533@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061107204853.GF9533@flint.arm.linux.org.uk>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	"Eric W.Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 07, 2006 at 08:48:53PM +0000, Russell King wrote:
> On Tue, Nov 07, 2006 at 01:44:32PM -0700, Matthew Wilcox wrote:
> > On Tue, Nov 07, 2006 at 08:14:36PM +0000, Russell King wrote:
> > > Bah.  chip_data is supposed to be __iomem.  I bet if you build ARM
> > > with sparse it'll kick out lots of warnings as a result of that loss.
> > 
> > Erm, since when?  When I introduced it (back in January 2005 [1]), it
> > was called handler_data and pointed to a struct which is chip-type
> > dependent.
> 
> Since before the generic irq merge.  If I was more expert with git
> I'd post a URL, but I'm not so I won't.  But I'm sure you can find
> it - look at the history of include/asm-arm/mach/irq.h.

OK.  Looks like the first mention of this is in 
4a2581a080098ca3a0c4e416d7a282e96c75ebf8 from July 2006
which is signed-off by you, Ingo Molnar and Thomas Gleixner:

-       void __iomem    *base;
[...]
+#define set_irq_chipdata(irq, d)       set_irq_chip_data(irq, d)
+#define get_irq_chipdata(irq)          get_irq_chip_data(irq)
-#define set_irq_chipdata(irq,d)                        do { irq_desc[irq].base = d; } while (0)
-#define get_irq_chipdata(irq)                  (irq_desc[irq].base)

Now, true, the __iomem has disappeared.  But there was never an __iomem
on chip_data, nor on the handler_data before it.  It went away back in
July when you signed off on the conversion to use the generic irq
handler, and apparently haven't noticed the problem since then, so I
don't see it as being a big problem.

As other architectures, you could embed the iomem pointer in a
struct (would it be useful to you to have more than an iomem pointer
in your handlers?), or you could put the cast adding __iomem in
get_irq_chipdata().
