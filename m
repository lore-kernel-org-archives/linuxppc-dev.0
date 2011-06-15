Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7095AB6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 14:31:44 +1000 (EST)
Message-ID: <4DF83577.6040903@zytor.com>
Date: Tue, 14 Jun 2011 21:30:47 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
References: <20110614190850.GA13526@linux-mips.org>
	<4DF7C3CA.9050902@zytor.com> <201106142333.16203.arnd@arndb.de>
In-Reply-To: <201106142333.16203.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Chen Liqin <liqin.chen@sunplusct.com>,
	Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
	Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Lennox Wu <lennox.wu@gmail.com>, linux-arch@vger.kernel.org,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Russell King <linux@arm.linux.org.uk>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Helge Deller <deller@gmx.de>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
	microblaze-uclinux@itee.uq.edu.au, Chris Metcalf <cmetcalf@tilera.com>,
	Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
	Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>,
	Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/14/2011 02:33 PM, Arnd Bergmann wrote:
>>
>> Why on earth restrict it like that?  It's just a device driver, like
>> more or less any other device driver...
> 
> I'd say any other classic ISA/PC driver, including floppy, gameport or
> serial-8250. One problem with these is that we never fully worked out
> the dependencies for these, which we probably should. CONFIG_ISA
> generally means ISA add-on cards, but that might not be enabled for
> platforms that have a pc-parport but no ISA slots.
> 

OK, serial-8250 is clearly just plain wrong, since the 8250 series UARTs
are ubiquitous across just about every platform.

Floppy is special (in the short bus sense), since it is closely tied to
ISA DMA.  Conditionalizing this on ISA DMA makes total sense.

Parallel port is an intermediate case... Centronics parallel ports
predate the PC ecosystem by quite a bit, and the particular arrangement
of ports became popular with the PC and spread to other platforms, but
the particular variant of it known as ECP (as opposed to EPP) is ISA DMA
specific.

> On the other hand, you have embedded platforms that currently build support
> for parport-pc but define the inb/outb macros to plain pointer dereferences
> (otherwise you can't build the 8250 driver). Loading parport-pc on those
> machines typically results in derefencing user memory in the best case.
>
> What I'd love to see is a configuration option for "arch has working
> PC-style inb/outb instructions", so we can build a kernel without them but
> still get MMIO based drivers for PCI-less platforms.

Now, isn't that was iowrite/ioread was designed for?

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
