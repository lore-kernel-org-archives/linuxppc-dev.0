Return-Path: <linuxppc-dev+bounces-16259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90725D715D1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jan 2026 07:47:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyn1V6Ldwz3bt9;
	Sat, 24 Jan 2026 18:46:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769240798;
	cv=none; b=gNpKWos3rRotJfQTH7s+JFtk9icdckznN9PbuHy5DrXcx8SDkh5Q38b9PQo7S6Lk+TnP77p0qI8q2rPWTBX2zw7sZwnxg+YUHSw1r7Z8Rdls0kQXg3ENq8RMYxvX5SBy6KLcQb9oqAWxc9VxMIida0vvrZjA512o+Ty5+OrlStjWjz6ji6lXVJ7yo8kTkKatBFrSERAexTGr70aCIpjujn/lclHdkCWWW1qNbNiXMHAFwwkdAXqvueoyfzqXWUTdK0TP/Hi5nw1scQuB7Qyh9FEYg2o/JqEKmhVj87qQb1q0QBkljRT16ukipwJZUpPt0yswCzypIN+x7Ic5FgStpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769240798; c=relaxed/relaxed;
	bh=aFxdKk3TVTGbZ741QSPtHZ39lb0EWDC9svYSkf2cf1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=olkekHR9ehuj4xB+N3q7/lif9oKDRFtpD8nXeo8AnEXES7ymvgge8cRLBhrdJvYy3cPulOipHlPR6nivtQfNzBYf8hOFktEmtvvIe1FrThCAkP+ENOf5uzEDYkGP4JqedYAIWOu+aufmg89ZNAfGrMxwVVV8exTT4TOj6OaAJ58Ph/SqjEaSsHUVXg63VwRVINzjI/wjFJqN3NMhNpb9jMwafSkBCAmYbQIxmlL1OOImuW/d5O7jRXQFp34k3wHDuS3e6JOEieUAIaT5++PjNbIMx/P+jZUfqa8kuwXU3oK1nip/0Ow596kzFMvvrEkOFtVv/e0oZbuP7S6ktPF/hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EYhYhT/r; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EYhYhT/r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyn1S4LYhz309C
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jan 2026 18:46:36 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769240791; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=aFxdKk3TVTGbZ741QSPtHZ39lb0EWDC9svYSkf2cf1o=;
	b=EYhYhT/rOAT136taReFldVEd5tM0cBb/BYqiyCd2ACBtpafwCxOLjvVoorDJyC8N0ai/gI6W0Z/8tXkiuU6s6pMnzYAwkiXPUcSBAao51L6wq3Rw6Z276zHU0SK5fDyBUEA0/0UBHd4kESWY4ZXKkFeW5Bwq4Z9gwnmVMFCvecA=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WxiIIBY_1769240787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 24 Jan 2026 15:46:27 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
Date: Sat, 24 Jan 2026 15:45:56 +0800
Message-Id: <20260124074557.73961-5-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
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

The DPC driver clears AER fatal status for the port that reported the
error, but not for the downstream device that deteced the error.  The
current recovery code only clears non-fatal AER status, leaving fatal
status bits set in the error device.

Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
status in the error device, ensuring all AER status bits are properly
cleared after recovery.

Fixes: aa344bc8b727 ("PCI/ERR: Clear AER status only when we control AER")
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pcie/err.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0780ea09478b..5e463efc3d05 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 */
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
-		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_raw_clear_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3


