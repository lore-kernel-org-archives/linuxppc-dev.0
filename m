Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD4061A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 12:32:00 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A53A140770
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2015 12:32:00 +1000 (AEST)
Received: by paciu1 with SMTP id iu1so15413415pac.0
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Jul 2015 19:31:59 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 4/8] cxl: Make IRQ release idempotent
Date: Tue, 14 Jul 2015 12:29:30 +1000
Message-Id: <1436840974-3412-5-git-send-email-dja@axtens.net>
In-Reply-To: <1436840974-3412-1-git-send-email-dja@axtens.net>
References: <1436840974-3412-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check if an IRQ is mapped before releasing it.

This will simplify future EEH code by allowing unconditional unmapping
of IRQs.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/irq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 680cd263436d..121ec48f3ab4 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -341,6 +341,9 @@ int cxl_register_psl_err_irq(struct cxl *adapter)
 
 void cxl_release_psl_err_irq(struct cxl *adapter)
 {
+	if (adapter->err_virq != irq_find_mapping(NULL, adapter->err_hwirq))
+		return;
+
 	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
 	cxl_unmap_irq(adapter->err_virq, adapter);
 	cxl_release_one_irq(adapter, adapter->err_hwirq);
@@ -374,6 +377,9 @@ int cxl_register_serr_irq(struct cxl_afu *afu)
 
 void cxl_release_serr_irq(struct cxl_afu *afu)
 {
+	if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
+		return;
+
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
 	cxl_unmap_irq(afu->serr_virq, afu);
 	cxl_release_one_irq(afu->adapter, afu->serr_hwirq);
@@ -400,6 +406,9 @@ int cxl_register_psl_irq(struct cxl_afu *afu)
 
 void cxl_release_psl_irq(struct cxl_afu *afu)
 {
+	if (afu->psl_virq != irq_find_mapping(NULL, afu->psl_hwirq))
+		return;
+
 	cxl_unmap_irq(afu->psl_virq, afu);
 	cxl_release_one_irq(afu->adapter, afu->psl_hwirq);
 	kfree(afu->psl_irq_name);
-- 
2.1.4
