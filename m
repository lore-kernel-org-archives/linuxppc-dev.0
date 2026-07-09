Return-Path: <linuxppc-dev+bounces-23963-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DA0C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 18:55:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gx40412yyz3brN;
	Fri, 10 Jul 2026 04:55:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783623300;
	cv=none; b=OALBJvpvY6fbjyiDVaXNOmQEoTq6wkrQ4yzV4YyrdBoTmrEehgMzAyvYRjgsspfCxKo9VBbjBQZoto9OJM0KMVDxXCHr067u10Jzg3ufmTxRJnqHzGWwDQmbd8P5ya30OMbPy6eNj19NeeATknHqPKAr9ujbZKdQnw5y4Th+M6a5XS5pbLgMJC8jY9yoicpEbK+HsSZsz3SuZUDZ/W0IwgwW0JraWqKfY2m0zW11c+RgQ6ejRhR8eQ9VbH9CrrxwyzouSfqzXJXsRrIq4J6KaJzoPNIwJfmDr7+goInQpD9njNr8L+jV1OS1JRdck2NwtjrfHLbNIy5LkQy6/Y+BvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783623300; c=relaxed/relaxed;
	bh=A9Chc45VPQT8BR3yqBtnHCzkEUtEngJlnmusVVJ44F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8NjyKaZ26GG6ukF+vyfnhUyqo6LZVhoU4UfuFdjKVvinTBYLL759TgWa1PJolKWfCZEbZMDP2/XzrbLJsyJFGjL5Htsov+cruRZkBwt/tB/dtY/YJdBaiwy/0sk97PiD6DzkVHinDHE3INqdr9ePF+XvIh6CTMd6hD78u+f2u4Nl/0NXEyj0HzclYgYShapzXJzDGu/izrVtIHtXCcsAMrcHi1ODK1lSMAU/rzveRBtyR3pN+9hFkMOQkjOIGAabUZDIo2hSQum+QfDAf7ydXqf1ytypkA8FIURgTrVp82gOgI+HtR8pwAx9LUZ71yDFV8pph36u+4VjXQydJhmSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com; dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=S/PrIsnq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org) smtp.mailfrom=arista.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=S/PrIsnq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arista.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=yurypm@arista.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gx40328wYz306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 04:54:59 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c7c61b5292so1820645ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623297; x=1784228097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A9Chc45VPQT8BR3yqBtnHCzkEUtEngJlnmusVVJ44F8=;
        b=S/PrIsnqf4dJu1eI9LACygSp24TWU+XcXn/xMD7UBERwb3fSrtm6DlfUDEw/ybaUjk
         6vVqtWxICE9WVxeS7RUzKynYOKubp3tCKjCaz5eGlvWGsnjK1UlBx46rmeq0jViQrW6A
         GfpQcZ2zk10amQYLgv9wDZAGEOFCiDpjh/qcEbKOCL1TfoVcW/fYmDNTkTAdVrYUuk9i
         qvGoZ7GGOM9TpGlU8lOj+bqvfWBbxN0Ynlge9CCWmoRCDxRDgw2r4WH80igY9j0uxjjO
         tk2zu0hC0HuJ4eoCg6qSJwYEez/KVnI/iLvlVS7rp6R2mp5qEobRXk7T0n60n8HAJM4y
         ElRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623297; x=1784228097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A9Chc45VPQT8BR3yqBtnHCzkEUtEngJlnmusVVJ44F8=;
        b=EwEdg+7xLELjX6NmU15Fqq1P79Cc7MtknTdLQkSHNP6Ne+0YwIoqttTzx07FJEV7yO
         fbG6yj6q22cZe1+PkWpclmgYD2qRcTnZf7Xsvl7JfeMHG+ZRZmNok2jFIy4Zz5/8FrY7
         ofyDr7KnEGUzXnTdv2gNk8lnW8XoJLrN04lyNyvObdJVicjLvK+635Z6HlfI+CInfuaG
         4VEancpKJ9ptBJgGLTmpzgyhCZ48ij+neDSd1yUxLsmekYQOORdjGLTHqBeK+GaKnpTS
         AhD4kaq91Ne2yFn093UV++LiNDUOrndvckH4ro0iPb3DooEpYF5pTtI6/GFfHuRB0Bc+
         Bwfw==
X-Forwarded-Encrypted: i=1; AHgh+RoClA41JAkYyNv92/RmYOLQx+TgKaU83rmo4zcv4+d2FU4TM8pcmlsbdKI/Ms56Qj5mhLGG+m5+1+8iSpg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0IEeeK+oM1NNbSvTrVuSdfxZWRBdseeKkMhCD2oZKtvk93rVe
	ngAM2otjLmUxzeZGNaZvI/B61hJDSdT2+YCGodWYxzR7iTMUIaed2hGpo0XmD2UWLQ==
X-Gm-Gg: AfdE7ckEsJ771zhPNmHsztqC54459HTh+IHzBZeYT1S72wW7Ea595eCjk/oXAEOxpPH
	SxxhLMt9qk2WB+ZVN5MKwwojOtjhIBMkgnu+NeR/ICD63J2uI54gabXn0xoanjGNa50g90iIstK
	wOwNXIfkNTGWMXIcVmzN2zuKbscnaIz0GnoYY6bPrER5x8WE2aSIQp3eZ+HKnxCrrfNKT4y6RDo
	4LI9M+KKoYHYx/OkkSi8P5u+mZtv7benbaPEu4sTAgLVg9ak3+Kx2NP29w1pxBSrt0iFeT8vjbt
	+XgmC/148hkBq5FuM3Mz8jOLkT/Tno6iN6yZIxXPqYW/Hx1gydr3vnd5ElYXEwJ1eITmB69IRvS
	d2NzmZKMdQXXnKWAvJeW1Q6mLwOvDnqS/xacFoQTiXH+SOoqq/yNbfhffAtiooyqdeYhWTSdNJ6
	h1Mr5co0RiM8W5arZPtBu06izpLY6+p95gEWx5Vtj4ECC/SVDekzixMkk=
X-Received: by 2002:a05:6a21:700b:b0:3c0:9c1b:d0bf with SMTP id adf61e73a8af0-3c0bd332198mr10404800637.74.1783623297316;
        Thu, 09 Jul 2026 11:54:57 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] PCI: Add pci=nodpc kernel boot option
Date: Thu,  9 Jul 2026 18:54:29 +0000
Message-ID: <20260709185429.627968-3-yurypm@arista.com>
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

PCI DPC (Downstream Port Containment) support can be advertised by PCIe
devices, but it might not be fully supported in the firmware. On large
modular systems with a complex PCIe tree, enabling DPC could cause
unexpected behavior and side effects. Sometimes it would be nice to have
the option to keep the system in an unmodified state and be able to
handle PCIe errors from userspace.

Add pci=nodpc kernel boot option to disable PCI DPC. When this option
is set, DPC initialization, state save/restore, recovery, and driver
registration are all skipped.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 .../admin-guide/kernel-parameters.txt         |  3 +++
 drivers/pci/pci.c                             |  2 ++
 drivers/pci/pci.h                             |  2 ++
 drivers/pci/pcie/dpc.c                        | 19 ++++++++++++++++---
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 13c6b53bb9ee..ccc26849a1ae 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5050,6 +5050,9 @@ Kernel parameters
 				through ports 0xC000-0xCFFF).
 				See http://wiki.osdev.org/PCI for more info
 				on the configuration access mechanisms.
+		nodpc		[PCIE] If the PCIE_DPC kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable the use of PCIE DPC.
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a215dd567d5d..6cd06a872ba0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6754,6 +6754,8 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "noats", 5)) {
 				pr_info("PCIe: ATS is disabled\n");
 				pcie_ats_disabled = true;
+			} else if (!strcmp(str, "nodpc")) {
+				pci_no_dpc();
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
 			} else if (!strcmp(str, "noaer_recovery")) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c4a42bbc277b..146cd5df985a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -880,6 +880,7 @@ struct rcec_ea {
 #endif
 
 #ifdef CONFIG_PCIE_DPC
+void pci_no_dpc(void);
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
@@ -888,6 +889,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
 #else
+static inline void pci_no_dpc(void) { }
 static inline void pci_save_dpc_state(struct pci_dev *dev) { }
 static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
 static inline void pci_dpc_init(struct pci_dev *pdev) { }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b779bd1d861..759d9f18812e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -43,12 +43,19 @@ static const char * const rp_pio_error_string[] = {
 	"Memory Request Completion Timeout",		 /* Bit Position 18 */
 };
 
+static bool pcie_dpc_disable;
+
+void pci_no_dpc(void)
+{
+	pcie_dpc_disable = true;
+}
+
 void pci_save_dpc_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (pcie_dpc_disable || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -64,7 +71,7 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	struct pci_cap_saved_state *save_state;
 	u16 *cap;
 
-	if (!pci_is_pcie(dev))
+	if (pcie_dpc_disable || !pci_is_pcie(dev))
 		return;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
@@ -104,7 +111,7 @@ bool pci_dpc_recovered(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host;
 
-	if (!pdev->dpc_cap)
+	if (pcie_dpc_disable || !pdev->dpc_cap)
 		return false;
 
 	/*
@@ -404,6 +411,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 {
 	u16 cap;
 
+	if (pcie_dpc_disable)
+		return;
+
 	pdev->dpc_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	if (!pdev->dpc_cap)
 		return;
@@ -532,5 +542,8 @@ static struct pcie_port_service_driver dpcdriver = {
 
 int __init pcie_dpc_init(void)
 {
+	if (pcie_dpc_disable)
+		return 0;
+
 	return pcie_port_service_register(&dpcdriver);
 }
-- 
2.51.0


