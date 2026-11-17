Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63466606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rtKjuUYk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMjh0zz6z2yMP;
	Tue, 17 Nov 2026 22:20:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914456;
	cv=none; b=oiMmTZRfWaBSNPxtMBJTR/C2WQwpTVo4JgdDOV1MEYWcETgeLzwgC3cqy8MvaVo53fI8svaf4ocKCS3JWwJNoxzuiGQNG8sdoXegIr/QnmaPmqK6u//V+Bgl+rlvWTKSXwrredbKytjenDmtt71lHCOUy24E2Ddk1TCwRuUV9o4mTeQyURkMBQW9Eva9nMdYCEOQ0z5jJhnJi0FgPk6FidT+cAjP+HGCHOYdc+x3Q7GW/gHch3sNyQl2ytHmwyZCz5XzU3GzLHpw5XC1hAKPyRd2UssB/p3P5qeQx30fzb3vXkReM3XzVzxbZ9UDtqMdaSrjo4tvWjZNB5FLBwbGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914456; c=relaxed/relaxed;
	bh=BckNrK/yBbpMJc7+ljdha3/xl+zHdn2KaJ8oIO6r40k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rn9eiFFG98WAFKJLMTS7tWqMHitQWbHBGlBBsiBDAnnFrEmvFq/TUhL6SNrrnCMK2wUFjzEoxKBnrvtSlgvIM2WKCUzsyiVskxnkTZpLsY4ktcAINpytoFyr9xhmNkPqX16TBJxGdebgEpSf9AERQatAvZqpQ9hWHQnBYLVv952Op471WQH9melmL7meda4kLVqv7lh22a4zdanhPxA+8+noyV8D3eSoBxLOqufnBegtJO3RCdWhAR2K+DWypHEo55nsE/3PMyOWborzrJnX5HGyOmcRPBWn+vV2ylYvU8Rp+0cgeIB/lalMMPVHxXGT7gkv14h3cnQoQEf+fCqkvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rtKjuUYk; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=rtKjuUYk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMjg32B8z2yLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:20:55 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61C351C14;
	Tue, 17 Nov 2026 03:20:21 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 359643F763;
	Tue, 17 Nov 2026 03:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914424; bh=/YV6HNEH/aCY1HDiH0DATihf/+IdxF8ClXwHWSKsQNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rtKjuUYkkowGneLHRGSDd+L4Ip2tTIvv7xnLo1AXBLuArBj61GyuO33cKw0rjyo3M
	 W8PsWMAwfkHnO0xIJ6u6inqNG0FaL7pcv90sJaYRTz4tK/Oxd5ajzeshihMfgGuOy4
	 R2I1GiclCp1SfRUqjhigZM+wBG5uNdokrFhCLbpc=
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 15/19] ACPI: APEI: Extend common CPER reporting for GHES section types
Date: Tue, 17 Nov 2026 12:10:25 +0100
Message-ID: <20261117111444.4185512-16-pierre.gondois@arm.com>
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

Add ARM processor tracing and CXL media delivery to acpi_extlog_report()
to prepare for GHES reuse. Trace CXL records as nonstandard events when
validation or queueing fails, preserving their payload and FRU metadata.

Reuse acpi_extlog_mem_err_min_len() to accept legacy 73-byte memory
sections while rejecting records with missing fields marked valid.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/extlog.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 8d9b91a764902..8cae5bdacf1c6 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -153,6 +153,8 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 	/* log event via trace */
 	err_seq = atomic_inc_return(&seqno);
 	apei_estatus_for_each_section(estatus, gdata) {
+		int fallback_log = 0;
+
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
 		else
@@ -165,8 +167,13 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
 			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
 
-			if (gdata->error_data_length >= sizeof(*mem))
-				acpi_extlog_mem_error(gdata, err_seq);
+			if (gdata->error_data_length <
+			    sizeof(struct cper_sec_mem_err_old))
+				continue;
+			if (gdata->error_data_length <
+			    acpi_extlog_mem_err_min_len(mem->validation_bits))
+				continue;
+			acpi_extlog_mem_error(gdata, err_seq);
 		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
 			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
 
@@ -181,7 +188,31 @@ void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
 					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			extlog_print_pcie(gdata);
+		} else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length >= sizeof(*err))
+				log_arm_hw_error(err, ghes_severity(gdata->error_severity));
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
+							   gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
+							   gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
+			struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
+
+			fallback_log = cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
+							   gdata->error_data_length);
 		} else {
+			fallback_log = 1;
+		}
+
+		if (fallback_log) {
 			void *err = acpi_hest_get_payload(gdata);
 
 			log_non_standard_event(sec_type, fru_id, fru_text,
-- 
2.43.0


