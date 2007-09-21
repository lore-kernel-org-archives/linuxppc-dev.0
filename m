Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 403EFDDEDC
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:11 +1000 (EST)
Date: Fri, 21 Sep 2007 14:33:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 04/11] [POWERPC] iSeries: simplify viocd initialisation
Message-Id: <20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
In-Reply-To: <20070921143205.64271521.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't need to keep a lump of dma coherent memory around for the life
of the module.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/cdrom/viocd.c |   37 +++++++++++++------------------------
 1 files changed, 13 insertions(+), 24 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index e51550d..b88fdeb 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -136,17 +136,12 @@ struct cdrom_info {
 	char	type[4];
 	char	model[3];
 };
-/*
- * This needs to be allocated since it is passed to the
- * Hypervisor and we may be a module.
- */
-static struct cdrom_info *viocd_unitinfo;
-static dma_addr_t unitinfo_dmaaddr;
 
 struct disk_info {
 	struct gendisk			*viocd_disk;
 	struct cdrom_device_info	viocd_info;
 	struct device			*dev;
+	struct cdrom_info		unitinfo;
 };
 static struct disk_info viocd_diskinfo[VIOCD_MAX_CD];
 
@@ -164,9 +159,9 @@ static int proc_viocd_show(struct seq_file *m, void *v)
 	for (i = 0; i < viocd_numdev; i++) {
 		seq_printf(m, "viocd device %d is iSeries resource %10.10s"
 				"type %4.4s, model %3.3s\n",
-				i, viocd_unitinfo[i].rsrcname,
-				viocd_unitinfo[i].type,
-				viocd_unitinfo[i].model);
+				i, viocd_diskinfo[i].unitinfo.rsrcname,
+				viocd_diskinfo[i].unitinfo.type,
+				viocd_diskinfo[i].unitinfo.model);
 	}
 	return 0;
 }
@@ -222,6 +217,8 @@ static void __init get_viocd_info(void)
 	HvLpEvent_Rc hvrc;
 	int i;
 	struct viocd_waitevent we;
+	struct cdrom_info *viocd_unitinfo;
+	dma_addr_t unitinfo_dmaaddr;
 
 	viocd_unitinfo = dma_alloc_coherent(iSeries_vio_dev,
 			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
@@ -259,16 +256,15 @@ static void __init get_viocd_info(void)
 		goto error_ret;
 	}
 
-	for (i = 0; (i < VIOCD_MAX_CD) && viocd_unitinfo[i].rsrcname[0]; i++)
+	for (i = 0; (i < VIOCD_MAX_CD) && viocd_unitinfo[i].rsrcname[0]; i++) {
+		viocd_diskinfo[viocd_numdev].unitinfo = viocd_unitinfo[i];
 		viocd_numdev++;
+	}
 
 error_ret:
-	if (viocd_numdev == 0) {
-		dma_free_coherent(iSeries_vio_dev,
-				sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-				viocd_unitinfo, unitinfo_dmaaddr);
-		viocd_unitinfo = NULL;
-	}
+	dma_free_coherent(iSeries_vio_dev,
+			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
+			viocd_unitinfo, unitinfo_dmaaddr);
 }
 
 static int viocd_open(struct cdrom_device_info *cdi, int purpose)
@@ -674,7 +670,7 @@ static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	d = &viocd_diskinfo[deviceno];
 	c = &d->viocd_info;
-	ci = &viocd_unitinfo[deviceno];
+	ci = &d->unitinfo;
 
 	c->ops = &viocd_dops;
 	c->speed = 4;
@@ -816,9 +812,6 @@ static int __init viocd_init(void)
 	return 0;
 
 out_free_info:
-	dma_free_coherent(iSeries_vio_dev,
-			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-			viocd_unitinfo, unitinfo_dmaaddr);
 	vio_clearHandler(viomajorsubtype_cdio);
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, MAX_CD_REQ + 2);
 out_unregister:
@@ -830,10 +823,6 @@ static void __exit viocd_exit(void)
 {
 	remove_proc_entry("iSeries/viocd", NULL);
 	vio_unregister_driver(&viocd_driver);
-	if (viocd_unitinfo != NULL)
-		dma_free_coherent(iSeries_vio_dev,
-				sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-				viocd_unitinfo, unitinfo_dmaaddr);
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, MAX_CD_REQ + 2);
 	vio_clearHandler(viomajorsubtype_cdio);
 	unregister_blkdev(VIOCD_MAJOR, VIOCD_DEVICE);
-- 
1.5.3.2
