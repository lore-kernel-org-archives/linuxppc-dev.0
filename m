Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 592941A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 12:49:58 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BBCE140307
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:49:58 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 8 Mar 2016 11:49:57 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 281DC3578052
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 12:49:55 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u281nlEE590100
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:49:55 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u281nMSM016127
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 12:49:22 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Matt Ochs <mrochs@us.ibm.com>, Manoj Kumar <kumarmn@us.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH v3 2/2] cxl: add set/get private data to context struct
Date: Tue,  8 Mar 2016 12:48:35 +1100
Message-Id: <1457401715-26435-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
References: <1457401715-26435-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

This provides AFU drivers a means to associate private data with a cxl
context. This is particularly intended for make the new callbacks for
driver specific events easier for AFU drivers to use, as they can easily
get back to any private data structures they may use.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---

No changes since v1, added Matt Ochs reviewed-by tag.

 drivers/misc/cxl/api.c | 21 +++++++++++++++++++++
 drivers/misc/cxl/cxl.h |  3 +++
 include/misc/cxl.h     |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index eebc9c3..93b270c 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -91,6 +91,27 @@ int cxl_release_context(struct cxl_context *ctx)
 }
 EXPORT_SYMBOL_GPL(cxl_release_context);
 
+
+int cxl_set_priv(struct cxl_context *ctx, void *priv)
+{
+	if (!ctx)
+		return -EINVAL;
+
+	ctx->priv = priv;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_set_priv);
+
+void *cxl_get_priv(struct cxl_context *ctx)
+{
+	if (!ctx)
+		return ERR_PTR(-EINVAL);
+
+	return ctx->priv;
+}
+EXPORT_SYMBOL_GPL(cxl_get_priv);
+
 int cxl_allocate_afu_irqs(struct cxl_context *ctx, int num)
 {
 	if (num == 0)
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 64e8e0a..71f66e7 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -454,6 +454,9 @@ struct cxl_context {
 	/* Only used in PR mode */
 	u64 process_token;
 
+	/* driver private data */
+	void *priv;
+
 	unsigned long *irq_bitmap; /* Accessed from IRQ context */
 	struct cxl_irq_ranges irqs;
 	struct list_head irq_names;
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 01d66a3..76c08cb 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -89,6 +89,13 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev);
 int cxl_release_context(struct cxl_context *ctx);
 
 /*
+ * Set and get private data associated with a context. Allows drivers to have a
+ * back pointer to some useful structure.
+ */
+int cxl_set_priv(struct cxl_context *ctx, void *priv);
+void *cxl_get_priv(struct cxl_context *ctx);
+
+/*
  * Allocate AFU interrupts for this context. num=0 will allocate the default
  * for this AFU as given in the AFU descriptor. This number doesn't include the
  * interrupt 0 (CAIA defines AFU IRQ 0 for page faults). Each interrupt to be
-- 
2.1.4
