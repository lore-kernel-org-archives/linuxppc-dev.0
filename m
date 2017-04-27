Return-Path: <srs0=6oba=4d=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD03y1MStzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:39:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wD03y0yRRz8tPS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 11:39:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wD03x3mMHz9s80
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:39:25 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3R1dKiZ008702
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:39:23 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2a2q9abww6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2017 21:39:22 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Thu, 27 Apr 2017 11:39:10 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3R1cxaV62193742
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:39:07 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3R1cXU0003985
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2017 11:38:33 +1000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v2] cxl: Prevent IRQ storm
Date: Thu, 27 Apr 2017 11:37:21 +1000
Message-Id: <20170427013721.2138-1-alastair@au1.ibm.com>
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

Changelog:
v2
	Rebase against linux-next

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/cxl/native.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 194c58e..95a776a 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1205,7 +1205,7 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
 	u64 errstat, serr, afu_error, dsisr;
-	u64 fir_slice, afu_debug;
+	u64 fir_slice, afu_debug, irq_mask;
 
 	/*
 	 * slice err interrupt is only used with full PSL (no XSL)
@@ -1226,6 +1226,10 @@ static irqreturn_t native_slice_irq_err(int irq, void *data)
 	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
 	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
 
+	/* mask off the IRQ so it won't retrigger until the card is reset */
+	irq_mask = (serr & 0xff80000000000000ULL) >> 32;
+	serr |= irq_mask;
+
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
 
 	return IRQ_HANDLED;
-- 
2.9.3
