Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0474D1A0D57
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:49 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 18/24] cxl: Split afu_register_irqs() function
Date: Wed, 27 May 2015 16:07:12 +1000
Message-Id: <1432706838-20794-19-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
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
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h |  1 +
 drivers/misc/cxl/irq.c | 31 ++++++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 58a9b2b..bbc7fd0 100644
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
