Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C9606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NL2FiKpK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMkq4Z6Qz2y8r;
	Tue, 17 Nov 2026 22:21:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914515;
	cv=none; b=i7Zf/w5Ab3DnuLviOHT4GJrqxXXEryeFUiPuiDeHm9HF4QmGj3Q61OIW6PfYATbxdlqtiLhiz5y3SnRx8IjaMb7Duhsc8QzFlLBU/X41J3hzpMcbfG9JUHiihfoEaV3O6y+/kM+iE73v22yGnFT4e1+sjV5OoGVzNgTgT4+Wi+BZzw/YIz94fc+We7lrTwxnDe2qHBzx5svpf1ZBIBjfxhpcn+0KxQNjY/0d+W5jrH2jLtxsa9libuoxdei/s9mUT3CIwPECjCe26E0X4l/o+oof3lIImEKqcKkTxlzQAKb38wT2Q/d9NXiYIgGKLne7BYnBrUj8H3CjwQub940xlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914515; c=relaxed/relaxed;
	bh=tPN6t0FJhDsH+qTMFEOJnF2T+J/OJfxtPVagdAeddTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dm7k0BZ5Y1Adca753zTOf5a2i/GO8ptAh6QOs1qz5T73eXfFgL2DQV9n+9Mgw1pnMDzhl7ihlNaF8Z6K3vwUMfvDW4qH30gM8UiKW2B2TtMwzYg/8gME2hUIx5aUEQkn6ekbTryZboxyc6mLyKQvxpVRr9byGfWE2zOy9RM34HdpNwo3ceuSr30pjLwfOjQCXmaz/vj+zQjTz/02rsxyD3BVnDwkTFDnrlucBMs3TaJlVgryBFUxTmxv/v/Yheq1rh3dW+OM/Ygfw73xgFlCTdsHxgHWNd38UGZKFdNiyZev60tNfPDpzvtNMbpPuu7ymoPkDR5LHFYqeo5Mv8z5qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NL2FiKpK; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NL2FiKpK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMkp6Qzgz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:21:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC3E1CC4;
	Tue, 17 Nov 2026 03:21:20 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A885C3F763;
	Tue, 17 Nov 2026 03:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914483; bh=+bvThLLNGVpaICo0kuChHAYX8t5QkzlYMXUCPq6vc/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NL2FiKpKnp16Qs6ShxRqCfGNMLtY5gfBiqOM20zRmq6FB5CYOe5bbm3Mn0fGvOJWL
	 xKwAjfMmVaI1LVQdEmMcHMKkqEAI55ttK0B5a1/Dc+s5zKv5RhL3CPwdSI+W1/NspS
	 ZAGigmcfxfssnjdv/9OKSwRsFcu590QJFvShC9HQ=
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
	Radu Rendec <radu@rendec.net>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 18/19] ACPI: APEI: Route GHES section reporting through extlog
Date: Tue, 17 Nov 2026 12:10:28 +0100
Message-ID: <20261117111444.4185512-19-pierre.gondois@arm.com>
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

Use acpi_extlog_report() for GHES section reporting and remove the
duplicate dispatch code.

GHES memory sections now emit extlog trace events independently of EDAC
registration, using the CPER section severity and one sequence number
per status block. CXL events that cannot be queued fall back to the
nonstandard trace event.

Report all sections before running the remaining GHES handlers. Keep
memory recovery, SIGBUS handling and notifier calls in GHES.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/apei-internal.h |  1 -
 drivers/acpi/apei/extlog.c        |  2 +-
 drivers/acpi/apei/ghes.c          | 57 +++++++------------------------
 3 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 22a33a21017a3..5063c743b4cf0 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -14,7 +14,6 @@ int ghes_severity(int severity);
 int cxl_cper_post_event(enum cxl_event_type event_type,
 			struct cxl_cper_event_rec *rec, u32 len);
 u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
-void extlog_print_pcie(struct acpi_hest_generic_data *gdata);
 void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
 
 struct apei_exec_context;
diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 42ba8ba13804f..d1677d299e389 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -31,7 +31,7 @@
  * CPER_SEV_FATAL or CPER_SEC_RESET -> AER_FATAL
  *     These both need to be reported and recovered from by the AER driver.
  */
-void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
+static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7d2864fa14503..221f0a81c94f6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -566,9 +566,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	char *p;
 
 	sec_sev = ghes_severity(gdata->error_severity);
-	if (length >= sizeof(*err)) {
-		log_arm_hw_error(err, sec_sev);
-	} else {
+	if (length < sizeof(*err)) {
 		pr_warn(FW_BUG "arm error length: %d\n", length);
 		pr_warn(FW_BUG "length is too small\n");
 		pr_warn(FW_BUG "firmware-generated error record is incorrect\n");
@@ -884,34 +882,23 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
-	int sev, sec_sev;
+	int sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
-	const guid_t *fru_id;
-	const char *fru_text;
 	bool queued = false;
 	bool sync = is_hest_sync_notify(ghes);
 
+	acpi_extlog_report(estatus);
+
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
 		sec_type = (guid_t *)gdata->section_type;
-		sec_sev = ghes_severity(gdata->error_severity);
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-			fru_id = (guid_t *)gdata->fru_id;
-		else
-			fru_id = &guid_null;
-
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-			fru_text = gdata->fru_text;
-		else
-			fru_text = "";
-
 		ghes_log_hwerr(sev, sec_type);
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
 			/*
-			 * Check once for all three consumers below. The 73-byte
+			 * Check once for all consumers below. The 73-byte
 			 * UEFI 2.1/2.2 layout is the floor, matching
 			 * cper_estatus_print_section() and making
 			 * validation_bits safe to read.
@@ -944,37 +931,17 @@ static void ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
 			arch_apei_report_mem_error2(sev, mem_err);
 			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			extlog_print_pcie(gdata);
 		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-			struct cxl_cper_sec_prot_err *prot_err = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_prot_err(prot_err, gdata->error_severity,
-					       gdata->error_data_length);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
-					    gdata->error_data_length);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
-					    gdata->error_data_length);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
-					    gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE) ||
+			   guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR) ||
+			   guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID) ||
+			   guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID) ||
+			   guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			/* Reporting and subsystem delivery are handled by extlog. */
+			continue;
 		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
 			ghes_defer_non_standard_event(gdata, sev);
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
 		}
 	}
 
-- 
2.43.0


