Return-Path: <linuxppc-dev+bounces-23854-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0213C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:26:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ421D71z30F0;
	Thu, 09 Jul 2026 09:26:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519237;
	cv=none; b=BjG58JDMxeWd8RyuoanG4X/hOLJz8LUKzHDS6UpWVxmRVW5frZmLmcfWIbNkQ4nuh1hIB/T41KWGZp5bKE6DoKa8yhrBIAmBBHeUJpjGHyHmjyEkXJBD7MmTR/GQCHUzXaV8bv26mRG8184ixNmVixyIYU6lOA1ECErkGuk20i00ZMnN0v3UnBskEIodg80QPP6V04lM97WaQCOnAIppEnQ4QiPbIuPf5RTHFvhNrE31ygxZLWxDlDgD4uLQkOyXMx6anx718NF+MmDVMFEZvbdmJLv7SEfS/u/4q+3zNcEDGAkdfxD55wJhC7xr1YHpHek3a1LTTPBVWsS3B/9u4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519237; c=relaxed/relaxed;
	bh=8kxX7dEIvyuDxw8E8sfXA9NQx4cHMELsH9WA1LbO1wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UdI8BEyqW6wPU8UmMH3b50//BUcxS/OnAs1Vka1yU86vNhH82pGsUNZE858CQtd3ARdg5+YHix5gFnW4P5b5JEMl9AHvfp/atsFdWuzGWgJXZapjjVzBYe6KmtpGh1LekKSIntMMsChJXQCzGt7k2/Slm54dYWbIqesDljI/6WBGCTMXv+b9j0aeQmy/jCuVnAr1U/KtK0iqgb0z8TNzR8OaM9edb2ny1CkMEwXQpFXvYAf/XyZZWenOtaa3R6NzVHYJR3bYouciEgJ/rW6zR7Cx9nP+gurd2uYclkrSGfGa2CnZbUz5XqdRTub829AadQeySX1TeNlPDFO6wZmGig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hHJ3bFIh; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=hHJ3bFIh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKVq5kwDz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:35 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C657B152B;
	Wed,  8 Jul 2026 07:00:00 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2579C3F66F;
	Wed,  8 Jul 2026 07:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519205; bh=Tsu3YA5dDiGwZYj0JxoNYapp8d527LejPJa7JNF2qj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hHJ3bFIh6c02fp1KsnHcVnmeScqr9aSqcjhP/bUEjaXVQy1KB2XKQKI7hLQ4T7+iO
	 +rkm48rg9tWn7gH5L7EgRJOvsXw7GHNnFos1eEzha4BAz3Gpl5cwdViZm3iTwpVFjo
	 eDUg0vK2l+Qi/Hv6T3iDg6iScUB+u671VGcR1KP4=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:07 +0100
Subject: [PATCH v7 08/10] ACPI: APEI: share GHES CPER helpers
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-8-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ahmed Tiba <ahmed.tiba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-edac@vger.kernel.org, 
 linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=35262;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=Tsu3YA5dDiGwZYj0JxoNYapp8d527LejPJa7JNF2qj4=;
 b=HZvs69dgc5QQEebWB6lCljWH1ziag2cX76r1bFqhCne5d3c7V6ihroyDDw2OTsH+LfUq6s5cb
 0ADal7bmjWJAFc3wfOytOhEQ9+20AK0A1+OAsn5/obd+0ZqvATUHEql
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Wire GHES up to the helper routines in ghes_cper.c and remove the local
copies from ghes.c. This keeps the control flow identical while letting
the helpers be shared with other firmware-first providers.

The weak arch_apei_report_mem_error() fallback is only there to keep the
shared helper buildable when GHES_CPER_HELPERS is enabled without
ACPI_APEI, while preserving the current GHES behaviour when ACPI_APEI
is enabled.

Serialize ghes_estatus_pool_init() and allow later users to extend the
shared pool instead of racing a second initialization or silently
reusing a pool sized only for the first user.

Fix queued tracking and AER overflow cleanup.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 464 +--------------------------------------
 drivers/acpi/apei/ghes_cper.c | 500 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/aer.c        |   9 +-
 include/acpi/ghes_cper.h      |  20 ++
 4 files changed, 529 insertions(+), 464 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 2a83d326e692..c643c1703819 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -67,8 +67,6 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
-static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
-
 /*
  * This driver isn't really modular, however for the time being,
  * continuing to use module_param is the easiest way to remain
@@ -113,469 +111,11 @@ static DEFINE_MUTEX(ghes_devs_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
-struct gen_pool *ghes_estatus_pool;
-
-int ghes_estatus_pool_init(unsigned int num_ghes)
-{
-	unsigned long addr, len;
-	int rc;
-
-	ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
-	if (!ghes_estatus_pool)
-		return -ENOMEM;
-
-	len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
-	len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
-
-	addr = (unsigned long)vmalloc(PAGE_ALIGN(len));
-	if (!addr)
-		goto err_pool_alloc;
-
-	rc = gen_pool_add(ghes_estatus_pool, addr, PAGE_ALIGN(len), -1);
-	if (rc)
-		goto err_pool_add;
-
-	return 0;
-
-err_pool_add:
-	vfree((void *)addr);
-
-err_pool_alloc:
-	gen_pool_destroy(ghes_estatus_pool);
-
-	return -ENOMEM;
-}
-
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
-static inline int ghes_severity(int severity)
-{
-	switch (severity) {
-	case CPER_SEV_INFORMATIONAL:
-		return GHES_SEV_NO;
-	case CPER_SEV_CORRECTED:
-		return GHES_SEV_CORRECTED;
-	case CPER_SEV_RECOVERABLE:
-		return GHES_SEV_RECOVERABLE;
-	case CPER_SEV_FATAL:
-		return GHES_SEV_PANIC;
-	default:
-		/* Unknown, go panic */
-		return GHES_SEV_PANIC;
-	}
-}
-
-
-/**
- * struct ghes_task_work - for synchronous RAS event
- *
- * @twork:                callback_head for task work
- * @pfn:                  page frame number of corrupted page
- * @flags:                work control flags
- *
- * Structure to pass task work to be handled before
- * returning to user-space via task_work_add().
- */
-struct ghes_task_work {
-	struct callback_head twork;
-	u64 pfn;
-	int flags;
-};
-
-static void memory_failure_cb(struct callback_head *twork)
-{
-	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
-	int ret;
-
-	ret = memory_failure(twcb->pfn, twcb->flags);
-	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
-
-	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
-		return;
-
-	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
-			twcb->pfn, current->comm, task_pid_nr(current));
-	force_sig(SIGBUS);
-}
-
-static bool ghes_do_memory_failure(u64 physical_addr, int flags)
-{
-	struct ghes_task_work *twcb;
-	unsigned long pfn;
-
-	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		return false;
-
-	pfn = PHYS_PFN(physical_addr);
-
-	if (flags == MF_ACTION_REQUIRED && current->mm) {
-		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
-		if (!twcb)
-			return false;
-
-		twcb->pfn = pfn;
-		twcb->flags = flags;
-		init_task_work(&twcb->twork, memory_failure_cb);
-		task_work_add(current, &twcb->twork, TWA_RESUME);
-		return true;
-	}
-
-	memory_failure_queue(pfn, flags);
-	return true;
-}
-
-static bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
-				       int sev, bool sync)
-{
-	int flags = -1;
-	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return false;
-
-	/* iff following two events can be handled properly by now */
-	if (sec_sev == GHES_SEV_CORRECTED &&
-	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
-		flags = MF_SOFT_OFFLINE;
-	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
-		flags = sync ? MF_ACTION_REQUIRED : 0;
-
-	if (flags != -1)
-		return ghes_do_memory_failure(mem_err->physical_addr, flags);
-
-	return false;
-}
-
-static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
-				     int sev, bool sync)
-{
-	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-	int flags = sync ? MF_ACTION_REQUIRED : 0;
-	int length = gdata->error_data_length;
-	char error_type[120];
-	bool queued = false;
-	int sec_sev, i;
-	char *p;
-
-	sec_sev = ghes_severity(gdata->error_severity);
-	if (length >= sizeof(*err)) {
-		log_arm_hw_error(err, sec_sev);
-	} else {
-		pr_warn(FW_BUG "arm error length: %d\n", length);
-		pr_warn(FW_BUG "length is too small\n");
-		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
-		return false;
-	}
-
-	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
-		return false;
-
-	p = (char *)(err + 1);
-	length -= sizeof(err);
-
-	for (i = 0; i < err->err_info_num; i++) {
-		struct cper_arm_err_info *err_info;
-		bool is_cache, has_pa;
-
-		/* Ensure we have enough data for the error info header */
-		if (length < sizeof(*err_info))
-			break;
-
-		err_info = (struct cper_arm_err_info *)p;
-
-		/* Validate the claimed length before using it */
-		length -= err_info->length;
-		if (length < 0)
-			break;
-
-		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
-		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-
-		/*
-		 * The field (err_info->error_info & BIT(26)) is fixed to set to
-		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
-		 * firmware won't mix corrected errors in an uncorrected section,
-		 * and don't filter out 'corrected' error here.
-		 */
-		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
-			p += err_info->length;
-			continue;
-		}
-
-		cper_bits_to_str(error_type, sizeof(error_type),
-				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
-				 cper_proc_error_type_strs,
-				 ARRAY_SIZE(cper_proc_error_type_strs));
-
-		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type 0x%02x: %s%s\n",
-				    err_info->type, error_type,
-				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
-		p += err_info->length;
-	}
-
-	return queued;
-}
-
-/*
- * PCIe AER errors need to be sent to the AER driver for reporting and
- * recovery. The GHES severities map to the following AER severities and
- * require the following handling:
- *
- * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
- *     These need to be reported by the AER driver but no recovery is
- *     necessary.
- * GHES_SEV_RECOVERABLE -> AER_NONFATAL
- * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
- *     These both need to be reported and recovered from by the AER driver.
- * GHES_SEV_PANIC does not make it to this handling since the kernel must
- *     panic.
- */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
-	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
-		unsigned int devfn;
-		int aer_severity;
-		u8 *aer_info;
-
-		devfn = PCI_DEVFN(pcie_err->device_id.device,
-				  pcie_err->device_id.function);
-		aer_severity = cper_severity_to_aer(gdata->error_severity);
-
-		/*
-		 * If firmware reset the component to contain
-		 * the error, we must reinitialize it before
-		 * use, so treat it as a fatal AER error.
-		 */
-		if (gdata->flags & CPER_SEC_RESET)
-			aer_severity = AER_FATAL;
-
-		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
-						  sizeof(struct aer_capability_regs));
-		if (!aer_info)
-			return;
-		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
-
-		aer_recover_queue(pcie_err->device_id.segment,
-				  pcie_err->device_id.bus,
-				  devfn, aer_severity,
-				  (struct aer_capability_regs *)
-				  aer_info);
-	}
-#endif
-}
-
-static void ghes_log_hwerr(int sev, guid_t *sec_type)
-{
-	if (sev != CPER_SEV_RECOVERABLE)
-		return;
-
-	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
-	    guid_equal(sec_type, &CPER_SEC_PROC_GENERIC) ||
-	    guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
-		hwerr_log_error_type(HWERR_RECOV_CPU);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
-	    guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-		hwerr_log_error_type(HWERR_RECOV_CXL);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
-	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS)) {
-		hwerr_log_error_type(HWERR_RECOV_PCI);
-		return;
-	}
-
-	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-		hwerr_log_error_type(HWERR_RECOV_MEMORY);
-		return;
-	}
-
-	hwerr_log_error_type(HWERR_RECOV_OTHERS);
-}
-
-static bool ghes_cxl_event_len_valid(struct acpi_hest_generic_data *gdata,
-				     struct cxl_cper_event_rec *rec)
-{
-	if (gdata->error_data_length < sizeof(*rec) ||
-	    rec->hdr.length <= sizeof(rec->hdr) ||
-	    rec->hdr.length > gdata->error_data_length ||
-	    rec->hdr.length > sizeof(*rec)) {
-		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
-		       rec->hdr.length);
-		return false;
-	}
-
-	return true;
-}
-
-static bool ghes_cxl_prot_err_len_valid(struct acpi_hest_generic_data *gdata,
-					struct cxl_cper_sec_prot_err *prot_err)
-{
-	if (gdata->error_data_length < sizeof(*prot_err) +
-	    sizeof(struct cxl_ras_capability_regs)) {
-		pr_err(FW_WARN "CXL CPER Invalid protocol error length (%u)\n",
-		       gdata->error_data_length);
-		return false;
-	}
-
-	if (prot_err->dvsec_len >
-	    gdata->error_data_length - sizeof(*prot_err) -
-	    sizeof(struct cxl_ras_capability_regs)) {
-		pr_err(FW_WARN "CXL CPER invalid DVSEC length (%u)\n",
-		       prot_err->dvsec_len);
-		return false;
-	}
-
-	return true;
-}
-
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
-	struct acpi_hest_generic_data *gdata;
-	guid_t *sec_type;
-	const guid_t *fru_id = &guid_null;
-	char *fru_text = "";
-	bool queued = false;
-	bool sync = is_hest_sync_notify(ghes);
-
-	sev = ghes_severity(estatus->error_severity);
-	apei_estatus_for_each_section(estatus, gdata) {
-		sec_type = (guid_t *)gdata->section_type;
-		sec_sev = ghes_severity(gdata->error_severity);
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-			fru_id = (guid_t *)gdata->fru_id;
-
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-			fru_text = gdata->fru_text;
-
-		ghes_log_hwerr(sev, sec_type);
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
-
-			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
-		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
-
-			if (!ghes_cxl_prot_err_len_valid(gdata, prot_err))
-				continue;
-
-			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			if (!ghes_cxl_event_len_valid(gdata, rec))
-				continue;
-
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			if (!ghes_cxl_event_len_valid(gdata, rec))
-				continue;
-
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			if (!ghes_cxl_event_len_valid(gdata, rec))
-				continue;
-
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
-		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
-			ghes_defer_non_standard_event(gdata, sev);
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
-		}
-	}
-
-	/*
-	 * If no memory failure work is queued for abnormal synchronous
-	 * errors, do a force kill.
-	 */
-	if (sync && !queued) {
-		dev_err(ghes->dev,
-			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
-			current->comm, task_pid_nr(current));
-		force_sig(SIGBUS);
-	}
-}
-
-static void __ghes_print_estatus(const char *pfx,
-				 const struct acpi_hest_generic *generic,
-				 const struct acpi_hest_generic_status *estatus)
-{
-	static atomic_t seqno;
-	unsigned int curr_seqno;
-	char pfx_seq[64];
-
-	if (pfx == NULL) {
-		if (ghes_severity(estatus->error_severity) <=
-		    GHES_SEV_CORRECTED)
-			pfx = KERN_WARNING;
-		else
-			pfx = KERN_ERR;
-	}
-	curr_seqno = atomic_inc_return(&seqno);
-	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
-	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
-	       pfx_seq, generic->header.source_id);
-	cper_estatus_print(pfx_seq, estatus);
-}
-
-static int ghes_print_estatus(const char *pfx,
-			      const struct acpi_hest_generic *generic,
-			      const struct acpi_hest_generic_status *estatus)
-{
-	/* Not more than 2 messages every 5 seconds */
-	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
-	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
-	struct ratelimit_state *ratelimit;
-
-	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
-		ratelimit = &ratelimit_corrected;
-	else
-		ratelimit = &ratelimit_uncorrected;
-	if (__ratelimit(ratelimit)) {
-		__ghes_print_estatus(pfx, generic, estatus);
-		return 1;
-	}
-	return 0;
+	ghes_cper_handle_status(ghes->dev, ghes->generic,
+				estatus, is_hest_sync_notify(ghes));
 }
 
 static void __ghes_panic(struct ghes *ghes,
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index b59e3ed3eab3..ec8881ada97e 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -13,7 +13,9 @@
  */
 
 #include <linux/aer.h>
+#include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/genalloc.h>
 #include <linux/io.h>
@@ -21,11 +23,20 @@
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/uuid.h>
+#include <linux/sched/signal.h>
+#include <linux/task_work.h>
 #include <linux/notifier.h>
+#include <linux/ras.h>
+#include <ras/ras_event.h>
 #include <linux/ratelimit.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/clock.h>
 #include <linux/slab.h>
+#include <linux/vmcore_info.h>
+#include <linux/vmalloc.h>
 
 #include <acpi/apei.h>
 #include <acpi/acpi_io.h>
@@ -36,9 +47,497 @@
 
 #include "apei-internal.h"
 
+ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
+
+#ifndef CONFIG_ACPI_APEI
+void __weak arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err) { }
+#endif
+
 static struct ghes_estatus_cache __rcu *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+struct gen_pool *ghes_estatus_pool;
+static DEFINE_MUTEX(ghes_estatus_pool_lock);
+
+int ghes_estatus_pool_init(unsigned int num_ghes)
+{
+	unsigned long addr, len;
+	int rc;
+
+	len = GHES_ESTATUS_CACHE_AVG_SIZE * GHES_ESTATUS_CACHE_ALLOCED_MAX;
+	len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
+	len = PAGE_ALIGN(len);
+
+	mutex_lock(&ghes_estatus_pool_lock);
+
+	if (!ghes_estatus_pool) {
+		ghes_estatus_pool = gen_pool_create(GHES_ESTATUS_POOL_MIN_ALLOC_ORDER, -1);
+		if (!ghes_estatus_pool) {
+			rc = -ENOMEM;
+			goto out_unlock;
+		}
+	}
+
+	addr = (unsigned long)vmalloc(len);
+	if (!addr) {
+		rc = -ENOMEM;
+		goto err_pool_alloc;
+	}
+
+	rc = gen_pool_add(ghes_estatus_pool, addr, len, -1);
+	if (rc)
+		goto err_pool_add;
+
+	mutex_unlock(&ghes_estatus_pool_lock);
+	return 0;
+
+err_pool_add:
+	vfree((void *)addr);
+
+err_pool_alloc:
+	if (!gen_pool_avail(ghes_estatus_pool) && !gen_pool_size(ghes_estatus_pool)) {
+		gen_pool_destroy(ghes_estatus_pool);
+		ghes_estatus_pool = NULL;
+	}
+out_unlock:
+	mutex_unlock(&ghes_estatus_pool_lock);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_init);
+
+/**
+ * ghes_estatus_pool_region_free - free previously allocated memory
+ *				   from the ghes_estatus_pool.
+ * @addr: address of memory to free.
+ * @size: size of memory to free.
+ *
+ * Returns none.
+ */
+void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
+{
+	gen_pool_free(ghes_estatus_pool, addr, size);
+}
+EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
+
+int ghes_severity(int severity)
+{
+	switch (severity) {
+	case CPER_SEV_INFORMATIONAL:
+		return GHES_SEV_NO;
+	case CPER_SEV_CORRECTED:
+		return GHES_SEV_CORRECTED;
+	case CPER_SEV_RECOVERABLE:
+		return GHES_SEV_RECOVERABLE;
+	case CPER_SEV_FATAL:
+		return GHES_SEV_PANIC;
+	default:
+		/* Unknown, go panic */
+		return GHES_SEV_PANIC;
+	}
+}
+
+/**
+ * struct ghes_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                work control flags
+ *
+ * Structure to pass task work to be handled before
+ * returning to user-space via task_work_add().
+ */
+struct ghes_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
+{
+	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
+	int ret;
+
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
+
+	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+			twcb->pfn, current->comm, task_pid_nr(current));
+	force_sig(SIGBUS);
+}
+
+static bool ghes_do_memory_failure(u64 physical_addr, int flags)
+{
+	struct ghes_task_work *twcb;
+	unsigned long pfn;
+
+	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
+		return false;
+
+	pfn = PHYS_PFN(physical_addr);
+
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return true;
+	}
+
+	memory_failure_queue(pfn, flags);
+	return true;
+}
+
+bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				int sev, bool sync)
+{
+	int flags = -1;
+	int sec_sev = ghes_severity(gdata->error_severity);
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return false;
+
+	/* iff following two events can be handled properly by now */
+	if (sec_sev == GHES_SEV_CORRECTED &&
+	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
+		flags = MF_SOFT_OFFLINE;
+	if (sev == GHES_SEV_RECOVERABLE && sec_sev == GHES_SEV_RECOVERABLE)
+		flags = sync ? MF_ACTION_REQUIRED : 0;
+
+	if (flags != -1)
+		return ghes_do_memory_failure(mem_err->physical_addr, flags);
+
+	return false;
+}
+
+bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+			      int sev, bool sync)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	int length = gdata->error_data_length;
+	char error_type[120];
+	bool queued = false;
+	int sec_sev, i;
+	char *p;
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (length >= sizeof(*err)) {
+		log_arm_hw_error(err, sec_sev);
+	} else {
+		pr_warn(FW_BUG "arm error length: %d\n", length);
+		pr_warn(FW_BUG "length is too small\n");
+		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
+		return false;
+	}
+
+	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
+		return false;
+
+	p = (char *)(err + 1);
+	length -= sizeof(*err);
+
+	for (i = 0; i < err->err_info_num; i++) {
+		struct cper_arm_err_info *err_info;
+		bool is_cache, has_pa;
+
+		/* Ensure we have enough data for the error info header */
+		if (length < sizeof(*err_info))
+			break;
+
+		err_info = (struct cper_arm_err_info *)p;
+
+		/* Validate the claimed length before using it */
+		length -= err_info->length;
+		if (length < 0)
+			break;
+
+		is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
+		has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
+
+		/*
+		 * The field (err_info->error_info & BIT(26)) is fixed to set to
+		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
+		 * firmware won't mix corrected errors in an uncorrected section,
+		 * and don't filter out 'corrected' error here.
+		 */
+		if (is_cache && has_pa) {
+			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			p += err_info->length;
+			continue;
+		}
+
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+		p += err_info->length;
+	}
+
+	return queued;
+}
+
+/*
+ * PCIe AER errors need to be sent to the AER driver for reporting and
+ * recovery. The GHES severities map to the following AER severities and
+ * require the following handling:
+ *
+ * GHES_SEV_CORRECTABLE -> AER_CORRECTABLE
+ *     These need to be reported by the AER driver but no recovery is
+ *     necessary.
+ * GHES_SEV_RECOVERABLE -> AER_NONFATAL
+ * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
+ *     These both need to be reported and recovered from by the AER driver.
+ * GHES_SEV_PANIC does not make it to this handling since the kernel must
+ *     panic.
+ */
+void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+
+	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO) {
+		unsigned int devfn;
+		int aer_severity;
+		u8 *aer_info;
+
+		devfn = PCI_DEVFN(pcie_err->device_id.device,
+				  pcie_err->device_id.function);
+		aer_severity = cper_severity_to_aer(gdata->error_severity);
+
+		/*
+		 * If firmware reset the component to contain
+		 * the error, we must reinitialize it before
+		 * use, so treat it as a fatal AER error.
+		 */
+		if (gdata->flags & CPER_SEC_RESET)
+			aer_severity = AER_FATAL;
+
+		aer_info = (void *)gen_pool_alloc(ghes_estatus_pool,
+						  sizeof(struct aer_capability_regs));
+		if (!aer_info)
+			return;
+		memcpy(aer_info, pcie_err->aer_info, sizeof(struct aer_capability_regs));
+
+		aer_recover_queue(pcie_err->device_id.segment,
+				  pcie_err->device_id.bus,
+				  devfn, aer_severity,
+				  (struct aer_capability_regs *)
+				  aer_info);
+	}
+#endif
+}
+
+void ghes_log_hwerr(int sev, guid_t *sec_type)
+{
+	if (sev != CPER_SEV_RECOVERABLE)
+		return;
+
+	if (guid_equal(sec_type, &CPER_SEC_PROC_ARM) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_GENERIC) ||
+	    guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		hwerr_log_error_type(HWERR_RECOV_CPU);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
+	    guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+		hwerr_log_error_type(HWERR_RECOV_CXL);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
+	    guid_equal(sec_type, &CPER_SEC_PCI_X_BUS)) {
+		hwerr_log_error_type(HWERR_RECOV_PCI);
+		return;
+	}
+
+	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+		hwerr_log_error_type(HWERR_RECOV_MEMORY);
+		return;
+	}
+
+	hwerr_log_error_type(HWERR_RECOV_OTHERS);
+}
+
+static bool ghes_cxl_event_len_valid(struct acpi_hest_generic_data *gdata,
+				     struct cxl_cper_event_rec *rec)
+{
+	if (gdata->error_data_length < sizeof(*rec) ||
+	    rec->hdr.length <= sizeof(rec->hdr) ||
+	    rec->hdr.length > gdata->error_data_length ||
+	    rec->hdr.length > sizeof(*rec)) {
+		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
+		       rec->hdr.length);
+		return false;
+	}
+
+	return true;
+}
+
+static bool ghes_cxl_prot_err_len_valid(struct acpi_hest_generic_data *gdata,
+					struct cxl_cper_sec_prot_err *prot_err)
+{
+	if (gdata->error_data_length < sizeof(*prot_err) +
+	    sizeof(struct cxl_ras_capability_regs)) {
+		pr_err(FW_WARN "CXL CPER Invalid protocol error length (%u)\n",
+		       gdata->error_data_length);
+		return false;
+	}
+
+	if (prot_err->dvsec_len >
+	    gdata->error_data_length - sizeof(*prot_err) -
+	    sizeof(struct cxl_ras_capability_regs)) {
+		pr_err(FW_WARN "CXL CPER invalid DVSEC length (%u)\n",
+		       prot_err->dvsec_len);
+		return false;
+	}
+
+	return true;
+}
+
+void ghes_cper_handle_status(struct device *dev,
+			     const struct acpi_hest_generic *generic,
+			     const struct acpi_hest_generic_status *estatus,
+			     bool sync)
+{
+	int sev, sec_sev;
+	struct acpi_hest_generic_data *gdata;
+	guid_t *sec_type;
+	const guid_t *fru_id = &guid_null;
+	char *fru_text = "";
+	bool queued = false;
+
+	sev = ghes_severity(estatus->error_severity);
+	apei_estatus_for_each_section(estatus, gdata) {
+		sec_type = (guid_t *)gdata->section_type;
+		sec_sev = ghes_severity(gdata->error_severity);
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+			fru_id = (guid_t *)gdata->fru_id;
+
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+			fru_text = gdata->fru_text;
+
+		ghes_log_hwerr(sev, sec_type);
+		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+
+			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
+
+			arch_apei_report_mem_error(sev, mem_err);
+			queued |= ghes_handle_memory_failure(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			ghes_handle_aer(gdata);
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
+
+			if (!ghes_cxl_prot_err_len_valid(gdata, prot_err))
+				continue;
+
+			cxl_cper_post_prot_err(prot_err, gdata->error_severity);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			if (!ghes_cxl_event_len_valid(gdata, rec))
+				continue;
+
+			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			if (!ghes_cxl_event_len_valid(gdata, rec))
+				continue;
+
+			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			if (!ghes_cxl_event_len_valid(gdata, rec))
+				continue;
+
+			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			ghes_defer_non_standard_event(gdata, sev);
+			log_non_standard_event(sec_type, fru_id, fru_text,
+					       sec_sev, err,
+					       gdata->error_data_length);
+		}
+	}
+
+	/*
+	 * If no memory failure work is queued for abnormal synchronous
+	 * errors, do a force kill.
+	 */
+	if (sync && !queued) {
+		dev_err(dev,
+			HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
+			current->comm, task_pid_nr(current));
+		force_sig(SIGBUS);
+	}
+}
+
+void __ghes_print_estatus(const char *pfx,
+			  const struct acpi_hest_generic *generic,
+			  const struct acpi_hest_generic_status *estatus)
+{
+	static atomic_t seqno;
+	unsigned int curr_seqno;
+	char pfx_seq[64];
+
+	if (pfx == NULL) {
+		if (ghes_severity(estatus->error_severity) <=
+		    GHES_SEV_CORRECTED)
+			pfx = KERN_WARNING;
+		else
+			pfx = KERN_ERR;
+	}
+	curr_seqno = atomic_inc_return(&seqno);
+	snprintf(pfx_seq, sizeof(pfx_seq), "%s{%u}" HW_ERR, pfx, curr_seqno);
+	printk("%s""Hardware error from APEI Generic Hardware Error Source: %d\n",
+	       pfx_seq, generic->header.source_id);
+	cper_estatus_print(pfx_seq, estatus);
+}
+
+int ghes_print_estatus(const char *pfx,
+		       const struct acpi_hest_generic *generic,
+		       const struct acpi_hest_generic_status *estatus)
+{
+	/* Not more than 2 messages every 5 seconds */
+	static DEFINE_RATELIMIT_STATE(ratelimit_corrected, 5*HZ, 2);
+	static DEFINE_RATELIMIT_STATE(ratelimit_uncorrected, 5*HZ, 2);
+	struct ratelimit_state *ratelimit;
+
+	if (ghes_severity(estatus->error_severity) <= GHES_SEV_CORRECTED)
+		ratelimit = &ratelimit_corrected;
+	else
+		ratelimit = &ratelimit_uncorrected;
+	if (__ratelimit(ratelimit)) {
+		__ghes_print_estatus(pfx, generic, estatus);
+		return 1;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_ACPI_APEI
 static void __iomem *ghes_map(u64 pfn, enum fixed_addresses fixmap_idx)
 {
 	phys_addr_t paddr;
@@ -284,6 +783,7 @@ void ghes_clear_estatus(struct ghes *ghes,
 	if (is_hest_type_generic_v2(ghes))
 		ghes_ack_error(ghes->generic_v2);
 }
+#endif /* CONFIG_ACPI_APEI */
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..1448f4f725d4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1228,6 +1228,8 @@ static void aer_recover_work_func(struct work_struct *work)
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
+			ghes_estatus_pool_region_free((unsigned long)entry.regs,
+					      sizeof(struct aer_capability_regs));
 			continue;
 		}
 		pci_print_aer(pdev, entry.severity, entry.regs);
@@ -1274,9 +1276,12 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
 				 &aer_recover_ring_lock))
 		schedule_work(&aer_recover_work);
-	else
-		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
+	else {
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					      sizeof(*aer_regs));
+		pr_err_ratelimited("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index a853a5996cdf..e09a33d343d7 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -16,6 +16,8 @@
 #ifndef ACPI_APEI_GHES_CPER_H
 #define ACPI_APEI_GHES_CPER_H
 
+#include <linux/device.h>
+#include <linux/notifier.h>
 #include <linux/workqueue.h>
 
 #include <acpi/ghes.h>
@@ -57,6 +59,7 @@
 	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
 
 extern struct gen_pool *ghes_estatus_pool;
+extern struct atomic_notifier_head ghes_report_chain;
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 {
@@ -107,6 +110,23 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
 void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 				   int sev);
+int ghes_severity(int severity);
+bool ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				int sev, bool sync);
+bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
+			      int sev, bool sync);
+void ghes_handle_aer(struct acpi_hest_generic_data *gdata);
+void ghes_log_hwerr(int sev, guid_t *sec_type);
+void __ghes_print_estatus(const char *pfx,
+			  const struct acpi_hest_generic *generic,
+			  const struct acpi_hest_generic_status *estatus);
+int ghes_print_estatus(const char *pfx,
+		       const struct acpi_hest_generic *generic,
+		       const struct acpi_hest_generic_status *estatus);
+void ghes_cper_handle_status(struct device *dev,
+			     const struct acpi_hest_generic *generic,
+			     const struct acpi_hest_generic_status *estatus,
+			     bool sync);
 void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 			    int severity);
 int cxl_cper_register_prot_err_work(struct work_struct *work);

-- 
2.43.0


