Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EB731A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 03:22:09 +1100 (AEDT)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Feb 2016 16:22:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C1C3617D8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:25 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1NGM4Q936044810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 16:22:04 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1NGM4pv008821
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Feb 2016 09:22:04 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 07/18] cxl: Update cxl_irq() prototype
Date: Tue, 23 Feb 2016 17:21:48 +0100
Message-Id: <1456244519-18934-8-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456244519-18934-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The context parameter when calling cxl_irq() should be strongly typed.

Co-authored-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h | 2 +-
 drivers/misc/cxl/irq.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 40f6783..c7ed265 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -714,7 +714,7 @@ struct cxl_irq_info {
 };
 
 void cxl_assign_psn_space(struct cxl_context *ctx);
-irqreturn_t cxl_irq(int irq, void *ctx, struct cxl_irq_info *irq_info);
+irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
 int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
 			void *cookie, irq_hw_number_t *dest_hwirq,
 			unsigned int *dest_virq, const char *name);
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 56ad301..5033869 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -27,9 +27,8 @@ static irqreturn_t schedule_cxl_fault(struct cxl_context *ctx, u64 dsisr, u64 da
 	return IRQ_HANDLED;
 }
 
-irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
+irqreturn_t cxl_irq(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info)
 {
-	struct cxl_context *ctx = data;
 	u64 dsisr, dar;
 
 	dsisr = irq_info->dsisr;
-- 
1.9.1
