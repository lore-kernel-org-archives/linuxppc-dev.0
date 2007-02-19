Return-Path: <brking@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E9D7DDF65
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 01:47:34 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1JElVIB001928
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 09:47:31 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1JElVTq495984
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 07:47:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1JElU6k030105
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 07:47:31 -0700
Message-Id: <200702191447.l1JElUdl030069@d03av03.boulder.ibm.com>
Subject: [PATCH 3/3] ipr: Use PCI-E reset API for new ipr adapter
To: greg@kroah.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2007 08:47:29 -0600
In-Reply-To: <11718964333825-patch-mail.ibm.com>
References: <11718964333825-patch-mail.ibm.com>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	brking@linux.vnet.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use a newly added PCI API to issue a PCI Fundamental reset
(warm reset) to a new ipr PCI-E adapter. Typically, the
ipr adapter uses the start BIST bit in config space to reset
an adapter. Issuing start BIST on this particular adapter
results in the PCI-E logic on the card losing sync, which
causes PCI-E errors, making the card unusable. The only reset
mechanism that exists on this hardware that does not have this
problem is PCI Fundamental reset (warm reset).

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/drivers/scsi/ipr.c |   61 ++++++++++++++++++++++++++++++++---
 linux-2.6-bjking1/drivers/scsi/ipr.h |   10 ++++-
 2 files changed, 64 insertions(+), 7 deletions(-)

diff -puN drivers/scsi/ipr.h~ipr_pci_reset6 drivers/scsi/ipr.h
--- linux-2.6/drivers/scsi/ipr.h~ipr_pci_reset6	2007-02-16 10:16:07.000000000 -0600
+++ linux-2.6-bjking1/drivers/scsi/ipr.h	2007-02-16 10:18:40.000000000 -0600
@@ -37,8 +37,8 @@
 /*
  * Literals
  */
-#define IPR_DRIVER_VERSION "2.3.1"
-#define IPR_DRIVER_DATE "(January 23, 2007)"
+#define IPR_DRIVER_VERSION "2.3.2"
+#define IPR_DRIVER_DATE "(January 26, 2007)"
 
 /*
  * IPR_MAX_CMD_PER_LUN: This defines the maximum number of outstanding
@@ -104,6 +104,9 @@
 #define IPR_IOASC_IOA_WAS_RESET			0x10000001
 #define IPR_IOASC_PCI_ACCESS_ERROR			0x10000002
 
+/* Driver data flags */
+#define IPR_USE_PCI_WARM_RESET			0x00000001
+
 #define IPR_DEFAULT_MAX_ERROR_DUMP			984
 #define IPR_NUM_LOG_HCAMS				2
 #define IPR_NUM_CFG_CHG_HCAMS				2
@@ -182,6 +185,7 @@
 #define IPR_WAIT_FOR_RESET_TIMEOUT		(2 * HZ)
 #define IPR_CHECK_FOR_RESET_TIMEOUT		(HZ / 10)
 #define IPR_WAIT_FOR_BIST_TIMEOUT		(2 * HZ)
+#define IPR_PCI_RESET_TIMEOUT			(HZ / 2)
 #define IPR_DUMP_TIMEOUT			(15 * HZ)
 
 /*
@@ -1058,6 +1062,7 @@ struct ipr_ioa_cfg {
 	u8 allow_cmds:1;
 	u8 allow_ml_add_del:1;
 	u8 needs_hard_reset:1;
+	u8 needs_warm_reset:1;
 
 	enum ipr_cache_state cache_state;
 	u16 type; /* CCIN of the card */
@@ -1150,6 +1155,7 @@ struct ipr_ioa_cfg {
 	struct pci_pool *ipr_cmd_pool;
 
 	struct ipr_cmnd *reset_cmd;
+	int (*reset) (struct ipr_cmnd *);
 
 	struct ata_host ata_host;
 	char ipr_cmd_label[8];
diff -puN drivers/scsi/ipr.c~ipr_pci_reset6 drivers/scsi/ipr.c
--- linux-2.6/drivers/scsi/ipr.c~ipr_pci_reset6	2007-02-16 10:16:07.000000000 -0600
+++ linux-2.6-bjking1/drivers/scsi/ipr.c	2007-02-16 10:18:29.000000000 -0600
@@ -6397,6 +6397,48 @@ static int ipr_reset_start_bist(struct i
 }
 
 /**
+ * ipr_reset_slot_reset_done - Clear PCI reset to the adapter
+ * @ipr_cmd:	ipr command struct
+ *
+ * Description: This clears PCI reset to the adapter and delays two seconds.
+ *
+ * Return value:
+ * 	IPR_RC_JOB_RETURN
+ **/
+static int ipr_reset_slot_reset_done(struct ipr_cmnd *ipr_cmd)
+{
+	ENTER;
+	pci_set_pcie_reset_state(ipr_cmd->ioa_cfg->pdev, pci_reset_normal);
+	ipr_cmd->job_step = ipr_reset_bist_done;
+	ipr_reset_start_timer(ipr_cmd, IPR_WAIT_FOR_BIST_TIMEOUT);
+	LEAVE;
+	return IPR_RC_JOB_RETURN;
+}
+
+/**
+ * ipr_reset_slot_reset - Reset the PCI slot of the adapter.
+ * @ipr_cmd:	ipr command struct
+ *
+ * Description: This asserts PCI reset to the adapter.
+ *
+ * Return value:
+ * 	IPR_RC_JOB_RETURN
+ **/
+static int ipr_reset_slot_reset(struct ipr_cmnd *ipr_cmd)
+{
+	struct ipr_ioa_cfg *ioa_cfg = ipr_cmd->ioa_cfg;
+	struct pci_dev *pdev = ioa_cfg->pdev;
+
+	ENTER;
+	pci_block_user_cfg_access(pdev);
+	pci_set_pcie_reset_state(pdev, pci_reset_pcie_warm_reset);
+	ipr_cmd->job_step = ipr_reset_slot_reset_done;
+	ipr_reset_start_timer(ipr_cmd, IPR_PCI_RESET_TIMEOUT);
+	LEAVE;
+	return IPR_RC_JOB_RETURN;
+}
+
+/**
  * ipr_reset_allowed - Query whether or not IOA can be reset
  * @ioa_cfg:	ioa config struct
  *
@@ -6435,7 +6477,7 @@ static int ipr_reset_wait_to_start_bist(
 		ipr_cmd->u.time_left -= IPR_CHECK_FOR_RESET_TIMEOUT;
 		ipr_reset_start_timer(ipr_cmd, IPR_CHECK_FOR_RESET_TIMEOUT);
 	} else {
-		ipr_cmd->job_step = ipr_reset_start_bist;
+		ipr_cmd->job_step = ioa_cfg->reset;
 		rc = IPR_RC_JOB_CONTINUE;
 	}
 
@@ -6468,7 +6510,7 @@ static int ipr_reset_alert(struct ipr_cm
 		writel(IPR_UPROCI_RESET_ALERT, ioa_cfg->regs.set_uproc_interrupt_reg);
 		ipr_cmd->job_step = ipr_reset_wait_to_start_bist;
 	} else {
-		ipr_cmd->job_step = ipr_reset_start_bist;
+		ipr_cmd->job_step = ioa_cfg->reset;
 	}
 
 	ipr_cmd->u.time_left = IPR_WAIT_FOR_RESET_TIMEOUT;
@@ -6748,8 +6790,11 @@ static pci_ers_result_t ipr_pci_slot_res
 	struct ipr_ioa_cfg *ioa_cfg = pci_get_drvdata(pdev);
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, flags);
-	_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space,
-	                                 IPR_SHUTDOWN_NONE);
+	if (ioa_cfg->needs_warm_reset)
+		ipr_initiate_ioa_reset(ioa_cfg, IPR_SHUTDOWN_NONE);
+	else
+		_ipr_initiate_ioa_reset(ioa_cfg, ipr_reset_restore_cfg_space,
+					IPR_SHUTDOWN_NONE);
 	spin_unlock_irqrestore(ioa_cfg->host->host_lock, flags);
 	return PCI_ERS_RESULT_RECOVERED;
 }
@@ -7313,6 +7358,12 @@ static int __devinit ipr_probe_ioa(struc
 		goto cleanup_nolog;
 	}
 
+	if (dev_id->driver_data & IPR_USE_PCI_WARM_RESET) {
+		ioa_cfg->needs_warm_reset = 1;
+		ioa_cfg->reset = ipr_reset_slot_reset;
+	} else
+		ioa_cfg->reset = ipr_reset_start_bist;
+
 	spin_lock(&ipr_driver_lock);
 	list_add_tail(&ioa_cfg->queue, &ipr_ioa_head);
 	spin_unlock(&ipr_driver_lock);
@@ -7553,7 +7604,7 @@ static struct pci_device_id ipr_pci_tabl
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN,
 	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_575C, 0, 0, 0 },
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_OBSIDIAN_E,
-	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_57B7, 0, 0, 0 },
+	      PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_57B7, 0, 0, IPR_USE_PCI_WARM_RESET},
 	{ PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_SNIPE,
 		PCI_VENDOR_ID_IBM, IPR_SUBS_DEV_ID_2780, 0, 0, 0 },
 	{ PCI_VENDOR_ID_ADAPTEC2, PCI_DEVICE_ID_ADAPTEC2_SCAMP,
_
