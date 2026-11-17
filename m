Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39110606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSG/Q5CD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMfk6wqRz2y8m;
	Tue, 17 Nov 2026 22:18:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914302;
	cv=none; b=EjcQP/BGRk/cYecb8fB0eILHJ6kP0+2V18PxQBgbPeDv/2fYhjwyXz54IH8PWgtSq7ScEgeypBIhDOu94Yq9W8Fl1M22m+40yyogt2YzvCzPJ8fakaYndPWx7oovRswRV2Y4y/F7xAf2TCE8JzNDnFmC+iZ1RI/PmWu9ehHLjNwcHBJjb1ZyDAORwoA/41J4uYbDmDz5cILf8qY4CJzXNiqE1jZzdkF21GQrCXogRDAEAPHdgyNjcY3AoqGDyckJHvgOf22x4EASSft28SBJsroI+df/r+lBPz0ncvqNOrrYDV8T+W9Zg3nIwebPqjFAZZwf5WCFx8hJja/RbAxyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914302; c=relaxed/relaxed;
	bh=/mF8YDn9SzKZ/tBRzo19EbnjnKr9dUA+FJJmwsFwbow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RsZ9NAYjlUCyibjREcqGiGlcmh1d4B70SQoBKup300OojOFjwV3ucDgn4d3UlD030Q4kYm8P57USC3iNHyEjNMf8auAd3SffDkkFCic1/nSGe9mOxvaShxKX/KMWcLLzkNAGtuf0uaTOgt+3nNEsY/FYvqmbX6HLMCmDF4pQ5Ebh9zDm7dcsGnpizm7bEnzQdIGVbd9sGYRS624oQx8bEx4YAXUvFeflXBV+/KYCVQpIpglwVDiIMX6yggMDVTNeyPuhFGS8/JhbyG3qlT9OpvuDCg1KLGO1eCx12pIR1is+UmKvrsXMTTEkgYX7Fs/tqCe8br1jf0vrfN5aGVB9Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSG/Q5CD; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iSG/Q5CD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMfk1J21z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:18:21 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118611682;
	Tue, 17 Nov 2026 03:17:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2D403F763;
	Tue, 17 Nov 2026 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914271; bh=BFRCbt9be3YwNyQfUo0JQonDsf0DD286+/Lqxp/rjUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSG/Q5CDnoaPwkNewXjRdk8C42BPFwFsjjHkjTZdKmdBPkh49YcL9Rpc6ImhFzCOs
	 PVQzfUn2l7bHxJfGi7fPi9mHIVgRxOjVkiv8W8fn+cyAziaRBXqvdJflajehLWhlYx
	 FVRpcF+TH85V7yMyqj1QZxc5PcaYVDtUVSgaZ+EY=
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
Subject: [PATCH v1 07/19] ACPI: extlog: Provide HEST generic data to extlog_print_pcie()
Date: Tue, 17 Nov 2026 12:10:17 +0100
Message-ID: <20261117111444.4185512-8-pierre.gondois@arm.com>
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

Pass struct acpi_hest_generic_data to extlog_print_pcie() and derive
the payload, severity and length from it instead of passing them
individually. This reduces the number of arguments and makes the
section flags available for subsequent changes.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 5565177be328f..125f7931b98bc 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -133,10 +133,10 @@ static int print_extlog_rcd(const char *pfx,
 	return 1;
 }
 
-static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
-			      int severity, u32 len)
+static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
 	struct aer_capability_regs aer_regs = {};
 	struct pci_dev *pdev;
 	unsigned int devfn;
@@ -144,9 +144,10 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	int aer_severity;
 	int domain;
 
-	if (len < sizeof(*pcie_err)) {
+	if (gdata->error_data_length < sizeof(*pcie_err)) {
 		pr_warn_ratelimited(FW_WARN
-				    "PCIe error section too small (%u)\n", len);
+				    "PCIe error section too small (%u)\n",
+				    gdata->error_data_length);
 		return;
 	}
 
@@ -154,7 +155,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
 		return;
 
-	aer_severity = cper_severity_to_aer(severity);
+	aer_severity = cper_severity_to_aer(gdata->error_severity);
 
 	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
@@ -245,10 +246,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 					       gdata->error_severity,
 					       gdata->error_data_length);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-
-			extlog_print_pcie(pcie_err, gdata->error_severity,
-					  gdata->error_data_length);
+			extlog_print_pcie(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.43.0


