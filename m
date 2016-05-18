Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8vVq3JQSzDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 23:02:27 +1000 (AEST)
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 18 May 2016 14:02:23 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9222917D807F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 14:03:20 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4ID2Jh362849096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 13:02:20 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4ID2INh024298
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 07:02:19 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mrochs@linux.vnet.ibm.com, manoj@linux.vnet.ibm.com, mpe@ellerman.id.au,
 imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [v4,2/2] cxl: Add set and get private data to context struct
Date: Wed, 18 May 2016 15:01:28 +0200
Message-Id: <1463576488-18944-2-git-send-email-felix@linux.vnet.ibm.com>
In-Reply-To: <1463576488-18944-1-git-send-email-felix@linux.vnet.ibm.com>
References: <1463576488-18944-1-git-send-email-felix@linux.vnet.ibm.com>
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
Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com
Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
No changes since v1, added Matt Ochs reviewed-by tag.

 drivers/misc/cxl/api.c | 21 +++++++++++++++++++++
 drivers/misc/cxl/cxl.h |  3 +++
 include/misc/cxl.h     |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index cd47f39..0eb4bbf 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -103,6 +103,27 @@ static irq_hw_number_t cxl_find_afu_irq(struct cxl_context *ctx, int num)
 	return 0;
 }
 
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
 	int res;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index b48828c..b0e51a3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -485,6 +485,9 @@ struct cxl_context {
 	/* Only used in PR mode */
 	u64 process_token;
 
+	/* driver private data */
+	void *priv;
+
 	unsigned long *irq_bitmap; /* Accessed from IRQ context */
 	struct cxl_irq_ranges irqs;
 	struct list_head irq_names;
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 8a7677e2..e91d849 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -86,6 +86,13 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev);
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
2.1.0
