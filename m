Return-Path: <linuxppc-dev+bounces-29478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB5DCC6B1D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 11:36:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4Tgl3XJgz2yYd;
	Wed, 14 Oct 2026 22:36:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=52.26.1.71
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791922256;
	cv=none; b=Eh3VeSVHt2Glfo65zFEhUrN5T6A+Lxhi/EavOg7Z7WKiy4hutJjbSC7oIE4jDQ/yFzE/jLFXbbYcyuPjtxgPkXS5Eyn++EzUzDmDI87/hgDlA4aF28/dqa/4q4MPApt8+b1+IXDz30xUvGoyptAwf3EKzWuKUazD5TTkA34qysw78xGQYLnTjyNxBDBwlI+nB8aNXDZxOBAQC1+hbKnYqijB3MNwrqHprF3VOBnwHjjrovtzovoV8acxRRNuWUn+NQwpSU7JgNqx7LeWYwfZxwKeDoEbE2yzDPJemuW21dBuCLohxfnZG3MGBRxyB600c11lJnh/Ws5gcCzM/oE9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791922256; c=relaxed/relaxed;
	bh=TrpveSit1wEH+8j/24R1ws6bYbF85HVwGd6ZkiaCh1M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzrivMZSi/XTOdflxiK1EVEo8eBWY1DE33Kcbrpd4vdhnkwzGyTAw+ngXhc8LXj7TEKlfhL1C+f5QJUgED9dzpiWpGzOyyzUP/Sbv/pnQQm3Ld2r1QRAWU+iPJrkROLgANIb1A4a8mLrAwn9nDBp2ztJ5hGFU1ywUTEWjyfJ6u4lDOLHTLWmp94pKrJGb+EVwRQ6OkwU4YuhZ+4dvZ2IyWSeMF+3Vu4GBbNkrkmT2WCh8oZoJXTxPXGRtSwzAhf1m/xR0EBOOQTGcW5Zmro5gpweNPZUo4qtowan6MGKfpRBWr1Tr7ht9kO7LghvpymHJW/34r57tRGVg3vukdkGAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NKdpXyW7; dkim-atps=neutral; spf=pass (client-ip=52.26.1.71; helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=739a182ec=sunnfeng@amazon.com; receiver=lists.ozlabs.org) smtp.mailfrom=amazon.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=NKdpXyW7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amazon.com (client-ip=52.26.1.71; helo=pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com; envelope-from=prvs=739a182ec=sunnfeng@amazon.com; receiver=lists.ozlabs.org)
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j457M10hmz30Tf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 07:10:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1791922255; x=1823458255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TrpveSit1wEH+8j/24R1ws6bYbF85HVwGd6ZkiaCh1M=;
  b=NKdpXyW7euaGeJvoW59G8zIaBL+hJwMK1phjAgN00YWDcGb7RV7JEcfN
   j5I1zaENsz6HVlDD264+cFMnUyPgJankAw8c3UKOQ0GoMcJZtsWGQIzUO
   b1Xa77pE5BEfnsJUKrv5ryKFn4eYI/b2qGY/58/r3pSv7eT6xk4JO8b6y
   WTemZSS6PriqWQcET5OyJro6679jvz9EGtB6hMul5jKay+3zNE2/9bGDm
   qlP9j/c6srTsVmOrq+P0B8N/vBvHCiP3dGr9FydEgHE0yLO+mTQdazj+r
   okO8q5A3+tMSK+sczs5XM+hrucva0PBx+vjfOR4T2KpfxB9P+VmkkmzV6
   Q==;
X-CSE-ConnectionGUID: 1qb2flQ2Sjy41jOsd611Ow==
X-CSE-MsgGUID: 2LNNa7r/SHauFUaqF4BpDw==
X-IronPort-AV: E=Sophos;i="6.27,156,1787011200"; 
   d="scan'208";a="31206066"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 20:10:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:6737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.91:2525] with esmtp (Farcaster)
 id 00a69108-e302-402a-b9c6-73e7cbc38a1e; Tue, 13 Oct 2026 20:10:50 +0000 (UTC)
X-Farcaster-Flow-ID: 00a69108-e302-402a-b9c6-73e7cbc38a1e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 13 Oct 2026 20:10:50 +0000
Received: from dev-dsk-sunnfeng-2b-e0a170ae.us-west-2.amazon.com
 (10.189.116.242) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53; Tue, 13 Oct 2026
 20:10:49 +0000
From: Sunny Feng <sunnfeng@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>
CC: Oliver O'Halloran <oohall@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/AER: Add a kernel parameter to skip the reset during AER recovery
Date: Tue, 13 Oct 2026 20:10:45 +0000
Message-ID: <20261013201045.33806-1-sunnfeng@amazon.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-Originating-IP: [10.189.116.242]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

After an uncorrectable error, AER recovery resets the hierarchy below
the Root Port in aer_root_reset() (a Secondary Bus Reset, or an FLR for
an RCEC or RCiEP). Some devices keep diagnostic state, in the device
itself or in the retimers on its link, that is lost by that reset. To
root cause the error, that state needs to be collected before the
device is reset.

Add a "pci=error_reset_disable=<pci_dev>[; ...]" kernel parameter,
using the same device format as "disable_acs_redir". When a device
below the Root Port matches, aer_root_reset() skips the reset, leaves
the devices in the state the error left them in and reports the
recovery as failed. The Root Error Status is still cleared and the
Root Port interrupts re-enabled, so later errors are still reported.
The diagnostics can then be collected before the devices are recovered.

Signed-off-by: Sunny Feng <sunnfeng@amazon.com>
---
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 drivers/pci/pci.c                             | 41 ++++++++++++++++++-
 drivers/pci/pci.h                             |  1 +
 drivers/pci/pcie/aer.c                        | 27 +++++++++++-
 4 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..eac6f72dcc2a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5329,6 +5329,16 @@ Kernel parameters
 
 				Note: this may remove isolation between devices
 				and may put more devices in an IOMMU group.
+		error_reset_disable=<pci_dev>[; ...]
+				Specify one or more PCI devices (in the format
+				specified above) separated by semicolons.
+				AER recovery does not reset a hierarchy that
+				contains one of these devices after an
+				uncorrectable error. Recovery is not attempted:
+				the devices are left in the state the error
+				left them in and are reported as failed, so
+				their diagnostics can be collected before they
+				are recovered.
 		force_floating	[S390] Force usage of floating interrupts.
 		nomio		[S390] Do not use MIO instructions.
 		norid		[S390] ignore the RID field and force use of
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c5ed5da9cdc8..2b4a06f3a38e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -901,6 +901,41 @@ void pci_request_acs(void)
 
 static const char *disable_acs_redir_param;
 static const char *config_acs_param;
+static const char *error_reset_disable_param;
+
+/**
+ * pci_error_reset_disabled - should AER recovery leave a device unreset
+ * @dev: the PCI device to test
+ *
+ * Returns true if @dev is listed in the "pci=error_reset_disable=" kernel
+ * parameter, in which case AER recovery must not reset the hierarchy
+ * that contains it.
+ */
+bool pci_error_reset_disabled(struct pci_dev *dev)
+{
+	const char *p = error_reset_disable_param;
+	int ret;
+
+	if (!p)
+		return false;
+
+	while (*p) {
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret < 0) {
+			pr_info_once("PCI: Can't parse error_reset_disable parameter: %s\n",
+				     error_reset_disable_param);
+			return false;
+		} else if (ret == 1) {
+			return true;
+		}
+
+		if (*p != ';' && *p != ',')
+			return false;
+		p++;
+	}
+
+	return false;
+}
 
 struct pci_acs {
 	u16 ctrl;
@@ -6883,6 +6918,8 @@ static int __init pci_setup(char *str)
 				disable_acs_redir_param = str + 18;
 			} else if (!strncmp(str, "config_acs=", 11)) {
 				config_acs_param = str + 11;
+			} else if (!strncmp(str, "error_reset_disable=", 20)) {
+				error_reset_disable_param = str + 20;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
@@ -6894,7 +6931,8 @@ static int __init pci_setup(char *str)
 early_param("pci", pci_setup);
 
 /*
- * 'resource_alignment_param' and 'disable_acs_redir_param' are initialized
+ * 'resource_alignment_param', 'disable_acs_redir_param' and
+ * 'error_reset_disable_param' are initialized
  * in pci_setup(), above, to point to data in the __initdata section which
  * will be freed after the init sequence is complete. We can't allocate memory
  * in pci_setup() because some architectures do not have any memory allocation
@@ -6908,6 +6946,7 @@ static int __init pci_realloc_setup_params(void)
 					   GFP_KERNEL);
 	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
 	config_acs_param = kstrdup(config_acs_param, GFP_KERNEL);
+	error_reset_disable_param = kstrdup(error_reset_disable_param, GFP_KERNEL);
 
 	return 0;
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a002fe1a3f4c..364c99e1a6a1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -244,6 +244,7 @@ bool pci_reset_supported(struct pci_dev *dev);
 void pci_init_reset_methods(struct pci_dev *dev);
 int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
 int pci_bus_error_reset(struct pci_dev *dev);
+bool pci_error_reset_disabled(struct pci_dev *dev);
 int pci_try_reset_bridge(struct pci_dev *bridge);
 
 struct pci_cap_saved_data {
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c376c3adbefd..1f403f0f5d25 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1837,6 +1837,16 @@ static int aer_resume(struct pcie_device *dev)
 	return 0;
 }
 
+/* pci_walk_bus() callback; returns 0 so the walk visits every device */
+static int aer_check_error_reset_disabled(struct pci_dev *dev, void *data)
+{
+	bool *disabled = data;
+
+	if (pci_error_reset_disabled(dev))
+		*disabled = true;
+	return 0;
+}
+
 /**
  * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
  * @dev: pointer to Root Port, RCEC, or RCiEP
@@ -1849,6 +1859,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	struct pci_dev *root;
 	int aer;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	bool reset_disabled = false;
 	u32 reg32;
 	int rc;
 
@@ -1872,7 +1883,21 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	if (host->native_aer && aer)
 		aer_disable_irq(root);
 
-	if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
+	/*
+	 * Leave the devices in the state the error left them in if one of
+	 * them is listed in the error_reset_disable parameter, so their
+	 * diagnostics can be collected before they are recovered.
+	 */
+	if (dev->subordinate)
+		pci_walk_bus(dev->subordinate, aer_check_error_reset_disabled,
+			     &reset_disabled);
+	else
+		aer_check_error_reset_disabled(dev, &reset_disabled);
+
+	if (reset_disabled) {
+		rc = -ECANCELED;
+		pci_info(dev, "not reset, error_reset_disable matches a device below\n");
+	} else if (type == PCI_EXP_TYPE_RC_EC || type == PCI_EXP_TYPE_RC_END) {
 		rc = pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 		if (!rc)
 			pci_info(dev, "has been reset\n");

base-commit: 573bbee68354c1a3566b6451d5477416c3be9462
-- 
2.47.3


