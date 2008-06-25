Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BA2ADFDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:19:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5PKJcQ8014242
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:19:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5PKJcUW177306
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:19:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5PKJbBj002919
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 16:19:38 -0400
Date: Wed, 25 Jun 2008 15:19:33 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 17/18 v2] ibmvscsi: driver enablement for CMO
Message-ID: <20080625201933.GS17020@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080625201202.GB17020@linux.vnet.ibm.com>
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>,
	Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Robert Jennings <rcj@linux.vnet.ibm.com>

Enable the driver to function in a Cooperative Memory Overcommitment (CMO)
environment.

The following changes are made to enable the driver for CMO:
 * DMA mapping errors will not result in error messages if entitlement has
   been exceeded and resources were not available.
 * The driver has a get_io_entitlement function defined to function
   in a CMO environment. It will indicate how much IO memory it would like
   to function.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 drivers/scsi/ibmvscsi/ibmvscsi.c |   46 +++++++++++++++++++++++++++++++++-=
-----
 drivers/scsi/ibmvscsi/ibmvscsi.h |    2 ++
 2 files changed, 41 insertions(+), 7 deletions(-)

Index: b/drivers/scsi/ibmvscsi/ibmvscsi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -72,6 +72,8 @@
 #include <linux/delay.h>
 #include <asm/firmware.h>
 #include <asm/vio.h>
+#include <asm/firmware.h>
+#include <asm/iommu.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -426,8 +428,10 @@ static int map_sg_data(struct scsi_cmnd=20
 					   SG_ALL * sizeof(struct srp_direct_buf),
 					   &evt_struct->ext_list_token, 0);
 		if (!evt_struct->ext_list) {
-			sdev_printk(KERN_ERR, cmd->device,
-				    "Can't allocate memory for indirect table\n");
+			if (!firmware_has_feature(FW_FEATURE_CMO))
+				sdev_printk(KERN_ERR, cmd->device,
+				            "Can't allocate memory "
+				            "for indirect table\n");
 			return 0;
 		}
 	}
@@ -743,7 +747,9 @@ static int ibmvscsi_queuecommand(struct=20
 	srp_cmd->lun =3D ((u64) lun) << 48;
=20
 	if (!map_data_for_srp_cmd(cmnd, evt_struct, srp_cmd, hostdata->dev)) {
-		sdev_printk(KERN_ERR, cmnd->device, "couldn't convert cmd to srp_cmd\n");
+		if (!firmware_has_feature(FW_FEATURE_CMO))
+			sdev_printk(KERN_ERR, cmnd->device,
+			            "couldn't convert cmd to srp_cmd\n");
 		free_event_struct(&hostdata->pool, evt_struct);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
@@ -855,7 +861,10 @@ static void send_mad_adapter_info(struct
 					    DMA_BIDIRECTIONAL);
=20
 	if (dma_mapping_error(req->buffer)) {
-		dev_err(hostdata->dev, "Unable to map request_buffer for adapter_info!\n=
");
+		if (!firmware_has_feature(FW_FEATURE_CMO))
+			dev_err(hostdata->dev,
+			        "Unable to map request_buffer for "
+			        "adapter_info!\n");
 		free_event_struct(&hostdata->pool, evt_struct);
 		return;
 	}
@@ -1400,7 +1409,9 @@ static int ibmvscsi_do_host_config(struc
 						    DMA_BIDIRECTIONAL);
=20
 	if (dma_mapping_error(host_config->buffer)) {
-		dev_err(hostdata->dev, "dma_mapping error getting host config\n");
+		if (!firmware_has_feature(FW_FEATURE_CMO))
+			dev_err(hostdata->dev,
+			        "dma_mapping error getting host config\n");
 		free_event_struct(&hostdata->pool, evt_struct);
 		return -1;
 	}
@@ -1604,7 +1615,7 @@ static struct scsi_host_template driver_
 	.eh_host_reset_handler =3D ibmvscsi_eh_host_reset_handler,
 	.slave_configure =3D ibmvscsi_slave_configure,
 	.change_queue_depth =3D ibmvscsi_change_queue_depth,
-	.cmd_per_lun =3D 16,
+	.cmd_per_lun =3D IBMVSCSI_CMDS_PER_LUN_DEFAULT,
 	.can_queue =3D IBMVSCSI_MAX_REQUESTS_DEFAULT,
 	.this_id =3D -1,
 	.sg_tablesize =3D SG_ALL,
@@ -1613,6 +1624,26 @@ static struct scsi_host_template driver_
 };
=20
 /**
+ * ibmvscsi_get_io_entitlement - Calculate IO entitlement needed by the dr=
iver
+ *
+ * @vdev: struct vio_dev for the device whose entitlement is to be returned
+ *
+ * Return value:
+ *	Number of bytes of IO data the driver will need to perform well.
+ */
+static unsigned long ibmvscsi_get_io_entitlement(struct vio_dev *vdev)
+{
+	/* iu_storage data allocated in initialize_event_pool */
+	unsigned long io_entitlement =3D max_requests * sizeof(union viosrp_iu);
+
+	/* add io space for sg data */
+	io_entitlement +=3D (IBMVSCSI_MAX_SECTORS_DEFAULT *
+	                     IBMVSCSI_CMDS_PER_LUN_DEFAULT);
+
+	return IOMMU_PAGE_ALIGN(io_entitlement);
+}
+
+/**
  * Called by bus code for each adapter
  */
 static int ibmvscsi_probe(struct vio_dev *vdev, const struct vio_device_id=
 *id)
@@ -1641,7 +1672,7 @@ static int ibmvscsi_probe(struct vio_dev
 	hostdata->host =3D host;
 	hostdata->dev =3D dev;
 	atomic_set(&hostdata->request_limit, -1);
-	hostdata->host->max_sectors =3D 32 * 8; /* default max I/O 32 pages */
+	hostdata->host->max_sectors =3D IBMVSCSI_MAX_SECTORS_DEFAULT;
=20
 	rc =3D ibmvscsi_ops->init_crq_queue(&hostdata->queue, hostdata, max_reque=
sts);
 	if (rc !=3D 0 && rc !=3D H_RESOURCE) {
@@ -1735,6 +1766,7 @@ static struct vio_driver ibmvscsi_driver
 	.id_table =3D ibmvscsi_device_table,
 	.probe =3D ibmvscsi_probe,
 	.remove =3D ibmvscsi_remove,
+	.get_io_entitlement =3D ibmvscsi_get_io_entitlement,
 	.driver =3D {
 		.name =3D "ibmvscsi",
 		.owner =3D THIS_MODULE,
Index: b/drivers/scsi/ibmvscsi/ibmvscsi.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/scsi/ibmvscsi/ibmvscsi.h
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.h
@@ -45,6 +45,8 @@ struct Scsi_Host;
 #define MAX_INDIRECT_BUFS 10
=20
 #define IBMVSCSI_MAX_REQUESTS_DEFAULT 100
+#define IBMVSCSI_CMDS_PER_LUN_DEFAULT 16
+#define IBMVSCSI_MAX_SECTORS_DEFAULT 256 /* 32 * 8 =3D default max I/O 32 =
pages */
 #define IBMVSCSI_MAX_CMDS_PER_LUN 64
=20
 /* ------------------------------------------------------------
