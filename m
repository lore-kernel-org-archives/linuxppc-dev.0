Date: Thu, 28 Sep 2000 13:18:19 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: R Shapiro <rshapiro@bbn.com>,
        Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009272022070.27656-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.10009281310500.3468-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 27 Sep 2000, Michael Schmitz wrote:
> So here we have three fb devices in the kernel (you could check with
> fbset that each is in fact accessible via /dev/fb[0-2]), and XFree unable
> to cope. You specify the PCI bus ID but not the corresponding framebuffer
> device node - I heard someone mention this was possible when I was
> fighting the Lombard crashes, could anyone point out the syntax to use
> there?
>
> If we can't specify the fb node XFree will have to probe for it (Geert
> mentioned an easy way to do that: open the device and compare
> pScrn->memPhysBase or fPtr->fix.smem_start to the PCI base address).

Besides, the current fbdev_open_pci() can't cope with multiple cards of the
same type, and doesn't recognize ATI Mach64.

> BTW Geert: why is fPtr->fboff calculated from fix.smem_len not
> fix.smem_start while pScrn->fbOffset is calculated from fix.smem_start?

That's indeed incorrect. But it's not the only bug in that part of the code
:-)

Hmmm... I just noticed I kept that bug in my version...

For reference, these are my (untested) patches...
Michel, I'll send you a diff relative to my previous version.

diff -urN michel/fbdevhw.c geert-3/fbdevhw.c
--- michel/fbdevhw.c	Mon Aug 28 16:36:59 2000
+++ geert-3/fbdevhw.c	Thu Sep 28 13:15:54 2000
@@ -86,8 +86,10 @@
 	char*				device;
 	int				fd;
 	void*				fbmem;
-	int				fboff;
+	unsigned int			fbmem_len;
+	unsigned int			fboff;
 	void*				mmio;
+	unsigned int			mmio_len;

 	/* current hardware state */
 	struct fb_fix_screeninfo	fix;
@@ -95,6 +97,8 @@

 	/* saved video mode */
 	struct fb_var_screeninfo	saved_var;
+
+	/* FIXME: unused??? [geert] */
 	struct fb_cmap			saved_cmap;
 	unsigned short			*saved_red;
 	unsigned short			*saved_green;
@@ -194,7 +198,7 @@
 		var->sync |= FB_SYNC_VERT_HIGH_ACT;
 	if (mode->Flags & V_PCSYNC)
 		var->sync |= FB_SYNC_COMP_HIGH_ACT;
-#if 0
+#if 1 /* Badly needed for PAL/NTSC on Amiga (amifb)!! [geert] */
 	if (mode->Flags & V_BCAST)
 		var->sync |= FB_SYNC_BROADCAST;
 #endif
@@ -222,7 +226,7 @@
 	mode->Flags |= var->sync & FB_SYNC_HOR_HIGH_ACT ? V_PHSYNC : V_NHSYNC;
 	mode->Flags |= var->sync & FB_SYNC_VERT_HIGH_ACT ? V_PVSYNC : V_NVSYNC;
 	mode->Flags |= var->sync & FB_SYNC_COMP_HIGH_ACT ? V_PCSYNC : V_NCSYNC;
-#if 0
+#if 1 /* Badly needed for PAL/NTSC on Amiga (amifb)!! [geert] */
 	if (var->sync & FB_SYNC_BROADCAST)
 		mode->Flags |= V_BCAST;
 #endif
@@ -247,28 +251,6 @@
 /* -------------------------------------------------------------------- */
 /* open correct framebuffer device                                      */

-static struct fb2pci_entry {
-	CARD32 id;
-	CARD32 vendor;
-	CARD32 chip;
-} fb2pci_map[] = {
-	{ FB_ACCEL_MATROX_MGA2064W,     PCI_VENDOR_MATROX, PCI_CHIP_MGA2064      },
-	{ FB_ACCEL_MATROX_MGA1064SG,    PCI_VENDOR_MATROX, PCI_CHIP_MGA1064      },
-	{ FB_ACCEL_MATROX_MGA2164W,     PCI_VENDOR_MATROX, PCI_CHIP_MGA2164      },
-	{ FB_ACCEL_MATROX_MGA2164W_AGP, PCI_VENDOR_MATROX, PCI_CHIP_MGA2164_AGP  },
-	{ FB_ACCEL_MATROX_MGAG100,      PCI_VENDOR_MATROX, PCI_CHIP_MGAG100      },
-	{ FB_ACCEL_MATROX_MGAG200,      PCI_VENDOR_MATROX, PCI_CHIP_MGAG200      },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128RE    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128RF    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128RK    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128RL    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128PF    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128LE    },
-	{ FB_ACCEL_ATI_RAGE128,         PCI_VENDOR_ATI,    PCI_CHIP_RAGE128LF    },
-	{ FB_ACCEL_3DFX_BANSHEE,        PCI_VENDOR_3DFX,   PCI_CHIP_VOODOO3      },
-};
-#define FB2PCICOUNT (sizeof(fb2pci_map)/sizeof(struct fb2pci_entry))
-
 /* try to find the framebuffer device for a given PCI device */
 static int
 fbdev_open_pci(pciVideoPtr pPci, char **namep)
@@ -276,8 +258,9 @@
 	struct	fb_fix_screeninfo fix;
 	char	filename[16];
 	int	fd,i,j;
+	memType res_start, res_end;

-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < 8; i++) {
 		sprintf(filename,"/dev/fb%d",i);
 		if (-1 == (fd = open(filename,O_RDWR,0))) {
 			continue;
@@ -286,15 +269,20 @@
 			close(fd);
 			continue;
 		}
-		/* FIXME: better ask the fbdev driver for bus/device/func,
-                          but there is no way to to this yet. */
-		for (j = 0; j < FB2PCICOUNT; j++) {
-			if (pPci->vendor   == fb2pci_map[j].vendor &&
-			    pPci->chipType == fb2pci_map[j].chip   &&
-			    fix.accel      == fb2pci_map[j].id)
+		for (j = 0; j < 6; j++) {
+			if ((pPci->type[i] & ResPhysMask) != ResMem)
+				continue;
+			res_start = pPci->memBase[j];
+			res_end = res_start+pPci->size[j];
+			if ((0 != fix.smem_len &&
+			     fix.smem_start >= res_start &&
+			     fix.smem_start < res_end) ||
+			    (0 != fix.mmio_len &&
+			     fix.mmio_start >= res_start &&
+			     fix.mmio_start < res_end))
 				break;
 		}
-		if (j == FB2PCICOUNT) {
+		if (j == 6) {
 			close(fd);
 			continue;
 		}
@@ -541,12 +529,19 @@

 	TRACE_ENTER("MapVidmem");
 	if (NULL == fPtr->fbmem) {
-		fPtr->fboff = fPtr->fix.smem_len & (PAGE_SIZE-1);
-		fPtr->fbmem = mmap(NULL, fPtr->fix.smem_len, PROT_READ | PROT_WRITE,
+		fPtr->fboff = fPtr->fix.smem_start & ~PAGE_MASK;
+		fPtr->fbmem_len = (fPtr->fboff+fPtr->fix.smem_len+~PAGE_MASK) &
+				  PAGE_MASK;
+		fPtr->fbmem = mmap(NULL, fPtr->fbmem_len, PROT_READ | PROT_WRITE,
 				   MAP_SHARED, fPtr->fd, 0);
 		if (-1 == (int)fPtr->fbmem) {
 			perror("mmap fbmem");
 			fPtr->fbmem = NULL;
+		} else {
+		    /* Perhaps we'd better add fboff to fbmem and return 0 in
+		       fbdevHWLinearOffset()? Of course we then need to mask
+		       fPtr->fbmem with PAGE_MASK in fbdevHWUnmapVidmem() as
+		       well. [geert] */
 		}
 	}
 	pScrn->memPhysBase = (unsigned long)fPtr->fix.smem_start & (unsigned long)(PAGE_MASK);
@@ -570,7 +565,7 @@

 	TRACE_ENTER("UnmapVidmem");
 	if (NULL != fPtr->fbmem) {
-		if (-1 == munmap(fPtr->fbmem, fPtr->fix.smem_len))
+		if (-1 == munmap(fPtr->fbmem, fPtr->fbmem_len))
 			perror("munmap fbmem");
 		fPtr->fbmem = NULL;
 	}
@@ -580,6 +575,8 @@
 void*
 fbdevHWMapMMIO(ScrnInfoPtr pScrn)
 {
+	unsigned int mmio_off;
+
 	fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);

 	TRACE_ENTER("MapMMIO");
@@ -590,12 +587,17 @@
 			perror("FBIOPUT_VSCREENINFO");
 			return FALSE;
 		}
-		fPtr->mmio = mmap(NULL, fPtr->fix.mmio_len, PROT_READ | PROT_WRITE,
-				  MAP_SHARED, fPtr->fd, fPtr->fix.smem_len);
+		mmio_off = fPtr->fix.mmio_start & ~PAGE_MASK;
+		fPtr->mmio_len = (mmio_off+fPtr->fix.mmio_len+~PAGE_MASK) &
+				  PAGE_MASK;
+		fPtr->mmio = mmap(NULL, fPtr->mmio_len, PROT_READ | PROT_WRITE,
+				  MAP_SHARED, fPtr->fd, fPtr->fbmem_len);
 		if (-1 == (int)fPtr->mmio) {
 			perror("mmap mmio");
 			fPtr->mmio = NULL;
-		}
+		} else
+			fPtr->mmio = (void *)((unsigned long)fPtr->mmio+
+							     mmio_off);
 	}
 	return fPtr->mmio;
 }
@@ -607,9 +609,11 @@

 	TRACE_ENTER("UnmapMMIO");
 	if (NULL != fPtr->mmio) {
-		if (-1 == munmap(fPtr->mmio, fPtr->fix.mmio_len))
+		if (-1 == munmap((void *)((unsigned long)fPtr->mmio & PAGE_MASK),
+				 fPtr->mmio_len))
 			perror("munmap mmio");
 		fPtr->mmio = NULL;
+		/* FIXME: restore var.accel_flags [geert] */
 	}
 	return TRUE;
 }
@@ -691,9 +695,12 @@
 	cmap.transp = NULL;
 	for (i = 0; i < numColors; i++) {
 		cmap.start = indices[i];
-		red   = colors[indices[i]].red   << 8;
-		green = colors[indices[i]].green << 8;
-		blue  = colors[indices[i]].blue  << 8;
+		red   = (colors[indices[i]].red   << 8) |
+			colors[indices[i]].red;
+		green = (colors[indices[i]].green << 8) |
+			colors[indices[i]].green;
+		blue  = (colors[indices[i]].blue  << 8) |
+			colors[indices[i]].blue;
 		if (-1 == ioctl(fPtr->fd,FBIOPUTCMAP,(void*)&cmap))
 			perror("ioctl FBIOPUTCMAP");
 	}

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
