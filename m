Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 451B967A78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 12:33:17 +1100 (EST)
Message-ID: <42378CD1.20608@mvista.com>
Date: Tue, 15 Mar 2005 18:33:05 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------010602040209090307070407"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.12] ppc32: Clean up mv64x60 bootwrapper support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------010602040209090307070407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: Clean up mv64x60 bootwrapper support

This patch removes the call to mv64x60_init() in 
arch/ppc/boot/simple/head.S and now uses the 'load_kernel()' hook to 
call to have mv64x60-specific code called.  This means that the mv64x60 
code will be called after the bootwrapper has relocated itself.  The 
platforms affected by this change are updated by this patch as well.

Depends on patch: 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-March/017269.html

Please apply.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------010602040209090307070407
Content-Type: text/plain;
 name="ppc32_bootwrapper.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc32_bootwrapper.patch"

diff -Nru a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
--- a/arch/ppc/boot/simple/Makefile	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/Makefile	2005-03-15 18:24:50 -07:00
@@ -49,7 +49,7 @@
 #----------------------------------------------------------------------------
       zimage-$(CONFIG_CPCI690)		:= zImage-STRIPELF
 zimageinitrd-$(CONFIG_CPCI690)		:= zImage.initrd-STRIPELF
-     extra.o-$(CONFIG_CPCI690)		:= misc-cpci690.o mv64x60_stub.o
+     extra.o-$(CONFIG_CPCI690)		:= misc-cpci690.o
          end-$(CONFIG_CPCI690)		:= cpci690
    cacheflag-$(CONFIG_CPCI690)		:= -include $(clear_L2_L3)
 
@@ -94,11 +94,11 @@
          end-$(CONFIG_K2)		:= k2
    cacheflag-$(CONFIG_K2)		:= -include $(clear_L2_L3)
 
-     extra.o-$(CONFIG_KATANA)		:= misc-katana.o mv64x60_stub.o
+     extra.o-$(CONFIG_KATANA)		:= misc-katana.o
          end-$(CONFIG_KATANA)		:= katana
    cacheflag-$(CONFIG_KATANA)		:= -include $(clear_L2_L3)
 
-     extra.o-$(CONFIG_RADSTONE_PPC7D)	:= misc-radstone_ppc7d.o mv64x60_stub.o
+     extra.o-$(CONFIG_RADSTONE_PPC7D)	:= misc-radstone_ppc7d.o
          end-$(CONFIG_RADSTONE_PPC7D)	:= radstone_ppc7d
    cacheflag-$(CONFIG_RADSTONE_PPC7D)	:= -include $(clear_L2_L3)
 
diff -Nru a/arch/ppc/boot/simple/head.S b/arch/ppc/boot/simple/head.S
--- a/arch/ppc/boot/simple/head.S	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/head.S	2005-03-15 18:24:50 -07:00
@@ -135,11 +135,6 @@
 			 */
 #endif
 
-#ifdef	CONFIG_MV64X60
-	/* mv64x60 specific hook to do things like moving register base, etc. */
-	bl	mv64x60_init
-#endif
-
 	/* Get the load address.
 	*/
 	subi	r3, r3, 4	/* Get the actual IP, not NIP */
diff -Nru a/arch/ppc/boot/simple/misc-chestnut.S b/arch/ppc/boot/simple/misc-chestnut.S
--- a/arch/ppc/boot/simple/misc-chestnut.S	2005-03-15 18:24:50 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,41 +0,0 @@
-/*
- * arch/ppc/boot/simple/misc-chestnut.S
- *
- * Setup for the IBM Chestnut (ibm-750fxgx_eval)
- *
- * Author: <source@mvista.com>
- *
- * <2004> (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-
-#include <asm/ppc_asm.h>
-#include <asm/mv64x60_defs.h>
-#include <platforms/chestnut.h>
-
-	.globl	mv64x60_board_init
-mv64x60_board_init:
-	/*
-	 * move UART to 0xffc00000
-	 */
-
-	li      r23,16
-
-	addis	r25,0,CONFIG_MV64X60_BASE@h
-	ori     r25,r25,MV64x60_CPU2DEV_2_BASE
-	addis   r26,0,CHESTNUT_UART_BASE@h
-	srw     r26,r26,r23
-	stwbrx  r26,0,(r25)
-	sync
-
-	addis	r25,0,CONFIG_MV64X60_BASE@h
-	ori     r25,r25,MV64x60_CPU2DEV_2_SIZE
-	addis   r26,0,0x00100000@h
-	srw     r26,r26,r23
-	stwbrx  r26,0,(r25)
-	sync
-
-	blr
diff -Nru a/arch/ppc/boot/simple/misc-chestnut.c b/arch/ppc/boot/simple/misc-chestnut.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/misc-chestnut.c	2005-03-15 18:24:50 -07:00
@@ -0,0 +1,35 @@
+/*
+ * arch/ppc/boot/simple/misc-chestnut.c
+ *
+ * Setup for the IBM Chestnut (ibm-750fxgx_eval)
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/mv64x60_defs.h>
+#include <platforms/chestnut.h>
+
+/* Not in the kernel so won't include kernel.h to get its 'max' definition */
+#define max(a,b)	(((a) > (b)) ? (a) : (b))
+
+void
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	/*
+	 * Change device bus 2 window so that bootoader can do I/O thru
+	 * 8250/16550 UART that's mapped in that window.
+	 */
+	out_le32(new_base + MV64x60_CPU2DEV_2_BASE, CHESTNUT_UART_BASE >> 16);
+	out_le32(new_base + MV64x60_CPU2DEV_2_SIZE, CHESTNUT_UART_SIZE >> 16);
+	__asm__ __volatile__("sync");
+#endif
+}
diff -Nru a/arch/ppc/boot/simple/misc-cpci690.c b/arch/ppc/boot/simple/misc-cpci690.c
--- a/arch/ppc/boot/simple/misc-cpci690.c	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/misc-cpci690.c	2005-03-15 18:24:50 -07:00
@@ -12,4 +12,16 @@
  */
 
 #include <linux/types.h>
-long	mv64x60_mpsc_clk_freq = 133000000;
+#include <platforms/cpci690.h>
+
+extern u32 mv64x60_console_baud;
+extern u32 mv64x60_mpsc_clk_src;
+extern u32 mv64x60_mpsc_clk_freq;
+
+void
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+	mv64x60_console_baud = CPCI690_MPSC_BAUD;
+	mv64x60_mpsc_clk_src = CPCI690_MPSC_CLK_SRC;
+	mv64x60_mpsc_clk_freq = CPCI690_BUS_FREQ;
+}
diff -Nru a/arch/ppc/boot/simple/misc-ev64260.S b/arch/ppc/boot/simple/misc-ev64260.S
--- a/arch/ppc/boot/simple/misc-ev64260.S	2005-03-15 18:24:50 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,68 +0,0 @@
-/*
- * arch/ppc/boot/simple/misc-ev64260.S
- *
- * Host bridge init code for the Marvell/Galileo EV-64260-BP evaluation board
- * with a GT64260 onboard.
- *
- * Author: Mark Greer <mgreer@mvista.com>
- *
- * 2001 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-#include <asm/cache.h>
-#include <asm/mv64x60_defs.h>
-#include <platforms/ev64260.h>
-
-	.globl	mv64x60_board_init
-mv64x60_board_init:
-	/* DINK doesn't enable 745x timebase, so enable here (Adrian Cox) */
-	mfspr	r25,SPRN_PVR
-	srwi	r25,r25,16
-	cmplwi	r25,(PVR_7450 >> 16)
-	bne	1f
-	mfspr	r25,SPRN_HID0
-	oris	r25,r25,(HID0_TBEN >> 16)
-	mtspr	SPRN_HID0,r25
-1:
-#if (CONFIG_MV64X60_NEW_BASE != CONFIG_MV64X60_BASE)
-	li	r23,20
-
-	/*
-	 * Change the CS2 window for the UART so that the bootloader
-	 * can do I/O thru the UARTs.
-	 */
-	addis	r25,0,CONFIG_MV64X60_NEW_BASE@h
-	ori	r25,r25,MV64x60_CPU2DEV_2_BASE
-	addis	r26,0,EV64260_UART_BASE@h
-	srw	r26,r26,r23
-	stwbrx	r26,0,(r25)
-	sync
-
-	addis	r25,0,CONFIG_MV64X60_NEW_BASE@h
-	ori	r25,r25,MV64x60_CPU2DEV_2_SIZE
-	addis	r26,0,EV64260_UART_END@h
-	srw	r26,r26,r23
-	stwbrx	r26,0,(r25)
-	sync
-#endif
-	blr
-
-#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
-.data
-	.globl	mv64x60_console_baud
-mv64x60_console_baud:
-.long	EV64260_DEFAULT_BAUD
-
-	.globl	mv64x60_mpsc_clk_src
-mv64x60_mpsc_clk_src:
-.long	EV64260_MPSC_CLK_SRC
-
-	.globl	mv64x60_mpsc_clk_freq
-mv64x60_mpsc_clk_freq:
-.long	EV64260_MPSC_CLK_FREQ
-#endif
diff -Nru a/arch/ppc/boot/simple/misc-ev64260.c b/arch/ppc/boot/simple/misc-ev64260.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/misc-ev64260.c	2005-03-15 18:24:50 -07:00
@@ -0,0 +1,57 @@
+/*
+ * arch/ppc/boot/simple/misc-ev64260.c
+ *
+ * Host bridge init code for the Marvell/Galileo EV-64260-BP evaluation board
+ * with a GT64260 onboard.
+ *
+ * Author: Mark A. Greer <mgreer@mvista.com>
+ *
+ * 2001 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/reg.h>
+#include <asm/io.h>
+#include <asm/mv64x60_defs.h>
+#include <platforms/ev64260.h>
+
+#ifdef CONFIG_SERIAL_MPSC_CONSOLE
+extern u32 mv64x60_console_baud;
+extern u32 mv64x60_mpsc_clk_src;
+extern u32 mv64x60_mpsc_clk_freq;
+#endif
+
+void
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+	u32	p, v;
+
+	/* DINK doesn't enable 745x timebase, so enable here (Adrian Cox) */
+	p = mfspr(SPRN_PVR);
+	p >>= 16;
+
+	/* Reasonable SWAG at a 745x PVR value */
+	if (((p & 0xfff0) == 0x8000) && (p != 0x800c)) {
+		v = mfspr(SPRN_HID0);
+		v |= HID0_TBEN;
+		mtspr(SPRN_HID0, v);
+	}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+	/*
+	 * Change device bus 2 window so that bootoader can do I/O thru
+	 * 8250/16550 UART that's mapped in that window.
+	 */
+	out_le32(new_base + MV64x60_CPU2DEV_2_BASE, EV64260_UART_BASE >> 20);
+	out_le32(new_base + MV64x60_CPU2DEV_2_SIZE, EV64260_UART_END >> 20);
+	__asm__ __volatile__("sync");
+#elif defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	mv64x60_console_baud = EV64260_DEFAULT_BAUD;
+	mv64x60_mpsc_clk_src = EV64260_MPSC_CLK_SRC;
+	mv64x60_mpsc_clk_freq = EV64260_MPSC_CLK_FREQ;
+#endif
+}
diff -Nru a/arch/ppc/boot/simple/misc-katana.c b/arch/ppc/boot/simple/misc-katana.c
--- a/arch/ppc/boot/simple/misc-katana.c	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/misc-katana.c	2005-03-15 18:24:50 -07:00
@@ -1,7 +1,7 @@
 /*
  * arch/ppc/boot/simple/misc-katana.c
  *
- * Add birec data for Artesyn KATANA board.
+ * Set up MPSC values to bootwrapper can prompt user.
  *
  * Author: Mark A. Greer <source@mvista.com>
  *
@@ -11,5 +11,27 @@
  * or implied.
  */
 
+#include <linux/config.h>
 #include <linux/types.h>
-long	mv64x60_mpsc_clk_freq = 133333333;
+#include <asm/io.h>
+#include <asm/mv64x60_defs.h>
+#include <platforms/katana.h>
+
+extern u32 mv64x60_console_baud;
+extern u32 mv64x60_mpsc_clk_src;
+extern u32 mv64x60_mpsc_clk_freq;
+
+/* Not in the kernel so won't include kernel.h to get its 'min' definition */
+#ifndef min
+#define	min(a,b)	(((a) < (b)) ? (a) : (b))
+#endif
+
+void
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+	mv64x60_console_baud = KATANA_DEFAULT_BAUD;
+	mv64x60_mpsc_clk_src = KATANA_MPSC_CLK_SRC;
+	mv64x60_mpsc_clk_freq =
+		min(katana_bus_freq((void __iomem *)KATANA_CPLD_BASE),
+			MV64x60_TCLK_FREQ_MAX);
+}
diff -Nru a/arch/ppc/boot/simple/misc-mv64x60.S b/arch/ppc/boot/simple/misc-mv64x60.S
--- a/arch/ppc/boot/simple/misc-mv64x60.S	2005-03-15 18:24:50 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,61 +0,0 @@
-/*
- * arch/ppc/boot/simple/misc-mv64x60.S
- *
- * Code to change the base address of the host bridges and call board specific
- * init routine.
- *
- * Author: Mark Greer <mgreer@mvista.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under the terms
- * of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-#include <asm/ppc_asm.h>
-#include <asm/processor.h>
-#include <asm/cache.h>
-#include <asm/mv64x60_defs.h>
-
-	.globl	mv64x60_init
-mv64x60_init:
-	mflr	r27
-
-#if (CONFIG_MV64X60_NEW_BASE != CONFIG_MV64X60_BASE)
-	bl	move_base
-#endif
-	bl	mv64x60_board_init
-
-	mtlr	r27
-	blr
-
-#if (CONFIG_MV64X60_NEW_BASE != CONFIG_MV64X60_BASE)
-move_base:
-	li	r20,0
-#ifdef CONFIG_GT64260
-	li	r23,20
-#else /* Must be mv64[34]60 which uses top 16 bits */
-	li	r23,16
-#endif
-
-	/* Relocate bridge's regs */
-	addis	r25,0,CONFIG_MV64X60_BASE@h
-	ori	r25,r25,MV64x60_INTERNAL_SPACE_DECODE
-	lwbrx	r26,0,(r25)
-	lis	r24,0xffff
-	and	r26,r26,r24
-	addis	r24,0,CONFIG_MV64X60_NEW_BASE@h
-	srw	r24,r24,r23
-	or	r26,r26,r24
-	stwbrx	r26,0,(r25)
-	sync
-
-	/* Wait for write to take effect */
-	addis	r25,0,CONFIG_MV64X60_NEW_BASE@h
-	ori	r25,r25,MV64x60_INTERNAL_SPACE_DECODE
-1:	lwbrx	r24,0,(r25)
-	cmpw	r24,r26
-	bne	1b
-
-	blr
-#endif
diff -Nru a/arch/ppc/boot/simple/misc-mv64x60.c b/arch/ppc/boot/simple/misc-mv64x60.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/boot/simple/misc-mv64x60.c	2005-03-15 18:24:50 -07:00
@@ -0,0 +1,61 @@
+/*
+ * arch/ppc/boot/simple/misc-mv64x60.c
+ *
+ * Relocate bridge's register base and call board specific routine.
+ *
+ * Author: Mark A. Greer <source@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/io.h>
+#include <asm/mv64x60_defs.h>
+
+extern struct bi_record *decompress_kernel(unsigned long load_addr,
+	int num_words, unsigned long cksum);
+
+void
+mv64x60_move_base(void __iomem *old_base, void __iomem *new_base)
+{
+	u32	bits, mask, b;
+
+	if (old_base != new_base) {
+#ifdef CONFIG_GT64260
+		bits = 12; 
+		mask = 0x07000000;
+#else /* Must be mv64[34]60 */
+		bits = 16; 
+		mask = 0x03000000;
+#endif
+		b = in_le32(old_base + MV64x60_INTERNAL_SPACE_DECODE);
+		b &= mask;
+		b |= ((u32)new_base >> (32 - bits));
+		out_le32(old_base + MV64x60_INTERNAL_SPACE_DECODE, b);
+
+		__asm__ __volatile__("sync");
+
+		/* Wait for change to happen (in accordance with the manual) */
+		while (in_le32(new_base + MV64x60_INTERNAL_SPACE_DECODE) != b);
+	}
+}
+
+void __attribute__ ((weak))
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+}
+
+void *
+load_kernel(unsigned long load_addr, int num_words, unsigned long cksum,
+		void *ign1, void *ign2)
+{
+	mv64x60_move_base((void __iomem *)CONFIG_MV64X60_BASE,
+		(void __iomem *)CONFIG_MV64X60_NEW_BASE);
+	mv64x60_board_init((void __iomem *)CONFIG_MV64X60_BASE,
+		(void __iomem *)CONFIG_MV64X60_NEW_BASE);
+	return decompress_kernel(load_addr, num_words, cksum);
+}
diff -Nru a/arch/ppc/boot/simple/misc-radstone_ppc7d.c b/arch/ppc/boot/simple/misc-radstone_ppc7d.c
--- a/arch/ppc/boot/simple/misc-radstone_ppc7d.c	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/misc-radstone_ppc7d.c	2005-03-15 18:24:50 -07:00
@@ -7,13 +7,20 @@
  */
 
 #include <linux/types.h>
-#include <asm/reg.h>
-
-#include "../../platforms/radstone_ppc7d.h"
+#include <platforms/radstone_ppc7d.h>
 
 #if defined(CONFIG_SERIAL_MPSC_CONSOLE)
-long	mv64x60_mpsc_clk_freq = PPC7D_MPSC_CLK_FREQ;;
-long	mv64x60_mpsc_clk_src = PPC7D_MPSC_CLK_SRC;
-long	mv64x60_mpsc_console_baud = PPC7D_DEFAULT_BAUD;
+extern u32 mv64x60_console_baud;
+extern u32 mv64x60_mpsc_clk_src;
+extern u32 mv64x60_mpsc_clk_freq;
 #endif
 
+void
+mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
+{
+#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	mv64x60_console_baud = PPC7D_DEFAULT_BAUD;
+	mv64x60_mpsc_clk_src = PPC7D_MPSC_CLK_SRC;
+	mv64x60_mpsc_clk_freq = PPC7D_MPSC_CLK_FREQ;
+#endif
+}
diff -Nru a/arch/ppc/boot/simple/mv64x60_stub.c b/arch/ppc/boot/simple/mv64x60_stub.c
--- a/arch/ppc/boot/simple/mv64x60_stub.c	2005-03-15 18:24:50 -07:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,24 +0,0 @@
-/*
- * arch/ppc/boot/simple/mv64x60_stub.c
- *
- * Stub for board_init() routine called from mv64x60_init().
- *
- * Author: Mark A. Greer <mgreer@mvista.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under the terms
- * of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/config.h>
-
-#if defined(CONFIG_SERIAL_MPSC_CONSOLE)
-long __attribute__ ((weak))	mv64x60_console_baud = 9600;
-long __attribute__ ((weak))	mv64x60_mpsc_clk_src = 8; /* TCLK */
-long __attribute__ ((weak))	mv64x60_mpsc_clk_freq = 100000000;
-#endif
-
-void __attribute__ ((weak))
-mv64x60_board_init(void)
-{
-}
diff -Nru a/arch/ppc/boot/simple/mv64x60_tty.c b/arch/ppc/boot/simple/mv64x60_tty.c
--- a/arch/ppc/boot/simple/mv64x60_tty.c	2005-03-15 18:24:50 -07:00
+++ b/arch/ppc/boot/simple/mv64x60_tty.c	2005-03-15 18:24:50 -07:00
@@ -18,36 +18,18 @@
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 #include <asm/serial.h>
+#include <asm/io.h>
 #include <asm/mv64x60_defs.h>
 #include <mpsc_defs.h>
 
+u32	mv64x60_console_baud = 9600;
+u32	mv64x60_mpsc_clk_src = 8; /* TCLK */
+u32	mv64x60_mpsc_clk_freq = 100000000;
+
 extern void udelay(long);
 static void stop_dma(int chan);
 
-static u32	mv64x60_base = CONFIG_MV64X60_NEW_BASE;
-
-inline unsigned
-mv64x60_in_le32(volatile unsigned *addr)
-{
-	unsigned ret;
-
-	__asm__ __volatile__("lwbrx %0,0,%1; eieio" : "=r" (ret) :
-				"r" (addr), "m" (*addr));
-	return ret;
-}
-
-inline void
-mv64x60_out_le32(volatile unsigned *addr, int val)
-{
-	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
-				"r" (val), "r" (addr));
-}
-
-#define MV64x60_REG_READ(offs)						\
-	(mv64x60_in_le32((volatile uint *)(mv64x60_base + (offs))))
-#define MV64x60_REG_WRITE(offs, d)					\
-	(mv64x60_out_le32((volatile uint *)(mv64x60_base + (offs)), (int)(d)))
-
+static void __iomem *mv64x60_base = (void __iomem *)CONFIG_MV64X60_NEW_BASE;
 
 struct sdma_regs {
 	u32	sdc;
@@ -142,9 +124,6 @@
 {
 	u32		mpsc_routing_base, sdma_base, brg_bcr, cdv;
 	int		i;
-	extern long	mv64x60_console_baud;
-	extern long	mv64x60_mpsc_clk_src;
-	extern long	mv64x60_mpsc_clk_freq;
 
 	chan = (chan == 1); /* default to chan 0 if anything but 1 */
 
@@ -157,8 +136,7 @@
 		sdma_base = MV64x60_SDMA_0_OFFSET;
 		brg_bcr = MV64x60_BRG_0_OFFSET + BRG_BCR;
 		SDMA_REGS_INIT(&sdma_regs[0], MV64x60_SDMA_0_OFFSET);
-	}
-	else {
+	} else {
 		sdma_base = MV64x60_SDMA_1_OFFSET;
 		brg_bcr = MV64x60_BRG_1_OFFSET + BRG_BCR;
 		SDMA_REGS_INIT(&sdma_regs[0], MV64x60_SDMA_1_OFFSET);
@@ -186,10 +164,10 @@
 	td[chan][TX_NUM_DESC - 1].next_desc_ptr = (u32)&td[chan][0];
 
 	/* Set MPSC Routing */
-	MV64x60_REG_WRITE(mpsc_routing_base + MPSC_MRR, 0x3ffffe38);
+	out_le32(mv64x60_base + mpsc_routing_base + MPSC_MRR, 0x3ffffe38);
 
 #ifdef CONFIG_GT64260
-	MV64x60_REG_WRITE(GT64260_MPP_SERIAL_PORTS_MULTIPLEX, 0x00001102);
+	out_le32(mv64x60_base + GT64260_MPP_SERIAL_PORTS_MULTIPLEX, 0x00001102);
 #else /* Must be MV64360 or MV64460 */
 	{
 	u32	enables, prot_bits, v;
@@ -197,68 +175,70 @@
 	/* Set up comm unit to memory mapping windows */
 	/* Note: Assumes MV64x60_CPU2MEM_WINDOWS == 4 */
 
-	enables = MV64x60_REG_READ(MV64360_CPU_BAR_ENABLE) & 0xf;
+	enables = in_le32(mv64x60_base + MV64360_CPU_BAR_ENABLE) & 0xf;
 	prot_bits = 0;
 
 	for (i=0; i<MV64x60_CPU2MEM_WINDOWS; i++) {
 		if (!(enables & (1 << i))) {
-			v = MV64x60_REG_READ(cpu2mem_tab[i][0]);
+			v = in_le32(mv64x60_base + cpu2mem_tab[i][0]);
 			v = ((v & 0xffff) << 16) | (dram_selects[i] << 8);
-			MV64x60_REG_WRITE(com2mem_tab[i][0], v);
+			out_le32(mv64x60_base + com2mem_tab[i][0], v);
 
-			v = MV64x60_REG_READ(cpu2mem_tab[i][1]);
+			v = in_le32(mv64x60_base + cpu2mem_tab[i][1]);
 			v = (v & 0xffff) << 16;
-			MV64x60_REG_WRITE(com2mem_tab[i][1], v);
+			out_le32(mv64x60_base + com2mem_tab[i][1], v);
 
 			prot_bits |= (0x3 << (i << 1)); /* r/w access */
 		}
 	}
 
-	MV64x60_REG_WRITE(MV64360_MPSC_0_REMAP, 0);
-	MV64x60_REG_WRITE(MV64360_MPSC_1_REMAP, 0);
-	MV64x60_REG_WRITE(MV64360_MPSC2MEM_ACC_PROT_0, prot_bits);
-	MV64x60_REG_WRITE(MV64360_MPSC2MEM_ACC_PROT_1, prot_bits);
-	MV64x60_REG_WRITE(MV64360_MPSC2MEM_BAR_ENABLE, enables);
+	out_le32(mv64x60_base + MV64360_MPSC_0_REMAP, 0);
+	out_le32(mv64x60_base + MV64360_MPSC_1_REMAP, 0);
+	out_le32(mv64x60_base + MV64360_MPSC2MEM_ACC_PROT_0, prot_bits);
+	out_le32(mv64x60_base + MV64360_MPSC2MEM_ACC_PROT_1, prot_bits);
+	out_le32(mv64x60_base + MV64360_MPSC2MEM_BAR_ENABLE, enables);
 	}
 #endif
 
 	/* MPSC 0/1 Rx & Tx get clocks BRG0/1 */
-	MV64x60_REG_WRITE(mpsc_routing_base + MPSC_RCRR, 0x00000100);
-	MV64x60_REG_WRITE(mpsc_routing_base + MPSC_TCRR, 0x00000100);
+	out_le32(mv64x60_base + mpsc_routing_base + MPSC_RCRR, 0x00000100);
+	out_le32(mv64x60_base + mpsc_routing_base + MPSC_TCRR, 0x00000100);
 
 	/* clear pending interrupts */
-	MV64x60_REG_WRITE(MV64x60_SDMA_INTR_OFFSET + SDMA_INTR_MASK, 0);
+	out_le32(mv64x60_base + MV64x60_SDMA_INTR_OFFSET + SDMA_INTR_MASK, 0);
 
-	MV64x60_REG_WRITE(SDMA_SCRDP + sdma_base, &rd[chan][0]);
-	MV64x60_REG_WRITE(SDMA_SCTDP + sdma_base, &td[chan][TX_NUM_DESC - 1]);
-	MV64x60_REG_WRITE(SDMA_SFTDP + sdma_base, &td[chan][TX_NUM_DESC - 1]);
+	out_le32(mv64x60_base + SDMA_SCRDP + sdma_base, (int)&rd[chan][0]);
+	out_le32(mv64x60_base + SDMA_SCTDP + sdma_base,
+		(int)&td[chan][TX_NUM_DESC - 1]);
+	out_le32(mv64x60_base + SDMA_SFTDP + sdma_base,
+		(int)&td[chan][TX_NUM_DESC - 1]);
 
-	MV64x60_REG_WRITE(SDMA_SDC + sdma_base,
+	out_le32(mv64x60_base + SDMA_SDC + sdma_base,
 		SDMA_SDC_RFT | SDMA_SDC_SFM | SDMA_SDC_BLMR | SDMA_SDC_BLMT |
 		(3 << 12));
 
 	cdv = ((mv64x60_mpsc_clk_freq/(32*mv64x60_console_baud))-1);
-	MV64x60_REG_WRITE(brg_bcr,
+	out_le32(mv64x60_base + brg_bcr,
 		((mv64x60_mpsc_clk_src << 18) | (1 << 16) | cdv));
 
 	/* Put MPSC into UART mode, no null modem, 16x clock mode */
-	MV64x60_REG_WRITE(MPSC_MMCRL + mpsc_base[chan], 0x000004c4);
-	MV64x60_REG_WRITE(MPSC_MMCRH + mpsc_base[chan], 0x04400400);
+	out_le32(mv64x60_base + MPSC_MMCRL + mpsc_base[chan], 0x000004c4);
+	out_le32(mv64x60_base + MPSC_MMCRH + mpsc_base[chan], 0x04400400);
 
-	MV64x60_REG_WRITE(MPSC_CHR_1 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_9 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_10 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_3 + mpsc_base[chan], 4);
-	MV64x60_REG_WRITE(MPSC_CHR_4 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_5 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_6 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_7 + mpsc_base[chan], 0);
-	MV64x60_REG_WRITE(MPSC_CHR_8 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_1 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_9 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_10 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_3 + mpsc_base[chan], 4);
+	out_le32(mv64x60_base + MPSC_CHR_4 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_5 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_6 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_7 + mpsc_base[chan], 0);
+	out_le32(mv64x60_base + MPSC_CHR_8 + mpsc_base[chan], 0);
 
 	/* 8 data bits, 1 stop bit */
-	MV64x60_REG_WRITE(MPSC_MPCR + mpsc_base[chan], (3 << 12));
-	MV64x60_REG_WRITE(SDMA_SDCM + sdma_base, SDMA_SDCM_ERD);
-	MV64x60_REG_WRITE(MPSC_CHR_2 + mpsc_base[chan], MPSC_CHR_2_EH);
+	out_le32(mv64x60_base + MPSC_MPCR + mpsc_base[chan], (3 << 12));
+	out_le32(mv64x60_base + SDMA_SDCM + sdma_base, SDMA_SDCM_ERD);
+	out_le32(mv64x60_base + MPSC_CHR_2 + mpsc_base[chan], MPSC_CHR_2_EH);
 
 	udelay(100);
 
@@ -271,20 +251,19 @@
 	int	i;
 
 	/* Abort MPSC Rx (aborting Tx messes things up) */
-	MV64x60_REG_WRITE(MPSC_CHR_2 + mpsc_base[chan], MPSC_CHR_2_RA);
+	out_le32(mv64x60_base + MPSC_CHR_2 + mpsc_base[chan], MPSC_CHR_2_RA);
 
 	/* Abort SDMA Rx, Tx */
-	MV64x60_REG_WRITE(sdma_regs[chan].sdcm, SDMA_SDCM_AR | SDMA_SDCM_STD);
+	out_le32(mv64x60_base + sdma_regs[chan].sdcm,
+		SDMA_SDCM_AR | SDMA_SDCM_STD);
 
 	for (i=0; i<MAX_RESET_WAIT; i++) {
-		if ((MV64x60_REG_READ(sdma_regs[chan].sdcm) &
+		if ((in_le32(mv64x60_base + sdma_regs[chan].sdcm) &
 				(SDMA_SDCM_AR | SDMA_SDCM_AT)) == 0)
 			break;
 
 		udelay(100);
 	}
-
-	return;
 }
 
 static int
@@ -293,7 +272,7 @@
 	int	i;
 
 	for (i=0; i<MAX_TX_WAIT; i++) {
-		if ((MV64x60_REG_READ(sdma_regs[chan].sdcm) &
+		if ((in_le32(mv64x60_base + sdma_regs[chan].sdcm) &
 				SDMA_SDCM_TXD) == 0)
 			break;
 
@@ -321,12 +300,11 @@
 	tdp->cmd_stat = SDMA_DESC_CMDSTAT_L | SDMA_DESC_CMDSTAT_F |
 		SDMA_DESC_CMDSTAT_O;
 
-	MV64x60_REG_WRITE(sdma_regs[com_port].sctdp, tdp);
-	MV64x60_REG_WRITE(sdma_regs[com_port].sftdp, tdp);
-	MV64x60_REG_WRITE(sdma_regs[com_port].sdcm,
-		MV64x60_REG_READ(sdma_regs[com_port].sdcm) | SDMA_SDCM_TXD);
-
-	return;
+	out_le32(mv64x60_base + sdma_regs[com_port].sctdp, (int)tdp);
+	out_le32(mv64x60_base + sdma_regs[com_port].sftdp, (int)tdp);
+	out_le32(mv64x60_base + sdma_regs[com_port].sdcm,
+		in_le32(mv64x60_base + sdma_regs[com_port].sdcm) |
+			SDMA_SDCM_TXD);
 }
 
 unsigned char
@@ -366,8 +344,7 @@
 			if (++cur_rd[com_port] >= RX_NUM_DESC)
 				cur_rd[com_port] = 0;
 			rdp = (struct mv64x60_rx_desc *)rdp->next_desc_ptr;
-		}
-		else {
+		} else {
 			rc = 1;
 			break;
 		}
@@ -380,5 +357,4 @@
 serial_close(unsigned long com_port)
 {
 	stop_dma(com_port);
-	return;
 }

--------------010602040209090307070407--
