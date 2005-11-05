Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 718856868B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Nov 2005 16:16:30 +1100 (EST)
Date: Fri, 4 Nov 2005 21:16:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Message-Id: <20051104211605.2ccffef5.akpm@osdl.org>
In-Reply-To: <20051103183256.GJ3839@smtp.west.cox.net>
References: <20051103183256.GJ3839@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2.6.14] ppc32: Allow for bigger compressed kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini <trini@kernel.crashing.org> wrote:
>
> The ppc (not ppc64) boot loader (zimage wrapper) has a hard coded limit of
> 4 MB on the size of an uncompressed kernel it can boot. The boot loader has
> been changed to dynamically determine the largest possible kernel and
> support it. Relocating the boot loader to a higher address (currently
> located at 8 MB) will provide additional room.
> 

I'm getting an unpleasant reject here from Matt's
ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot.patch.  In
decompress_kernel he has added this ifdef:

@@ -164,7 +172,9 @@ decompress_kernel(unsigned long load_add
 		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
 	}
 
+#ifndef CONFIG_40x /* don't overwrite the 40x image located at 0x00400000! */
 	avail_ram = (char *)0x00400000;
+#endif
 	end_avail = (char *)0x00800000;
 	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
 	puthex((unsigned long)end_avail); puts("\n");


Which would appear to leave avail_ram at zero on CONFIG_40x.  There's no
mention in the changelog that this was the intent, so I dunno what's going
on.

But your change does appear to conflict in intent with Matt's patch (below),
so...  help!

> 
> diff --git a/arch/ppc/boot/simple/misc.c b/arch/ppc/boot/simple/misc.c
> --- a/arch/ppc/boot/simple/misc.c
> +++ b/arch/ppc/boot/simple/misc.c
> @@ -7,10 +7,10 @@
>   * your serial console.  If a machine meets these requirements, it can quite
>   * likely use this code during boot.
>   *
> - * Author: Matt Porter <mporter@mvista.com>
> + * Author: Tom Rini <trini@mvista.com>
>   * Derived from arch/ppc/boot/prep/misc.c
>   *
> - * 2001 (c) MontaVista, Software, Inc.  This file is licensed under
> + * 2001-2005 (c) MontaVista, Software, Inc.  This file is licensed under
>   * the terms of the GNU General Public License version 2.  This program
>   * is licensed "as is" without any warranty of any kind, whether express
>   * or implied.
> @@ -56,6 +56,11 @@
>  #define INTERACTIVE_CONSOLE	1
>  #endif
>  
> +#define	ONE_MB		(1 << 20)
> +#define	MAX_BI_RECS	(8 * 1024)
> +#define	MAX_AVAIL_MEM	(4 * ONE_MB)
> +#define	RAM_RESERVE	(4 * ONE_MB)
> +
>  char *avail_ram;
>  char *end_avail;
>  char *zimage_start;
> @@ -97,7 +102,8 @@ decompress_kernel(unsigned long load_add
>  #endif
>  	char *cp;
>  	struct bi_record *rec;
> -	unsigned long initrd_loc = 0, TotalMemory = 0;
> +	unsigned long initrd_loc, TotalMemory;
> +	unsigned long max_kernel, top_free;
>  
>  #if defined(CONFIG_SERIAL_8250_CONSOLE) || defined(CONFIG_SERIAL_MPSC_CONSOLE)
>  	com_port = serial_init(0, NULL);
> @@ -119,9 +125,6 @@ decompress_kernel(unsigned long load_add
>  	 */
>  	TotalMemory = get_mem_size();
>  
> -	/* assume the chunk below 8M is free */
> -	end_avail = (char *)0x00800000;
> -
>  	/*
>  	 * Reveal where we were loaded at and where we
>  	 * were relocated to.
> @@ -153,7 +156,6 @@ decompress_kernel(unsigned long load_add
>  	 * The zImage and initrd will be between start and _end, so they've
>  	 * already been moved once.  We're good to go now. -- Tom
>  	 */
> -	avail_ram = (char *)PAGE_ALIGN((unsigned long)_end);
>  	puts("zimage at:     "); puthex((unsigned long)zimage_start);
>  	puts(" "); puthex((unsigned long)(zimage_size+zimage_start));
>  	puts("\n");
> @@ -164,11 +166,51 @@ decompress_kernel(unsigned long load_add
>  		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
>  	}
>  
> -	avail_ram = (char *)0x00400000;
> -	end_avail = (char *)0x00800000;
> +	/*
> +	 * If there is sufficent memory move the available RAM area after
> +	 * the zImage (but stay away from the top of RAM). Otherwise fudge
> +	 * it to fit in below the zImage as it did in the past.
> +	 */
> +
> +	top_free = _ALIGN((unsigned long)(_end) + ONE_MB - 1, ONE_MB);
> +
> +	if ((TotalMemory != 0) &&
> +		((top_free + MAX_AVAIL_MEM + RAM_RESERVE) < TotalMemory)) {
> +		avail_ram = (char *) top_free;
> +
> +		/*
> +		 * We're linked in the middle of RAM and the kernel starts
> +		 * at zero. This means that the kernel must fit between
> +		 * zero and our starting address. Figure out the highest
> +		 * address below this that will allow a complete
> +		 * uncompressed kernel and bi_recs to fit - the maximum
> +		 * kernel size.
> +		 */
> +
> +		max_kernel = (unsigned long) &start;
> +
> +		while (1) {
> +			avail_ram = (char *) bootinfo_addr(max_kernel);
> +
> +			if ((avail_ram + MAX_BI_RECS) < ((char *) &start))
> +				break;
> +
> +			max_kernel -= MAX_BI_RECS;
> +		}
> +	}
> +	else {
> +		max_kernel = ((unsigned long) &start) - MAX_AVAIL_MEM;
> +		avail_ram = max_kernel;
> +	}
> +
> +	end_avail = avail_ram + MAX_AVAIL_MEM;
> +
>  	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
>  	puthex((unsigned long)end_avail); puts("\n");
>  
> +	/* Document the limitation */
> +	puts("max kernel:    "); puthex(max_kernel); puts("\n");
> +
>  	if (keyb_present)
>  		CRT_tstc();  /* Forces keyboard to be initialized */
>  #ifdef CONFIG_GEMINI
> @@ -222,32 +264,12 @@ decompress_kernel(unsigned long load_add
>  	puts("\n");
>  
>  	puts("Uncompressing Linux...");
> -	gunzip(NULL, 0x400000, zimage_start, &zimage_size);
> +	gunzip(NULL, max_kernel, zimage_start, &zimage_size);
>  	puts("done.\n");
>  
>  	/* get the bi_rec address */
>  	rec = bootinfo_addr(zimage_size);
>  
> -	/* We need to make sure that the initrd and bi_recs do not
> -	 * overlap. */
> -	if ( initrd_size ) {
> -		unsigned long rec_loc = (unsigned long) rec;
> -		initrd_loc = (unsigned long)(&__ramdisk_begin);
> -		/* If the bi_recs are in the middle of the current
> -		 * initrd, move the initrd to the next MB
> -		 * boundary. */
> -		if ((rec_loc > initrd_loc) &&
> -				((initrd_loc + initrd_size) > rec_loc)) {
> -			initrd_loc = _ALIGN((unsigned long)(zimage_size)
> -					+ (2 << 20) - 1, (2 << 20));
> -		 	memmove((void *)initrd_loc, &__ramdisk_begin,
> -				 initrd_size);
> -	         	puts("initrd moved:  "); puthex(initrd_loc);
> -		 	puts(" "); puthex(initrd_loc + initrd_size);
> -		 	puts("\n");
> -		}
> -	}
> -
>  	bootinfo_init(rec);
>  	if ( TotalMemory )
>  		bootinfo_append(BI_MEMSIZE, sizeof(int), (void*)&TotalMemory);
> @@ -258,7 +280,7 @@ decompress_kernel(unsigned long load_add
>  	if (initrd_size) {
>  		unsigned long initrd[2];
>  
> -		initrd[0] = initrd_loc;
> +		initrd[0] = (unsigned long)(&__ramdisk_begin);
>  		initrd[1] = initrd_size;
>  
>  		bootinfo_append(BI_INITRD, sizeof(initrd), &initrd);
> 


From: Matt Porter <mporter@kernel.crashing.org>

Cleanup PPC40x eval boards (bubinga, walnut and sycamore) to support U-Boot
as bootloader.  The OpenBIOS bd_info struct is not used in the kernel
anymore (only U-Boot now).

uImage (U-Boot) tested on walnut, sycamore and bubinga
zImage (OpenBIOS) tested on sycamore, bubinga and ebony

Signed-off-by: Stefan Roese <sr@denx.de>
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/boot/simple/Makefile     |   21 +++++++
 arch/ppc/boot/simple/misc.c       |   16 ++++-
 arch/ppc/boot/simple/openbios.c   |  106 +++++++++++++++++++++++++++++++++++---
 arch/ppc/platforms/4xx/Kconfig    |    2 
 arch/ppc/platforms/4xx/bubinga.c  |    2 
 arch/ppc/platforms/4xx/bubinga.h  |   64 +++++++++-------------
 arch/ppc/platforms/4xx/ebony.h    |    4 -
 arch/ppc/platforms/4xx/sycamore.c |    7 --
 arch/ppc/platforms/4xx/sycamore.h |   67 +++++++++---------------
 arch/ppc/platforms/4xx/walnut.c   |    2 
 arch/ppc/platforms/4xx/walnut.h   |   67 ++++++++----------------
 include/asm-ppc/ibm_ocp.h         |   19 +++++-
 include/asm-ppc/ppcboot.h         |    6 +-
 13 files changed, 237 insertions(+), 146 deletions(-)

diff -puN arch/ppc/boot/simple/Makefile~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/boot/simple/Makefile
--- devel/arch/ppc/boot/simple/Makefile~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/boot/simple/Makefile	2005-10-31 20:15:04.000000000 -0800
@@ -67,6 +67,12 @@ zimageinitrd-$(CONFIG_BAMBOO)		:= zImage
   entrypoint-$(CONFIG_BAMBOO)		:= 0x01000000
      extra.o-$(CONFIG_BAMBOO)		:= pibs.o
 
+      zimage-$(CONFIG_BUBINGA)		:= zImage-TREE
+zimageinitrd-$(CONFIG_BUBINGA)		:= zImage.initrd-TREE
+         end-$(CONFIG_BUBINGA)		:= bubinga
+  entrypoint-$(CONFIG_BUBINGA)		:= 0x01000000
+     extra.o-$(CONFIG_BUBINGA)		:= openbios.o
+
       zimage-$(CONFIG_EBONY)		:= zImage-TREE
 zimageinitrd-$(CONFIG_EBONY)		:= zImage.initrd-TREE
          end-$(CONFIG_EBONY)		:= ebony
@@ -91,6 +97,18 @@ zimageinitrd-$(CONFIG_OCOTEA)		:= zImage
   entrypoint-$(CONFIG_OCOTEA)		:= 0x01000000
      extra.o-$(CONFIG_OCOTEA)		:= pibs.o
 
+      zimage-$(CONFIG_SYCAMORE)		:= zImage-TREE
+zimageinitrd-$(CONFIG_SYCAMORE)		:= zImage.initrd-TREE
+         end-$(CONFIG_SYCAMORE)		:= sycamore
+  entrypoint-$(CONFIG_SYCAMORE)		:= 0x01000000
+     extra.o-$(CONFIG_SYCAMORE)		:= openbios.o
+
+      zimage-$(CONFIG_WALNUT)		:= zImage-TREE
+zimageinitrd-$(CONFIG_WALNUT)		:= zImage.initrd-TREE
+         end-$(CONFIG_WALNUT)		:= walnut
+  entrypoint-$(CONFIG_WALNUT)		:= 0x01000000
+     extra.o-$(CONFIG_WALNUT)		:= openbios.o
+
      extra.o-$(CONFIG_EV64260)		:= misc-ev64260.o
          end-$(CONFIG_EV64260)		:= ev64260
    cacheflag-$(CONFIG_EV64260)		:= -include $(clear_L2_L3)
@@ -168,7 +186,8 @@ OBJCOPY_ARGS			:= -O elf32-powerpc
 
 # head.o and relocate.o must be at the start.
 boot-y				:= head.o relocate.o $(extra.o-y) $(misc-y)
-boot-$(CONFIG_40x)		+= embed_config.o
+boot-$(CONFIG_REDWOOD_5)	+= embed_config.o
+boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
diff -puN arch/ppc/boot/simple/misc.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/boot/simple/misc.c
--- devel/arch/ppc/boot/simple/misc.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/boot/simple/misc.c	2005-10-31 20:15:04.000000000 -0800
@@ -23,7 +23,7 @@
 #include <asm/page.h>
 #include <asm/mmu.h>
 #include <asm/bootinfo.h>
-#ifdef CONFIG_44x
+#ifdef CONFIG_4xx
 #include <asm/ibm4xx.h>
 #endif
 #include <asm/reg.h>
@@ -88,6 +88,14 @@ get_mem_size(void)
 	return 0;
 }
 
+#if defined(CONFIG_40x)
+#define PPC4xx_EMAC0_MR0	EMAC0_BASE
+#endif
+
+#if defined(CONFIG_44x) && defined(PPC44x_EMAC0_MR0)
+#define PPC4xx_EMAC0_MR0	PPC44x_EMAC0_MR0
+#endif
+
 struct bi_record *
 decompress_kernel(unsigned long load_addr, int num_words, unsigned long cksum)
 {
@@ -103,13 +111,13 @@ decompress_kernel(unsigned long load_add
 	com_port = serial_init(0, NULL);
 #endif
 
-#if defined(CONFIG_44x) && defined(PPC44x_EMAC0_MR0)
+#if defined(PPC4xx_EMAC0_MR0)
 	/* Reset MAL */
 	mtdcr(DCRN_MALCR(DCRN_MAL_BASE), MALCR_MMSR);
 	/* Wait for reset */
 	while (mfdcr(DCRN_MALCR(DCRN_MAL_BASE)) & MALCR_MMSR) {};
 	/* Reset EMAC */
-	*(volatile unsigned long *)PPC44x_EMAC0_MR0 = 0x20000000;
+	*(volatile unsigned long *)PPC4xx_EMAC0_MR0 = 0x20000000;
 	__asm__ __volatile__("eieio");
 #endif
 
@@ -164,7 +172,9 @@ decompress_kernel(unsigned long load_add
 		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
 	}
 
+#ifndef CONFIG_40x /* don't overwrite the 40x image located at 0x00400000! */
 	avail_ram = (char *)0x00400000;
+#endif
 	end_avail = (char *)0x00800000;
 	puts("avail ram:     "); puthex((unsigned long)avail_ram); puts(" ");
 	puthex((unsigned long)end_avail); puts("\n");
diff -puN arch/ppc/boot/simple/openbios.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/boot/simple/openbios.c
--- devel/arch/ppc/boot/simple/openbios.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/boot/simple/openbios.c	2005-10-31 20:15:04.000000000 -0800
@@ -1,19 +1,43 @@
 /*
  * arch/ppc/boot/simple/openbios.c
  *
- * 2005 (c) SYSGO AG - g.jaeger@sysgo.com
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ *      2005 (c) SYSGO AG - g.jaeger@sysgo.com
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without
  * any warranty of any kind, whether express or implied.
  *
- * Derived from arch/ppc/boot/simple/pibs.c (from MontaVista)
  */
 
 #include <linux/types.h>
 #include <linux/config.h>
 #include <linux/string.h>
 #include <asm/ppcboot.h>
-#include <platforms/4xx/ebony.h>
+#include <asm/ibm4xx.h>
+#include <asm/reg.h>
+#ifdef CONFIG_40x
+#include <asm/io.h>
+#endif
+
+#if defined(CONFIG_BUBINGA)
+#define BOARD_INFO_VECTOR       0xFFF80B50 /* openbios 1.19 moved this vector down  - armin */
+#else
+#define BOARD_INFO_VECTOR	0xFFFE0B50
+#endif
+
+#ifdef CONFIG_40x
+/* Supply a default Ethernet address for those eval boards that don't
+ * ship with one.  This is an address from the MBX board I have, so
+ * it is unlikely you will find it on your network.
+ */
+static	ushort	def_enet_addr[] = { 0x0800, 0x3e26, 0x1559 };
+
+extern unsigned long timebase_period_ns;
+#endif /* CONFIG_40x */
 
 extern unsigned long decompress_kernel(unsigned long load_addr, int num_words,
 				       unsigned long cksum);
@@ -23,15 +47,85 @@ extern unsigned long decompress_kernel(u
 bd_t hold_resid_buf __attribute__ ((__section__ (".data.boot")));
 bd_t *hold_residual = &hold_resid_buf;
 
+typedef struct openbios_board_info {
+        unsigned char    bi_s_version[4];       /* Version of this structure */
+        unsigned char    bi_r_version[30];      /* Version of the IBM ROM */
+        unsigned int     bi_memsize;            /* DRAM installed, in bytes */
+#ifdef CONFIG_405EP
+        unsigned char    bi_enetaddr[2][6];     /* Local Ethernet MAC address */
+#else /* CONFIG_405EP */
+        unsigned char    bi_enetaddr[6];        /* Local Ethernet MAC address */
+#endif /* CONFIG_405EP */
+        unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address */
+        unsigned int     bi_intfreq;            /* Processor speed, in Hz */
+        unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
+        unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
+#ifdef CONFIG_405EP
+        unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
+        unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
+#endif /* CONFIG_405EP */
+} openbios_bd_t;
+
 void *
 load_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
 		void *ign1, void *ign2)
 {
-	decompress_kernel(load_addr, num_words, cksum);
+#ifdef CONFIG_40x
+	openbios_bd_t *openbios_bd = NULL;
+	openbios_bd_t *(*get_board_info)(void) =
+		(openbios_bd_t *(*)(void))(*(unsigned long *)BOARD_INFO_VECTOR);
+
+	/*
+	 * On 40x platforms we not only need the MAC-addresses, but also the
+	 * clocks and memsize. Now try to get all values using the OpenBIOS
+	 * "get_board_info()" callback.
+	 */
+	if ((openbios_bd = get_board_info()) != NULL) {
+		/*
+		 * Copy bd_info from OpenBIOS struct into U-Boot struct
+		 * used by kernel
+		 */
+	        hold_residual->bi_memsize = openbios_bd->bi_memsize;
+	        hold_residual->bi_intfreq = openbios_bd->bi_intfreq;
+	        hold_residual->bi_busfreq = openbios_bd->bi_busfreq;
+	        hold_residual->bi_pci_busfreq = openbios_bd->bi_pci_busfreq;
+		memcpy(hold_residual->bi_pci_enetaddr, openbios_bd->bi_pci_enetaddr, 6);
+#ifdef CONFIG_405EP
+		memcpy(hold_residual->bi_enetaddr, openbios_bd->bi_enetaddr[0], 6);
+		memcpy(hold_residual->bi_enet1addr, openbios_bd->bi_enetaddr[1], 6);
+	        hold_residual->bi_opbfreq = openbios_bd->bi_opb_busfreq;
+	        hold_residual->bi_procfreq = openbios_bd->bi_pllouta_freq;
+#else /* CONFIG_405EP */
+		memcpy(hold_residual->bi_enetaddr, openbios_bd->bi_enetaddr, 6);
+#endif /* CONFIG_405EP */
+	} else {
+		/* Hmmm...better try to stuff some defaults.
+		 */
+		hold_residual->bi_memsize = 16 * 1024 * 1024;
+		hold_residual->bi_intfreq = 200000000;
+		hold_residual->bi_busfreq = 100000000;
+		hold_residual->bi_pci_busfreq = 66666666;
+
+		/*
+		 * Only supply one mac-address in this fallback
+		 */
+		memcpy(hold_residual->bi_enetaddr, (void *)def_enet_addr, 6);
+#ifdef CONFIG_405EP
+	        hold_residual->bi_opbfreq = 50000000;
+	        hold_residual->bi_procfreq = 200000000;
+#endif /* CONFIG_405EP */
+	}
+
+	timebase_period_ns = 1000000000 / hold_residual->bi_intfreq;
+#endif /* CONFIG_40x */
 
+#ifdef CONFIG_440GP
 	/* simply copy the MAC addresses */
-	memcpy(hold_residual->bi_enetaddr,  (char *)EBONY_OPENBIOS_MAC_BASE, 6);
-	memcpy(hold_residual->bi_enet1addr, (char *)(EBONY_OPENBIOS_MAC_BASE+EBONY_OPENBIOS_MAC_OFFSET), 6);
+	memcpy(hold_residual->bi_enetaddr,  (char *)OPENBIOS_MAC_BASE, 6);
+	memcpy(hold_residual->bi_enet1addr, (char *)(OPENBIOS_MAC_BASE+OPENBIOS_MAC_OFFSET), 6);
+#endif /* CONFIG_440GP */
+
+	decompress_kernel(load_addr, num_words, cksum);
 
 	return (void *)hold_residual;
 }
diff -puN arch/ppc/platforms/4xx/bubinga.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/bubinga.c
--- devel/arch/ppc/platforms/4xx/bubinga.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/bubinga.c	2005-10-31 20:15:04.000000000 -0800
@@ -89,7 +89,7 @@ bubinga_early_serial_map(void)
           * by 16.
           */
 	uart_div = (mfdcr(DCRN_CPC0_UCR_BASE) & DCRN_CPC0_UCR_U0DIV);
-	uart_clock = __res.bi_pllouta_freq / uart_div;
+	uart_clock = __res.bi_procfreq / uart_div;
 
 	/* Setup serial port access */
 	memset(&port, 0, sizeof(port));
diff -puN arch/ppc/platforms/4xx/bubinga.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/bubinga.h
--- devel/arch/ppc/platforms/4xx/bubinga.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/bubinga.h	2005-10-31 20:15:04.000000000 -0800
@@ -1,52 +1,34 @@
 /*
- * Support for IBM PPC 405EP evaluation board (Bubinga).
+ * arch/ppc/platforms/4xx/bubinga.h
  *
- * Author: SAW (IBM), derived from walnut.h.
- *         Maintained by MontaVista Software <source@mvista.com>
+ * Bubinga board definitions
+ *
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ *	SAW (IBM)
+ *	2003 (c) MontaVista Softare Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  *
- * 2003 (c) MontaVista Softare Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2. This program is
- * licensed "as is" without any warranty of any kind, whether express
- * or implied.
  */
 
 #ifdef __KERNEL__
 #ifndef __BUBINGA_H__
 #define __BUBINGA_H__
 
-/* 405EP */
+#include <linux/config.h>
 #include <platforms/4xx/ibm405ep.h>
-
-#ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-        unsigned char    bi_s_version[4];       /* Version of this structure */
-        unsigned char    bi_r_version[30];      /* Version of the IBM ROM */
-        unsigned int     bi_memsize;            /* DRAM installed, in bytes */
-        unsigned char    bi_enetaddr[2][6];     /* Local Ethernet MAC address */        unsigned char    bi_pci_enetaddr[6];    /* PCI Ethernet MAC address */
-        unsigned int     bi_intfreq;            /* Processor speed, in Hz */
-        unsigned int     bi_busfreq;            /* PLB Bus speed, in Hz */
-        unsigned int     bi_pci_busfreq;        /* PCI Bus speed, in Hz */
-        unsigned int     bi_opb_busfreq;        /* OPB Bus speed, in Hz */
-        unsigned int     bi_pllouta_freq;       /* PLL OUTA speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
+#include <asm/ppcboot.h>
 
 /* Memory map for the Bubinga board.
  * Generic 4xx plus RTC.
  */
 
-extern void *bubinga_rtc_base;
 #define BUBINGA_RTC_PADDR	((uint)0xf0000000)
 #define BUBINGA_RTC_VADDR	BUBINGA_RTC_PADDR
 #define BUBINGA_RTC_SIZE	((uint)8*1024)
@@ -58,12 +40,18 @@ extern void *bubinga_rtc_base;
  * for typical configurations at various CPU speeds.
  * The base baud is calculated as (FWDA / EXT UART DIV / 16)
  */
-#define BASE_BAUD       0
+#define BASE_BAUD		0
 
-#define BUBINGA_FPGA_BASE      0xF0300000
+/* Flash */
+#define PPC40x_FPGA_BASE	0xF0300000
+#define PPC40x_FPGA_REG_OFFS	1	/* offset to flash map reg */
+#define PPC40x_FLASH_ONBD_N(x)	(x & 0x02)
+#define PPC40x_FLASH_SRAM_SEL(x) (x & 0x01)
+#define PPC40x_FLASH_LOW	0xFFF00000
+#define PPC40x_FLASH_HIGH	0xFFF80000
+#define PPC40x_FLASH_SIZE	0x80000
 
-#define PPC4xx_MACHINE_NAME     "IBM Bubinga"
+#define PPC4xx_MACHINE_NAME	"IBM Bubinga"
 
-#endif /* !__ASSEMBLY__ */
 #endif /* __BUBINGA_H__ */
 #endif /* __KERNEL__ */
diff -puN arch/ppc/platforms/4xx/ebony.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/ebony.h
--- devel/arch/ppc/platforms/4xx/ebony.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/ebony.h	2005-10-31 20:15:04.000000000 -0800
@@ -24,8 +24,8 @@
 #define PPC44x_EMAC0_MR0	0xE0000800
 
 /* Where to find the MAC info */
-#define EBONY_OPENBIOS_MAC_BASE   0xfffffe0c
-#define EBONY_OPENBIOS_MAC_OFFSET 0x0c
+#define OPENBIOS_MAC_BASE	0xfffffe0c
+#define OPENBIOS_MAC_OFFSET	0x0c
 
 /* Default clock rates for Rev. B and Rev. C silicon */
 #define EBONY_440GP_RB_SYSCLK	33000000
diff -puN arch/ppc/platforms/4xx/Kconfig~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/Kconfig
--- devel/arch/ppc/platforms/4xx/Kconfig~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/Kconfig	2005-10-31 20:15:04.000000000 -0800
@@ -225,7 +225,7 @@ config EMBEDDEDBOOT
 
 config IBM_OPENBIOS
 	bool
-	depends on ASH || BUBINGA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
+	depends on ASH || REDWOOD_5 || REDWOOD_6
 	default y
 
 config PPC4xx_DMA
diff -puN arch/ppc/platforms/4xx/sycamore.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/sycamore.c
--- devel/arch/ppc/platforms/4xx/sycamore.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/sycamore.c	2005-10-31 20:15:04.000000000 -0800
@@ -88,9 +88,6 @@ ppc405_map_irq(struct pci_dev *dev, unsi
 void __init
 sycamore_setup_arch(void)
 {
-#define SYCAMORE_PS2_BASE	0xF0100000
-#define SYCAMORE_FPGA_BASE	0xF0300000
-
 	void *fpga_brdc;
 	unsigned char fpga_brdc_data;
 	void *fpga_enable;
@@ -100,7 +97,7 @@ sycamore_setup_arch(void)
 
 	ppc4xx_setup_arch();
 
-	ibm_ocp_set_emac(0, 1);
+	ibm_ocp_set_emac(0, 0);
 
 	kb_data = ioremap(SYCAMORE_PS2_BASE, 8);
 	if (!kb_data) {
@@ -111,7 +108,7 @@ sycamore_setup_arch(void)
 
 	kb_cs = kb_data + 1;
 
-	fpga_status = ioremap(SYCAMORE_FPGA_BASE, 8);
+	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
 		printk(KERN_CRIT
 		       "sycamore_setup_arch() fpga_status ioremap failed\n");
diff -puN arch/ppc/platforms/4xx/sycamore.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/sycamore.h
--- devel/arch/ppc/platforms/4xx/sycamore.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/sycamore.h	2005-10-31 20:15:04.000000000 -0800
@@ -1,67 +1,52 @@
 /*
  * arch/ppc/platforms/4xx/sycamore.h
  *
- * Macros, definitions, and data structures specific to the IBM PowerPC
- * 405GPr "Sycamore" evaluation board.
+ * Sycamore board definitions
  *
- * Author: Armin Kuster <akuster@mvista.com>
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
+ *
+ * Based on original work by
+ * 	Armin Kuster <akuster@mvista.com>
+ *	2000 (c) MontaVista, Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
  */
 
 #ifdef __KERNEL__
 #ifndef __ASM_SYCAMORE_H__
 #define __ASM_SYCAMORE_H__
 
+#include <linux/config.h>
 #include <platforms/4xx/ibm405gpr.h>
+#include <asm/ppcboot.h>
 
-#ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Sycamore" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
-
-/* Memory map for the IBM "Sycamore" 405GP evaluation board.
+/* Memory map for the IBM "Sycamore" 405GPr evaluation board.
  * Generic 4xx plus RTC.
  */
 
-extern void *sycamore_rtc_base;
 #define SYCAMORE_RTC_PADDR	((uint)0xf0000000)
 #define SYCAMORE_RTC_VADDR	SYCAMORE_RTC_PADDR
-#define SYCAMORE_RTC_SIZE		((uint)8*1024)
+#define SYCAMORE_RTC_SIZE	((uint)8*1024)
 
-#ifdef CONFIG_PPC405GP_INTERNAL_CLOCK
-#define BASE_BAUD		201600
-#else
 #define BASE_BAUD		691200
-#endif
 
-#define SYCAMORE_PS2_BASE		0xF0100000
-#define SYCAMORE_FPGA_BASE	0xF0300000
+#define SYCAMORE_PS2_BASE	0xF0100000
+
+/* Flash */
+#define PPC40x_FPGA_BASE	0xF0300000
+#define PPC40x_FPGA_REG_OFFS	5	/* offset to flash map reg */
+#define PPC40x_FLASH_ONBD_N(x)	(x & 0x02)
+#define PPC40x_FLASH_SRAM_SEL(x) (x & 0x01)
+#define PPC40x_FLASH_LOW	0xFFF00000
+#define PPC40x_FLASH_HIGH	0xFFF80000
+#define PPC40x_FLASH_SIZE	0x80000
 
 #define PPC4xx_MACHINE_NAME	"IBM Sycamore"
 
-#endif /* !__ASSEMBLY__ */
 #endif /* __ASM_SYCAMORE_H__ */
 #endif /* __KERNEL__ */
diff -puN arch/ppc/platforms/4xx/walnut.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/walnut.c
--- devel/arch/ppc/platforms/4xx/walnut.c~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/walnut.c	2005-10-31 20:15:04.000000000 -0800
@@ -90,7 +90,7 @@ walnut_setup_arch(void)
 
 	kb_cs = kb_data + 1;
 
-	fpga_status = ioremap(WALNUT_FPGA_BASE, 8);
+	fpga_status = ioremap(PPC40x_FPGA_BASE, 8);
 	if (!fpga_status) {
 		printk(KERN_CRIT
 		       "walnut_setup_arch() fpga_status ioremap failed\n");
diff -puN arch/ppc/platforms/4xx/walnut.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot arch/ppc/platforms/4xx/walnut.h
--- devel/arch/ppc/platforms/4xx/walnut.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/arch/ppc/platforms/4xx/walnut.h	2005-10-31 20:15:04.000000000 -0800
@@ -1,72 +1,55 @@
 /*
  * arch/ppc/platforms/4xx/walnut.h
  *
- * Macros, definitions, and data structures specific to the IBM PowerPC
- * 405GP "Walnut" evaluation board.
+ * Walnut board definitions
  *
- * Authors: Grant Erickson <grant@lcse.umn.edu>, Frank Rowand
- * <frank_rowand@mvista.com>, Debbie Chu <debbie_chu@mvista.com> or
- * source@mvista.com
+ * Copyright (c) 2005 DENX Software Engineering
+ * Stefan Roese <sr@denx.de>
  *
- * Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ * Based on original work by
+ * 	Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
+ *	Frank Rowand <frank_rowand@mvista.com>
+ *	Debbie Chu <debbie_chu@mvista.com>
+ *	2000 (c) MontaVista, Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
  *
- * 2000 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
  */
 
 #ifdef __KERNEL__
 #ifndef __ASM_WALNUT_H__
 #define __ASM_WALNUT_H__
 
-/* We have a 405GP core */
+#include <linux/config.h>
 #include <platforms/4xx/ibm405gp.h>
-
-#ifndef __ASSEMBLY__
-/*
- * Data structure defining board information maintained by the boot
- * ROM on IBM's "Walnut" evaluation board. An effort has been made to
- * keep the field names consistent with the 8xx 'bd_t' board info
- * structures.
- */
-
-typedef struct board_info {
-	unsigned char	 bi_s_version[4];	/* Version of this structure */
-	unsigned char	 bi_r_version[30];	/* Version of the IBM ROM */
-	unsigned int	 bi_memsize;		/* DRAM installed, in bytes */
-	unsigned char	 bi_enetaddr[6];	/* Local Ethernet MAC address */
-	unsigned char	 bi_pci_enetaddr[6];	/* PCI Ethernet MAC address */
-	unsigned int	 bi_intfreq;		/* Processor speed, in Hz */
-	unsigned int	 bi_busfreq;		/* PLB Bus speed, in Hz */
-	unsigned int	 bi_pci_busfreq;	/* PCI Bus speed, in Hz */
-} bd_t;
-
-/* Some 4xx parts use a different timebase frequency from the internal clock.
-*/
-#define bi_tbfreq bi_intfreq
-
+#include <asm/ppcboot.h>
 
 /* Memory map for the IBM "Walnut" 405GP evaluation board.
  * Generic 4xx plus RTC.
  */
 
-extern void *walnut_rtc_base;
 #define WALNUT_RTC_PADDR	((uint)0xf0000000)
 #define WALNUT_RTC_VADDR	WALNUT_RTC_PADDR
 #define WALNUT_RTC_SIZE		((uint)8*1024)
 
-#ifdef CONFIG_PPC405GP_INTERNAL_CLOCK
-#define BASE_BAUD		201600
-#else
 #define BASE_BAUD		691200
-#endif
 
 #define WALNUT_PS2_BASE		0xF0100000
-#define WALNUT_FPGA_BASE	0xF0300000
+
+/* Flash */
+#define PPC40x_FPGA_BASE	0xF0300000
+#define PPC40x_FPGA_REG_OFFS	5	/* offset to flash map reg */
+#define PPC40x_FLASH_ONBD_N(x)	(x & 0x02)
+#define PPC40x_FLASH_SRAM_SEL(x) (x & 0x01)
+#define PPC40x_FLASH_LOW	0xFFF00000
+#define PPC40x_FLASH_HIGH	0xFFF80000
+#define PPC40x_FLASH_SIZE	0x80000
+#define WALNUT_FPGA_BASE	PPC40x_FPGA_BASE
 
 #define PPC4xx_MACHINE_NAME	"IBM Walnut"
 
-#endif /* !__ASSEMBLY__ */
 #endif /* __ASM_WALNUT_H__ */
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/ibm_ocp.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot include/asm-ppc/ibm_ocp.h
--- devel/include/asm-ppc/ibm_ocp.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/include/asm-ppc/ibm_ocp.h	2005-10-31 20:15:04.000000000 -0800
@@ -131,9 +131,22 @@ static inline void ibm_ocp_set_emac(int 
 	/* Copy MAC addresses to EMAC additions */
 	for (i=start; i<=end; i++) {
 		def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, i);
-		memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
-				&__res.bi_enetaddr[i],
-				6);
+		if (i == 0)
+			memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
+			       __res.bi_enetaddr, 6);
+#if defined(CONFIG_405EP) || defined(CONFIG_44x)
+		else if (i == 1)
+			memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
+			       __res.bi_enet1addr, 6);
+#endif
+#if defined(CONFIG_440GX)
+		else if (i == 2)
+			memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
+			       __res.bi_enet2addr, 6);
+		else if (i == 3)
+			memcpy(((struct ocp_func_emac_data *)def->additions)->mac_addr,
+			       __res.bi_enet3addr, 6);
+#endif
 	}
 }
 #endif
diff -puN include/asm-ppc/ppcboot.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot include/asm-ppc/ppcboot.h
--- devel/include/asm-ppc/ppcboot.h~ppc32-cleanup-amcc-ppc40x-eval-boards-to-support-u-boot	2005-10-31 20:15:04.000000000 -0800
+++ devel-akpm/include/asm-ppc/ppcboot.h	2005-10-31 20:15:04.000000000 -0800
@@ -73,8 +73,8 @@ typedef struct bd_info {
 #if defined(CONFIG_HYMOD)
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
-#if defined(CONFIG_EVB64260) || defined(CONFIG_44x) || defined(CONFIG_85xx) ||\
-	defined(CONFIG_83xx)
+#if defined(CONFIG_EVB64260) || defined(CONFIG_405EP) || defined(CONFIG_44x) || \
+	defined(CONFIG_85xx) ||	defined(CONFIG_83xx)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #endif
@@ -96,5 +96,7 @@ typedef struct bd_info {
 #endif
 } bd_t;
 
+#define bi_tbfreq	bi_intfreq
+
 #endif /* __ASSEMBLY__ */
 #endif	/* __ASM_PPCBOOT_H__ */
_
