Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B24911A05FF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:18 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 11/19] cxl: cxl_afu_reset() -> __cxl_afu_reset()
Date: Tue, 19 May 2015 21:22:28 +1000
Message-Id: <1432034556-32400-12-git-send-email-mikey@neuling.org>
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

Rename cxl_afu_reset() to __cxl_afu_reset() to we can reuse this function name
in the API.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/cxl.h    | 2 +-
 drivers/misc/cxl/native.c | 8 ++++----
 drivers/misc/cxl/pci.c    | 4 ++--
 drivers/misc/cxl/sysfs.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 296a077..8180680 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -657,7 +657,7 @@ int cxl_check_error(struct cxl_afu *afu);
 int cxl_afu_slbia(struct cxl_afu *afu);
 int cxl_tlb_slb_invalidate(struct cxl *adapter);
 int cxl_afu_disable(struct cxl_afu *afu);
-int cxl_afu_reset(struct cxl_afu *afu);
+int __cxl_afu_reset(struct cxl_afu *afu);
 int cxl_psl_purge(struct cxl_afu *afu);
 
 void cxl_stop_trace(struct cxl *cxl);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 29185fc..f85b6ae 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -73,7 +73,7 @@ int cxl_afu_disable(struct cxl_afu *afu)
 }
 
 /* This will disable as well as reset */
-int cxl_afu_reset(struct cxl_afu *afu)
+int __cxl_afu_reset(struct cxl_afu *afu)
 {
 	pr_devel("AFU reset request\n");
 
@@ -495,7 +495,7 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
 	cxl_sysfs_afu_m_remove(afu);
 	cxl_chardev_afu_remove(afu);
 
-	cxl_afu_reset(afu);
+	__cxl_afu_reset(afu);
 	cxl_afu_disable(afu);
 	cxl_psl_purge(afu);
 
@@ -566,7 +566,7 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 	/* master only context for dedicated */
 	assign_psn_space(ctx);
 
-	if ((rc = cxl_afu_reset(afu)))
+	if ((rc = __cxl_afu_reset(afu)))
 		return rc;
 
 	cxl_p2n_write(afu, CXL_PSL_WED_An, wed);
@@ -629,7 +629,7 @@ int cxl_attach_process(struct cxl_context *ctx, bool kernel, u64 wed, u64 amr)
 
 static inline int detach_process_native_dedicated(struct cxl_context *ctx)
 {
-	cxl_afu_reset(ctx->afu);
+	__cxl_afu_reset(ctx->afu);
 	cxl_afu_disable(ctx->afu);
 	cxl_psl_purge(ctx->afu);
 	return 0;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 9066a7a..7130c85 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -641,7 +641,7 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	reg = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
 	if ((reg & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
 		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#.16llx\n", reg);
-		if (cxl_afu_reset(afu))
+		if (__cxl_afu_reset(afu))
 			return -EIO;
 		if (cxl_afu_disable(afu))
 			return -EIO;
@@ -701,7 +701,7 @@ static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 		goto err2;
 
 	/* We need to reset the AFU before we can read the AFU descriptor */
-	if ((rc = cxl_afu_reset(afu)))
+	if ((rc = __cxl_afu_reset(afu)))
 		goto err2;
 
 	if (cxl_verbose)
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index d0c38c7..2d6e104 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -185,7 +185,7 @@ static ssize_t reset_store_afu(struct device *device,
 		goto err;
 	}
 
-	if ((rc = cxl_afu_reset(afu)))
+	if ((rc = __cxl_afu_reset(afu)))
 		goto err;
 
 	rc = count;
-- 
2.1.0
