Return-Path: <srs0=7h/x=4e=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDfJ65ZWqzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 13:22:14 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDfJ64nVYz8sxx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 13:22:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDfJ61ScSz9s7w
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 13:22:13 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3S3IdFM099500
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 23:22:09 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a3p0djtx6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 23:22:09 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Fri, 28 Apr 2017 13:22:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3S3LvJt7143734
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 13:22:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3S3LRFN003592
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 13:21:28 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: frederic.barrat@fr.ibm.com, vaibhav@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v3] cxl: mask slice error interrupts after first occurrence
Date: Fri, 28 Apr 2017 13:20:15 +1000
Message-Id: <20170428032015.22872-2-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

In some situations, a faulty AFU slice may create an interrupt storm,
rendering the machine unusable. Since these interrupts are informational
only, present the interrupt once, then mask it off to prevent it from
being retriggered until the card is reset.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
Changelog:
v3
	Add CXL_PSL_SERR_An_IRQS, CXL_PSL_SERR_An_IRQ_MASKS macros
	Explicitly reenable masked interrupts after reset
	Issue an info line that subsequent interrupts will be masked
v2
        Rebase against linux-next

---
 drivers/misc/cxl/cxl.h    | 18 ++++++++++++++++++
 drivers/misc/cxl/native.c | 19 +++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 452e209..6b00952 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -228,6 +228,24 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
 #define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
 #define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
+#define CXL_PSL_SERR_An_IRQS	( \
+	CXL_PSL_SERR_An_afuto | CXL_PSL_SERR_An_afudup | CXL_PSL_SERR_An_afuov | \
+	CXL_PSL_SERR_An_badsrc | CXL_PSL_SERR_An_badctx | CXL_PSL_SERR_An_llcmdis | \
+	CXL_PSL_SERR_An_llcmdto | CXL_PSL_SERR_An_afupar | CXL_PSL_SERR_An_afudup)
+#define CXL_PSL_SERR_An_afuto_mask	(1ull << (63-32))
+#define CXL_PSL_SERR_An_afudis_mask	(1ull << (63-33))
+#define CXL_PSL_SERR_An_afuov_mask	(1ull << (63-34))
+#define CXL_PSL_SERR_An_badsrc_mask	(1ull << (63-35))
+#define CXL_PSL_SERR_An_badctx_mask	(1ull << (63-36))
+#define CXL_PSL_SERR_An_llcmdis_mask	(1ull << (63-37))
+#define CXL_PSL_SERR_An_llcmdto_mask	(1ull << (63-38))
+#define CXL_PSL_SERR_An_afupar_mask	(1ull << (63-39))
+#define CXL_PSL_SERR_An_afudup_mask	(1ull << (63-40))
+#define CXL_PSL_SERR_An_IRQ_MASKS	( \
+	CXL_PSL_SERR_An_afuto_mask | CXL_PSL_SERR_An_afudup_mask | CXL_PSL_SERR_An_afuov_mask | \
+	CXL_PSL_SERR_An_badsrc_mask | CXL_PSL_SERR_An_badctx_mask | CXL_PSL_SERR_An_llcmdis_mask | \
+	CXL_PSL_SERR_An_llcmdto_mask | CXL_PSL_SERR_An_afupar_mask | CXL_PSL_SERR_An_afudup_mask)
+
 #define CXL_PSL_SERR_An_AE	(1ull << (63-30))
 
 /****** CXL_PSL_SCNTL_An ****************************************************/
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 194c58e..3e7fc86 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -95,12 +95,23 @@ int cxl_afu_disable(struct cxl_afu *afu)
 /* This will disable as well as reset */
 static int native_afu_reset(struct cxl_afu *afu)
 {
+	int rc;
+	u64 serr;
+
 	pr_devel("AFU reset request\n");
 
-	return afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
+	rc = afu_control(afu, CXL_AFU_Cntl_An_RA, 0,
 			   CXL_AFU_Cntl_An_RS_Complete | CXL_AFU_Cntl_An_ES_Disabled,
 			   CXL_AFU_Cntl_An_RS_MASK | CXL_AFU_Cntl_An_ES_MASK,
 			   false);
+
+	/* Re-enable any masked interrupts */
+	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
+	serr &= ~CXL_PSL_SERR_An_IRQ_MASKS;
+	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
+
+
+	return rc;
 }
 
 static int native_afu_check_and_enable(struct cxl_afu *afu)
@@ -1205,7 +1216,7 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
 	u64 errstat, serr, afu_error, dsisr;
-	u64 fir_slice, afu_debug;
+	u64 fir_slice, afu_debug, irq_mask;
 
 	/*
 	 * slice err interrupt is only used with full PSL (no XSL)
@@ -1226,7 +1237,11 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
 	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
 
+	/* mask off the IRQ so it won't retrigger until the card is reset */
+	irq_mask = (serr & CXL_PSL_SERR_An_IRQS) >> 32;
+	serr |= irq_mask;
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
+	dev_info(&afu->dev, "Further interrupts will be masked until the AFU is reset\n");
 
 	return IRQ_HANDLED;
 }
-- 
2.9.3
