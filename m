Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC060A2612
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=WWMLSES8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9XRl19Swz2yWy;
	Fri, 23 Oct 2026 03:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792688339;
	cv=none; b=QaQI5E6mG6blo5dkGrFKBC6SgkJLB+VX0fpdF+YwGqvWJzoWgdfmeHUa+puer3M/8BT6LPgPS9XDxCoCAKJOv62INVV24lGbMoSX3su9mETRkn0jVrDB5DgT3wGmxBilh/3SVDaEWanmjhYeRHYMZZ2MBoE2B91QhTe1HxFn2qksOfULDawC9JFzJMaSp8k9Iin2hx8h9Kl150Tn7yFmw+bqb5MJLPnhCQeiZ3c375yqwAiRBPdlGYZWBVDLLJnM4aEhzcSmtlUvwNjDp3EDHXGPQnIh3mAKXyh5Wk7b2e5m1ykx77BGoHBFisIwn5qpqXy4Yve0widt9JEs14JZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792688339; c=relaxed/relaxed;
	bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXZDcjcEJAXVU3gX6z5rn3YkD4On47b2F4/Mq6lW0Lr8r8+CkdBcaxOuFro+rQuKJ4ToU1bf2G6GUUp2nqtVVH8djZYWCMUTFH4rmelJIDK7Oitk3UdOH8fZ0pOgzuOnErmHmFqwGQ2PpvBq6D9LosXPAldVUEZb+nZHZL9nc/8sX+6gTM5MzeI2bbegLLvxQD2hyLE9NLaQX/GlXmJaOtkv+eVMJx9rk0i0CFdAvFMumTKWPuM4ywSzq0+qKxRR4++hbErTlrYQt35dS+tv5U66X7XgqUUViKiejo7fZmILjJZ2kBpWW7ojEBTpDe1SEz5qYYlGPNkuu91NfaKVZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=WWMLSES8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=WWMLSES8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::122b; helo=mail-dl1-x122b.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9XRk41l5z2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 03:58:58 +1100 (AEDT)
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-1846bc43c28so1479755c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 09:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688336; x=1793293136; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=WWMLSES8QSPpoem4UpkoOJKxd0o7cC+2w+uCVJ/BelFQ3YBaks1C0JRNqn+baJ3HDb
         z8oKTxWRD9y/Fd/wTKS2G+0osMZoE3rqEOXcR9eIJRq61fIFwrIPgy7Odf9h/PHL1avL
         aLNxFo6Shi0Y9dqLRokkFTFeidi69L+41SQ5SZmNlU0dhqfMwKwxQvotRvxjWDIPWg7A
         g73jIsUXbrP+xDVN/XKxyLWo3HnLPhisqhCLIhoOXG3lS1lXffAQQO8whiHptBRwbfv1
         WisYWlUOzgEzwhwZmYB91iD94YeITcFVY26pfHx3MTcvVDB/ugN8afMxgtVU9Kngi4jt
         GB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688336; x=1793293136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wszrh6R2g8rAfmRyvD0Q1PJ/LXwFW3iH+CJpBKb1e0Y=;
        b=GBabMIZN2J6vHPgKlFQGYYJZ5Uqroa70mV2np8eB4UsptZSZhldZDjPfZanDZhsJWv
         w1zzIZE0JEeufA1jr9UkMXO3Zv1txjk9uxT4EAV2shDuELrRwz8SSb/GLSTfOMPbELMr
         muV0l4bbC3xYt4NgvaJpOkIQND/CGhoj+uEChD/WbM1vDTVfjTyVkvnm5xddyly5oaYz
         3saLHJjwmY7ReTTiwVevuf3L+uRo9p1Itwjzb2vKZWaGVxACPBsAOULVYqOZBij4s0jx
         ztXC8kUrunAPE42M1TVz0k8jy63Ii79wz7z2188FWmRWfM5lc5ZYMC/2U8Ye/nmHlaaT
         zEnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwD/Crh4cUbZksYxnLK0ruWCtHizcRGSeyRZOHsyk1LLeH/svGyTpXNfG+6865DTz+Loi7qSFQ4KAiK3Fk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIFECAu26tIGU9vramhCiMb0AdmXEZKqKQj6avvVIQ7+RO6chVS
	gveWAjggjDt/rBlvLCKiG67IjqWzz1L7sA0yGvcUuAUJpWUeGyA7dCzCGur+h0g+Zg==
X-Gm-Gg: AYBFou0S1sRDxUbbCFMioStNyj0liwJs6dlzQYP4+RnrGL1fKsX2lbh1ODbBkaddvFp
	8Rn3ASKxLJvWR7DrzDopWsqoRi6JWkLDxQXIIH367QMrnYprvdEoliq8qqsFo5fuw1dNGNI68R8
	+nCWtirrAZJriZc3IUTGtjlJscAfMbIRnZ2ySau9Lj+MaPgXMg/H8UNS8XapIERmgC1jPNM5rYx
	Urptuc/YKEKxNuUZKX+7PBVVVatka4ThosdmT21qGKJrXy8INm2Iwal9O55mE/DKlrROYxclqjW
	xrAROJMxZSV29hXqEet/iJ5giNgLncek3rLM2AtSUwyJztqA5JWQ0UhkYFrsjhavZciuEo2tYUT
	x5Z0lj2bNzdF6Gh50JAqWalG5Rl4cGSFji3wxoaKzf6W/FVz1J2VJnHa6xbbixQd1bC3qNtTh8c
	jVLcRIvnw78xThFzt/XrJ4j6CeEoLO5l2Ax5gS/uBDJqfFfiiN6hQfOEjzqtp8YTEODEoyxgagi
	6uZTGJE+1jq1/snDl8oet1o56Mu14WUPrb9A8ir1Qj2T/1MX1HFC2ftjGOL7413X0I/kmPpKc/0
	RKHBqA79IN7QRulzq58EbMDult1njbTpZQk=
X-Received: by 2002:a05:701b:204f:20b0:184:329d:eced with SMTP id a92af1059eb24-190a52de3edmr7715048c88.25.1792688336131;
        Thu, 22 Oct 2026 09:58:56 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:55 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Thu, 22 Oct 2026 16:58:41 +0000
Message-ID: <20261022165842.1463451-2-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261022165842.1463451-1-yurypm@arista.com>
References: <20261022165842.1463451-1-yurypm@arista.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery.

Add pci=noaer_recovery to retain AER logging while skipping recovery for
uncorrectable errors. Check the option before dispatching either CXL RCH
internal errors or ordinary PCIe errors so CXL driver error callbacks
cannot bypass it. Also skip recovery for errors reported through GHES,
while retaining error logging and releasing error buffers and device
references.

Correctable errors continue to be handled normally. Skipping recovery
avoids its clearing of uncorrectable error status, but does not suppress
Root Port interrupt acknowledgment or change firmware error handling.
The option is AER-specific and does not disable DPC recovery.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
Changes in v3:
- Check the option before both CXL RCH and ordinary PCIe error dispatch.
- Preserve logging, correctable handling, and current GHES cleanup.
- Clarify the AER-only scope and rebase onto PCI next.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-2-yurypm@arista.com/
Review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/pci/pci.c                               |  2 ++
 drivers/pci/pci.h                               |  2 ++
 drivers/pci/pcie/aer.c                          | 13 +++++++++++--
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4b..6047efd3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5118,6 +5118,11 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] Disable Linux AER recovery for
+				uncorrectable errors, including CXL RCH errors,
+				while retaining AER logging. Correctable errors
+				are handled normally. Requires CONFIG_PCIEAER.
+				Does not disable DPC or firmware error recovery.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a62af7320..9ca8d3fbb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6840,6 +6840,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 77efa4c5c..ccc6a678c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1337,6 +1337,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1348,6 +1349,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c376c3adb..c41e5e13f 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -142,6 +142,7 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_recovery_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -149,6 +150,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_no_aer_recovery(void)
+{
+	pcie_aer_recovery_disable = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
@@ -1338,6 +1344,9 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
+	if (pcie_aer_recovery_disable && info->severity != AER_CORRECTABLE)
+		return;
+
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
 }
@@ -1383,15 +1392,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (pdev) {
+		if (pdev && !pcie_aer_recovery_disable) {
 			if (entry.severity == AER_NONFATAL)
 				pcie_do_recovery(pdev, pci_channel_io_normal,
 						 aer_root_reset);
 			else if (entry.severity == AER_FATAL)
 				pcie_do_recovery(pdev, pci_channel_io_frozen,
 						 aer_root_reset);
-			pci_dev_put(pdev);
 		}
+		pci_dev_put(pdev);
 	}
 }
 
-- 
2.51.0


