Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4090BT4FxszF24C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:35:45 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGT3Je064777
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy1t28g16-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:35:42 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 12:35:41 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 40/41] cxlflash: Remove commmands from pending list on
 timeout
Date: Mon, 26 Mar 2018 11:35:34 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082134-58938-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following Oops can occur if an internal command sent to the AFU does
not complete within the timeout:

[c000000ff101b810] c008000016020d94 term_mc+0xfc/0x1b0 [cxlflash]
[c000000ff101b8a0] c008000016020fb0 term_afu+0x168/0x280 [cxlflash]
[c000000ff101b930] c0080000160232ec cxlflash_pci_error_detected+0x184/0x230
                                       [cxlflash]
[c000000ff101b9e0] c00800000d95d468 cxl_vphb_error_detected+0x90/0x150[cxl]
[c000000ff101ba20] c00800000d95f27c cxl_pci_error_detected+0xa4/0x240 [cxl]
[c000000ff101bac0] c00000000003eaf8 eeh_report_error+0xd8/0x1b0
[c000000ff101bb20] c00000000003d0b8 eeh_pe_dev_traverse+0x98/0x170
[c000000ff101bbb0] c00000000003f438 eeh_handle_normal_event+0x198/0x580
[c000000ff101bc60] c00000000003fba4 eeh_handle_event+0x2a4/0x338
[c000000ff101bd10] c0000000000400b8 eeh_event_handler+0x1f8/0x200
[c000000ff101bdc0] c00000000013da48 kthread+0x1a8/0x1b0
[c000000ff101be30] c00000000000b528 ret_from_kernel_thread+0x5c/0xb4

When an internal command times out, the command buffer is freed while it
is still in the pending commands list of the context. This corrupts the
list and when the context is cleaned up, a crash is encountered.

To resolve this issue, when an AFU command or TMF command times out, the
command should be deleted from the hardware queue pending command list
before freeing the buffer.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index dfe7648..c920328 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -473,6 +473,7 @@ static int send_tmf(struct cxlflash_cfg *cfg, struct scsi_device *sdev,
 	struct afu_cmd *cmd = NULL;
 	struct device *dev = &cfg->dev->dev;
 	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
+	bool needs_deletion = false;
 	char *buf = NULL;
 	ulong lock_flags;
 	int rc = 0;
@@ -527,6 +528,7 @@ static int send_tmf(struct cxlflash_cfg *cfg, struct scsi_device *sdev,
 	if (!to) {
 		dev_err(dev, "%s: TMF timed out\n", __func__);
 		rc = -ETIMEDOUT;
+		needs_deletion = true;
 	} else if (cmd->cmd_aborted) {
 		dev_err(dev, "%s: TMF aborted\n", __func__);
 		rc = -EAGAIN;
@@ -537,6 +539,12 @@ static int send_tmf(struct cxlflash_cfg *cfg, struct scsi_device *sdev,
 	}
 	cfg->tmf_active = false;
 	spin_unlock_irqrestore(&cfg->tmf_slock, lock_flags);
+
+	if (needs_deletion) {
+		spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
+		list_del(&cmd->list);
+		spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
+	}
 out:
 	kfree(buf);
 	return rc;
@@ -2284,6 +2292,7 @@ static int send_afu_cmd(struct afu *afu, struct sisl_ioarcb *rcb)
 	struct device *dev = &cfg->dev->dev;
 	struct afu_cmd *cmd = NULL;
 	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
+	ulong lock_flags;
 	char *buf = NULL;
 	int rc = 0;
 	int nretry = 0;
@@ -2329,6 +2338,11 @@ static int send_afu_cmd(struct afu *afu, struct sisl_ioarcb *rcb)
 	case -ETIMEDOUT:
 		rc = afu->context_reset(hwq);
 		if (rc) {
+			/* Delete the command from pending_cmds list */
+			spin_lock_irqsave(&hwq->hsq_slock, lock_flags);
+			list_del(&cmd->list);
+			spin_unlock_irqrestore(&hwq->hsq_slock, lock_flags);
+
 			cxlflash_schedule_async_reset(cfg);
 			break;
 		}
-- 
2.1.0
