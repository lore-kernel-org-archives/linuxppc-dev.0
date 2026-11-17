Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF1606A323
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ey53Fz+d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMcR4dy6z2xnZ;
	Tue, 17 Nov 2026 22:16:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914183;
	cv=none; b=ZSZBGW1xR7y8U41fec5yJV92i2p4Iih2kQ4Bk4/8L6WUxHWmPfet01GXCKIWuXNlPKZ+8HMXkWHkaKrHRN8WU2L5dTvhGN32wN5V9ni/nSL97OeqpvybPzX30oi5kIsJl12u9ygvebl2FhX23n0UjtWQl3C9vNOawKaH3HG/r2mAys+DYy4SwxRHl28VadjutmDXEKwhPz8awCx+vg4N/fF214ycPTYTwBhUA+nrFSIxJsOYghcJPmftbMym5MKtqLbi0CnhgDIOi6tPGX5JR5fDYBfM8yJuC942c1d2YWt2DyNXVtNYVY3eUCB6hlHFVHaiydZUjg+SbliZtvUFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914183; c=relaxed/relaxed;
	bh=mQgaO4mrJ1/PGb5G6f2VYZd+cZSDJVZYowDL8wylwCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecnTgOScMx+lDeVV0+oi4/zCwGKfAugH9+nX+PXHbg0XdGeaP0Bi3MPQGgwBSwhI2CYTpwoEWv9RFqOvD8ETnhpOWCG051yBGRK7h9B/DdSEyEsvHSIXn1+QjPsKYV8mil2y7LpE3W/dNJtgMBijmA2p6v8tXQ3FMW/d6fSbh4E7Mxz1I9DoxaHDQohHCVxNGyS5JzuACZItkQzuIRJ1wrkHsRvZk4nTaSOdxZ38qhls5S9/w/5sQefeSm/00ia3MQ5E5b8mp31kdLGutLMiH+pCd3hdXrEPDywR3wpQCmiRRSd03ri05cWYUnqaw5f8YCTm+hWUmLRcdTDtbmkgqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ey53Fz+d; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ey53Fz+d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMcQ5X65z2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:16:22 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D10014BF;
	Tue, 17 Nov 2026 03:15:48 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 341773F763;
	Tue, 17 Nov 2026 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914151; bh=hApODwvFYZ3XYDnq9Y8ZuF8YD8vDXmjk4z8lFM6Cyuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ey53Fz+d5RDQs83ECGw1AmAhQ+qHQ9sl4eduhb/EusQi+ClN+OEp159tnvmtm+6E4
	 8gJ+Q66+Fl7k0xfIjAX50e+vh4UrpPwOKRpJQZlQM2vBwa31m8Ljha5iDvwuwf9GDz
	 kc4Ga55mItNZhNIpYzEJGyr/ebPbSsEP1sx25kFQ=
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
Subject: [PATCH v1 01/19] x86/APEI: Extract common CPER memory error reporting helper
Date: Tue, 17 Nov 2026 12:10:11 +0100
Message-ID: <20261117111444.4185512-2-pierre.gondois@arm.com>
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

Prepare for reporting CPER Memory Error Section 2 records through MCE
by extracting apei_mce_report_mem_error_common().

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0a89947e47bc8..b993ac78a3b36 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -26,24 +26,15 @@
 
 #include "internal.h"
 
-void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
+static void apei_mce_report_mem_error_common(int severity, u64 physical_addr,
+					     u64 physical_addr_mask)
 {
 	struct mce_hw_err err;
 	struct mce *m;
 	int lsb;
 
-	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
-		return;
-
-	/*
-	 * Even if the ->validation_bits are set for address mask,
-	 * to be extra safe, check and reject an error radius '0',
-	 * and fall back to the default page size.
-	 */
-	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
-		lsb = find_first_bit((void *)&mem_err->physical_addr_mask, PAGE_SHIFT);
-	else
-		lsb = PAGE_SHIFT;
+	/* Missing or zero masks default to page granularity. */
+	lsb = find_first_bit((void *)&physical_addr_mask, PAGE_SHIFT);
 
 	mce_prep_record(&err);
 	m = &err.m;
@@ -60,9 +51,21 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 		m->tsc = rdtsc();
 	}
 
-	m->addr = mem_err->physical_addr;
+	m->addr = physical_addr;
 	mce_log(&err);
 }
+
+void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
+{
+	u64 mask = 0;
+
+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
+		return;
+	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
+		mask = mem_err->physical_addr_mask;
+
+	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
+}
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
-- 
2.43.0


