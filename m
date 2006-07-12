Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 09/16] [powerpc, video & agp] Constify & voidify get_property()
Message-ID: <1152678686.20160.09@pokey>
Date: Wed, 12 Jul 2006 15:40:40 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

powerpc-specific video & agp driver changes.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 char/agp/uninorth-agp.c    |    4 ++--
 video/S3triofb.c           |   12 ++++++------
 video/aty/radeon_base.c    |    8 ++++----
 video/aty/radeon_monitor.c |   12 ++++++------
 video/aty/radeon_pm.c      |    4 ++--
 video/nvidia/nv_of.c       |   12 +++++-------
 video/offb.c               |   22 +++++++++++-----------
 video/riva/fbdev.c         |    5 ++---
 8 files changed, 38 insertions(+), 41 deletions(-)

Index: linux-2.6/drivers/video/S3triofb.c
===================================================================
--- linux-2.6.orig/drivers/video/S3triofb.c
+++ linux-2.6/drivers/video/S3triofb.c
@@ -350,30 +350,30 @@ static void __init s3triofb_of_init(stru
     s3trio_name[sizeof(s3trio_name)-1] = '\0';
     strcpy(fb_fix.id, s3trio_name);
 
-    if((pp = (int *)get_property(dp, "vendor-id", &len)) != NULL
+    if((pp = get_property(dp, "vendor-id", &len)) != NULL
 	&& *pp!=PCI_VENDOR_ID_S3) {
 	printk("%s: can't find S3 Trio board\n", dp->full_name);
 	return;
     }
 
-    if((pp = (int *)get_property(dp, "device-id", &len)) != NULL
+    if((pp = get_property(dp, "device-id", &len)) != NULL
 	&& *pp!=PCI_DEVICE_ID_S3_TRIO) {
 	printk("%s: can't find S3 Trio board\n", dp->full_name);
 	return;
     }
 
-    if ((pp = (int *)get_property(dp, "depth", &len)) != NULL
+    if ((pp = get_property(dp, "depth", &len)) != NULL
 	&& len == sizeof(int) && *pp != 8) {
 	printk("%s: can't use depth = %d\n", dp->full_name, *pp);
 	return;
     }
-    if ((pp = (int *)get_property(dp, "width", &len)) != NULL
+    if ((pp = get_property(dp, "width", &len)) != NULL
 	&& len == sizeof(int))
 	fb_var.xres = fb_var.xres_virtual = *pp;
-    if ((pp = (int *)get_property(dp, "height", &len)) != NULL
+    if ((pp = get_property(dp, "height", &len)) != NULL
 	&& len == sizeof(int))
 	fb_var.yres = fb_var.yres_virtual = *pp;
-    if ((pp = (int *)get_property(dp, "linebytes", &len)) != NULL
+    if ((pp = get_property(dp, "linebytes", &len)) != NULL
 	&& len == sizeof(int))
 	fb_fix.line_length = *pp;
     else
Index: linux-2.6/drivers/video/aty/radeon_base.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/radeon_base.c
+++ linux-2.6/drivers/video/aty/radeon_base.c
@@ -412,11 +412,11 @@ static int  __devinit radeon_find_mem_vb
 static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 {
 	struct device_node *dp = rinfo->of_node;
-	u32 *val;
+	const u32 *val;
 
 	if (dp == NULL)
 		return -ENODEV;
-	val = (u32 *) get_property(dp, "ATY,RefCLK", NULL);
+	val = get_property(dp, "ATY,RefCLK", NULL);
 	if (!val || !*val) {
 		printk(KERN_WARNING "radeonfb: No ATY,RefCLK property !\n");
 		return -EINVAL;
@@ -424,11 +424,11 @@ static int __devinit radeon_read_xtal_OF
 
 	rinfo->pll.ref_clk = (*val) / 10;
 
-	val = (u32 *) get_property(dp, "ATY,SCLK", NULL);
+	val = get_property(dp, "ATY,SCLK", NULL);
 	if (val && *val)
 		rinfo->pll.sclk = (*val) / 10;
 
-	val = (u32 *) get_property(dp, "ATY,MCLK", NULL);
+	val = get_property(dp, "ATY,MCLK", NULL);
 	if (val && *val)
 		rinfo->pll.mclk = (*val) / 10;
 
Index: linux-2.6/drivers/video/aty/radeon_monitor.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/radeon_monitor.c
+++ linux-2.6/drivers/video/aty/radeon_monitor.c
@@ -64,13 +64,13 @@ static int __devinit radeon_parse_montyp
 {
         static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
 				     "EDID1", "EDID2",  NULL };
-	u8 *pedid = NULL;
-	u8 *pmt = NULL;
+	const u8 *pedid = NULL;
+	const u8 *pmt = NULL;
 	u8 *tmp;
         int i, mt = MT_NONE;  
 	
 	RTRACE("analyzing OF properties...\n");
-	pmt = (u8 *)get_property(dp, "display-type", NULL);
+	pmt = get_property(dp, "display-type", NULL);
 	if (!pmt)
 		return MT_NONE;
 	RTRACE("display-type: %s\n", pmt);
@@ -89,7 +89,7 @@ static int __devinit radeon_parse_montyp
 	}
 
 	for (i = 0; propnames[i] != NULL; ++i) {
-		pedid = (u8 *)get_property(dp, propnames[i], NULL);
+		pedid = get_property(dp, propnames[i], NULL);
 		if (pedid != NULL)
 			break;
 	}
@@ -124,14 +124,14 @@ static int __devinit radeon_probe_OF_hea
 		return MT_NONE;
 
 	if (rinfo->has_CRTC2) {
-		char *pname;
+		const char *pname;
 		int len, second = 0;
 
 		dp = dp->child;
 		do {
 			if (!dp)
 				return MT_NONE;
-			pname = (char *)get_property(dp, "name", NULL);
+			pname = get_property(dp, "name", NULL);
 			if (!pname)
 				return MT_NONE;
 			len = strlen(pname);
Index: linux-2.6/drivers/video/nvidia/nv_of.c
===================================================================
--- linux-2.6.orig/drivers/video/nvidia/nv_of.c
+++ linux-2.6/drivers/video/nvidia/nv_of.c
@@ -32,7 +32,7 @@ int nvidia_probe_of_connector(struct fb_
 {
 	struct nvidia_par *par = info->par;
 	struct device_node *parent, *dp;
-	unsigned char *pedid = NULL;
+	const unsigned char *pedid = NULL;
 	static char *propnames[] = {
 		"DFP,EDID", "LCD,EDID", "EDID", "EDID1",
 		"EDID,B", "EDID,A", NULL };
@@ -42,20 +42,19 @@ int nvidia_probe_of_connector(struct fb_
 	if (parent == NULL)
 		return -1;
 	if (par->twoHeads) {
-		char *pname;
+		const char *pname;
 		int len;
 
 		for (dp = NULL;
 		     (dp = of_get_next_child(parent, dp)) != NULL;) {
-			pname = (char *)get_property(dp, "name", NULL);
+			pname = get_property(dp, "name", NULL);
 			if (!pname)
 				continue;
 			len = strlen(pname);
 			if ((pname[len-1] == 'A' && conn == 1) ||
 			    (pname[len-1] == 'B' && conn == 2)) {
 				for (i = 0; propnames[i] != NULL; ++i) {
-					pedid = (unsigned char *)
-						get_property(dp, propnames[i],
+					pedid = get_property(dp, propnames[i],
 							     NULL);
 					if (pedid != NULL)
 						break;
@@ -67,8 +66,7 @@ int nvidia_probe_of_connector(struct fb_
 	}
 	if (pedid == NULL) {
 		for (i = 0; propnames[i] != NULL; ++i) {
-			pedid = (unsigned char *)
-				get_property(parent, propnames[i], NULL);
+			pedid = get_property(parent, propnames[i], NULL);
 			if (pedid != NULL)
 				break;
 		}
Index: linux-2.6/drivers/video/offb.c
===================================================================
--- linux-2.6.orig/drivers/video/offb.c
+++ linux-2.6/drivers/video/offb.c
@@ -410,30 +410,30 @@ static void __init offb_init_nodriver(st
 	unsigned int flags, rsize, addr_prop = 0;
 	unsigned long max_size = 0;
 	u64 rstart, address = OF_BAD_ADDR;
-	u32 *pp, *addrp, *up;
+	const u32 *pp, *addrp, *up;
 	u64 asize;
 
-	pp = (u32 *)get_property(dp, "linux,bootx-depth", &len);
+	pp = get_property(dp, "linux,bootx-depth", &len);
 	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "depth", &len);
+		pp = get_property(dp, "depth", &len);
 	if (pp && len == sizeof(u32))
 		depth = *pp;
 
-	pp = (u32 *)get_property(dp, "linux,bootx-width", &len);
+	pp = get_property(dp, "linux,bootx-width", &len);
 	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "width", &len);
+		pp = get_property(dp, "width", &len);
 	if (pp && len == sizeof(u32))
 		width = *pp;
 
-	pp = (u32 *)get_property(dp, "linux,bootx-height", &len);
+	pp = get_property(dp, "linux,bootx-height", &len);
 	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "height", &len);
+		pp = get_property(dp, "height", &len);
 	if (pp && len == sizeof(u32))
 		height = *pp;
 
-	pp = (u32 *)get_property(dp, "linux,bootx-linebytes", &len);
+	pp = get_property(dp, "linux,bootx-linebytes", &len);
 	if (pp == NULL)
-		pp = (u32 *)get_property(dp, "linebytes", &len);
+		pp = get_property(dp, "linebytes", &len);
 	if (pp && len == sizeof(u32))
 		pitch = *pp;
 	else
@@ -451,9 +451,9 @@ static void __init offb_init_nodriver(st
 	 * ranges and pick one that is both big enough and if possible encloses
 	 * the "address" property. If none match, we pick the biggest
 	 */
-	up = (u32 *)get_property(dp, "linux,bootx-addr", &len);
+	up = get_property(dp, "linux,bootx-addr", &len);
 	if (up == NULL)
-		up = (u32 *)get_property(dp, "address", &len);
+		up = get_property(dp, "address", &len);
 	if (up && len == sizeof(u32))
 		addr_prop = *up;
 
Index: linux-2.6/drivers/video/riva/fbdev.c
===================================================================
--- linux-2.6.orig/drivers/video/riva/fbdev.c
+++ linux-2.6/drivers/video/riva/fbdev.c
@@ -1816,14 +1816,13 @@ static int __devinit riva_get_EDID_OF(st
 	NVTRACE_ENTER();
 	dp = pci_device_to_OF_node(pd);
 	for (; dp != NULL; dp = dp->child) {
-		disptype = (unsigned char *)get_property(dp, "display-type", NULL);
+		disptype = get_property(dp, "display-type", NULL);
 		if (disptype == NULL)
 			continue;
 		if (strncmp(disptype, "LCD", 3) != 0)
 			continue;
 		for (i = 0; propnames[i] != NULL; ++i) {
-			pedid = (unsigned char *)
-				get_property(dp, propnames[i], NULL);
+			pedid = get_property(dp, propnames[i], NULL);
 			if (pedid != NULL) {
 				par->EDID = pedid;
 				NVTRACE("LCD found.\n");
Index: linux-2.6/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/radeon_pm.c
+++ linux-2.6/drivers/video/aty/radeon_pm.c
@@ -1167,7 +1167,7 @@ static void radeon_pm_full_reset_sdram(s
 			  0x21320032, 0xa1320032, 0x21320032, 0xffffffff,
 			  0x31320032 };
 
-		u32 *mrtable = default_mrtable;
+		const u32 *mrtable = default_mrtable;
 		int i, mrtable_size = ARRAY_SIZE(default_mrtable);
 
 		mdelay(30);
@@ -1186,7 +1186,7 @@ static void radeon_pm_full_reset_sdram(s
 		if (rinfo->of_node != NULL) {
 			int size;
 
-			mrtable = (u32 *)get_property(rinfo->of_node, "ATY,MRT", &size);
+			mrtable = get_property(rinfo->of_node, "ATY,MRT", &size);
 			if (mrtable)
 				mrtable_size = size >> 2;
 			else
Index: linux-2.6/drivers/char/agp/uninorth-agp.c
===================================================================
--- linux-2.6.orig/drivers/char/agp/uninorth-agp.c
+++ linux-2.6/drivers/char/agp/uninorth-agp.c
@@ -601,8 +601,8 @@ static int __devinit agp_uninorth_probe(
 		uninorth_node = of_find_node_by_name(NULL, "u3");
 	}
 	if (uninorth_node) {
-		int *revprop = (int *)
-			get_property(uninorth_node, "device-rev", NULL);
+		const int *revprop = get_property(uninorth_node,
+				"device-rev", NULL);
 		if (revprop != NULL)
 			uninorth_rev = *revprop & 0x3f;
 		of_node_put(uninorth_node);
