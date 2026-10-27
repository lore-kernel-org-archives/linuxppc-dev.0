Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD74606CB29
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YUiIybxD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVDH3Rhxz2yqx;
	Tue, 27 Oct 2026 23:29:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104159;
	cv=none; b=oMbZbZTXBOuzj+Dmvr3xesPIBLVWhfB7H9NPGwap/vvWDSqG8XG6H+rkuVGYOXwlkTNdKwEEj4iOcb6lwPHmzTN1+b7445CzgatFVZRfsl4Ixz32zM8NRFsIs/JZldb18sLDpjDDDeP58g55+YlMjgBZ3QqQG/DyblblD0zxaheULSjXQTArhy1Big0tctLBBfBc0cx5kAB/r/dk2w8WDvycqwnwF9/8ptT1iUfyu4opwtoX2b85Y1adKngn7/Ae6Q9F/8tUBwtXzish8FG/dZbGP/Angy7St7I3J+ip5BLLUhkGQp2R7zmGucQsNkl5U+POFFc4EV3IkKKUqzq63w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104159; c=relaxed/relaxed;
	bh=S5t7uFoKN8gTi5kSeRc4raDy/yZw3HkWKIXPXE2zN9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqU5c8lorYLd/4ZdZcgxnqcSwJ3nWsI9qzybvc3vX/e8Mqt8/i9AtgPqg9Hr0vZZL/WnlQKctpPM/AOGv6stI8YgEgh3Wcglg2l+gh8xL+rvmsYv861AAWeNfuhd7jz4Qw7ctnwIPor9sKG6deo1SgGMqQF/Q9FqyL4lO39+FZhb4aNKQmjsPPGGKNSC+Ygy0w7/xdqbe+iwvrOQojcqkdji7bPKOjdbNAWKS1nD1zHWecIXa6mVpnArKDlsyJcWDIe2CTU2dksZkKRvxnFFIcx2wdKOqAWpgNCKHIcObzpLvVaWVFBvwG2vcSxplpIpAYRsZVBJQl4+UQSm5kdU3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YUiIybxD; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=YUiIybxD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVD93qYdz2yVT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:29:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=S5
	t7uFoKN8gTi5kSeRc4raDy/yZw3HkWKIXPXE2zN9Q=; b=YUiIybxDqGUIwQ39mp
	PlrkjVLyqnAT8c0ajSwxUOZ0YZTx5JW2mzUJxYEkhfjV8NSjDLo1nDdb9Vzq2nAh
	GxN8cOsr7RVD3efA056DUVYU9fu4Gmu1VvZiVLsecWtFLbIuqWngDvb51ChAyg6P
	VNPgnAkifZY+By/6k8VnTQ+7k=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S2;
	Tue, 27 Oct 2026 20:28:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 08/16] PCI: dwc: fu740: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:19 +0800
Message-ID: <20261027122827.2725643-9-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDXrWkJw4Dtr4rZFWUArb_yoWfCwbE9F
	yDGFn7ArWDKr9YyF12kw1fJFykZa47W3WjgayrtFZxZFn2gw18XrykXFWDAF4kWFZxXF97
	JF1qyF48tay7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtpnmPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7Bs32mrgmPsZugAA3Q
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

fu740_pcie_start_link() is the .start_link callback. It runs after the
controller has been powered up, so replace the capability search with
dw_pcie_get_pcie_cap() to cache the offset.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index d0a34f680397..61e2daa20b19 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -178,7 +178,7 @@ static int fu740_pcie_start_link(struct dw_pcie *pci)
 {
 	struct device *dev = pci->dev;
 	struct fu740_pcie *afp = dev_get_drvdata(dev);
-	u8 cap_exp = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 cap_exp = dw_pcie_get_pcie_cap(pci);
 	int ret;
 	u32 orig, tmp;
 
-- 
2.43.0


