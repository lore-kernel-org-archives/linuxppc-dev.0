Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BAA606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DDZWJqL3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMdb4fVYz2y7p;
	Tue, 17 Nov 2026 22:17:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914243;
	cv=none; b=N/BIfev6LRtXyeX4Ke2DsXHywikfpDRPQ+6ZVlWjB/ZarGTmDQXDTjc1cez26bzJc/dLMVszsAn2MRYAuK0R1CpbyQ8eyo3vL+2XubRGzHgoW577+pWxIEPrICrTd3/ZPcrckLlp0SykZWKSivdE443vWYNkeDYDt506NZQ8Mz375sX2sKBgT4pMZDLZdTrqC/SCiIZqQ/LtPXKYxgpMFzyYcL5CzY+UrM+oh6TdgXX4fsTO4ioCqYb/U8cWpZDTgFFJtG2SPCrDcguuhloHloErAqRKwFUKjOotplptLVZ01Z8lG4B4OOvu+k4HDzFQHlho1sQbwzwSwPdSb88yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914243; c=relaxed/relaxed;
	bh=1gFolVlbnQDXq7AXqEZR4zbd1HbosfkpV82uoaeqRJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pgoy7RBTFqL5NeOCSpZdeGH0xNpoHCzYPZbvPnZoIAsfAAdiH0hrFvGpxriHcPji+qAFzQu4URuuV+pBMxv7c/kXGROJyZqM68LrkzrhTAjRU26RzQ8WZj364wDL+ud9i+DzLs3bgP8WmNA56vP9lMwHv0vQU3JkyG96Tn03yRz+I9KEZjY6abit1Ph/m+JSF8p8e9HfWOICr86cQA+kXMWmy4agBIt+AAWg/RK4bS58gChdle5wsBfMQhASVkBUmyfUgP8r9U/qPxLaNsUG69QuA2vfugIuY743Q1d1GPq+PijbqLV3rSJpKhCLkmqjv03YKxQtocMWG/s8148Sug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DDZWJqL3; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=DDZWJqL3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMdb05FZz2xqL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:17:22 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 667031A32;
	Tue, 17 Nov 2026 03:16:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD5AD3F763;
	Tue, 17 Nov 2026 03:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914211; bh=yG1nBF1b9ClCQ09cnEWfpTO17qf4/sPT/Xz+KvI9LS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDZWJqL3hpEb6fgA+Erdl+GlfKCrNmcK3poDr93VEXJbe92PdvfQewqRI75jNcKns
	 2Zdb/0ufZrIf6sSQtpr8OvK3n9H0eyxrYw6BhS9yZUFqTPrT5XhktNX8UlqHArvYXp
	 NBZgwM8MrOzGZuSA0iYLXFdRcJGYkZqFq+wl3uNM=
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 04/19] ACPI: APEI: Use empty FRU values if valid bit is absent
Date: Tue, 17 Nov 2026 12:10:14 +0100
Message-ID: <20261117111444.4185512-5-pierre.gondois@arm.com>
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

When a status block contains multiple sections, a section without valid
FRU fields inherits pointers from the preceding section.

Use empty fru_id and fru_text values whenever the matching VALID
bit is not set instead of reusing the value of the previous loop.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/ghes.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 703f3b7f700a6..444d8e82353a7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -979,8 +979,8 @@ static void ghes_do_proc(struct ghes *ghes,
 	int sev, sec_sev;
 	struct acpi_hest_generic_data *gdata;
 	guid_t *sec_type;
-	const guid_t *fru_id = &guid_null;
-	char *fru_text = "";
+	const guid_t *fru_id;
+	const char *fru_text;
 	bool queued = false;
 	bool sync = is_hest_sync_notify(ghes);
 
@@ -990,9 +990,13 @@ static void ghes_do_proc(struct ghes *ghes,
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
 			fru_id = (guid_t *)gdata->fru_id;
+		else
+			fru_id = &guid_null;
 
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
+		else
+			fru_text = "";
 
 		ghes_log_hwerr(sev, sec_type);
 		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-- 
2.43.0


