Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-20.bluehost.com (outbound-mail-20.bluehost.com
	[70.98.111.235]) by ozlabs.org (Postfix) with SMTP id 2117A688F8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 15:45:01 +1100 (EST)
Message-ID: <43BF4703.8080601@secretlab.ca>
Date: Fri, 06 Jan 2006 21:43:47 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Fwd: Re: RESEND:[RFC] Pico E12 (Xilinx V4) patches to 2.6.15]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[Trimmed & Resent; first one rejected by mailing list due to size]

David H. Lynch Jr. wrote:
> I could not figure out how to seek to the 2.6.14 tag so it is against
> HEAD/2.6.15
try cg-seek, but head is just fine.  :)

> 
> I am also presuming that git diff produces a unified diff. I do not try
> to read diffs - I typically do my diff/merges with vim, but it looks
> about right to me.
Your right; git uses unified by default.  You'll need to start reading
them.  If found *lots* of stuff in this patch that shouldn't be there.

> 
> There are basically 5 parts, and I have no idea how to easily separate
> the pieces:
Commit to your git tree frequently and commit related files at the same
time.  Then you can bring up a list of all your commits and coalate
related changes into a single patch.

BTW, many of the long lines were word wrapped (making an unusable
patch).  You should attach the diff instead of pasting it into thunderbird.

> diff --git a/README.pico b/README.pico
> new file mode 120000
> index 0000000..3daad5a
> --- /dev/null
> +++ b/README.pico
> @@ -0,0 +1 @@
> +pico/README.pico
> \ No newline at end of file
> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> index cc3f64c..7c4318a 100644
> --- a/arch/ppc/Kconfig
> +++ b/arch/ppc/Kconfig
> @@ -53,7 +53,7 @@ menu "Processor"
> 
>  choice
>  	prompt "Processor Type"
> -	default 6xx
> +	default 4xx
You don't want to do this... Your defconfig file should set it instead.

> diff --git a/arch/ppc/boot/common/misc-common.c
> b/arch/ppc/boot/common/misc-common.c
> index e79e6b3..a50762a 100644
> --- a/arch/ppc/boot/common/misc-common.c
> +++ b/arch/ppc/boot/common/misc-common.c

<--- snip --->

> @@ -271,6 +284,15 @@ void gunzip(void *dst, int dstlen, unsig
>  	*lenp = s.next_out - (unsigned char *) dst;
>  	zlib_inflateEnd(&s);
>  }
> +#if 0
> +void
> +puthexb(unsigned char val)
> +{
> +	char digits[] = "0123456789abcdef" ;
> +	putc(digits[(val/16) & 0x0F]);
> +	putc(digits[val & 0x0F]);
> +}
> +#endif

Why is this in your patch?  Keep debug hacks to yourself, especially
"#if 0" ones.  :)

> 
>  void
>  puthex(unsigned long val)
> @@ -488,8 +510,13 @@ _dump_buf_with_offset(unsigned char *p,
>  			{
>  				_printk("  ");
>  			}
> +#if defined(CONFIG_PICO_DEBUG)
> +// more readable dump
> +			 _printk(" ");
> +#else
>  			if ((i % 2) == 1) _printk(" ");
>  			if ((i % 8) == 7) _printk(" ");
> +#endif

ditto

> diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
> index f3e9c53..3094f1c 100644
> --- a/arch/ppc/boot/simple/Makefile
> +++ b/arch/ppc/boot/simple/Makefile
> @@ -188,6 +188,7 @@ OBJCOPY_ARGS			:= -O elf32-powerpc
>  boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
>  boot-$(CONFIG_REDWOOD_5)	+= embed_config.o
>  boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
> +boot-$(CONFIG_PICO_E12)		+= embed_config.o
>  boot-$(CONFIG_8xx)		+= embed_config.o
>  boot-$(CONFIG_8260)		+= embed_config.o
>  boot-$(CONFIG_BSEIP)		+= iic.o
> @@ -202,6 +203,16 @@ boot-$(CONFIG_8260)		+= m8260_tty.o
>  endif
>  boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
>  boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
> +boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o
> +boot-$(CONFIG_SERIAL_KEYHOLE_CONSOLE)	+= keyhole_tty.o
> +#ifdef CONFIG_XILINX_UARTLITE_CONSOLE
> +#LIBS				+= $(TOPDIR)/drivers/char/xilinx_uartlite/xuartlite_l.o
> +#endif
> +# ifeq ($(CONFIG_XILINX_ML300),y)
> +# CFLAGS_xuartlite_tty.o		+= -I$(TOPDIR)/drivers/char/xilinx_uartlite
> +# EXTRA_CFLAGS			+= -I$(TOPDIR)/arch/ppc/platforms/xilinx_ocp \
> +# 					-I$(TOPDIR)/drivers/i2c/xilinx_iic
> +# endif

Wrong place for this; should be done in:
drivers/char/xilinx_uartlite/Makefile

<--- snip --->

> diff --git a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
> index 5e4adc2..e432b64 100644
> --- a/arch/ppc/boot/simple/head.S
> +++ b/arch/ppc/boot/simple/head.S
> @@ -46,6 +46,46 @@ start:
>  #endif
> 
>  start_:
> +#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_PICO_E12) /* PPC
> errata 213: only for Virtex-4 */
> +	mfccr0	0
> +	oris	0,0,0x50000000@h
> +	mtccr0	0
> +#endif

ML300 doesn't have this issue.

<--- snip --->

> diff --git a/arch/ppc/boot/simple/keyhole_tty.c
> b/arch/ppc/boot/simple/keyhole_tty.c
> new file mode 100644
> index 0000000..ab07ca8
> --- /dev/null
> +++ b/arch/ppc/boot/simple/keyhole_tty.c
> @@ -0,0 +1,93 @@
> +/*
> + * arch/ppc/boot/simple/keyhole_tty.c
> + *
> + * Bootloader version of the embedded Xilinx/KEYHOLE driver.
> + *
> + * Author: David H. Lynch Jr. <dhlii@dlasys.net>
> + *
> + * 2005 (c) DLA Systems  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/serial_keyhole.h>
> +
> +static int MillisecTimeout=1000;
> +void usleep(int t) {
> +   int ii, waitTime=100;
> +    while(t) {
> +    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
> +	t--;
> +    }
> +}

umm, isn't udelay already defined in the kernel?


<--- snip --->

> @@ -180,11 +192,16 @@ load_kernel(unsigned long load_addr, int
>  #ifdef CONFIG_CMDLINE_BOOL
>  	memcpy (cmd_line, compiled_string, sizeof(compiled_string));
>  #else
> +// INITRAMFS and initrd should be handled the same.
> +#ifdef CONFIG_INITRAMFS_SOURCE
> +	memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
> +#else
>  	if ( initrd_size )
>  		memcpy (cmd_line, ramroot_string, sizeof(ramroot_string));
>  	else
>  		memcpy (cmd_line, netroot_string, sizeof(netroot_string));
>  #endif
> +#endif
why?

<--- snip --->

> diff --git a/arch/ppc/boot/simple/uartlite_tty.c b/arch/ppc/boot/simple/uartlite_tty.c

Russell King needs to be CC'd on serial stuff; but looks okay from a
real-quick look

<--- snip --->

> diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
> index 10c261c..c08aa7f 100644
> --- a/arch/ppc/kernel/head_4xx.S
> +++ b/arch/ppc/kernel/head_4xx.S
> @@ -75,13 +75,25 @@ _GLOBAL(_start)
>   * ready to work.
>   */
>  turn_on_mmu:
> +#if 0						// debuging code used to find the spurious E12 machine check
> problem
> +	khdbg(0x57002)
> +
> +#if defined(CONFIG_PICO_DEBUG) && 0
> +	bl	pico_dbg
> +#endif
> +#endif
>  	lis	r0,MSR_KERNEL@h
>  	ori	r0,r0,MSR_KERNEL@l
>  	mtspr	SPRN_SRR1,r0
> -	lis	r0,start_here@h
> +	lis	r0,start_here@h			// SPRN_SRR0 is where the rfi resumes execution
>  	ori	r0,r0,start_here@l
>  	mtspr	SPRN_SRR0,r0
>  	SYNC
> +// 	PPC405_ERR77_SYNC
> +/* We now have the lower 16 Meg mapped into TLB entries, and the caches
> + * ready to work.
> + */
> +

again, leave out private debug stuff and notes; or put in seperate patch

>  	rfi				/* enables MMU */
>  	b	.			/* prevent prefetch past rfi */
> 
> @@ -364,6 +376,9 @@ label:
>  	b	.		/* prevent prefetch past rfi */
> 
>  2:
> +	// khdbg(0x55001)
> +	// khdbgr(r16)
> +	

ditto

>  	/* The bailout.  Restore registers to pre-exception conditions
>  	 * and call the heavyweights to help us out.
>  	 */
> @@ -478,8 +493,11 @@ label:
>  	mtspr	SPRN_SPRG7, r11
>  	mtspr	SPRN_SPRG6, r12
>  #endif
> -	mfspr	r10, SPRN_DEAR		/* Get faulting address */
> 
> +	// khdbg(0x55000)
> +	// khdbgr(r16)
> +	mfspr	r10, SPRN_DEAR		/* Get faulting address */
> +	// khdbgr(r10)

ditto

>  	/* If we are faulting a kernel address, we have to use the
>  	 * kernel page tables.
>  	 */
> @@ -521,6 +539,8 @@ label:
>  	b	finish_tlb_load
> 
>  2:	/* Check for possible large-page pmd entry */
> +	// khdbg(0x55002)
> +	// khdbgr(r16)

ditto


<--- snip --->

> diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
> diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile

This stuff all conflicts with my patches of course; but that's to be
expected.  :)  Looks okay otherwise

> diff --git a/arch/ppc/platforms/4xx/pico_e12.c b/arch/ppc/platforms/4xx/pico_e12.c

this is just a copy of xilinx_ml300 and modified for the e12; I didn't
look deep into it; but seems okay.

> diff --git a/arch/ppc/platforms/4xx/pico_e12.h b/arch/ppc/platforms/4xx/pico_e12.h

ditto

> diff --git a/arch/ppc/platforms/4xx/virtex-iv.c b/arch/ppc/platforms/4xx/virtex-iv.c
> diff --git a/arch/ppc/platforms/4xx/virtex-iv.h b/arch/ppc/platforms/4xx/virtex-iv.h

conflicts with my changes; but okay.

> diff --git a/arch/ppc/platforms/4xx/xparameters/xparameters_pico_e12.h b/arch/ppc/platforms/4xx/xparameters/xparameters_pico_e12.h
okay


> diff --git a/arch/ppc/syslib/keyhole.h b/arch/ppc/syslib/keyhole.h
> new file mode 100644
> index 0000000..4b7a374
> --- /dev/null
> +++ b/arch/ppc/syslib/keyhole.h
> @@ -0,0 +1,17 @@
> +/*
> + * arch/ppc/syslib/keyhole.h
> + *
> + * keyhole prototypes
> + *
> + * Matt Porter <mporter@kernel.crashing.org>

You can add your name to the copyright list.

> + *
> + * 2004 (c) MontaVista Software, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
> +
> +extern void keyhole_progress(char *, unsigned short);
> +extern void keyhole_puts(char *);
> +extern void keyhole_init(int, struct uart_port *);
> +extern void keyhole_kgdb_map_scc(void);
> diff --git a/arch/ppc/syslib/keyhole_dbg.c b/arch/ppc/syslib/keyhole_dbg.c
> new file mode 100644
> index 0000000..73dd275
> --- /dev/null
> +++ b/arch/ppc/syslib/keyhole_dbg.c

<--- snip --->

> +/* SERIAL_PORT_DFNS is defined in <asm/serial.h> */
> +#ifndef SERIAL_PORT_DFNS
> +#define SERIAL_PORT_DFNS
> +#endif
> +
> +static struct serial_state rs_table[RS_TABLE_SIZE] = {
> +	SERIAL_PORT_DFNS	/* defined in <asm/serial.h> */
> +};
> +static int MillisecTimeout=1000;
> +void usleep(int t) {
> +   int ii, waitTime=100;
> +    while(t) {
> +    	for (ii=0; ii < MillisecTimeout*1000/waitTime; ii++){};
> +	t--;
> +    }
> +}

again; what about udelay?

<--- snip --->

> diff --git a/arch/ppc/syslib/ppc4xx_setup.c b/arch/ppc/syslib/ppc4xx_setup.c
> index e83a83f..c601390 100644
> --- a/arch/ppc/syslib/ppc4xx_setup.c
> +++ b/arch/ppc/syslib/ppc4xx_setup.c
> @@ -41,7 +41,15 @@
>  #include <asm/pci-bridge.h>
>  #include <asm/bootinfo.h>
> 
> +#if defined(CONFIG_SERIAL_8250)
>  #include <syslib/gen550.h>
> +#endif
> +#if defined(CONFIG_SERIAL_KEYHOLE)
> +#include <syslib/keyhole.h>
> +#endif
> +#if defined(CONFIG_SERIAL_UARTLITE)
> +#include <syslib/uartlite.h>
> +#endif
> 
>  /* Function Prototypes */
>  extern void abort(void);
> @@ -72,11 +80,18 @@ ppc4xx_setup_arch(void)
>   *   This routine pretty-prints the platform's internal CPU clock
>   *   frequencies into the buffer for usage in /proc/cpuinfo.
>   */
> +#if defined(CONFIG_PICO_DEBUG)
> +#define DEBUG_PRINTK(fmt...)	_printk(fmt)
> +#else
> +#define DEBUG_PRINTK(fmt...)	do { } while (0)
> +#endif
> +#define _printk printk

The code cleanliness police will probably have something to say about
you defining your own debug macros.  :)

<--- snip --->

> diff --git a/config.x86 b/config.x86

why?  This is just noise in your diff.

> diff --git a/cross b/cross
> new file mode 120000
> index 0000000..d11f058
> --- /dev/null
> +++ b/cross
> @@ -0,0 +1 @@
> +pico/cross
> \ No newline at end of file

???

<--- snip --->

> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 4aeae68..800f4c8 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -119,3 +119,20 @@ $(obj)/defkeymap.c $(obj)/qtronixmap.c:
>  	rm $@.tmp
> 
>  endif
> +# mod-subdirs     +=	xilinx_gpio xilinx_ts xilinx_uartlite xilinx_spi
> +# subdir-$(CONFIG_XILINX_GPIO) += xilinx_gpio
> +# subdir-$(CONFIG_XILINX_TS) += xilinx_ts
> +# subdir-$(CONFIG_XILINX_UARTLITE) += xilinx_uartlite
> +# subdir-$(CONFIG_XILINX_SPI) += xilinx_spi
> +# obj-$(CONFIG_XILINX_GPIO) += xilinx_gpio/xilinx_gpio.o
> +# obj-$(CONFIG_XILINX_TS) += xilinx_ts/xilinx_ts.o
> +# obj-$(CONFIG_XILINX_UARTLITE) += xilinx_uartlite/xilinx_uartlite.o
> generic_serial.o
> +# obj-$(CONFIG_XILINX_SPI) += xilinx_spi/xilinx_spi.o
> +# ifeq ($(CONFIG_VIRTEX_II_PRO),y)
> +#   ifeq ($(CONFIG_VT),y)
> +#     ifeq ($(CONFIG_PC_KEYBOARD),y)
> +#       subdir-$(CONFIG_VT) += xilinx_keyb
> +#       obj-$(CONFIG_VT) += xilinx_keyb/xilinx_keyb.o
> +#     endif
> +#   endif
> +# endif

???

> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 4cffd34..d559224 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -206,4 +206,6 @@ obj-$(CONFIG_ETRAX_ETHERNET) += cris/
>  obj-$(CONFIG_NETCONSOLE) += netconsole.o
> 
>  obj-$(CONFIG_FS_ENET) += fs_enet/
> -
> +#mod-subdirs     +=	xilinx_enet
> +#subdir-$(CONFIG_XILINX_ENET) += xilinx_enet
> +#obj-$(CONFIG_XILINX_ENET) += xilinx_enet/xilinx_enet.o

???

<--- snip --->

> diff --git a/drivers/serial/printk.c b/drivers/serial/printk.c
> new file mode 100644
> index 0000000..5e87489
> --- /dev/null
> +++ b/drivers/serial/printk.c
> @@ -0,0 +1,267 @@
> +/*
> + * arch/ppc/kernel/printf.c
> + *
> + * early printk code code (almost) all platforms can use
> + *
> + * Author: David H. Lynch Jr. <dhlii@dlasys.net>
> + *
> + * Derived heavily from arch/ppc/boot/common/misc-common1.c
> + *
> + * 20050 (c) DLA Systems This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + */
You'll need to run this stuff by Tom Rini.


<---snip--->

> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> diff --git a/drivers/serial/uartlite_early.c b/drivers/serial/uartlite_early.c

I didn't review these, sorry

<--- snip --->

> diff --git a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
> index 00ad9c7..5221970 100644
> --- a/include/asm-ppc/reg_booke.h
> +++ b/include/asm-ppc/reg_booke.h
> @@ -120,6 +120,11 @@ do {						\
>  #elif defined(CONFIG_BOOKE)
>  #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
>  #endif
> +#if defined (CONFIG_PICO_E12)
> +// The E12 seems to generate spurious Machine Checks - disable them.
> +#undef MSR_KERNEL
> +#define MSR_KERNEL	(MSR_RI|MSR_IR|MSR_DR|MSR_CE)
> +#endif

Ugh; this worries me.  What about legitimate machine checks?

<--- snip --->

> diff --git a/include/linux/serial_keyhole.h b/include/linux/serial_keyhole.h
> diff --git a/include/linux/serial_uartlite.h b/include/linux/serial_uartlite.h

Didn't review these, sorry

<--- snip --->

Ugh! I'm not doing that again.  Make sure your next patch set is broken
up into bite size emails.  That was far too long.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
