Return-Path: <linuxppc-dev+bounces-23962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA95C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:55:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx40137n4z2xrC;
	Fri, 10 Jul 2026 04:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783623297;
	cv=none; b=CE4gvxD+SgNosF0Sg19v/vftMbj6KKi1uVwzANppKLiYPLqNeV12dnjlzNq/YaeaQVTxMyZFyx7kRiy1hu04O4Pf+zDkuQ8bkAxa18Uzw6NsxLL/uno+EnlpCpIF9fWMVUaXkZY1LSNqWm1zna+JWBX9796DzIO9kyU+mKaJLWGFlkwPhfeIOn5ihCkZIardcjUE3qKuqUKRVWTJ25NlLJyavBPaK2DLuBh7t1zzXfXmYlETnjMharE7btBuSh5AZqHk8vxPXZk34JJq74xLG/YUem7g2AxtlUe9Nm/UYC9OZkw7O+N2A5+9Uj3Zf6BMWSDHJ5I311EABuW0NeP0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783623297; c=relaxed/relaxed;
	bh=Z8Zy5PB6oCNiDdVLDyMMBSqbi/zOyH2nEGcV3a3Utlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D46tha/8eYrZNJLRMeEJnkM+Jd+yxehlCrVs8NOWfmoQYhT5UeNtgNHAW20zwpFxg0Wt0EB4CtAk+sDXXqnpqH3l9HO6GdSzkVTjk1UCMvpU+JyrJ4LaTCHTR1Hl79JG+n6huyKe0eK6WiiuNZDjDGxfq7QuLkPw0FwbJ4SDoNLsx1eZhbjaOCsXEgdr5AgU0iUMOlIVrEo839tl12pVGm41Uy1ePwvmYMg9OJQjUItCVTm1VhEd0oxRtpTQ7j8z+wdOWRsxLgmoRPwAiL1tJl2gFrF+Ej/8UDejXbGFlR4X0k+aQd0k3QcdeeZw6QszbEJTa2e6+43jjOjVyhawug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=knCV+Kpi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=knCV+Kpi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx4002q1Zz306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:54:56 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cacf197759so1206165ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623294; x=1784228094; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8Zy5PB6oCNiDdVLDyMMBSqbi/zOyH2nEGcV3a3Utlo=;
        b=knCV+KpiGB8ORS1p+RBYdu8puyJi6DFWNF4RzyMYwF7dux3Qjls//U6u2nMRoMs9os
         Ukt83AqC5OwmdCnVMdoWLk3SChnO2QsPbaUbwx36joDhX/pE80VfbJ3cWxbhpUaxLGpo
         6m1ZenRhfxYir5IkFhrA7R2zj1C/hI8RfbeInl7ejXJtazM/lOxl0cOtMR3CbkLuGLkN
         zcWnMnVa+APMZDoae6kq7C8ntNBYlTtXyG1AtfoUhnCgI4LMzQ/fhfTLksMgKv8z5xdT
         6aASHBeZ6jCqJR7xXeDBziVa8HEITDfO9E/O/SXj24854V5NK8ma09Sjn+FwlNyv4HKs
         IRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623294; x=1784228094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8Zy5PB6oCNiDdVLDyMMBSqbi/zOyH2nEGcV3a3Utlo=;
        b=n5igG89MDArC/fsUI9obAiupzbxtaOa3v2cej1FOKZD+qcZbansRKTuT/YgJlbFRaQ
         IcLz45LNk3+QHwjDQFqZ+FO/9jtWZ6fFvzxLKdUiRX64frUtqjLjP+q8pCah3oJvb9vm
         Vw3+rn1oTHMl53a0NAzsmeKZ1Ltp85mQVVKPv5xvaBY8n2iumiCaYgTTJqqvLphh3M4Q
         /LJLsdshj75UhDTm9KNhnSBjx174pE8dSxTmjYgxqsCuPrxD0OG+9A1V8vAgwH+0bWLN
         //0hcjbW2rWfdKga2BQKfbptSDCdB6V9l2slLaEIOoz/1iuAFVInA+vwqs/MLXwd+6/m
         t+CA==
X-Forwarded-Encrypted: i=1; AHgh+RrtHIPHoNpbDMFVcOQoZrpKvrU2gBFunrmitFa3nrNwEi9lxGlTmrKBURc7M4fPxhy7bNi06awxg0yKISk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGHb/cTbGGWrgfLCjPTfrqZOxRI7+H2w2omdKq2X3ziudzNMSN
	d05LoONI5YU/Jo+MRR+T8ds7IEiyOaAWhiZknal6+5dcd09B9YnyiVqKYZCxpxLqS8NxcuHPUo6
	XwbuFGg==
X-Gm-Gg: AfdE7cn6GqSZf/DiTWuKeo01nD9Kp/L1kEKsFLIC13wvXdzdFHsWZTxqisiaGxhZWZ2
	aUX58CUd4pqyOt2yhqvwsLd3WuSoBQ2HP82OyMGltOMaTSv2yW8Y3xBneIgOVrFKR1Z8N+fiM/V
	eFhzXcOI3zZ0VPCcB6o1nXcMH+bLco7XjR0AA7J/cOfcA0etWjs/RyDXvDPcS8N3jk2K0lemkDM
	e+CoXFC0SWKQ71ANgT7GFd5Xz2ZYKF3bJTVpeYJHUMn7MkE5FhrkS0NurhWdwQ+MG8/HimklI+v
	F67ylaBmfuCeOQgfPoiTx45zqdOtnwdow8QIYbXnGxUXqXMOPzpMZvxlpjGL/abOMmCF5o111mV
	5VoXWCFVxlRLfUeM09ZAS3we8qxYD/QKT+hf6h2eATnlK93HyKWLmPVnfUjjkakWQ2kf99cFT8T
	CwWFY2i0uGOuhWRKm/cs2rnwhCx/eFS+lgPqr14s21iH93
X-Received: by 2002:a05:6a21:38e:b0:3b3:241f:66c4 with SMTP id adf61e73a8af0-3c0bd0028bfmr10439038637.28.1783623294191;
        Thu, 09 Jul 2026 11:54:54 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:53 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH v2 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Thu,  9 Jul 2026 18:54:28 +0000
Message-ID: <20260709185429.627968-2-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709185429.627968-1-yurypm@arista.com>
References: <20260709185429.627968-1-yurypm@arista.com>
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
Content-Transfer-Encoding: 8bit

AER error recovery is part of the AER error handling subsystem in the
Linux kernel. On large modular systems with a complex PCIe tree, AER
recovery could cause unexpected behavior and side effects. Sometimes it
would be nice to have the option to keep the system in an unmodified
state and be able to handle PCIe errors from userspace.

Add pci=noaer_recovery kernel boot option to disable AER error recovery
when an uncorrectable error is reported. When this option is set, the
error is still logged but no recovery actions are taken. AER error
status bits are preserved so userspace can inspect the error state.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 drivers/pci/pci.c                             |  2 ++
 drivers/pci/pci.h                             |  2 ++
 drivers/pci/pcie/aer.c                        | 30 ++++++++++++-------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..13c6b53bb9ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5053,6 +5053,12 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] If the PCIEAER kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable AER error recovery when an uncorrectable
+				error is reported. AER error status bits are
+				preserved so userspace can inspect the error
+				state.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..a215dd567d5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6756,6 +6756,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..c4a42bbc277b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1283,6 +1283,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1294,6 +1295,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..fb79990ce8ff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -128,6 +128,7 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_recovery_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -135,6 +136,11 @@ void pci_no_aer(void)
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
@@ -1187,10 +1193,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 				pdrv->err_handler->cor_error_detected(dev);
 			pcie_clear_device_status(dev);
 		}
-	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
-	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+	} else if (!pcie_aer_recovery_disable) {
+		if (info->severity == AER_NONFATAL)
+			pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
+		else if (info->severity == AER_FATAL)
+			pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+	}
 }
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
@@ -1242,12 +1250,14 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+		if (!pcie_aer_recovery_disable) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+		}
 		pci_dev_put(pdev);
 	}
 }
-- 
2.51.0


