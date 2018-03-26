Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40909R1LBxzF1xf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:50 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGXxMQ080214
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:48 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gy1t28ex1-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:48 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:34:47 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 32/41] cxlflash: Setup LISNs for user contexts
Date: Mon, 26 Mar 2018 11:34:42 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082082-58638-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SISLite specification has been updated for OCXL to support
communicating data to generate AFU interrupts to the AFU. This includes
a new capability bit that is advertised for OCXL AFUs and new registers
to hold the object handle and translation PASID of each interrupt. For
Power, the object handle is the mapped trigger page. Note that because
these mappings are kernel only, the PASID of a kernel context must be
used to satisfy the translation.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/common.h    |  5 +++++
 drivers/scsi/cxlflash/sislite.h   |  5 +++++
 drivers/scsi/cxlflash/superpipe.c | 14 ++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/scsi/cxlflash/common.h b/drivers/scsi/cxlflash/common.h
index d7fccea..b69fd32 100644
--- a/drivers/scsi/cxlflash/common.h
+++ b/drivers/scsi/cxlflash/common.h
@@ -273,6 +273,11 @@ static inline bool afu_has_cap(struct afu *afu, u64 cap)
 	return afu_cap & cap;
 }
 
+static inline bool afu_is_ocxl_lisn(struct afu *afu)
+{
+	return afu_has_cap(afu, SISL_INTVER_CAP_OCXL_LISN);
+}
+
 static inline bool afu_is_afu_debug(struct afu *afu)
 {
 	return afu_has_cap(afu, SISL_INTVER_CAP_AFU_DEBUG);
diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
index d8940f1..c08b9d3 100644
--- a/drivers/scsi/cxlflash/sislite.h
+++ b/drivers/scsi/cxlflash/sislite.h
@@ -310,6 +310,10 @@ struct sisl_ctrl_map {
 #define SISL_CTX_CAP_WRITE_CMD         0x0000000000000002ULL /* afu_rc 0x21 */
 #define SISL_CTX_CAP_READ_CMD          0x0000000000000001ULL /* afu_rc 0x21 */
 	__be64 mbox_r;
+	__be64 lisn_pasid[2];
+	/* pasid _a arg must be ULL */
+#define SISL_LISN_PASID(_a, _b)	(((_a) << 32) | (_b))
+	__be64 lisn_ea[3];
 };
 
 /* single copy global regs */
@@ -416,6 +420,7 @@ struct sisl_global_regs {
 #define SISL_INTVER_CAP_RESERVED_CMD_MODE_B	0x100000000000ULL
 #define SISL_INTVER_CAP_LUN_PROVISION		0x080000000000ULL
 #define SISL_INTVER_CAP_AFU_DEBUG		0x040000000000ULL
+#define SISL_INTVER_CAP_OCXL_LISN		0x020000000000ULL
 };
 
 #define CXLFLASH_NUM_FC_PORTS_PER_BANK	2	/* fixed # of ports per bank */
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index 2fe79df..04a3bf9 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -269,6 +269,7 @@ static int afu_attach(struct cxlflash_cfg *cfg, struct ctx_info *ctxi)
 	int rc = 0;
 	struct hwq *hwq = get_hwq(afu, PRIMARY_HWQ);
 	u64 val;
+	int i;
 
 	/* Unlock cap and restrict user to read/write cmds in translated mode */
 	readq_be(&ctrl_map->mbox_r);
@@ -282,6 +283,19 @@ static int afu_attach(struct cxlflash_cfg *cfg, struct ctx_info *ctxi)
 		goto out;
 	}
 
+	if (afu_is_ocxl_lisn(afu)) {
+		/* Set up the LISN effective address for each interrupt */
+		for (i = 0; i < ctxi->irqs; i++) {
+			val = cfg->ops->get_irq_objhndl(ctxi->ctx, i);
+			writeq_be(val, &ctrl_map->lisn_ea[i]);
+		}
+
+		/* Use primary HWQ PASID as identifier for all interrupts */
+		val = hwq->ctx_hndl;
+		writeq_be(SISL_LISN_PASID(val, val), &ctrl_map->lisn_pasid[0]);
+		writeq_be(SISL_LISN_PASID(0UL, val), &ctrl_map->lisn_pasid[1]);
+	}
+
 	/* Set up MMIO registers pointing to the RHT */
 	writeq_be((u64)ctxi->rht_start, &ctrl_map->rht_start);
 	val = SISL_RHT_CNT_ID((u64)MAX_RHT_PER_CONTEXT, (u64)(hwq->ctx_hndl));
-- 
2.1.0
