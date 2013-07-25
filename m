Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 119D52C00DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 12:12:39 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r6P2CXa4024194
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 21:12:35 -0500
Message-ID: <1374718352.6142.48.camel@pasglop>
Subject: [PATCH] powerpc/pmac: Early debug output on screen on 64-bit macs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 25 Jul 2013 12:12:32 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a bunch of CONFIG_PPC_EARLY_DEBUG_* options that are intended
for bringup/debug only. They hard wire a machine specific udbg backend
very early on (before we even probe the platform), and use whatever
tricks are available on each machine/cpu to be able to get some kind
of output out there early on.

So far, on powermac with no serial ports, we have CONFIG_PPC_EARLY_DEBUG_BOOTX
to use the low-level btext engine on the screen, but it doesn't do much, at
least on 64-bit. It only really gets enabled after the platform has been
probed and the MMU enabled.

This adds a way to enable it much earlier. From prom_init.c (while still
running with Open Firmware), we grab the screen details and set things up
using the physical address of the frame buffer.

Then btext itself uses the "rm_ci" feature of the 970 processor (Real
Mode Cache Inhibited) to access it while in real mode.

We need to do a little bit of reorg of the btext code to inline things
better, in order to limit how much we touch memory while in this mode as
the consequences might be ... interesting.

This successfully allowed me to debug problems early on with the G5
(related to gold being broken vs. ppc64 kernels).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/include/asm/btext.h b/arch/powerpc/include/asm/btext.h
index 906f46e..89fc382 100644
--- a/arch/powerpc/include/asm/btext.h
+++ b/arch/powerpc/include/asm/btext.h
@@ -13,6 +13,7 @@ extern void btext_update_display(unsigned long phys, int width, int height,
 extern void btext_setup_display(int width, int height, int depth, int pitch,
 				unsigned long address);
 extern void btext_prepare_BAT(void);
+extern void btext_map(void);
 extern void btext_unmap(void);
 
 extern void btext_drawchar(char c);
diff --git a/arch/powerpc/kernel/btext.c b/arch/powerpc/kernel/btext.c
index ac8f527..0428992 100644
--- a/arch/powerpc/kernel/btext.c
+++ b/arch/powerpc/kernel/btext.c
@@ -25,11 +25,6 @@
 static void scrollscreen(void);
 #endif
 
-static void draw_byte(unsigned char c, long locX, long locY);
-static void draw_byte_32(unsigned char *bits, unsigned int *base, int rb);
-static void draw_byte_16(unsigned char *bits, unsigned int *base, int rb);
-static void draw_byte_8(unsigned char *bits, unsigned int *base, int rb);
-
 #define __force_data __attribute__((__section__(".data")))
 
 static int g_loc_X __force_data;
@@ -52,6 +47,26 @@ static unsigned char vga_font[cmapsz];
 int boot_text_mapped __force_data = 0;
 int force_printk_to_btext = 0;
 
+extern void rmci_on(void);
+extern void rmci_off(void);
+
+static inline void rmci_maybe_on(void)
+{
+#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+	if (!(mfmsr() & MSR_DR))
+		rmci_on();
+#endif
+}
+
+static inline void rmci_maybe_off(void)
+{
+#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+	if (!(mfmsr() & MSR_DR))
+		rmci_off();
+#endif
+}
+
+
 #ifdef CONFIG_PPC32
 /* Calc BAT values for mapping the display and store them
  * in disp_BAT.  Those values are then used from head.S to map
@@ -134,7 +149,7 @@ void __init btext_unmap(void)
  *    changes.
  */
 
-static void map_boot_text(void)
+void btext_map(void)
 {
 	unsigned long base, offset, size;
 	unsigned char *vbase;
@@ -209,7 +224,7 @@ int btext_initialize(struct device_node *np)
 	dispDeviceRect[2] = width;
 	dispDeviceRect[3] = height;
 
-	map_boot_text();
+	btext_map();
 
 	return 0;
 }
@@ -283,7 +298,7 @@ void btext_update_display(unsigned long phys, int width, int height,
 		iounmap(logicalDisplayBase);
 		boot_text_mapped = 0;
 	}
-	map_boot_text();
+	btext_map();
 	g_loc_X = 0;
 	g_loc_Y = 0;
 	g_max_loc_X = width / 8;
@@ -298,6 +313,7 @@ void btext_clearscreen(void)
 					(dispDeviceDepth >> 3)) >> 2;
 	int i,j;
 
+	rmci_maybe_on();
 	for (i=0; i<(dispDeviceRect[3] - dispDeviceRect[1]); i++)
 	{
 		unsigned int *ptr = base;
@@ -305,6 +321,7 @@ void btext_clearscreen(void)
 			*(ptr++) = 0;
 		base += (dispDeviceRowBytes >> 2);
 	}
+	rmci_maybe_off();
 }
 
 void btext_flushscreen(void)
@@ -355,6 +372,8 @@ static void scrollscreen(void)
 				   (dispDeviceDepth >> 3)) >> 2;
 	int i,j;
 
+	rmci_maybe_on();
+
 	for (i=0; i<(dispDeviceRect[3] - dispDeviceRect[1] - 16); i++)
 	{
 		unsigned int *src_ptr = src;
@@ -371,9 +390,116 @@ static void scrollscreen(void)
 			*(dst_ptr++) = 0;
 		dst += (dispDeviceRowBytes >> 2);
 	}
+
+	rmci_maybe_off();
 }
 #endif /* ndef NO_SCROLL */
 
+static unsigned int expand_bits_8[16] = {
+	0x00000000,
+	0x000000ff,
+	0x0000ff00,
+	0x0000ffff,
+	0x00ff0000,
+	0x00ff00ff,
+	0x00ffff00,
+	0x00ffffff,
+	0xff000000,
+	0xff0000ff,
+	0xff00ff00,
+	0xff00ffff,
+	0xffff0000,
+	0xffff00ff,
+	0xffffff00,
+	0xffffffff
+};
+
+static unsigned int expand_bits_16[4] = {
+	0x00000000,
+	0x0000ffff,
+	0xffff0000,
+	0xffffffff
+};
+
+
+static void draw_byte_32(unsigned char *font, unsigned int *base, int rb)
+{
+	int l, bits;
+	int fg = 0xFFFFFFFFUL;
+	int bg = 0x00000000UL;
+
+	for (l = 0; l < 16; ++l)
+	{
+		bits = *font++;
+		base[0] = (-(bits >> 7) & fg) ^ bg;
+		base[1] = (-((bits >> 6) & 1) & fg) ^ bg;
+		base[2] = (-((bits >> 5) & 1) & fg) ^ bg;
+		base[3] = (-((bits >> 4) & 1) & fg) ^ bg;
+		base[4] = (-((bits >> 3) & 1) & fg) ^ bg;
+		base[5] = (-((bits >> 2) & 1) & fg) ^ bg;
+		base[6] = (-((bits >> 1) & 1) & fg) ^ bg;
+		base[7] = (-(bits & 1) & fg) ^ bg;
+		base = (unsigned int *) ((char *)base + rb);
+	}
+}
+
+static inline void draw_byte_16(unsigned char *font, unsigned int *base, int rb)
+{
+	int l, bits;
+	int fg = 0xFFFFFFFFUL;
+	int bg = 0x00000000UL;
+	unsigned int *eb = (int *)expand_bits_16;
+
+	for (l = 0; l < 16; ++l)
+	{
+		bits = *font++;
+		base[0] = (eb[bits >> 6] & fg) ^ bg;
+		base[1] = (eb[(bits >> 4) & 3] & fg) ^ bg;
+		base[2] = (eb[(bits >> 2) & 3] & fg) ^ bg;
+		base[3] = (eb[bits & 3] & fg) ^ bg;
+		base = (unsigned int *) ((char *)base + rb);
+	}
+}
+
+static inline void draw_byte_8(unsigned char *font, unsigned int *base, int rb)
+{
+	int l, bits;
+	int fg = 0x0F0F0F0FUL;
+	int bg = 0x00000000UL;
+	unsigned int *eb = (int *)expand_bits_8;
+
+	for (l = 0; l < 16; ++l)
+	{
+		bits = *font++;
+		base[0] = (eb[bits >> 4] & fg) ^ bg;
+		base[1] = (eb[bits & 0xf] & fg) ^ bg;
+		base = (unsigned int *) ((char *)base + rb);
+	}
+}
+
+static noinline void draw_byte(unsigned char c, long locX, long locY)
+{
+	unsigned char *base	= calc_base(locX << 3, locY << 4);
+	unsigned char *font	= &vga_font[((unsigned int)c) * 16];
+	int rb			= dispDeviceRowBytes;
+
+	rmci_maybe_on();
+	switch(dispDeviceDepth) {
+	case 24:
+	case 32:
+		draw_byte_32(font, (unsigned int *)base, rb);
+		break;
+	case 15:
+	case 16:
+		draw_byte_16(font, (unsigned int *)base, rb);
+		break;
+	case 8:
+		draw_byte_8(font, (unsigned int *)base, rb);
+		break;
+	}
+	rmci_maybe_off();
+}
+
 void btext_drawchar(char c)
 {
 	int cline = 0;
@@ -465,107 +591,12 @@ void btext_drawhex(unsigned long v)
 	btext_drawchar(' ');
 }
 
-static void draw_byte(unsigned char c, long locX, long locY)
-{
-	unsigned char *base	= calc_base(locX << 3, locY << 4);
-	unsigned char *font	= &vga_font[((unsigned int)c) * 16];
-	int rb			= dispDeviceRowBytes;
-
-	switch(dispDeviceDepth) {
-	case 24:
-	case 32:
-		draw_byte_32(font, (unsigned int *)base, rb);
-		break;
-	case 15:
-	case 16:
-		draw_byte_16(font, (unsigned int *)base, rb);
-		break;
-	case 8:
-		draw_byte_8(font, (unsigned int *)base, rb);
-		break;
-	}
-}
-
-static unsigned int expand_bits_8[16] = {
-	0x00000000,
-	0x000000ff,
-	0x0000ff00,
-	0x0000ffff,
-	0x00ff0000,
-	0x00ff00ff,
-	0x00ffff00,
-	0x00ffffff,
-	0xff000000,
-	0xff0000ff,
-	0xff00ff00,
-	0xff00ffff,
-	0xffff0000,
-	0xffff00ff,
-	0xffffff00,
-	0xffffffff
-};
-
-static unsigned int expand_bits_16[4] = {
-	0x00000000,
-	0x0000ffff,
-	0xffff0000,
-	0xffffffff
-};
-
-
-static void draw_byte_32(unsigned char *font, unsigned int *base, int rb)
-{
-	int l, bits;
-	int fg = 0xFFFFFFFFUL;
-	int bg = 0x00000000UL;
-
-	for (l = 0; l < 16; ++l)
-	{
-		bits = *font++;
-		base[0] = (-(bits >> 7) & fg) ^ bg;
-		base[1] = (-((bits >> 6) & 1) & fg) ^ bg;
-		base[2] = (-((bits >> 5) & 1) & fg) ^ bg;
-		base[3] = (-((bits >> 4) & 1) & fg) ^ bg;
-		base[4] = (-((bits >> 3) & 1) & fg) ^ bg;
-		base[5] = (-((bits >> 2) & 1) & fg) ^ bg;
-		base[6] = (-((bits >> 1) & 1) & fg) ^ bg;
-		base[7] = (-(bits & 1) & fg) ^ bg;
-		base = (unsigned int *) ((char *)base + rb);
-	}
-}
-
-static void draw_byte_16(unsigned char *font, unsigned int *base, int rb)
-{
-	int l, bits;
-	int fg = 0xFFFFFFFFUL;
-	int bg = 0x00000000UL;
-	unsigned int *eb = (int *)expand_bits_16;
-
-	for (l = 0; l < 16; ++l)
-	{
-		bits = *font++;
-		base[0] = (eb[bits >> 6] & fg) ^ bg;
-		base[1] = (eb[(bits >> 4) & 3] & fg) ^ bg;
-		base[2] = (eb[(bits >> 2) & 3] & fg) ^ bg;
-		base[3] = (eb[bits & 3] & fg) ^ bg;
-		base = (unsigned int *) ((char *)base + rb);
-	}
-}
-
-static void draw_byte_8(unsigned char *font, unsigned int *base, int rb)
+void __init udbg_init_btext(void)
 {
-	int l, bits;
-	int fg = 0x0F0F0F0FUL;
-	int bg = 0x00000000UL;
-	unsigned int *eb = (int *)expand_bits_8;
-
-	for (l = 0; l < 16; ++l)
-	{
-		bits = *font++;
-		base[0] = (eb[bits >> 4] & fg) ^ bg;
-		base[1] = (eb[bits & 0xf] & fg) ^ bg;
-		base = (unsigned int *) ((char *)base + rb);
-	}
+	/* If btext is enabled, we might have a BAT setup for early display,
+	 * thus we do enable some very basic udbg output
+	 */
+	udbg_putc = btext_drawchar;
 }
 
 static unsigned char vga_font[cmapsz] = {
@@ -913,10 +944,3 @@ static unsigned char vga_font[cmapsz] = {
 0x00, 0x00, 0x00, 0x00,
 };
 
-void __init udbg_init_btext(void)
-{
-	/* If btext is enabled, we might have a BAT setup for early display,
-	 * thus we do enable some very basic udbg output
-	 */
-	udbg_putc = btext_drawchar;
-}
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 6820e45..5a29bc5 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -247,6 +247,37 @@ _GLOBAL(__bswapdi2)
 	blr
 
 #if defined(CONFIG_PPC_PMAC) || defined(CONFIG_PPC_MAPLE)
+
+_GLOBAL(rmci_on)
+	sync
+	isync
+	li	r3,0x100
+	rldicl	r3,r3,32,0
+	mfspr	r5,SPRN_HID4
+	or	r5,r5,r3
+	sync
+	mtspr	SPRN_HID4,r5
+	isync
+	slbia
+	isync
+	sync
+	blr
+
+_GLOBAL(rmci_off)
+	sync
+	isync
+	li	r3,0x100
+	rldicl	r3,r3,32,0
+	mfspr	r5,SPRN_HID4
+	andc	r5,r5,r3
+	sync
+	mtspr	SPRN_HID4,r5
+	isync
+	slbia
+	isync
+	sync
+	blr
+
 /*
  * Do an IO access in real mode
  */
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6079024..57df5cb 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2082,6 +2082,22 @@ static void __init prom_check_displays(void)
 					   clut[2]) != 0)
 				break;
 #endif /* CONFIG_LOGO_LINUX_CLUT224 */
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+		if (prom_getprop(node, "linux,boot-display", NULL, 0) !=
+		    PROM_ERROR) {
+			u32 width, height, pitch, addr;
+
+			prom_printf("Setting btext !\n");
+			prom_getprop(node, "width", &width, 4);
+			prom_getprop(node, "height", &height, 4);
+			prom_getprop(node, "linebytes", &pitch, 4);
+			prom_getprop(node, "address", &addr, 4);
+			prom_printf("W=%d H=%d LB=%d addr=0x%x\n",
+				    width, height, pitch, addr);
+			btext_setup_display(width, height, 8, pitch, addr);
+		}
+#endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
 	}
 }
 
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 3765da6..b0c263d 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -22,7 +22,8 @@ __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
 reloc_got2 kernstart_addr memstart_addr linux_banner _stext
 opal_query_takeover opal_do_takeover opal_enter_rtas opal_secondary_entry
-boot_command_line __prom_init_toc_start __prom_init_toc_end"
+boot_command_line __prom_init_toc_start __prom_init_toc_end
+btext_setup_display"
 
 NM="$1"
 OBJ="$2"
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 389fb807..7016a13 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -10,7 +10,7 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define DEBUG
 
 #include <linux/export.h>
 #include <linux/string.h>
@@ -237,6 +237,18 @@ void __init early_setup(unsigned long dt_ptr)
 	reserve_hugetlb_gpages();
 
 	DBG(" <- early_setup()\n");
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
+	/*
+	 * This needs to be done *last* (after the above DBG() even)
+	 *
+	 * Right after we return from this function, we turn on the MMU
+	 * which means the real-mode access trick that btext does will
+	 * no longer work, it needs to switch to using a real MMU
+	 * mapping. This call will ensure that it does
+	 */
+	btext_map();
+#endif /* CONFIG_PPC_EARLY_DEBUG_BOOTX */
 }
 
 #ifdef CONFIG_SMP
