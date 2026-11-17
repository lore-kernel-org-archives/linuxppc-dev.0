Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87C606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ePUqz6Y+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMfL2mpQz2xqL;
	Tue, 17 Nov 2026 22:18:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914282;
	cv=none; b=dvt1gZn9LjbcCHOsd5Rk8GQawUEK8UerYAduVPNUf5HNr9psOqWCUYrH1ec/02V5fNZKiLZHXQHG424gMS3IL1KKZqHaxXDH9OqbbXbgLEW51UPjvkGxVXktFgBMEwcrrh0Tl8QvDKzTTyzeArE1uU0N0XhfmckJfYlx9DTm6Gv0a+FJ/qLmHrBPe9s1n/QWaFlJ4F7kXCbmmuO/MAmYILcwjQCNhY84uP4Rc1UGmRwuGOsV9k3SVkHOd8t8M0ul83+foX/FImIuJWYd2Y59p08IFhMprB8kwx51s5zfZCwpgJmE/EasMJX0E2slV4SRK7ZycUWQOXVrdfVuCneAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914282; c=relaxed/relaxed;
	bh=tpTbtNPlh0yFyNiQuwrnCVn7d+2Dlp/qOMDJjkdmFss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o06ITobT5mI/HcmN/nZNbxvXDtux6pA0SmryHqUVq4nt0UgKSaPayrPmp7GrtAMsFvvj2IlEuSj4xtw1yolCSlSbplGwZJQEk/d8IVX8hzQB75GWojBx85ZL8Smr5+GRaM/N8l7R0qKNVfprVPsJ51w3SmYM52L0LPrFJh87LCXyO6dBQK7WrzqR3NxfnxxraGgjOmksk+0EUBWkVh+JDq9ic3ZvRZeobXE6I2E9JoCshe++Mg3CJgAZD6v+cGlPPwkVZLlv1tXS1oqEh2uKfOHvl3OuTeD4ONrdnnZR3wo/UcrE39c0p246V0iyxmbOdKljEpVsTj43QoeZCj5l3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ePUqz6Y+; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ePUqz6Y+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMfK49czz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:18:01 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DFDB1688;
	Tue, 17 Nov 2026 03:17:27 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 886E13F763;
	Tue, 17 Nov 2026 03:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914250; bh=CZxQUP4/YGsMm/XqVPx8eQPf2WaLQJdyQBXadMV+rVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePUqz6Y+XP7+z8eWafB5lC30G+5VcWocsWmV+Nmevu7mpUir69jf2OzPA0Qsjjs9Z
	 wxipkL7hLlPwuY8QHLfZSIn5phFYVcYWMb7IaFV9C51T4DGoOXJryXIDdDk+OcCCZw
	 8P+rwVvE7LX1RST8g/twdCW2Xe1VoDQ3BygTnTfo=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 06/19] ACPI: APEI: Remove aer allocation in ghes_handle_aer()
Date: Tue, 17 Nov 2026 12:10:16 +0100
Message-ID: <20261117111444.4185512-7-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aer_recover_queue() now copies the input aer_regs instead of
storing a pointer to the struct. Use a local variable to pass
aer_regs in ghes_handle_aer() and remove the memory allocation
introduced by:
commit e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error
status data has multiple sections")

No functional change intended.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 25 +++----------------------
 drivers/pci/pcie/aer.c   | 17 +++++------------
 include/acpi/ghes.h      |  4 ----
 include/linux/aer.h      |  2 +-
 4 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 444d8e82353a7..3aecd3f828e58 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -228,20 +228,6 @@ int ghes_estatus_pool_init(unsigned int num_ghes)
 	return -ENOMEM;
 }
 
-/**
- * ghes_estatus_pool_region_free - free previously allocated memory
- *				   from the ghes_estatus_pool.
- * @addr: address of memory to free.
- * @size: size of memory to free.
- *
- * Returns none.
- */
-void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
-{
-	gen_pool_free(ghes_estatus_pool, addr, size);
-}
-EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
-
 static int map_gen_v2(struct ghes *ghes)
 {
 	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
@@ -666,7 +652,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
 	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
-		struct aer_capability_regs *aer_info;
+		struct aer_capability_regs aer_info;
 		unsigned int devfn;
 		int aer_severity;
 
@@ -682,16 +668,11 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 		if (gdata->flags & CPER_SEC_RESET)
 			aer_severity = AER_FATAL;
 
-		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
-						  sizeof(struct aer_capability_regs));
-		if (!aer_info)
-			return;
-
-		aer_cap_regs_unpack(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+		aer_cap_regs_unpack(&aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
-				  devfn, aer_severity, aer_info);
+				  devfn, aer_severity, &aer_info);
 	}
 #endif
 }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 57406494ec1f7..d7ef84e3b988e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -32,7 +32,6 @@
 #include <linux/slab.h>
 #include <linux/vmcore_info.h>
 #include <acpi/apei.h>
-#include <acpi/ghes.h>
 #include <ras/ras_event.h>
 
 #include "../pci.h"
@@ -1413,18 +1412,15 @@ static DECLARE_WORK(aer_recover_work, aer_recover_work_func);
  * @severity: AER_CORRECTABLE, AER_NONFATAL or AER_FATAL
  * @aer_regs: snapshot of the device's AER Capability registers
  *
- * Queue an error record received from firmware through APEI GHES.  The
- * record is processed later from a workqueue, which logs the error and,
+ * Queue an error record received from firmware. The record is processed
+ * later from a workqueue, which logs the error and,
  * for uncorrectable errors, attempts recovery of the device.
  *
- * Takes ownership of @aer_regs, which must have been allocated from
- * ghes_estatus_pool with a size of sizeof(struct aer_capability_regs).
- * Copies the registers into the queue entry and frees the supplied buffer
- * before returning, including when the queue is full. The caller must not
- * access or free @aer_regs after this call.
+ * Copies @aer_regs into the recovery queue. The caller retains ownership of
+ * the supplied snapshot and may reuse it after this function returns.
  */
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs)
+		       int severity, const struct aer_capability_regs *aer_regs)
 {
 	struct aer_recover_entry entry = {
 		.bus		= bus,
@@ -1434,9 +1430,6 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		.regs		= *aer_regs,
 	};
 
-	ghes_estatus_pool_region_free((unsigned long)aer_regs,
-				      sizeof(struct aer_capability_regs));
-
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
 				 &aer_recover_ring_lock)) {
 		schedule_work(&aer_recover_work);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 3fdb7ea59f9cc..ef58e2251407e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -84,15 +84,11 @@ int devm_ghes_register_vendor_record_notifier(struct device *dev,
 
 struct list_head *ghes_get_devices(void);
 
-void ghes_estatus_pool_region_free(unsigned long addr, u32 size);
-
 struct cxl_cper_sec_prot_err;
 void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 			    int severity, u32 len);
 #else
 static inline struct list_head *ghes_get_devices(void) { return NULL; }
-
-static inline void ghes_estatus_pool_region_free(unsigned long addr, u32 size) { return; }
 #endif
 
 int ghes_estatus_pool_init(unsigned int num_ghes);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 043ee76b6f538..0a5ec7956b487 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -79,6 +79,6 @@ void aer_cap_regs_unpack(struct aer_capability_regs *regs, const void *raw,
 			 size_t raw_len);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
-		       int severity, struct aer_capability_regs *aer_regs);
+		       int severity, const struct aer_capability_regs *aer_regs);
 #endif //_AER_H_
 
-- 
2.43.0


