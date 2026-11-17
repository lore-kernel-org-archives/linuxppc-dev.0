Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDC606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+NzOeBA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMcr2gsxz2xqL;
	Tue, 17 Nov 2026 22:16:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914204;
	cv=none; b=eRCnAsVD6+cBMAMnukSGxIrmV+mHfUHmii7Qvlf8wA92AUkCEmfiEFoeTgi19Du37oeDdznb9nUjqgHH44dAFY98FUwsFFztytQcb8IYAvoyBBZIAgwT8ptby2mPQ79WPB4s2gR/yot5GMWwbEZLjAsEbqUKM57/6RVldd/qqALJIHbbAldp9ipeX5fP2KWHbDS4gfE1co95SoLS8cPrvvGyD91cBp5gRSKvkBz1QKvO+AkxIuwUc/DWJ4BcJeRPZy90Fl3QoXU+XKqPzjT+us+AA+u/z6e7wc7YJF6y3nPHJVIZzTqx57oS0gj+QD77f33XuB5uo3tm6HEqdhibbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914204; c=relaxed/relaxed;
	bh=KdPfRKQsITkj2xTm0Ckh0nynyb6gsVLNNS8iQhKtX9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XnJFyhXb7RQFb4M7XCtGrpF1/2JTDo4NuvvRr3GfTVYrzFk4M7OxvjMMV8idgzAzWPxWYcICOwF5j2EzKrJnJIkJI2XOzODPXfSjLGneKeDYkOm3+4zn0c0rrxE6VdupzMVr/ExUB4r3pgzxgmmuRuDT6bZIqzDjWU4bFGd7mV+q4KSFPF9uz49HxcusrbxnsHtTkGvZL8tRSLnA0rKoefCm1cjSLnLgvC5nCztpeVydny4e9JcRI4Ro9BcRaCNBpTFfwzxtMEhEbQguHgs/hC9H9YpnocYP+5ukd/Wjx+Mt/JQ+21HmBJa87fJEgVU5Yy3eYVq+d+b6u3JeUI922A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+NzOeBA; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+NzOeBA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMcq29WGz2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:16:43 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164BD1A00;
	Tue, 17 Nov 2026 03:16:09 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46A183F763;
	Tue, 17 Nov 2026 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914172; bh=+seG+Es6T8P/0cUkexaRG5Jcisr8c6aEc2SHs8eVSIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+NzOeBAxsNGcwnMbahxLW1vlZFQM3oATmAeDVp631vAcYwtgSPnu/Tm5NR1MTRvY
	 5VvGSJ10TUlgkE08LaxPOtttIdMeB7pXbEasWgp1oSDKNSy99Xb7h/efGIC0QZtZQY
	 WOkvP8vP7b17X/ucRI9utTZCS6ah+ZaM2N7FSmr4=
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
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 02/19] x86/APEI: Report Memory Error Section 2 through MCE
Date: Tue, 17 Nov 2026 12:10:12 +0100
Message-ID: <20261117111444.4185512-3-pierre.gondois@arm.com>
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

Add support for CPER Memory Error Section 2 through MCE, allowing
to emit an mce_record trace event. The implementation follows
the existing CPER Memory Error Section (1) implementation.

Fix the mismatch between the parameter definition/declaration
of apei_mce_report_mem_error().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/x86/include/asm/mce.h     |  5 ++++-
 arch/x86/kernel/acpi/apei.c    |  7 +++++++
 arch/x86/kernel/cpu/mce/apei.c | 12 ++++++++++++
 drivers/acpi/apei/apei-base.c  |  5 +++++
 drivers/acpi/apei/ghes.c       |  1 +
 include/acpi/apei.h            |  1 +
 6 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9995176d68790..4a590a250720d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -336,8 +336,11 @@ extern void (*deferred_error_int_vector)(void);
  */
 
 struct cper_sec_mem_err;
-extern void apei_mce_report_mem_error(int corrected,
+struct cper_sec_mem_err2;
+extern void apei_mce_report_mem_error(int severity,
 				      struct cper_sec_mem_err *mem_err);
+extern void apei_mce_report_mem_error2(int severity,
+				      struct cper_sec_mem_err2 *mem_err);
 
 /*
  * Enumerate new IP types and HWID values in AMD processors which support
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index e21419e686eb3..96eb75b570e4e 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -46,6 +46,13 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 #endif
 }
 
+void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err)
+{
+#ifdef CONFIG_X86_MCE
+	apei_mce_report_mem_error2(sev, mem_err);
+#endif
+}
+
 int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	return apei_smca_report_x86_error(ctx_info, lapic_id);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b993ac78a3b36..2404faa60c325 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -68,6 +68,18 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+void apei_mce_report_mem_error2(int severity, struct cper_sec_mem_err2 *mem_err)
+{
+	u64 mask = 0;
+
+	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
+		return;
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
+		mask = mem_err->physical_addr_mask;
+
+	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
+}
+
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 7a06d30bd40e9..a2dbdfabeb6c7 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -773,6 +773,11 @@ void __weak arch_apei_report_mem_error(int sev,
 }
 EXPORT_SYMBOL_GPL(arch_apei_report_mem_error);
 
+void __weak arch_apei_report_mem_error2(int sev,
+					struct cper_sec_mem_err2 *mem_err)
+{
+}
+
 int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07306af5a54b9..703f3b7f700a6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1030,6 +1030,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			}
 
 			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
+			arch_apei_report_mem_error2(sev, mem_err);
 			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524f..a92174793d9c2 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -52,6 +52,7 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err);
 
 #endif
 #endif
-- 
2.43.0


