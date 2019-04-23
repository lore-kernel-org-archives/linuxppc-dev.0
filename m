Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221EDC10F03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:34:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E0C621773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijck6Jk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E0C621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pZt74dnDzDqR2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:34:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ijck6Jk5"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pTZC3XGzzDqHR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 02:34:59 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id e92so6004155plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbDzPgrG7sGMDqtDgEqDecIChfX7yasg95T4JIMF8ig=;
 b=ijck6Jk5jSTFu2bSdPPJqVJPs/1kM3SnO59t7pHYDikzku4nrYwI5QOuv+i7bZeD4o
 cZdrTPRAEmDk+Q7LJXtlbwSHqUhJEcTpIzf+LF2oS1Wy8urQppC8jVKLqRseAhikBvWg
 P8YQyzWrhkSBQsCQpunArWaQxYs1aXD0kalpZD8S875Eb53ISaNiK7b8hnfGSYHTaJBt
 uFLc20tsMQb4fRiT5J3ElRgI4hPXsxWR8T5cdSsqpdU6zTR2dYdjdI7SVLXrThhy57u0
 bDQASgNo4HvrS3Gs8W01u1xZy9OaTrSkuHlunsi1TGDbpg6LctOoToru/gNgkpxRp1YQ
 BkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbDzPgrG7sGMDqtDgEqDecIChfX7yasg95T4JIMF8ig=;
 b=UQEKYh+dpwTCbCfQF8qMgb0xp0ZMowMxRIJxjtGiGowzZV8Q7czuOBKrfhn4q26ZG8
 enOP+Sxc+EXIs7OVyD4m+ilEDHGlIRTRDhPEnTZnNMW1ePvvxRYV6Un1LPy42oNI2PrE
 9dL5RVWHtFmwcSEFECaUR5vsqKPctzZ8QZaDl8aAT6R9mUD4vwzQaNrc84GEOIsZWdJb
 CM/wA2WTd97ZaxyBGwFUbJw/pzPtYsCXAIKd6eIDVCHPhxWrUK5HDj1a+dC/znkMA1Yz
 xJEH9YF5s/5qIvMQaXiidOfvrDdXu8ndpM7h0ZTvWTDiGI0suBF0RLSk9Ehrl+8opPbN
 rlBg==
X-Gm-Message-State: APjAAAVY/c8ikWwuh50mgHD6rldRkjkShtucCAtA9l0qcI2u/moWvovy
 KbPAaNWtWUGVD9uiij9SLE4=
X-Google-Smtp-Source: APXvYqxx15uCdJw5COvBnkhivriUaaQc4+Y+k3PQcEua79hCuteAQL71tHPPK/VosXDCo8QQ2oStuw==
X-Received: by 2002:a17:902:b10c:: with SMTP id
 q12mr27706060plr.254.1556037297364; 
 Tue, 23 Apr 2019 09:34:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Apr 2019 09:34:55 -0700 (PDT)
From: Changbin Du <changbin.du@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4 28/63] Documentation: PCI: convert pci-iov-howto.txt to reST
Date: Wed, 24 Apr 2019 00:28:57 +0800
Message-Id: <20190423162932.21428-29-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Apr 2019 05:41:31 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, x86@kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 mingo@redhat.com, Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst                   |   1 +
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++++++--------
 2 files changed, 94 insertions(+), 68 deletions(-)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 452723318405..e1c19962a7f8 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -10,3 +10,4 @@ Linux PCI Bus Subsystem
 
    pci
    PCIEBUS-HOWTO
+   pci-iov-howto
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.rst
similarity index 63%
rename from Documentation/PCI/pci-iov-howto.txt
rename to Documentation/PCI/pci-iov-howto.rst
index d2a84151e99c..b9fd003206f1 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.rst
@@ -1,14 +1,19 @@
-		PCI Express I/O Virtualization Howto
-		Copyright (C) 2009 Intel Corporation
-		    Yu Zhao <yu.zhao@intel.com>
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-		Update: November 2012
-			-- sysfs-based SRIOV enable-/disable-ment
-		Donald Dutile <ddutile@redhat.com>
+====================================
+PCI Express I/O Virtualization Howto
+====================================
 
-1. Overview
+:Copyright: |copy| 2009 Intel Corporation
+:Authors: - Yu Zhao <yu.zhao@intel.com>
+          - Donald Dutile <ddutile@redhat.com>
 
-1.1 What is SR-IOV
+Overview
+========
+
+What is SR-IOV
+--------------
 
 Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
 capability which makes one physical device appear as multiple virtual
@@ -23,9 +28,11 @@ Memory Space, which is used to map its register set. VF device driver
 operates on the register set so it can be functional and appear as a
 real existing PCI device.
 
-2. User Guide
+User Guide
+==========
 
-2.1 How can I enable SR-IOV capability
+How can I enable SR-IOV capability
+----------------------------------
 
 Multiple methods are available for SR-IOV enablement.
 In the first method, the device driver (PF driver) will control the
@@ -43,105 +50,123 @@ checks, e.g., check numvfs == 0 if enabling VFs, ensure
 numvfs <= totalvfs.
 The second method is the recommended method for new/future VF devices.
 
-2.2 How can I use the Virtual Functions
+How can I use the Virtual Functions
+-----------------------------------
 
 The VF is treated as hot-plugged PCI devices in the kernel, so they
 should be able to work in the same way as real PCI devices. The VF
 requires device driver that is same as a normal PCI device's.
 
-3. Developer Guide
+Developer Guide
+===============
 
-3.1 SR-IOV API
+SR-IOV API
+----------
 
 To enable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
-	'nr_virtfn' is number of VFs to be enabled.
-(b) For the second method, from sysfs:
+
+'nr_virtfn' is number of VFs to be enabled.
+
+(b) For the second method, from sysfs::
+
 	echo 'nr_virtfn' > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To disable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	void pci_disable_sriov(struct pci_dev *dev);
-(b) For the second method, from sysfs:
+
+(b) For the second method, from sysfs::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To enable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. This is the
 default behavior.
+::
+
 	echo 1 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
 To disable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. Updating this
 entry will not affect VFs which are already probed.
+::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
-3.2 Usage example
+Usage example
+-------------
 
 Following piece of code illustrates the usage of the SR-IOV API.
+::
 
-static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	pci_enable_sriov(dev, NR_VIRTFN);
+	static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
+	{
+		pci_enable_sriov(dev, NR_VIRTFN);
 
-	...
-
-	return 0;
-}
+		...
 
-static void dev_remove(struct pci_dev *dev)
-{
-	pci_disable_sriov(dev);
+		return 0;
+	}
 
-	...
-}
+	static void dev_remove(struct pci_dev *dev)
+	{
+		pci_disable_sriov(dev);
 
-static int dev_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	...
+		...
+	}
 
-	return 0;
-}
+	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+	{
+		...
 
-static int dev_resume(struct pci_dev *dev)
-{
-	...
+		return 0;
+	}
 
-	return 0;
-}
+	static int dev_resume(struct pci_dev *dev)
+	{
+		...
 
-static void dev_shutdown(struct pci_dev *dev)
-{
-	...
-}
+		return 0;
+	}
 
-static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	if (numvfs > 0) {
-		...
-		pci_enable_sriov(dev, numvfs);
+	static void dev_shutdown(struct pci_dev *dev)
+	{
 		...
-		return numvfs;
 	}
-	if (numvfs == 0) {
-		....
-		pci_disable_sriov(dev);
-		...
-		return 0;
+
+	static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
+	{
+		if (numvfs > 0) {
+			...
+			pci_enable_sriov(dev, numvfs);
+			...
+			return numvfs;
+		}
+		if (numvfs == 0) {
+			....
+			pci_disable_sriov(dev);
+			...
+			return 0;
+		}
 	}
-}
-
-static struct pci_driver dev_driver = {
-	.name =		"SR-IOV Physical Function driver",
-	.id_table =	dev_id_table,
-	.probe =	dev_probe,
-	.remove =	dev_remove,
-	.suspend =	dev_suspend,
-	.resume =	dev_resume,
-	.shutdown =	dev_shutdown,
-	.sriov_configure = dev_sriov_configure,
-};
+
+	static struct pci_driver dev_driver = {
+		.name =		"SR-IOV Physical Function driver",
+		.id_table =	dev_id_table,
+		.probe =	dev_probe,
+		.remove =	dev_remove,
+		.suspend =	dev_suspend,
+		.resume =	dev_resume,
+		.shutdown =	dev_shutdown,
+		.sriov_configure = dev_sriov_configure,
+	};
-- 
2.20.1

