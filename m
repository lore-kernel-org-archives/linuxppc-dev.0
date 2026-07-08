Return-Path: <linuxppc-dev+bounces-23851-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EB8C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 23:26:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwZ3Y6bxvz30C7;
	Thu, 09 Jul 2026 09:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783519232;
	cv=none; b=MzrNc1jAjO7VWsKh5Y9vCZCGGjEH1ralzeRRG8l7vVJMuke6sbmswUxPMtN93o6v2gaNMHbr0n3YBzIsGKmdIQ8LZTv/JK5fWz4D3Djsn24fGjc6+oSimj7jaXvisJpO9x+KPftfdj0zmRvJgJsRF14hvtS+buEJzbaGNQyLMfixtx3YVsd0bsRkv1iimpTbIITmnAP22xN5b4vEFVAUxGlZqrOtL35bjmjlwKOy61syeev+izVcfzZ9qVePXyv3SM4gsq06hex+C8LmIGSvBXdrTsvPy0JoYg6fTH4Jh9vHeBw5PpgzxytaH+bwq92zi38vrQ6fr6N2Lg0DmeX+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783519232; c=relaxed/relaxed;
	bh=IJZJVpu7AUehH2cXNC4RvQeWfZ9z0Z7izIfIIyjeKPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmNFyKKgctp0TEwDplYr94n4WRzrNTrpser/tLALABbA82xQRRiESLUc55G1+WlLWpvYi58Jpb2KjyW0haL2wHO5OJybkG3ATVEPsruVnMEIgOMf5BLiKeMvAv+kzq6hAbWqaNiOb3ZsKVR7AUax7NxajyYfg9s6uzDyPj/iTSD5SwAoTCSNG0SOMiv16QJAFt1MgoFE7JVvzdYuxrX4+/UcZkywls/IntVgoEQfyFYXYWEWhKCzTRCTTlgExFKEzCeuBHVmX6E1a38RyrHjxZbVjScCH6v9LHevsCev1bhsDy6BgB2KIk3MOpnhKPK6ZjNdccA5YSI/qnmXDGQpTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U/EYVI2P; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=U/EYVI2P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=ahmed.tiba@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwKVl5pTFz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 00:00:31 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03D921F91;
	Wed,  8 Jul 2026 06:59:45 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF763F66F;
	Wed,  8 Jul 2026 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783519189; bh=m+Rir9qQJxeEvy4zcNmwvIPVKvHkQ2LpXQCSR4RGK/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U/EYVI2P/LJaUAD9qYjnANqxCJAtI81z1pyeNODy0oleHOouZ8jQW+ojdtNeb+fFk
	 NLcMoTTeIzzm975KyCghjH5LquwBHwBqEcAq5JUO9QQHrfbBRs7SQik/zb+SDUmsYN
	 O+Ejjd8OvfaVOuhZKr74C1STnfmFGqDNBIzI5FU0=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Wed, 08 Jul 2026 14:59:04 +0100
Subject: [PATCH v7 05/10] ACPI: APEI: GHES: move vendor record helpers
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
Message-Id: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-5-8b3a85216cef@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783519157; l=6442;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=m+Rir9qQJxeEvy4zcNmwvIPVKvHkQ2LpXQCSR4RGK/k=;
 b=bVj+vCq2iQ32yyUrW44OR3IUx7RREz4D7phTILPujJep+Kboo/XT+PfGO6nPL9IK1yyjkGgAE
 zEXm7auPh7WB3JxXiSIrh2bYGlhW6qTkfLwqnW8h1jLyS4FSfO4QMgs
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Shift the vendor record workqueue helpers into ghes_cper.c so both GHES
and future DT-based providers can use the same implementation. The change
is mechanical and keeps the notifier behavior identical.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 68 ------------------------------------------
 drivers/acpi/apei/ghes_cper.c | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h      |  2 ++
 3 files changed, 71 insertions(+), 68 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e9cb576eefcf..07e4001ea8d7 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -383,74 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
-static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
-
-int ghes_register_vendor_record_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
-
-void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
-{
-	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
-}
-EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
-
-static void ghes_vendor_record_notifier_destroy(void *nb)
-{
-	ghes_unregister_vendor_record_notifier(nb);
-}
-
-int devm_ghes_register_vendor_record_notifier(struct device *dev,
-					      struct notifier_block *nb)
-{
-	int ret;
-
-	ret = ghes_register_vendor_record_notifier(nb);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
-}
-EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
-
-static void ghes_vendor_record_work_func(struct work_struct *work)
-{
-	struct ghes_vendor_record_entry *entry;
-	struct acpi_hest_generic_data *gdata;
-	u32 len;
-
-	entry = container_of(work, struct ghes_vendor_record_entry, work);
-	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
-
-	blocking_notifier_call_chain(&vendor_record_notify_list,
-				     entry->error_severity, gdata);
-
-	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len);
-}
-
-static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
-					  int sev)
-{
-	struct acpi_hest_generic_data *copied_gdata;
-	struct ghes_vendor_record_entry *entry;
-	u32 len;
-
-	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
-	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
-	if (!entry)
-		return;
-
-	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
-	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
-	entry->error_severity = sev;
-
-	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
-	schedule_work(&entry->work);
-}
-
 /* Room for 8 entries */
 #define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
 static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 44b644584703..7e4a66b788b8 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/mm.h>
+#include <linux/notifier.h>
 #include <linux/ratelimit.h>
 #include <linux/rcupdate.h>
 #include <linux/sched/clock.h>
@@ -281,6 +282,74 @@ void ghes_clear_estatus(struct ghes *ghes,
 		ghes_ack_error(ghes->generic_v2);
 }
 
+static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
+
+int ghes_register_vendor_record_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
+
+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
+
+static void ghes_vendor_record_notifier_destroy(void *nb)
+{
+	ghes_unregister_vendor_record_notifier(nb);
+}
+
+int devm_ghes_register_vendor_record_notifier(struct device *dev,
+					      struct notifier_block *nb)
+{
+	int ret;
+
+	ret = ghes_register_vendor_record_notifier(nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
+}
+EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
+
+static void ghes_vendor_record_work_func(struct work_struct *work)
+{
+	struct ghes_vendor_record_entry *entry;
+	struct acpi_hest_generic_data *gdata;
+	u32 len;
+
+	entry = container_of(work, struct ghes_vendor_record_entry, work);
+	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
+
+	blocking_notifier_call_chain(&vendor_record_notify_list,
+				     entry->error_severity, gdata);
+
+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
+	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len);
+}
+
+void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
+				   int sev)
+{
+	struct acpi_hest_generic_data *copied_gdata;
+	struct ghes_vendor_record_entry *entry;
+	u32 len;
+
+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
+	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
+	if (!entry)
+		return;
+
+	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
+	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
+	entry->error_severity = sev;
+
+	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
+	schedule_work(&entry->work);
+}
+
 /*
  * GHES error status reporting throttle, to report more kinds of
  * errors, instead of just most frequently occurred errors.
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index 15305c8be9a7..d9f9253d8de9 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -104,5 +104,7 @@ int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
 int ghes_estatus_cached(struct acpi_hest_generic_status *estatus);
 void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
 			    struct acpi_hest_generic_status *estatus);
+void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
+				   int sev);
 
 #endif /* ACPI_APEI_GHES_CPER_H */

-- 
2.43.0


