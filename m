Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 146B11A1DE9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 17:44:17 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 64CD4140291
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 17:44:16 +1000 (AEST)
Received: by paccq16 with SMTP id cq16so11338570pac.1
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 00:44:14 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, Daniel Axtens <dja@axtens.net>
Subject: [PATCH v5 03/11] cxl: Allocate and release the SPA with the AFU
Date: Fri, 14 Aug 2015 17:41:19 +1000
Message-Id: <1439538087-32137-4-git-send-email-dja@axtens.net>
In-Reply-To: <1439538087-32137-1-git-send-email-dja@axtens.net>
References: <1439538087-32137-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previously the SPA was allocated and freed upon entering and leaving
AFU-directed mode. This causes some issues for error recovery - contexts
hold a pointer inside the SPA, and they may persist after the AFU has
been detached.

We would ideally like to allocate the SPA when the AFU is allocated, and
release it until the AFU is released. However, we don't know how big the
SPA needs to be until we read the AFU descriptor.

Therefore, restructure the code:

 - Allocate the SPA only once, on the first attach.

 - Release the SPA only when the entire AFU is being released (not
   detached). Guard the release with a NULL check, so we don't free
   if it was never allocated (e.g. dedicated mode)

Acked-by: Cyril Bur <cyrilbur@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/misc/cxl/cxl.h    |  3 +++
 drivers/misc/cxl/native.c | 33 ++++++++++++++++++++++-----------
 drivers/misc/cxl/pci.c    |  2 ++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 9b9e89fd02cc..d540542f9931 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -632,6 +632,9 @@ void unregister_cxl_calls(struct cxl_calls *calls);
 int cxl_alloc_adapter_nr(struct cxl *adapter);
 void cxl_remove_adapter_nr(struct cxl *adapter);
 
+int cxl_alloc_spa(struct cxl_afu *afu);
+void cxl_release_spa(struct cxl_afu *afu);
+
 int cxl_file_init(void);
 void cxl_file_exit(void);
 int cxl_register_adapter(struct cxl *adapter);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 44568dd68bb9..b37f2e8004f5 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -183,10 +183,8 @@ static int spa_max_procs(int spa_size)
 	return ((spa_size / 8) - 96) / 17;
 }
 
-static int alloc_spa(struct cxl_afu *afu)
+int cxl_alloc_spa(struct cxl_afu *afu)
 {
-	u64 spap;
-
 	/* Work out how many pages to allocate */
 	afu->spa_order = 0;
 	do {
@@ -205,6 +203,13 @@ static int alloc_spa(struct cxl_afu *afu)
 	pr_devel("spa pages: %i afu->spa_max_procs: %i   afu->num_procs: %i\n",
 		 1<<afu->spa_order, afu->spa_max_procs, afu->num_procs);
 
+	return 0;
+}
+
+static void attach_spa(struct cxl_afu *afu)
+{
+	u64 spap;
+
 	afu->sw_command_status = (__be64 *)((char *)afu->spa +
 					    ((afu->spa_max_procs + 3) * 128));
 
@@ -213,14 +218,19 @@ static int alloc_spa(struct cxl_afu *afu)
 	spap |= CXL_PSL_SPAP_V;
 	pr_devel("cxl: SPA allocated at 0x%p. Max processes: %i, sw_command_status: 0x%p CXL_PSL_SPAP_An=0x%016llx\n", afu->spa, afu->spa_max_procs, afu->sw_command_status, spap);
 	cxl_p1n_write(afu, CXL_PSL_SPAP_An, spap);
-
-	return 0;
 }
 
-static void release_spa(struct cxl_afu *afu)
+static inline void detach_spa(struct cxl_afu *afu)
 {
 	cxl_p1n_write(afu, CXL_PSL_SPAP_An, 0);
-	free_pages((unsigned long) afu->spa, afu->spa_order);
+}
+
+void cxl_release_spa(struct cxl_afu *afu)
+{
+	if (afu->spa) {
+		free_pages((unsigned long) afu->spa, afu->spa_order);
+		afu->spa = NULL;
+	}
 }
 
 int cxl_tlb_slb_invalidate(struct cxl *adapter)
@@ -447,8 +457,11 @@ static int activate_afu_directed(struct cxl_afu *afu)
 
 	dev_info(&afu->dev, "Activating AFU directed mode\n");
 
-	if (alloc_spa(afu))
-		return -ENOMEM;
+	if (afu->spa == NULL) {
+		if (cxl_alloc_spa(afu))
+			return -ENOMEM;
+	}
+	attach_spa(afu);
 
 	cxl_p1n_write(afu, CXL_PSL_SCNTL_An, CXL_PSL_SCNTL_An_PM_AFU);
 	cxl_p1n_write(afu, CXL_PSL_AMOR_An, 0xFFFFFFFFFFFFFFFFULL);
@@ -559,8 +572,6 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
 	cxl_afu_disable(afu);
 	cxl_psl_purge(afu);
 
-	release_spa(afu);
-
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1d314f1f95fe..dc26cdd653ad 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -552,6 +552,8 @@ static void cxl_release_afu(struct device *dev)
 	pr_devel("cxl_release_afu\n");
 
 	idr_destroy(&afu->contexts_idr);
+	cxl_release_spa(afu);
+
 	kfree(afu);
 }
 
-- 
2.1.4
