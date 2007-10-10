Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 43226DE08C
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 04:32:33 +1000 (EST)
Received: from pd4mr1so.prod.shaw.ca
	(pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPP009CPKT8WC80@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:56 -0600 (MDT)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPP007Q3KT76ND0@pd4mr1so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 10 Oct 2007 12:31:56 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPP005YJKT3LHQ0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 10 Oct 2007 12:31:51 -0600 (MDT)
Date: Wed, 10 Oct 2007 12:31:56 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/3] XilinxFB: Allow fixed framebuffer base address
In-reply-to: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
To: linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com,
	linuxppc-dev@ozlabs.org, adaplas@gmail.com, jwboyer@linux.vnet.ibm.com
Message-id: <20071010183156.12852.37319.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071010182920.12852.41903.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Allow a fixed framebuffer address to be assigned to the framebuffer device
instead of allocating the framebuffer from the consistent memory pool.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/video/xilinxfb.c |   22 ++++++++++++++++------
 include/linux/xilinxfb.h |    5 +++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
index c617412..6ef99b2 100644
--- a/drivers/video/xilinxfb.c
+++ b/drivers/video/xilinxfb.c
@@ -117,6 +117,7 @@ struct xilinxfb_drvdata {
 
 	void		*fb_virt;	/* virt. address of the frame buffer */
 	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
+	int		fb_alloced;	/* Flag, was the fb memory alloced? */
 
 	u32		reg_ctrl_default;
 
@@ -235,8 +236,15 @@ static int xilinxfb_assign(struct device *dev, unsigned long physaddr,
 	}
 
 	/* Allocate the framebuffer memory */
-	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
-				&drvdata->fb_phys, GFP_KERNEL);
+	if (pdata->fb_phys) {
+		drvdata->fb_phys = pdata->fb_phys;
+		drvdata->fb_virt = ioremap(pdata->fb_phys, fbsize);
+	} else {
+		drvdata->fb_alloced = 1;
+		drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
+					&drvdata->fb_phys, GFP_KERNEL);
+	}
+
 	if (!drvdata->fb_virt) {
 		dev_err(dev, "Could not allocate frame buffer memory\n");
 		rc = -ENOMEM;
@@ -300,8 +308,9 @@ err_regfb:
 	fb_dealloc_cmap(&drvdata->info.cmap);
 
 err_cmap:
-	dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
-		drvdata->fb_phys);
+	if (drvdata->fb_alloced)
+		dma_free_coherent(dev, PAGE_ALIGN(fbsize), drvdata->fb_virt,
+			drvdata->fb_phys);
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
 
@@ -330,8 +339,9 @@ static int xilinxfb_release(struct device *dev)
 
 	fb_dealloc_cmap(&drvdata->info.cmap);
 
-	dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
-			  drvdata->fb_virt, drvdata->fb_phys);
+	if (drvdata->fb_alloced)
+		dma_free_coherent(dev, PAGE_ALIGN(drvdata->info.fix.smem_len),
+				  drvdata->fb_virt, drvdata->fb_phys);
 
 	/* Turn off the display */
 	xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
diff --git a/include/linux/xilinxfb.h b/include/linux/xilinxfb.h
index 199a1ee..f2463f5 100644
--- a/include/linux/xilinxfb.h
+++ b/include/linux/xilinxfb.h
@@ -20,6 +20,11 @@ struct xilinxfb_platform_data {
 	u32 screen_width_mm;
 	u32 xres, yres;		/* resolution of screen in pixels */
 	u32 xvirt, yvirt;	/* resolution of memory buffer */
+
+	/* Physical address of framebuffer memory; If non-zero, driver
+	 * will use provided memory address instead of allocating one from
+	 * the consistent pool. */
+	u32 fb_phys;
 };
 
 #endif  /* __XILINXFB_H__ */
