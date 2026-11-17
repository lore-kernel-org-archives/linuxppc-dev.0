Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C74606A329
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Za+XRYw1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMjL1W86z2yRn;
	Tue, 17 Nov 2026 22:20:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794914438;
	cv=none; b=ND3y0TFEZhBerZItnvvziLnkdvRxiiCP60v/7rvkGe7BRnHI5RHBf7WjPxH7rqMkf8OsLyw8CVIfJRbVvorloizjP0PUbHqIMJCazejVZ1pxz8KU0C0m/FrZRd4TcGzxB2fzXSjYrCg8sImPuxRzoll3V4YF25N5SwCcaI0fPVhESln+Xpo9EUOgPm2bTQtDBPeDNh8S4i0x8Me9ZX6t4Um0pKgKA4NrnzyvGjfFenGQHD6ojh4jrJILZTQ2Uh8tUVgae84/AV3oNHV+lzm01hCutNLZDiZRmwAczSMD4BONbdzNHH84VI62zI7K5wxuLj9+qlp0OI+RsQZNI4IRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794914438; c=relaxed/relaxed;
	bh=lerhcVcRfU2lk4PsrpleRqAwjsseFlibrr+AoAnaIA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egk/pIOIT/UDOy4T6mItVIJcssEY/++O3cRNr3RidgK34ojUDzQ0PddjaRBtUIg7aiGmtWnHCclVH2mrf21+cNBDvAGfPCFQ6ByxMcDYSy0WK1Lr2jGKGPVaFjxS/QLFv0IB6CLpJlMvf5kxSryFab8Utg/0YYTYWPAuTQ5pgLvd+nnm7Y0z1lRgd9NXvBc2cBWhCzfwxup7OCzQ1XNFfP1vX5zd0mIYnv0W0MFJxvO3+7Q1V3mkDfeYovwKSN9DTBPou8Aw/w7biM0sd1oewqo6EExfaS6KsymoNKOqRaZg+ZPSJ8nusmDMIulhJWyK1i6PhRC8vF1fVcfemDKcvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Za+XRYw1; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Za+XRYw1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=pierre.gondois@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTMjK1sJ4z2yQl
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 22:20:37 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FB971C0A;
	Tue, 17 Nov 2026 03:20:03 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F24F3F763;
	Tue, 17 Nov 2026 03:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914406; bh=YDgzasSlipXKe/56e4CM9c8AHByhT73/Jmer5AUWPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za+XRYw1cGqmZ/sAMGiGXzSiQ6xN4qBcFk9Rqylzhmn/qXSsl6sVKQ7ydwzAhTxcT
	 F2CbwSyWbFfGkIeCAw96i3tF9OTKTcCPzhxNGKEX2PMJzaLfR2lcWMNfVxkgs5DQlV
	 qSFgMy6wd7Hh+QIizurUzIyO3/+T4tK6oKEwGeyg=
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
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 14/19] ACPI: APEI: Return status from cxl_cper_post_event()
Date: Tue, 17 Nov 2026 12:10:24 +0100
Message-ID: <20261117111444.4185512-15-pierre.gondois@arm.com>
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

Callers cannot tell whether cxl_cper_post_event() queued a CPER event or
discarded it. Return 0 if success and 1 if aborted. Existing callers
continue to ignore the result for now.

A worker that is already scheduled still processes the queued event, so
its schedule_work() return value does not indicate a delivery failure.

This prepares for a following patch moving PCI/CXL handling to
extlog.c.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/apei-internal.h |  4 ++--
 drivers/acpi/apei/ghes.c          | 15 ++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index f7f0ab8e5ed7f..5063c743b4cf0 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -11,8 +11,8 @@
 #include <cxl/event.h>
 
 int ghes_severity(int severity);
-void cxl_cper_post_event(enum cxl_event_type event_type,
-			 struct cxl_cper_event_rec *rec, u32 len);
+int cxl_cper_post_event(enum cxl_event_type event_type,
+			struct cxl_cper_event_rec *rec, u32 len);
 u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
 void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b51b621208ed1..623ac2a7f7a75 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -823,42 +823,43 @@ DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
-void cxl_cper_post_event(enum cxl_event_type event_type,
-			 struct cxl_cper_event_rec *rec, u32 len)
+int cxl_cper_post_event(enum cxl_event_type event_type,
+			struct cxl_cper_event_rec *rec, u32 len)
 {
 	struct cxl_cper_work_data wd;
 
 	if (len < sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
-		return;
+		return 1;
 	}
 
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
 		       rec->hdr.length);
-		return;
+		return 1;
 	}
 
 	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
 		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
+		return 1;
 	}
 
 	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
 
 	if (!cxl_cper_work)
-		return;
+		return 1;
 
 	wd.event_type = event_type;
 	memcpy(&wd.rec, rec, sizeof(wd.rec));
 
 	if (!kfifo_put(&cxl_cper_fifo, wd)) {
 		pr_err_ratelimited("CXL CPER kfifo overflow\n");
-		return;
+		return 1;
 	}
 
 	schedule_work(cxl_cper_work);
+	return 0;
 }
 
 int cxl_cper_register_work(struct work_struct *work)
-- 
2.43.0


