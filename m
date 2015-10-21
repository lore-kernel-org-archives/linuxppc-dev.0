Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 587951A0A7C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 07:15:02 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 16:15:00 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 52C3D38C8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:14:58 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9LKEwCi64159872
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 20:14:58 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LKEFVY009049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:14:17 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Tomas Henzl <thenzl@redhat.com>, David Laight <David.Laight@ACULAB.COM>
Cc: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 15/37] cxlflash: Fix host link up event handling
Date: Wed, 21 Oct 2015 15:13:37 -0500
Message-Id: <1445458417-15949-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1445458134-63197-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Following a link up event, the LUNs available to the host may
have changed. Without rescanning the host, the LUN topology is
unknown to the user. In such a state, the user would be unable
to locate provisioned resources.

To remedy, the host should be rescanned after a link up event.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

Conflicts:
	drivers/scsi/cxlflash/common.h
---
 drivers/scsi/cxlflash/common.h |  1 +
 drivers/scsi/cxlflash/main.c   | 17 +++++++++++++----
 drivers/scsi/cxlflash/main.h   |  1 +
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index 7a0cb5c..faf7f56 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -102,6 +102,7 @@ struct cxlflash_cfg {
 	enum cxlflash_init_state init_state;
 	enum cxlflash_lr_state lr_state;
 	int lr_port;
+	atomic_t scan_host_needed;
 
 	struct cxl_afu *cxl_afu;
 
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 5503a40..98fdac1 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1119,17 +1119,17 @@ static const struct asyc_intr_info ainfo[] = {
 	{SISL_ASTATUS_FC0_CRC_T, "CRC threshold exceeded", 0, LINK_RESET},
 	{SISL_ASTATUS_FC0_LOGI_R, "login timed out, retrying", 0, 0},
 	{SISL_ASTATUS_FC0_LOGI_F, "login failed", 0, CLR_FC_ERROR},
-	{SISL_ASTATUS_FC0_LOGI_S, "login succeeded", 0, 0},
+	{SISL_ASTATUS_FC0_LOGI_S, "login succeeded", 0, SCAN_HOST},
 	{SISL_ASTATUS_FC0_LINK_DN, "link down", 0, 0},
-	{SISL_ASTATUS_FC0_LINK_UP, "link up", 0, 0},
+	{SISL_ASTATUS_FC0_LINK_UP, "link up", 0, SCAN_HOST},
 	{SISL_ASTATUS_FC1_OTHER, "other error", 1, CLR_FC_ERROR | LINK_RESET},
 	{SISL_ASTATUS_FC1_LOGO, "target initiated LOGO", 1, 0},
 	{SISL_ASTATUS_FC1_CRC_T, "CRC threshold exceeded", 1, LINK_RESET},
 	{SISL_ASTATUS_FC1_LOGI_R, "login timed out, retrying", 1, 0},
 	{SISL_ASTATUS_FC1_LOGI_F, "login failed", 1, CLR_FC_ERROR},
-	{SISL_ASTATUS_FC1_LOGI_S, "login succeeded", 1, 0},
+	{SISL_ASTATUS_FC1_LOGI_S, "login succeeded", 1, SCAN_HOST},
 	{SISL_ASTATUS_FC1_LINK_DN, "link down", 1, 0},
-	{SISL_ASTATUS_FC1_LINK_UP, "link up", 1, 0},
+	{SISL_ASTATUS_FC1_LINK_UP, "link up", 1, SCAN_HOST},
 	{0x0, "", 0, 0}		/* terminator */
 };
 
@@ -1350,6 +1350,11 @@ static irqreturn_t cxlflash_async_err_irq(int irq, void *data)
 			writeq_be(reg, &global->fc_regs[port][FC_ERROR / 8]);
 			writeq_be(0, &global->fc_regs[port][FC_ERRCAP / 8]);
 		}
+
+		if (info->action & SCAN_HOST) {
+			atomic_inc(&cfg->scan_host_needed);
+			schedule_work(&cfg->work_q);
+		}
 	}
 
 out:
@@ -2309,6 +2314,7 @@ MODULE_DEVICE_TABLE(pci, cxlflash_pci_table);
  * - Link reset which cannot be performed on interrupt context due to
  * blocking up to a few seconds
  * - Read AFU command room
+ * - Rescan the host
  */
 static void cxlflash_worker_thread(struct work_struct *work)
 {
@@ -2351,6 +2357,9 @@ static void cxlflash_worker_thread(struct work_struct *work)
 	}
 
 	spin_unlock_irqrestore(cfg->host->host_lock, lock_flags);
+
+	if (atomic_dec_if_positive(&cfg->scan_host_needed) >= 0)
+		scsi_scan_host(cfg->host);
 }
 
 /**
diff --git a/drivers/scsi/cxlflash/main.h b/drivers/scsi/cxlflash/main.h
index cf0e809..6032456 100644
--- a/drivers/scsi/cxlflash/main.h
+++ b/drivers/scsi/cxlflash/main.h
@@ -99,6 +99,7 @@ struct asyc_intr_info {
 	u8 action;
 #define CLR_FC_ERROR	0x01
 #define LINK_RESET	0x02
+#define SCAN_HOST	0x04
 };
 
 #ifndef CONFIG_CXL_EEH
-- 
2.1.0
