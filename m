Message-Id: <199905081545.RAA20120@student.physik.uni-mainz.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Patches for endianess problems in atyfb
Date: Sat, 08 May 1999 17:43:24 CEST
From: "Christian Bauer" <Christian.Bauer@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Reply-To: Christian.Bauer@uni-mainz.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

The following patches cure some of the problems I had with the atyfb
on my PowerMac clone with onboard ATI 264VT2:

 - corrected false colors and unstable picture in X11 15 and 32 bit depths
 - the display no longer depends on what color depth was selected in MacOS

I didn't have any other ATI chips to test it with, so all changes are
protected by a check of the chip ID.

I'm unsure of the "i |= 0x08000000" that is done in the setup of MEM_CNTL.
Can someone with an ATI data book verify is this bit really has something
to do with frame buffer endianess?

--- atyfb.c.orig	Sat May  8 19:32:31 1999
+++ atyfb.c.new	Sat May  8 19:31:47 1999
@@ -1118,25 +1118,44 @@
     if (bpp <= 8) {
 	bpp = 8;
 	pix_width = CRTC_PIX_WIDTH_8BPP;
-	dp_pix_width = HOST_8BPP | SRC_8BPP | DST_8BPP | BYTE_ORDER_LSB_TO_MSB;
+	dp_pix_width = HOST_8BPP | SRC_8BPP | DST_8BPP;
 	dp_chain_mask = 0x8080;
+	if (Gx == VT_CHIP_ID) {
+	    pix_width |= 0x00040000;	// FIFO setup
+	}
+#ifdef __LITTLE_ENDIAN
+	dp_pix_width |= BYTE_ORDER_LSB_TO_MSB;
+#endif
     } else if (bpp <= 16) {
 	bpp = 16;
 	pix_width = CRTC_PIX_WIDTH_15BPP;
-	dp_pix_width = HOST_15BPP | SRC_15BPP | DST_15BPP |
-		       BYTE_ORDER_LSB_TO_MSB;
+	dp_pix_width = HOST_15BPP | SRC_15BPP | DST_15BPP;
 	dp_chain_mask = 0x4210;
+	if (Gx == VT_CHIP_ID) {
+	    pix_width |= 0x00068000;	// FIFO setup
+	}
+#ifdef __LITTLE_ENDIAN
+	dp_pix_width |= BYTE_ORDER_LSB_TO_MSB;
+#endif
     } else if ((bpp <= 24) && (Gx != GX_CHIP_ID) && (Gx != CX_CHIP_ID)) {
 	bpp = 24;
 	pix_width = CRTC_PIX_WIDTH_24BPP;
-	dp_pix_width = HOST_8BPP | SRC_8BPP | DST_8BPP | BYTE_ORDER_LSB_TO_MSB;
+	dp_pix_width = HOST_8BPP | SRC_8BPP | DST_8BPP;
 	dp_chain_mask = 0x8080;
+#ifdef __LITTLE_ENDIAN
+	dp_pix_width |= BYTE_ORDER_LSB_TO_MSB;
+#endif
     } else if (bpp <= 32) {
 	bpp = 32;
 	pix_width = CRTC_PIX_WIDTH_32BPP;
-	dp_pix_width = HOST_32BPP | SRC_32BPP | DST_32BPP |
-		       BYTE_ORDER_LSB_TO_MSB;
+	dp_pix_width = HOST_32BPP | SRC_32BPP | DST_32BPP;
 	dp_chain_mask = 0x8080;
+	if (Gx == VT_CHIP_ID) {
+	    pix_width |= 0x000dc000;	// FIFO setup
+	}
+#ifdef __LITTLE_ENDIAN
+	dp_pix_width |= BYTE_ORDER_LSB_TO_MSB;
+#endif
     } else
 	FAIL("invalid bpp");
 
@@ -1161,7 +1180,7 @@
     crtc->off_pitch = ((yoffset*vxres+xoffset)*bpp/64) | (vxres<<19);
     crtc->gen_cntl = pix_width | c_sync | CRTC_EXT_DISP_EN | CRTC_ENABLE;
     if ((Gx == CT_CHIP_ID) || (Gx == ET_CHIP_ID) ||
-	((Gx == VT_CHIP_ID || Gx == GT_CHIP_ID) && !(Rev & 0x07))) {
+	((Gx == GT_CHIP_ID) && !(Rev & 0x07))) {
 	/* Not VTB/GTB */
 	/* FIXME: magic FIFO values */
 	crtc->gen_cntl |= aty_ld_le32(CRTC_GEN_CNTL, info) & 0x000e0000;
@@ -1743,17 +1762,36 @@
 	i = aty_ld_le32(MEM_CNTL, info) & 0xf30fffff;
 	if (!(Gx == VT_CHIP_ID && (Rev == 0x40 || Rev == 0x48)))
 	    i |= info->mem_refresh_rate << 20;
-	switch (par->crtc.bpp) {
-	    case 8:
-	    case 24:
-		i |= 0x00000000;
-		break;
-	    case 16:
-		i |= 0x04000000;
-		break;
-	    case 32:
-		i |= 0x08000000;
-		break;
+	if (Gx == VT_CHIP_ID) {
+	    i &= 0xf0ffffff;
+	    switch (par->crtc.bpp) {
+		case 8:
+		case 24:
+		    i |= 0x02000000;
+		    break;
+		case 16:
+		    i |= 0x03000000;
+		    break;
+		case 32:
+		    i |= 0x06000000;
+		    break;
+	    }
+#ifdef __BIG_ENDIAN
+	    i |= 0x08000000;
+#endif
+	} else {
+	    switch (par->crtc.bpp) {
+		case 8:
+		case 24:
+		    i |= 0x00000000;
+		    break;
+		case 16:
+		    i |= 0x04000000;
+		    break;
+		case 32:
+		    i |= 0x08000000;
+		    break;
+	    }
 	}
 	if ((Gx == CT_CHIP_ID) || (Gx == ET_CHIP_ID)) {
 	    aty_st_le32(DAC_CNTL, 0x87010184, info);

Bye,
Christian

-- 
  / Coding on PowerPC and proud of it
\/ http://www.uni-mainz.de/~bauec002/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
