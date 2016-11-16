Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJmNk2r3ZzDvmd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:09:57 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGE8hqX007736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:09:55 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rq3fny7g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:09:54 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 17 Nov 2016 00:09:52 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 44EA82BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:09:49 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAGE9nIj48103626
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:09:49 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAGE9mO9028561
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:09:49 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, gkurz@linux.vnet.ibm.com
Subject: [PATCH] cxl: Do adapter fence check before handling afu interrupt
Date: Wed, 16 Nov 2016 19:39:33 +0530
Message-Id: <1479305373-20539-1-git-send-email-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If an afu interrupt is in flight when an eeh error is triggered the
control still reaches the function native_irq_multiplexed and the
PE-Handle read from the CXL_PSL_PEHandle_An register is 0xffff. The
function then erroneously assumes that the interrupt belonged to a
detached context and generates a warning with full stack dump in the
kernel log complaining:

"Unable to demultiplex CXL PSL IRQ for PE 65535 DSISR ffffffff DAR
ffffffff. (Possible AFU HW issue - was a term/remove acked with
outstanding transactions"

To fix this the patch adds new code to the function
native_irq_multiplexed function to compares the read value of register
CXL_PSL_PEHandle_An to ~0ULL. If true then logs a warning message
saying that the interrupt is being ignored and returns IRQ_HANDLED from
the irq handler.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/native.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index a217a74ccc98..c336350ede94 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -931,9 +931,18 @@ static irqreturn_t native_irq_multiplexed(int irq, void *data)
 	struct cxl_afu *afu = data;
 	struct cxl_context *ctx;
 	struct cxl_irq_info irq_info;
-	int ph = cxl_p2n_read(afu, CXL_PSL_PEHandle_An) & 0xffff;
-	int ret;
-
+	u64 phreg = cxl_p2n_read(afu, CXL_PSL_PEHandle_An);
+	int ph, ret;
+
+	/* check if eeh kicked in while the interrupt was in flight */
+	if (unlikely(phreg == ~0ULL)) {
+		dev_warn(&afu->dev,
+			 "Ignoring slice interrupt(%d) due to fenced card",
+			 irq);
+		return IRQ_HANDLED;
+	}
+	/* Mask the pe-handle from register value */
+	ph = phreg & 0xffff;
 	if ((ret = native_get_irq_info(afu, &irq_info))) {
 		WARN(1, "Unable to get CXL IRQ Info: %i\n", ret);
 		return fail_psl_irq(afu, &irq_info);
-- 
2.7.4
