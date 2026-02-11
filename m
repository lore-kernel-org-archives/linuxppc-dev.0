Return-Path: <linuxppc-dev+bounces-16795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B2EEB5967
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Feb 2026 05:49:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9nZS3KZsz2xlj;
	Wed, 11 Feb 2026 16:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770788992;
	cv=none; b=RRItv9m6aYtj/gqvb+kT3wPZsnxDJq+uVygjgk9PvX5LOHaqr2L1QEp7mQL9a6O7xW7X9Sw4Bfqpq19R2PaW5HPg4zxJYGKj6v13gIZBYWHXkiDLoan/4C52Z/0nuiK2i4xS7c2dy4M4zK1v1Dkis3cCK7HX5IsD6wWP+W7WF7W4jAUZQqFpwdxxASwpEcFKnW715Wqges8ygvUQfzxdsOR22dqfxo05W+WbzPqCKbcSnxSPgFxBpifPIeFrlOTb+vt7U0ERUbr5WKL34Ob9HfljNOQpVUsXVGGsGkkVvyyXu41Hio37CdFrupi6KwLD84AlzOmDolJsZGIvcyNcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770788992; c=relaxed/relaxed;
	bh=UqnhVYkDoGdmcyF6gevkU4CNI7W2gELCoht2buEIfQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CU6wsmtNZOIRsqXnG6mJ3Xk3+kjFhFqkQDZMiutoHiZbpxB3bix0HtXvvsMFJbLC1MuW11w6bqxUfbvyRuZv4Am4uZW1TgRn5KNx/m7r8fMXL19Aab3fq18gkKpZpcAQZfPb+kWyRUs4KwV1Q4B3m3rMJU8mDseujRuLvj8pwADpzSOUReSfuD9iZBK8q8MJPBmZOkkWT03ovwZdQtrBLeWOyJBXftD0mXUq7mKYi8bU8w3wRjkzQwaWf0/C6enH7PfOVxz96DMoJ9gfhY5jkj69Pf7mUop30xBJcS971S8d+bLix4GQ/RqXbInm9TN8uH9UKZzA1UprBlE5I544bA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CF3RHBAQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CF3RHBAQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9nZP3h2Hz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 16:49:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770788982; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UqnhVYkDoGdmcyF6gevkU4CNI7W2gELCoht2buEIfQ0=;
	b=CF3RHBAQ09llCGXdExCSP6v+tgRY5gL8bSQmTQ78KI7yAI5oPXCK1wsiJcEDjuGYU4OnhOP59spflyNSFExLKxJqQEiPMxqAFs735l+OAsmmePr2+RCJWtzj7alsIdqvgK04GjPeDe0eccw+m7WbEvOou28VULDinR8fytGQtdo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wz.qUCa_1770788979 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 13:49:41 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v2] PCI/AER: Only clear error bits in PCIe Device Status register
Date: Wed, 11 Feb 2026 13:48:16 +0800
Message-Id: <20260211054816.22758-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Currently, pcie_clear_device_status() clears the entire PCIe Device
Status register (PCI_EXP_DEVSTA) by writing back the value read from
the register, which affects not only the error status bits but also
other writable bits.

According to PCIe Base Specification r7.0, sec 7.5.3.5 (Device Status
Register), this register contains:

- RW1C error status bits (CED, NFED, FED, URD at bits 0-3): These are
  the four error status bits that need to be cleared.

- Read-only bits (AUXPD at bit 4, TRPND at bit 5): Writing to these
  has no effect.

- Emergency Power Reduction Detected (bit 6): A RW1C non-error bit
  introduced in PCIe r5.0 (2019). This is currently the only writable
  non-error bit in the Device Status register. Unconditionally
  clearing this bit can interfere with other software components that
  rely on this power management indication.

- Reserved bits (RsvdZ): These bits are required to be written as
  zero. Writing 1s to them (as the current implementation may do)
  violates the specification.

To prevent unintended side effects, modify pcie_clear_device_status()
to only write 1s to the four error status bits (CED, NFED, FED, URD),
leaving the Emergency Power Reduction Detected bit and reserved bits
unaffected.

Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
Cc: stable@vger.kernel.org
Suggested-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
changes since v1:
- Correct the commit message to be more specific per Lukas and Cameron
- Add Reviewed-by tag from Kuppuswamy Sathyanarayanan
- Send this patch individually instead of as part of a series
---
 drivers/pci/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31..2ceb81ebead8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2243,10 +2243,11 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
 #ifdef CONFIG_PCIEAER
 void pcie_clear_device_status(struct pci_dev *dev)
 {
-	u16 sta;
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+				    PCI_EXP_DEVSTA_CED |
+				    PCI_EXP_DEVSTA_NFED |
+				    PCI_EXP_DEVSTA_FED |
+				    PCI_EXP_DEVSTA_URD);
 }
 #endif
 
-- 
2.43.5


