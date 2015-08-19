Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E7761A087B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 14:21:13 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EEF314077A
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 19 Aug 2015 14:21:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 375E62BB0051
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J4L1rf50987124
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:21:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J4KatN021649
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 14:20:37 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Matt Ochs <mrochs@us.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 2/2] cxl: add set/get private data to context struct
Date: Wed, 19 Aug 2015 14:19:31 +1000
Message-Id: <1439957971-30483-2-git-send-email-imunsie@au.ibm.com>
In-Reply-To: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
References: <1439957971-30483-1-git-send-email-imunsie@au.ibm.com>
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
---
 drivers/misc/cxl/api.c | 21 +++++++++++++++++++++
 drivers/misc/cxl/cxl.h |  3 +++
 include/misc/cxl.h     |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index e0f0c78..5f0b22e 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -70,6 +70,27 @@ int cxl_release_context(struct cxl_context *ctx)
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
index 30e44a8..93db76a 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -431,6 +431,9 @@ struct cxl_context {
 	/* Only used in PR mode */
 	u64 process_token;
 
+	/* driver private data */
+	void *priv;
+
 	unsigned long *irq_bitmap; /* Accessed from IRQ context */
 	struct cxl_irq_ranges irqs;
 	struct list_head irq_names;
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index 73e03a6..3f5edbe 100644
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
