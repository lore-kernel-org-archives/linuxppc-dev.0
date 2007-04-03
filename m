Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 437F5DE014
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:40 +1000 (EST)
Date: Tue, 3 Apr 2007 22:45:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 13/17] [POWERPC] Rename get_property to of_get_property:
	drivers/video
Message-Id: <20070403224505.5d5a1495.sfr@canb.auug.org.au>
In-Reply-To: <20070403224340.5533abc9.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
	<20070403222841.a2c6af1c.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/aty/radeon_base.c    |    6 +++---
 drivers/video/aty/radeon_monitor.c |   13 +++++++------
 drivers/video/aty/radeon_pm.c      |    2 +-
 drivers/video/nvidia/nv_of.c       |    8 ++++----
 drivers/video/offb.c               |   28 ++++++++++++++--------------
 drivers/video/riva/fbdev.c         |    4 ++--
 6 files changed, 31 insertions(+), 30 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 1bf6f42..4972630 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -422,7 +422,7 @@ static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 
 	if (dp == NULL)
 		return -ENODEV;
-	val = get_property(dp, "ATY,RefCLK", NULL);
+	val = of_get_property(dp, "ATY,RefCLK", NULL);
 	if (!val || !*val) {
 		printk(KERN_WARNING "radeonfb: No ATY,RefCLK property !\n");
 		return -EINVAL;
@@ -430,11 +430,11 @@ static int __devinit radeon_read_xtal_OF (struct radeonfb_info *rinfo)
 
 	rinfo->pll.ref_clk = (*val) / 10;
 
-	val = get_property(dp, "ATY,SCLK", NULL);
+	val = of_get_property(dp, "ATY,SCLK", NULL);
 	if (val && *val)
 		rinfo->pll.sclk = (*val) / 10;
 
-	val = get_property(dp, "ATY,MCLK", NULL);
+	val = of_get_property(dp, "ATY,MCLK", NULL);
 	if (val && *val)
 		rinfo->pll.mclk = (*val) / 10;
 
diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index 38c7dbf..ec7a5d4 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -65,12 +65,12 @@ static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_
         static char *propnames[] = { "DFP,EDID", "LCD,EDID", "EDID",
 				     "EDID1", "EDID2",  NULL };
 	const u8 *pedid = NULL;
-	const u8 *pmt = NULL;
+	const u8 *pmt;
 	u8 *tmp;
         int i, mt = MT_NONE;  
 	
 	RTRACE("analyzing OF properties...\n");
-	pmt = get_property(dp, "display-type", NULL);
+	pmt = of_get_property(dp, "display-type", NULL);
 	if (!pmt)
 		return MT_NONE;
 	RTRACE("display-type: %s\n", pmt);
@@ -89,7 +89,7 @@ static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_
 	}
 
 	for (i = 0; propnames[i] != NULL; ++i) {
-		pedid = get_property(dp, propnames[i], NULL);
+		pedid = of_get_property(dp, propnames[i], NULL);
 		if (pedid != NULL)
 			break;
 	}
@@ -98,9 +98,10 @@ static int __devinit radeon_parse_montype_prop(struct device_node *dp, u8 **out_
 	 * single-head cards have hdno == -1 and skip this step
 	 */
 	if (pedid == NULL && dp->parent && (hdno != -1))
-		pedid = get_property(dp->parent, (hdno == 0) ? "EDID1" : "EDID2", NULL);
+		pedid = of_get_property(dp->parent,
+				(hdno == 0) ? "EDID1" : "EDID2", NULL);
 	if (pedid == NULL && dp->parent && (hdno == 0))
-		pedid = get_property(dp->parent, "EDID", NULL);
+		pedid = of_get_property(dp->parent, "EDID", NULL);
 	if (pedid == NULL)
 		return mt;
 
@@ -130,7 +131,7 @@ static int __devinit radeon_probe_OF_head(struct radeonfb_info *rinfo, int head_
 		do {
 			if (!dp)
 				return MT_NONE;
-			pname = get_property(dp, "name", NULL);
+			pname = of_get_property(dp, "name", NULL);
 			if (!pname)
 				return MT_NONE;
 			len = strlen(pname);
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index c411293..1786ae1 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -1290,7 +1290,7 @@ static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 		if (rinfo->of_node != NULL) {
 			int size;
 
-			mrtable = get_property(rinfo->of_node, "ATY,MRT", &size);
+			mrtable = of_get_property(rinfo->of_node, "ATY,MRT", &size);
 			if (mrtable)
 				mrtable_size = size >> 2;
 			else
diff --git a/drivers/video/nvidia/nv_of.c b/drivers/video/nvidia/nv_of.c
index 163a774..73afd7e 100644
--- a/drivers/video/nvidia/nv_of.c
+++ b/drivers/video/nvidia/nv_of.c
@@ -46,15 +46,15 @@ int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
 
 		for (dp = NULL;
 		     (dp = of_get_next_child(parent, dp)) != NULL;) {
-			pname = get_property(dp, "name", NULL);
+			pname = of_get_property(dp, "name", NULL);
 			if (!pname)
 				continue;
 			len = strlen(pname);
 			if ((pname[len-1] == 'A' && conn == 1) ||
 			    (pname[len-1] == 'B' && conn == 2)) {
 				for (i = 0; propnames[i] != NULL; ++i) {
-					pedid = get_property(dp, propnames[i],
-							     NULL);
+					pedid = of_get_property(dp,
+							propnames[i], NULL);
 					if (pedid != NULL)
 						break;
 				}
@@ -65,7 +65,7 @@ int nvidia_probe_of_connector(struct fb_info *info, int conn, u8 **out_edid)
 	}
 	if (pedid == NULL) {
 		for (i = 0; propnames[i] != NULL; ++i) {
-			pedid = get_property(parent, propnames[i], NULL);
+			pedid = of_get_property(parent, propnames[i], NULL);
 			if (pedid != NULL)
 				break;
 		}
diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index 9576a55..3cf603c 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -425,27 +425,27 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	const u32 *pp, *addrp, *up;
 	u64 asize;
 
-	pp = get_property(dp, "linux,bootx-depth", &len);
+	pp = of_get_property(dp, "linux,bootx-depth", &len);
 	if (pp == NULL)
-		pp = get_property(dp, "depth", &len);
+		pp = of_get_property(dp, "depth", &len);
 	if (pp && len == sizeof(u32))
 		depth = *pp;
 
-	pp = get_property(dp, "linux,bootx-width", &len);
+	pp = of_get_property(dp, "linux,bootx-width", &len);
 	if (pp == NULL)
-		pp = get_property(dp, "width", &len);
+		pp = of_get_property(dp, "width", &len);
 	if (pp && len == sizeof(u32))
 		width = *pp;
 
-	pp = get_property(dp, "linux,bootx-height", &len);
+	pp = of_get_property(dp, "linux,bootx-height", &len);
 	if (pp == NULL)
-		pp = get_property(dp, "height", &len);
+		pp = of_get_property(dp, "height", &len);
 	if (pp && len == sizeof(u32))
 		height = *pp;
 
-	pp = get_property(dp, "linux,bootx-linebytes", &len);
+	pp = of_get_property(dp, "linux,bootx-linebytes", &len);
 	if (pp == NULL)
-		pp = get_property(dp, "linebytes", &len);
+		pp = of_get_property(dp, "linebytes", &len);
 	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
 		pitch = *pp;
 	else
@@ -463,9 +463,9 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	 * ranges and pick one that is both big enough and if possible encloses
 	 * the "address" property. If none match, we pick the biggest
 	 */
-	up = get_property(dp, "linux,bootx-addr", &len);
+	up = of_get_property(dp, "linux,bootx-addr", &len);
 	if (up == NULL)
-		up = get_property(dp, "address", &len);
+		up = of_get_property(dp, "address", &len);
 	if (up && len == sizeof(u32))
 		addr_prop = *up;
 
@@ -521,7 +521,7 @@ static int __init offb_init(void)
 		return -ENODEV;
 
 	/* Check if we have a MacOS display without a node spec */
-	if (get_property(of_chosen, "linux,bootx-noscreen", NULL) != NULL) {
+	if (of_get_property(of_chosen, "linux,bootx-noscreen", NULL) != NULL) {
 		/* The old code tried to work out which node was the MacOS
 		 * display based on the address. I'm dropping that since the
 		 * lack of a node spec only happens with old BootX versions
@@ -532,14 +532,14 @@ static int __init offb_init(void)
 	}
 
 	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
-		if (get_property(dp, "linux,opened", NULL) &&
-		    get_property(dp, "linux,boot-display", NULL)) {
+		if (of_get_property(dp, "linux,opened", NULL) &&
+		    of_get_property(dp, "linux,boot-display", NULL)) {
 			boot_disp = dp;
 			offb_init_nodriver(dp, 0);
 		}
 	}
 	for (dp = NULL; (dp = of_find_node_by_type(dp, "display"));) {
-		if (get_property(dp, "linux,opened", NULL) &&
+		if (of_get_property(dp, "linux,opened", NULL) &&
 		    dp != boot_disp)
 			offb_init_nodriver(dp, 0);
 	}
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index d7ece8d..9c6bd09 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -1760,13 +1760,13 @@ static int __devinit riva_get_EDID_OF(struct fb_info *info, struct pci_dev *pd)
 	NVTRACE_ENTER();
 	dp = pci_device_to_OF_node(pd);
 	for (; dp != NULL; dp = dp->child) {
-		disptype = get_property(dp, "display-type", NULL);
+		disptype = of_get_property(dp, "display-type", NULL);
 		if (disptype == NULL)
 			continue;
 		if (strncmp(disptype, "LCD", 3) != 0)
 			continue;
 		for (i = 0; propnames[i] != NULL; ++i) {
-			pedid = get_property(dp, propnames[i], NULL);
+			pedid = of_get_property(dp, propnames[i], NULL);
 			if (pedid != NULL) {
 				par->EDID = (unsigned char *)pedid;
 				NVTRACE("LCD found.\n");
-- 
1.5.0.3
