Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDA801A03B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:45 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 20:32:43 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id DEE8C38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:32:40 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1WeAp33619978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:40 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TNXc003755
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:24 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 5/7] ibmvscsi: Remove unsupported host config MAD
Date: Wed, 10 Feb 2016 19:32:26 -0600
Message-Id: <1455154348-3226-6-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A VIOSRP_HOST_CONFIG_TYPE management datagram (MAD) has existed in
the code for some time. From what information I've gathered from
Brian King this was likely implemented on the host side in a SLES 9
based VIOS, which is no longer supported anywhere. Further, it is
not defined in PAPR or supported by any AIX based VIOS.

Treating as bit rot and removing the associated host config code.
The config attribute and its show function are left as not to break
userspace. The behavior remains the same returning nothing.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 71 +++-------------------------------------
 drivers/scsi/ibmvscsi/viosrp.h   |  7 ----
 2 files changed, 4 insertions(+), 74 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index c208295..e8d4af5 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1853,62 +1853,6 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 }
 
 /**
- * ibmvscsi_get_host_config: Send the command to the server to get host
- * configuration data.  The data is opaque to us.
- */
-static int ibmvscsi_do_host_config(struct ibmvscsi_host_data *hostdata,
-				   unsigned char *buffer, int length)
-{
-	struct viosrp_host_config *host_config;
-	struct srp_event_struct *evt_struct;
-	unsigned long flags;
-	dma_addr_t addr;
-	int rc;
-
-	evt_struct = get_event_struct(&hostdata->pool);
-	if (!evt_struct) {
-		dev_err(hostdata->dev, "couldn't allocate event for HOST_CONFIG!\n");
-		return -1;
-	}
-
-	init_event_struct(evt_struct,
-			  sync_completion,
-			  VIOSRP_MAD_FORMAT,
-			  info_timeout);
-
-	host_config = &evt_struct->iu.mad.host_config;
-
-	/* The transport length field is only 16-bit */
-	length = min(0xffff, length);
-
-	/* Set up a lun reset SRP command */
-	memset(host_config, 0x00, sizeof(*host_config));
-	host_config->common.type = cpu_to_be32(VIOSRP_HOST_CONFIG_TYPE);
-	host_config->common.length = cpu_to_be16(length);
-	addr = dma_map_single(hostdata->dev, buffer, length, DMA_BIDIRECTIONAL);
-
-	if (dma_mapping_error(hostdata->dev, addr)) {
-		if (!firmware_has_feature(FW_FEATURE_CMO))
-			dev_err(hostdata->dev,
-			        "dma_mapping error getting host config\n");
-		free_event_struct(&hostdata->pool, evt_struct);
-		return -1;
-	}
-
-	host_config->buffer = cpu_to_be64(addr);
-
-	init_completion(&evt_struct->comp);
-	spin_lock_irqsave(hostdata->host->host_lock, flags);
-	rc = ibmvscsi_send_srp_event(evt_struct, hostdata, info_timeout * 2);
-	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
-	if (rc == 0)
-		wait_for_completion(&evt_struct->comp);
-	dma_unmap_single(hostdata->dev, addr, length, DMA_BIDIRECTIONAL);
-
-	return rc;
-}
-
-/**
  * ibmvscsi_slave_configure: Set the "allow_restart" flag for each disk.
  * @sdev:	struct scsi_device device to configure
  *
@@ -2093,21 +2037,14 @@ static struct device_attribute ibmvscsi_host_os_type = {
 static ssize_t show_host_config(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct Scsi_Host *shost = class_to_shost(dev);
-	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
-
-	/* returns null-terminated host config data */
-	if (ibmvscsi_do_host_config(hostdata, buf, PAGE_SIZE) == 0)
-		return strlen(buf);
-	else
-		return 0;
+	return 0;
 }
 
 static struct device_attribute ibmvscsi_host_config = {
 	.attr = {
-		 .name = "config",
-		 .mode = S_IRUGO,
-		 },
+		.name = "config",
+		.mode = S_IRUGO,
+		},
 	.show = show_host_config,
 };
 
diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
index d0f689b..c1ab8a4 100644
--- a/drivers/scsi/ibmvscsi/viosrp.h
+++ b/drivers/scsi/ibmvscsi/viosrp.h
@@ -99,7 +99,6 @@ enum viosrp_mad_types {
 	VIOSRP_EMPTY_IU_TYPE = 0x01,
 	VIOSRP_ERROR_LOG_TYPE = 0x02,
 	VIOSRP_ADAPTER_INFO_TYPE = 0x03,
-	VIOSRP_HOST_CONFIG_TYPE = 0x04,
 	VIOSRP_CAPABILITIES_TYPE = 0x05,
 	VIOSRP_ENABLE_FAST_FAIL = 0x08,
 };
@@ -165,11 +164,6 @@ struct viosrp_adapter_info {
 	__be64 buffer;
 };
 
-struct viosrp_host_config {
-	struct mad_common common;
-	__be64 buffer;
-};
-
 struct viosrp_fast_fail {
 	struct mad_common common;
 };
@@ -207,7 +201,6 @@ union mad_iu {
 	struct viosrp_empty_iu empty_iu;
 	struct viosrp_error_log error_log;
 	struct viosrp_adapter_info adapter_info;
-	struct viosrp_host_config host_config;
 	struct viosrp_fast_fail fast_fail;
 	struct viosrp_capabilities capabilities;
 };
-- 
2.5.0
