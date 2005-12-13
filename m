Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 18:12:51 +1100
Message-Id: <1134457971.6989.198.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] nvidiafb: Fixes for new G5
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch is not for inclusion in anything but powerpc git tree and
only temporarily as it's being dealt with separately for upstream merge
and is already in -mm. It fixes an issue in nvidiafb for the the G5s.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/nvidia/nv_hw.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_hw.c	2005-11-24 17:18:46.000000000 +1100
+++ linux-work/drivers/video/nvidia/nv_hw.c	2005-12-07 19:14:52.000000000 +1100
@@ -848,7 +848,7 @@ void NVCalcStateExt(struct nvidia_par *p
 		    int width,
 		    int hDisplaySize, int height, int dotClock, int flags)
 {
-	int pixelDepth, VClk;
+	int pixelDepth, VClk = 0;
 	/*
 	 * Save mode parameters.
 	 */
@@ -938,17 +938,26 @@ void NVLoadStateExt(struct nvidia_par *p
 
 	if (par->Architecture == NV_ARCH_04) {
 		NV_WR32(par->PFB, 0x0200, state->config);
-	} else if ((par->Chipset & 0xfff0) == 0x0090) {
-		for (i = 0; i < 15; i++) {
-			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
-			NV_WR32(par->PFB, 0x0604 + (i * 0x10), par->FbMapSize - 1);
-		}
-	} else {
+	} else if ((par->Architecture < NV_ARCH_40) ||
+		   (par->Chipset & 0xfff0) == 0x0040) {
 		for (i = 0; i < 8; i++) {
 			NV_WR32(par->PFB, 0x0240 + (i * 0x10), 0);
-			NV_WR32(par->PFB, 0x0244 + (i * 0x10), par->FbMapSize - 1);
+			NV_WR32(par->PFB, 0x0244 + (i * 0x10),
+				par->FbMapSize - 1);
 		}
-	}
+	} else {
+		int regions = 12;
+  	 
+		if (((par->Chipset & 0xfff0) == 0x0090) ||
+		    ((par->Chipset & 0xfff0) == 0x01D0) ||
+		    ((par->Chipset & 0xfff0) == 0x0290))
+			regions = 15;  	 
+		for(i = 0; i < regions; i++) {
+			NV_WR32(par->PFB, 0x0600 + (i * 0x10), 0);
+			NV_WR32(par->PFB, 0x0604 + (i * 0x10),
+				par->FbMapSize - 1);
+		}
+	} 
 
 	if (par->Architecture >= NV_ARCH_40) {
 		NV_WR32(par->PRAMIN, 0x0000 * 4, 0x80000010);
@@ -1182,11 +1191,17 @@ void NVLoadStateExt(struct nvidia_par *p
 			NV_WR32(par->PGRAPH, 0x0608, 0xFFFFFFFF);
 		} else {
 			if (par->Architecture >= NV_ARCH_40) {
+				u32 tmp;
+
 				NV_WR32(par->PGRAPH, 0x0084, 0x401287c0);
 				NV_WR32(par->PGRAPH, 0x008C, 0x60de8051);
 				NV_WR32(par->PGRAPH, 0x0090, 0x00008000);
 				NV_WR32(par->PGRAPH, 0x0610, 0x00be3c5f);
 
+				tmp = NV_RD32(par->REGS, 0x1540) & 0xff;
+				for(i = 0; tmp && !(tmp & 1); tmp >>= 1, i++);
+				NV_WR32(par->PGRAPH, 0x5000, i);
+ 
 				if ((par->Chipset & 0xfff0) == 0x0040) {
 					NV_WR32(par->PGRAPH, 0x09b0,
 						0x83280fff);
@@ -1211,6 +1226,7 @@ void NVLoadStateExt(struct nvidia_par *p
 						0xffff7fff);
 					break;
 				case 0x00C0:
+				case 0x0120:
 					NV_WR32(par->PGRAPH, 0x0828,
 						0x007596ff);
 					NV_WR32(par->PGRAPH, 0x082C,
@@ -1245,6 +1261,7 @@ void NVLoadStateExt(struct nvidia_par *p
 						0x00100000);
 					break;
 				case 0x0090:
+				case 0x0290:
 					NV_WR32(par->PRAMDAC, 0x0608,
 						NV_RD32(par->PRAMDAC, 0x0608) |
 						0x00100000);
@@ -1310,14 +1327,44 @@ void NVLoadStateExt(struct nvidia_par *p
 				}
 			}
 
-			if ((par->Chipset & 0xfff0) == 0x0090) {
-				for (i = 0; i < 60; i++)
-					NV_WR32(par->PGRAPH, 0x0D00 + i,
-						NV_RD32(par->PFB, 0x0600 + i));
+			if ((par->Architecture < NV_ARCH_40) ||
+			    ((par->Chipset & 0xfff0) == 0x0040)) {
+				for (i = 0; i < 32; i++) {
+					NV_WR32(par->PGRAPH, 0x0900 + i*4,
+						NV_RD32(par->PFB, 0x0240 +i*4));
+					NV_WR32(par->PGRAPH, 0x6900 + i*4,
+						NV_RD32(par->PFB, 0x0240 +i*4));
+				}
 			} else {
-				for (i = 0; i < 32; i++)
-					NV_WR32(par->PGRAPH, 0x0900 + i,
-						NV_RD32(par->PFB, 0x0240 + i));
+				if (((par->Chipset & 0xfff0) == 0x0090) ||
+				    ((par->Chipset & 0xfff0) == 0x01D0) ||
+				    ((par->Chipset & 0xfff0) == 0x0290)) {
+					for (i = 0; i < 60; i++) {
+						NV_WR32(par->PGRAPH,
+							0x0D00 + i*4,
+							NV_RD32(par->PFB,
+								0x0600 + i*4));
+						NV_WR32(par->PGRAPH,
+							0x6900 + i*4,
+							NV_RD32(par->PFB,
+								0x0600 + i*4));
+					}
+				} else {
+					for (i = 0; i < 48; i++) {
+						NV_WR32(par->PGRAPH,
+							0x0900 + i*4,
+							NV_RD32(par->PFB,
+								0x0600 + i*4));
+						if(((par->Chipset & 0xfff0)
+						    != 0x0160) &&
+						   ((par->Chipset & 0xfff0)
+						    != 0x0220))
+							NV_WR32(par->PGRAPH,
+								0x6900 + i*4,
+								NV_RD32(par->PFB,
+									0x0600 + i*4));
+					}
+				}
 			}
 
 			if (par->Architecture >= NV_ARCH_40) {
@@ -1338,7 +1385,9 @@ void NVLoadStateExt(struct nvidia_par *p
 					NV_WR32(par->PGRAPH, 0x0868,
 						par->FbMapSize - 1);
 				} else {
-					if((par->Chipset & 0xfff0) == 0x0090) {
+					if ((par->Chipset & 0xfff0) == 0x0090 ||
+					    (par->Chipset & 0xfff0) == 0x01D0 ||
+					    (par->Chipset & 0xfff0) == 0x0290) {
 						NV_WR32(par->PGRAPH, 0x0DF0,
 							NV_RD32(par->PFB, 0x0200));
 						NV_WR32(par->PGRAPH, 0x0DF4,
Index: linux-work/drivers/video/nvidia/nv_setup.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_setup.c	2005-11-24 17:18:46.000000000 +1100
+++ linux-work/drivers/video/nvidia/nv_setup.c	2005-12-07 19:09:01.000000000 +1100
@@ -285,7 +285,6 @@ static void nv10GetConfig(struct nvidia_
 			par->CrystalFreqKHz = 27000;
 	}
 
-	par->CursorStart = (par->RamAmountKBytes - 96) * 1024;
 	par->CURSOR = NULL;	/* can't set this here */
 	par->MinVClockFreqKHz = 12000;
 	par->MaxVClockFreqKHz = par->twoStagePLL ? 400000 : 350000;
@@ -382,6 +381,8 @@ void NVCommonSetup(struct fb_info *info)
 	case 0x0146:
 	case 0x0147:
 	case 0x0148:
+	case 0x0098:
+	case 0x0099:
 		mobile = 1;
 		break;
 	default:
Index: linux-work/drivers/video/nvidia/nvidia.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nvidia.c	2005-11-24 17:18:46.000000000 +1100
+++ linux-work/drivers/video/nvidia/nvidia.c	2005-12-07 18:52:36.000000000 +1100
@@ -1485,6 +1485,8 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0210:
 	case 0x0220:
 	case 0x0230:
+	case 0x0290:
+	case 0x0390:
 		arch = NV_ARCH_40;
 		break;
 	case 0x0020:		/* TNT, TNT2 */
@@ -1581,10 +1583,15 @@ static int __devinit nvidiafb_probe(stru
 	if (par->FbMapSize > 64 * 1024 * 1024)
 		par->FbMapSize = 64 * 1024 * 1024;
 
-	par->FbUsableSize = par->FbMapSize - (128 * 1024);
+	if(par->Architecture >= NV_ARCH_40)
+  	        par->FbUsableSize = par->FbMapSize - (560 * 1024);
+	else
+		par->FbUsableSize = par->FbMapSize - (128 * 1024);
 	par->ScratchBufferSize = (par->Architecture < NV_ARCH_10) ? 8 * 1024 :
 	    16 * 1024;
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
+	par->CursorStart = par->FbUsableSize + (32 * 1024);
+
 	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
