Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id D1C9BB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Jun 2011 06:24:02 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC,PATCH] Cleanup PC parallel port Kconfig
Date: Tue, 14 Jun 2011 22:22:43 +0200
References: <20110614190850.GA13526@linux-mips.org>
In-Reply-To: <20110614190850.GA13526@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106142222.43553.arnd@arndb.de>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
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
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 14 June 2011 21:08:50 Ralf Baechle wrote:

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9adc278..2968751f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -21,6 +21,7 @@ config ARM
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
>  	select HAVE_IRQ_WORK
> +	select HAVE_PC_PARPORT
>  	select HAVE_PERF_EVENTS
>  	select PERF_USE_VMALLOC
>  	select HAVE_REGS_AND_STACK_ACCESS_API

On arm that should only be set on a couple of subarchitectures, but
we can fan that out after your patch goes in, just like you do for Mips

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2729c66..b8328df 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -128,6 +128,7 @@ config PPC
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS && PPC_BOOK3S_64
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select HAVE_SPARSE_IRQ
>  	select IRQ_PER_CPU
>  	select GENERIC_IRQ_SHOW

Similar to ARM and Mips.

> index e446bab..ceac9b5 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -15,6 +15,7 @@ config MICROBLAZE
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  

Highly unlikely, except through PCI.

> diff --git a/arch/score/Kconfig b/arch/score/Kconfig
> index 288add8..ba078d0 100644
> --- a/arch/score/Kconfig
> +++ b/arch/score/Kconfig
> @@ -1,9 +1,10 @@
>  menu "Machine selection"
>  
>  config SCORE
> -       def_bool y
> -       select HAVE_GENERIC_HARDIRQS
> -       select GENERIC_IRQ_SHOW
> +	def_bool y
> +	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
> +	select GENERIC_IRQ_SHOW
>  
>  choice
>  	prompt "System type"

Certainly not, no PIO support

> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 0249b8b..3e96eff 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -8,6 +8,7 @@ config TILE
>  	select USE_GENERIC_SMP_HELPERS
>  	select CC_OPTIMIZE_FOR_SIZE
>  	select HAVE_GENERIC_HARDIRQS
> +	select HAVE_PC_PARPORT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_PENDING_IRQ if SMP
>  	select GENERIC_IRQ_SHOW

Only through PCI

> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index e57dcce..3832e7e 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -8,6 +8,7 @@ config UNICORE32
>  	select HAVE_KERNEL_BZIP2
>  	select HAVE_KERNEL_LZO
>  	select HAVE_KERNEL_LZMA
> +	select HAVE_PC_PARPORT
>  	select GENERIC_FIND_FIRST_BIT
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW

Probably not.

I think you can leave these four out right away, provided you add
the section below:

> --- a/drivers/parport/Kconfig
> +++ b/drivers/parport/Kconfig
> @@ -35,8 +35,7 @@ if PARPORT
> 
>  config PARPORT_PC
>  
>         tristate "PC-style hardware"
> 
> -       depends on (!SPARC64 || PCI) && !SPARC32 && !M32R && !FRV && \
> -               (!M68K || ISA) && !MN10300 && !AVR32 && !BLACKFIN
> +       depends on HAVE_PC_PARPORT
> 
>         ---help---
>         
>           You should say Y here if you have a PC-style parallel port. All
>           IBM PC compatible computers and some Alphas have PC-style
> 
> @@ -48,6 +47,9 @@ config PARPORT_PC
> 
>           If unsure, say Y.
> 
> +config HAVE_PC_PARPORT
> +       bool
> +

As you write, anything that has PCI can theoretically take parallel ports,
so I would always list PCI here as a way to get it anyway. Probably also
ISA and PCMCIA. How about adding this?

config HAVE_PC_PARPORT
	bool
	default (PCI || ISA || PCMCIA)

	Arnd
