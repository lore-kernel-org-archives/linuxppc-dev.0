Date: Mon, 9 Jul 2001 17:08:50 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jeff Rugen <jprugen@earthlink.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: RTC and SCSI for PowerStack/2.4.6 Kernel
In-Reply-To: <20010709075703.G825@opus.bloom.county>
Message-ID: <Pine.LNX.4.05.10107091706100.15110-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 9 Jul 2001, Tom Rini wrote:
> On Mon, Jul 09, 2001 at 07:38:58AM -0700, Jeff Rugen wrote:
> > I've booted 2.4.6 successfully 4 times so far -- 2 times it crashed with
> > SCSI timeouts, and 2 times it hung for unknown reasons (with no oops output
> > or anything).  The second time it might have been framebuffer or network
> > related (I'd installed clgenfb, changed video modes, and then did 'dir' in
> > an ftp session to a site with a long directory listing twice -- the second
> > time it hung).
>
> Did you do any fixes/cleanups to clgenfb?  I took a stab and trying to
> re-do your PReP fixes in it a while back, but I don't think it ever got
> into the main tree.

There's still an off-by-one error in the PCI probing. Patch below from the m68k
tree (which needs other fixes for Zorro boards).

Hmmm, perhaps you still need the <asm/io.h> for PCI. Please let me know...

--- linux-2.4.6/drivers/video/clgenfb.c	Fri Mar 30 14:27:05 2001
+++ linux-m68k-2.4.6/drivers/video/clgenfb.c	Thu Jul  5 14:52:08 2001
@@ -46,7 +46,7 @@
 #include <linux/init.h>
 #include <linux/selection.h>
 #include <asm/pgtable.h>
-#include <asm/io.h>
+
 #ifdef CONFIG_ZORRO
 #include <linux/zorro.h>
 #endif
@@ -286,22 +286,28 @@
 static const struct {
 	clgen_board_t btype;
 	zorro_id id, id2;
+	unsigned long size;
 } clgen_zorro_probe_list[] __initdata = {
 	{ BT_SD64,
 		ZORRO_PROD_HELFRICH_SD64_RAM,
-		ZORRO_PROD_HELFRICH_SD64_REG },
+		ZORRO_PROD_HELFRICH_SD64_REG,
+		0x400000 },
 	{ BT_PICCOLO,
 		ZORRO_PROD_HELFRICH_PICCOLO_RAM,
-		ZORRO_PROD_HELFRICH_PICCOLO_REG },
+		ZORRO_PROD_HELFRICH_PICCOLO_REG,
+		0x200000 },
 	{ BT_PICASSO,
 		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_RAM,
-		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG },
+		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_II_II_PLUS_REG,
+		0x200000 },
 	{ BT_SPECTRUM,
 		ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_RAM,
-		ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG },
+		ZORRO_PROD_GVP_EGS_28_24_SPECTRUM_REG,
+		0x200000 },
 	{ BT_PICASSO4,
 		ZORRO_PROD_VILLAGE_TRONIC_PICASSO_IV_Z3,
-		0 },
+		0,
+		0x400000 },
 };
 #endif /* CONFIG_ZORRO */

@@ -1479,7 +1485,8 @@
 		WGen (fb_info, VGA_PEL_MSK, 0xff);	/* pixel mask: pass-through all planes */
 #ifdef CONFIG_PCI
 		WHDR (fb_info, 0xc0);	/* Copy Xbh */
-#elif CONFIG_ZORRO
+#elif defined(CONFIG_ZORRO)
+		/* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined both */
 		WHDR (fb_info, 0xa0);	/* hidden dac reg: nothing special */
 #endif
 		vga_wseq (fb_info->regs, VGA_SEQ_MEMORY_MODE, 0x0a);	/* memory mode: chain4, ext. memory */
@@ -1918,16 +1925,7 @@
 		break;
 	}

-#ifdef CLGEN_USE_HARDCODED_RAM_SETTINGS
-	/* "pre-set" a RAMsize; if the test succeeds, double it */
-	if (fb_info->btype == BT_SD64 ||
-	    fb_info->btype == BT_PICASSO4)
-		fb_info->size = 0x400000;
-	else
-		fb_info->size = 0x200000;
-#else
 	assert (fb_info->size > 0); /* make sure RAM size set by this point */
-#endif

 	/* assume it's a "large memory" board (2/4 MB) */
 	fb_info->smallboard = FALSE;
@@ -2434,7 +2432,7 @@
 		while ((pdev = pci_find_device (PCI_VENDOR_ID_CIRRUS,
 				clgen_pci_probe_list[i].device, pdev)) != NULL) {
 			if (pci_enable_device(pdev) == 0) {
-				*btype = clgen_pci_probe_list[i - 1].btype;
+				*btype = clgen_pci_probe_list[i].btype;
 				DPRINTK ("EXIT, returning pdev=%p\n", pdev);
 				return pdev;
 			}
@@ -2572,7 +2570,7 @@
 #ifdef CONFIG_ZORRO
 static int __init clgen_zorro_find (struct zorro_dev **z_o,
 				    struct zorro_dev **z2_o,
-				    clgen_board_t *btype)
+				    clgen_board_t *btype, unsigned long *size)
 {
 	struct zorro_dev *z = NULL;
 	int i;
@@ -2590,7 +2588,8 @@
 			*z2_o = zorro_find_device(clgen_zorro_probe_list[i].id2, NULL);
 		else
 			*z2_o = NULL;
-		*btype = clgen_zorro_probe_list[i - 1].btype;
+		*btype = clgen_zorro_probe_list[i].btype;
+		*size = clgen_zorro_probe_list[i].size;

 		printk (KERN_INFO "clgen: %s board detected; ",
 			clgen_board_info[*btype].name);
@@ -2621,12 +2620,12 @@
 				     clgen_board_t *btype)
 {
 	struct zorro_dev *z = NULL, *z2 = NULL;
-	unsigned long board_addr, board_size;
+	unsigned long board_addr, board_size, size;

 	assert (info != NULL);
 	assert (btype != NULL);

-	if (clgen_zorro_find (&z, &z2, btype))
+	if (clgen_zorro_find (&z, &z2, btype, &size))
 		return -1;

 	assert (z > 0);
@@ -2635,6 +2634,7 @@

 	info->board_addr = board_addr = z->resource.start;
 	info->board_size = board_size = z->resource.end-z->resource.start+1;
+	info->size = size;

 	if (!request_mem_region(board_addr, board_size, "clgenfb")) {
 		printk(KERN_ERR "clgen: cannot reserve region 0x%lx, abort\n",
@@ -2704,7 +2704,8 @@
 		return -ENXIO;
 	}

-#elif CONFIG_ZORRO
+#elif defined(CONFIG_ZORRO)
+	/* FIXME: CONFIG_PCI and CONFIG_ZORRO may be defined both */
 	if (clgen_zorro_setup (fb_info, &btype)) {
 		DPRINTK ("EXIT, returning -ENXIO\n");
 		return -ENXIO;
@@ -2966,7 +2967,7 @@
 #ifdef CONFIG_ZORRO
 	assert (fb_info->regs != NULL);
 	fb_info->SFR = val;
-	writeb (val, fb_info->regs + 0x8000);
+	z_writeb (val, fb_info->regs + 0x8000);
 #endif
 }

@@ -2978,7 +2979,7 @@
 	/* to flip to Amiga display */
 	assert (fb_info->regs != NULL);
 	fb_info->SFR = val;
-	writeb (val, fb_info->regs + 0x9000);
+	z_writeb (val, fb_info->regs + 0x9000);
 #endif
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
