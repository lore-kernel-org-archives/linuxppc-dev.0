Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1044A1A1D59
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 10:51:06 +1000 (AEST)
Received: from mail-pd0-x22d.google.com (mail-pd0-x22d.google.com
 [IPv6:2607:f8b0:400e:c02::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E7441401C7
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2015 10:51:05 +1000 (AEST)
Received: by pdco4 with SMTP id o4so953281pdc.3
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2015 17:51:03 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, cyrilbur@gmail.com,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey@neuling.org, imunsie@au.ibm.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v3 03/11] cxl: Allocate and release the SPA with the AFU
Date: Wed, 12 Aug 2015 10:48:12 +1000
Message-Id: <1439340500-18610-4-git-send-email-dja@axtens.net>
In-Reply-To: <1439340500-18610-1-git-send-email-dja@axtens.net>
References: <1439340500-18610-1-git-send-email-dja@axtens.net>
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
index cd1dda5fcd3a..0af3a0d1c697 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -182,10 +182,8 @@ static int spa_max_procs(int spa_size)
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
@@ -204,6 +202,13 @@ static int alloc_spa(struct cxl_afu *afu)
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
 
@@ -212,14 +217,19 @@ static int alloc_spa(struct cxl_afu *afu)
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
@@ -446,8 +456,11 @@ static int activate_afu_directed(struct cxl_afu *afu)
 
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
@@ -558,8 +571,6 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
 	cxl_afu_disable(afu);
 	cxl_psl_purge(afu);
 
-	release_spa(afu);
-
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 32ad09705949..62a762d94de3 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -551,6 +551,8 @@ static void cxl_release_afu(struct device *dev)
 
 	pr_devel("cxl_release_afu\n");
 
+	cxl_release_spa(afu);
+
 	kfree(afu);
 }
 
-- 
2.1.4
