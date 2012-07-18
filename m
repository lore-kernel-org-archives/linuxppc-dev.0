Return-Path: <olaf@aepfle.de>
Received: from mo6-p00-ob.rzone.de (mo6-p00-ob.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EAC622C024D
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2012 03:00:21 +1000 (EST)
From: olaf@aepfle.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] radeonfb: Add quirk for the graphics adapter in some JSxx
Date: Wed, 18 Jul 2012 18:49:04 +0200
Message-Id: <1342630144-16350-1-git-send-email-olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
 Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tony Breeds <tony@bakeyournoodle.com>

These devices are set to 640x480 by firmware, switch them to 800x600@60
so that the graphical installer can run on remote console.

Reported by IBM during SLES10 SP2 beta testing:

https://bugzilla.novell.com/show_bug.cgi?id=461002
LTC50817

Signed-off-by: Olaf Hering <olaf@aepfle.de>

diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index 9261c91..5c23eac 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -730,6 +730,25 @@ static void radeon_videomode_to_var(struct fb_var_screeninfo *var,
 	var->vmode = mode->vmode;
 }
 
+#ifdef CONFIG_PPC_PSERIES
+static int is_powerblade(const char *model)
+{
+	struct device_node *root;
+	const char* cp;
+	int len, l, rc = 0;
+
+	root = of_find_node_by_path("/");
+	if (root && model) {
+		l = strlen(model);
+		cp = of_get_property(root, "model", &len);
+		if (cp)
+			rc = memcmp(model, cp, min(len, l)) == 0;
+		of_node_put(root);
+	}
+	return rc;
+}
+#endif
+
 /*
  * Build the modedb for head 1 (head 2 will come later), check panel infos
  * from either BIOS or EDID, and pick up the default mode
@@ -865,6 +884,22 @@ void __devinit radeon_check_modes(struct radeonfb_info *rinfo, const char *mode_
 			has_default_mode = 1;
  	}
 
+#ifdef CONFIG_PPC_PSERIES
+	if (!has_default_mode && (
+		is_powerblade("IBM,8842") || /* JS20 */
+		is_powerblade("IBM,8844") || /* JS21 */
+		is_powerblade("IBM,7998") || /* JS12/JS21/JS22 */
+		is_powerblade("IBM,0792") || /* QS21 */
+		is_powerblade("IBM,0793")    /* QS22 */
+	    )) {
+		printk("Falling back to 800x600 on JSxx hardware\n");
+		if (fb_find_mode(&info->var, info, "800x600@60",
+				 info->monspecs.modedb,
+				 info->monspecs.modedb_len, NULL, 8) != 0)
+			has_default_mode = 1;
+	}
+#endif
+
 	/*
 	 * Still no mode, let's pick up a default from the db
 	 */
-- 
1.7.10.4
