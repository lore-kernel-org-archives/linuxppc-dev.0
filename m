Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 447F8DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 14:50:39 +1000 (EST)
Subject: [PATCH] powerpc: Fix platinumfb framebuffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 14:50:22 +1000
Message-Id: <1190177423.6403.151.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

powerpc: Fix platinumfb resource handling

Current kernels have a non-working platinumfb due to some resource
management issues. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Note: platinumfb is a powermac only driver

Index: linux-work/drivers/video/platinumfb.c
===================================================================
--- linux-work.orig/drivers/video/platinumfb.c	2007-09-19 14:21:42.000000000 +1000
+++ linux-work/drivers/video/platinumfb.c	2007-09-19 14:47:11.000000000 +1000
@@ -17,6 +17,8 @@
  *  more details.
  */
 
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -535,33 +537,35 @@ static int __devinit platinumfb_probe(st
 	volatile __u8		*fbuffer;
 	int			bank0, bank1, bank2, bank3, rc;
 
-	printk(KERN_INFO "platinumfb: Found Apple Platinum video hardware\n");
+	dev_info(&odev->dev, "Found Apple Platinum video hardware\n");
 
 	info = framebuffer_alloc(sizeof(*pinfo), &odev->dev);
-	if (info == NULL)
+	if (info == NULL) {
+		dev_err(&odev->dev, "Failed to allocate fbdev !\n");
 		return -ENOMEM;
+	}
 	pinfo = info->par;
 
 	if (of_address_to_resource(dp, 0, &pinfo->rsrc_reg) ||
 	    of_address_to_resource(dp, 1, &pinfo->rsrc_fb)) {
-		printk(KERN_ERR "platinumfb: Can't get resources\n");
-		framebuffer_release(info);
-		return -ENXIO;
-	}
-	if (!request_mem_region(pinfo->rsrc_reg.start,
-				pinfo->rsrc_reg.start -
-				pinfo->rsrc_reg.end + 1,
-				"platinumfb registers")) {
+		dev_err(&odev->dev, "Can't get resources\n");
 		framebuffer_release(info);
 		return -ENXIO;
 	}
+	dev_dbg(&odev->dev, " registers  : 0x%llx...0x%llx\n",
+		(unsigned long long)pinfo->rsrc_reg.start,
+		(unsigned long long)pinfo->rsrc_reg.end);
+	dev_dbg(&odev->dev, " framebuffer: 0x%llx...0x%llx\n",
+		(unsigned long long)pinfo->rsrc_fb.start,
+		(unsigned long long)pinfo->rsrc_fb.end);
+
+	/* Do not try to request register space, they overlap with the
+	 * northbridge and that can fail. Only request framebuffer
+	 */
 	if (!request_mem_region(pinfo->rsrc_fb.start,
-				pinfo->rsrc_fb.start
-				- pinfo->rsrc_fb.end + 1,
+				pinfo->rsrc_fb.end - pinfo->rsrc_fb.start + 1,
 				"platinumfb framebuffer")) {
-		release_mem_region(pinfo->rsrc_reg.start,
-				   pinfo->rsrc_reg.end -
-				   pinfo->rsrc_reg.start + 1);
+		printk(KERN_ERR "platinumfb: Can't request framebuffer !\n");
 		framebuffer_release(info);
 		return -ENXIO;
 	}
@@ -600,7 +604,8 @@ static int __devinit platinumfb_probe(st
 	bank2 = fbuffer[0x200000] == 0x56;
 	bank3 = fbuffer[0x300000] == 0x78;
 	pinfo->total_vram = (bank0 + bank1 + bank2 + bank3) * 0x100000;
-	printk(KERN_INFO "platinumfb: Total VRAM = %dMB (%d%d%d%d)\n", (int) (pinfo->total_vram / 1024 / 1024),
+	printk(KERN_INFO "platinumfb: Total VRAM = %dMB (%d%d%d%d)\n",
+	       (unsigned int) (pinfo->total_vram / 1024 / 1024),
 	       bank3, bank2, bank1, bank0);
 
 	/*
@@ -644,16 +649,15 @@ static int __devexit platinumfb_remove(s
         unregister_framebuffer (info);
 	
 	/* Unmap frame buffer and registers */
+	iounmap(pinfo->frame_buffer);
+	iounmap(pinfo->platinum_regs);
+	iounmap(pinfo->cmap_regs);
+
 	release_mem_region(pinfo->rsrc_fb.start,
 			   pinfo->rsrc_fb.end -
 			   pinfo->rsrc_fb.start + 1);
-	release_mem_region(pinfo->rsrc_reg.start,
-			   pinfo->rsrc_reg.end -
-			   pinfo->rsrc_reg.start + 1);
-	iounmap(pinfo->frame_buffer);
-	iounmap(pinfo->platinum_regs);
+
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
-	iounmap(pinfo->cmap_regs);
 
 	framebuffer_release(info);
 
