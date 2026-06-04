Return-Path: <linuxppc-dev+bounces-22087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4BDCD6E75
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 02:17:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWlSl6Ghdz2xlw;
	Fri, 05 Jun 2026 12:17:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780585330;
	cv=none; b=Uizm6O62c02SmuzRH4UbMHdookF9wQ7P4OFX+kouvmN9DiCLguT3/DKWg5HEIIm/gx/nTRfZ5v6Kd69xBxDHvaCxnZ/kro4Ut+zlbXMZcUSQTlgavzoVCe4aAH/8vwwLHBYAs9/JAzPw9xKMdDTVRdwStryR3H7aWnQjnvQvFJr+04QFVb+QGJM5TxjeEsW9LB+dSXP1GWK5vAVfPaRo5EUdiE5+9R1vswYP9671aSL5MemcGHcp7pG8dTurm1Wm69wWiFb2P6YiLOoH5mPZStv9cbz58oLEkWjJD0NYDRBSVc0+BfULYLlrI1NsajvXVk+8s3KQeD8LxO3d/1BxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780585330; c=relaxed/relaxed;
	bh=2hIFtvWihjq2T5uRD8ilA/smzXwEZg9tgf7CPYlO5lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etfXi5XrimkeXFQTzW9gYiVEG+xi1GjFd8IoZm+0kqfk97cJ5RUvi7eL7pkK42Fooow2n4kjaf7SRrB5U2HrIN7dVpgtRkwDQd68JRsehZ7oSw8f1GnPt9AsQS5f4jGu4dfGdE8hNJxtqLftSkCQzF4uoTYVvYHLac1OZx2VcGfyQTUZsR+KBGu1SJY8mDo3de3XnVWaeiop9x1m0XFyJTVz+5lvFvdL2ibMLyJWXq6g64Ve5+Sx8/zKfSYDY8w0glBDGYamVSF9Q4zNT4MzJyeFRVxf2aR5prNDHF2wCGBPFtM+J4TV+zDrQRC4C0PkF8ZxUn+P2edBCqOXxF8Q0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QYATu6nE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QYATu6nE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=dimitri.daskalakis1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWSTW53Qjz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 01:02:07 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so1079163a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585326; x=1781190126; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hIFtvWihjq2T5uRD8ilA/smzXwEZg9tgf7CPYlO5lE=;
        b=QYATu6nENBUPO7vPnOmf16QP1bZuyYSSIZt/TPt8sh68FDNLp5Uo+3HrZWqWVtSyTT
         7HrhVzfEaZyc5npH5A9+goEFmqV7v7XkME2LnkXGA7Z0cz0Ad8VZyvAmF+7VUxZ13ZI9
         lEiHCvxg3viCGqLd42EvogSZXx0vMgxMXm43NlcMxDnELIgNWD7ZPpLnWa6tyPif9CJV
         m07RTYmxRjwZTDHmu1Wkd6L7VvccEATSL+DRnPrrSU2Av4QUPga9tl68Yt3U4wKzBTTh
         s93Fc8UlftGkkWAdDG6xsEQLPujpz3a37xx1YS7Jgrj18a646p4CZ05bb2h2oEtsABoM
         9lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585326; x=1781190126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hIFtvWihjq2T5uRD8ilA/smzXwEZg9tgf7CPYlO5lE=;
        b=qASmacHfiC7BvJDCCucximV9pgavLZv80gI8lJjgpwa4JP+F808epBx/7zl4XPfRYR
         5gTOzkATnXV8Kfz/6CBhgZM37EsA27ZsQDilQm9pLsoTtnMz/uESmBcL1UiGiap0MJlB
         w/sMX/tKSWdj6nSP6B0D2C0OV4nskuCxKrpbAaom5Nthw+L56EOejhi/njCDjooY4sRe
         ZqRUeWY45NNt5cOwbMErRlN0OLBX8xYBLVk8Makt+ZytRugvYXCrCgDaZNl9tGbYTLa6
         yUY003Jwb4QXBMLFENJul2O+MijAaX+D0uJ0t+I2HCVw4XnHnuK3JmTqUCkVc3GJ/d3q
         fLyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8x4YbSQ3qc8ePXapbfGdADgEPbkMYUZ8nA4cUMDYpcxmdaLylhI7uRFZYvrD5cKXEpV6jZdyaeDji2aag=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4VXMkQvMKEXzum5HiJiNoy4zA3E1r4FNY7OMo/BZempfe4NLm
	2sbgbv4nvQkjguSbvH2fFYdfOwE4QTtEYRddbGpM5Nj2rpWrJmVDbACk
X-Gm-Gg: Acq92OECm6GvaQEnNOYfzkybmh4Sd0W7VOsfXEftV1L3WvM+xDM1GfGAdTvuvw0fBoi
	znjRUoZt88mR9WGuHL0PYggd8FtzRw7DC53t/WFhyDty433l5JDSBFf+jMVeA73pI/KJZUJIhks
	rLZy5jb+iczQ8w9zlS8JpS1Yw811vGabEoZTD14U6leI6S8y5QrMQhLyKV+jsDLSalPZWMkUuJx
	xSVV+uZsU5QgvhTk0ttB1FX93UG5ObQ7iKu/C27mtzIf52f8luxcvglQn1iIvonlAe6wmoXSbRJ
	HduONKLFa9iCjg82KcobuqelTMhP+zlbahSqek26p/Li7m1dI9K9oriV+YFBWy6VPRBdMhNELh+
	bzj5AchVkTQjmqUWLEMnz5Le6KLitwSVWKgcLDs0NfVtx6h+DkDeRrU/zeKvEwNzQYeY14VVF
X-Received: by 2002:a17:90b:2b8c:b0:36a:8519:a4e9 with SMTP id 98e67ed59e1d1-36f7898e08dmr3643368a91.18.1780585325710;
        Thu, 04 Jun 2026 08:02:05 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f711e7b53sm3448820a91.14.2026.06.04.08.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:05 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 07/12] PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:48 -0700
Message-ID: <20260604150153.3619662-8-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
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

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/pci-driver.c           | 4 ++--
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d10ece0889f0..926f80bccd70 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -357,7 +357,7 @@ static void local_pci_probe_callback(struct work_struct *work)
 static bool pci_physfn_is_probed(struct pci_dev *dev)
 {
 #ifdef CONFIG_PCI_IOV
-	return dev->is_virtfn && dev->physfn->is_probed;
+	return pci_is_sriov_virtfn(dev) && dev->physfn->is_probed;
 #else
 	return false;
 #endif
@@ -453,7 +453,7 @@ static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
 #ifdef CONFIG_PCI_IOV
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
 {
-	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
+	return (!pci_is_sriov_virtfn(pdev) || pdev->physfn->sriov->drivers_autoprobe ||
 		device_has_driver_override(&pdev->dev));
 }
 #else
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 79a2b5dfd694..fd5a13f79fcf 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1695,7 +1695,7 @@ static int pci_stub_notifier(struct notifier_block *nb,
 	if (action != BUS_NOTIFY_UNBIND_DRIVER)
 		return NOTIFY_DONE;
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return NOTIFY_DONE;
 
 	for (;;) {
-- 
2.52.0


