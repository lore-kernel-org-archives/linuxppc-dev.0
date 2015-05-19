Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D37F91A0688
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:21 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 14/19] cxl: Split afu_register_irqs() function
Date: Tue, 19 May 2015 21:22:31 +1000
Message-Id: <1432034556-32400-15-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Split the afu_register_irqs() function so that different parts can
be useful elsewhere.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/cxl.h |  1 +
 drivers/misc/cxl/irq.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 15e1077..f9782a3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -668,5 +668,6 @@ int cxl_psl_purge(struct cxl_afu *afu);
 void cxl_stop_trace(struct cxl *cxl);
 
 extern struct pci_driver cxl_pci_driver;
+int afu_allocate_irqs(struct cxl_context *ctx, u32 count);
 
 #endif
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c740c7b..212790b 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -416,9 +416,8 @@ void afu_irq_name_free(struct cxl_context *ctx)
 	}
 }
 
-int afu_register_irqs(struct cxl_context *ctx, u32 count)
+int afu_allocate_irqs(struct cxl_context *ctx, u32 count)
 {
-	irq_hw_number_t hwirq;
 	int rc, r, i, j = 1;
 	struct cxl_irq_name *irq_name;
 
@@ -458,6 +457,18 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count)
 			j++;
 		}
 	}
+	return 0;
+
+out:
+	afu_irq_name_free(ctx);
+	return -ENOMEM;
+}
+
+void afu_register_hwirqs(struct cxl_context *ctx)
+{
+	irq_hw_number_t hwirq;
+	struct cxl_irq_name *irq_name;
+	int r,i;
 
 	/* We've allocated all memory now, so let's do the irq allocations */
 	irq_name = list_first_entry(&ctx->irq_names, struct cxl_irq_name, list);
@@ -469,13 +480,19 @@ int afu_register_irqs(struct cxl_context *ctx, u32 count)
 			irq_name = list_next_entry(irq_name, list);
 		}
 	}
+}
 
-	return 0;
+int afu_register_irqs(struct cxl_context *ctx, u32 count)
+{
+	int rc;
 
-out:
-	afu_irq_name_free(ctx);
-	return -ENOMEM;
-}
+	rc = afu_allocate_irqs(ctx, count);
+	if (rc)
+		return rc;
+
+	afu_register_hwirqs(ctx);
+	return 0;
+ }
 
 void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 {
-- 
2.1.0
