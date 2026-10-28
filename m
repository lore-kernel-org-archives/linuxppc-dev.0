Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BE606A33A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JHVEs9/F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjk5Lpjz30Vd;
	Wed, 28 Oct 2026 14:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156858;
	cv=none; b=Jky0CtX+r2tY4ZbVK2wqS4m6QpFEzlA0WEvWRdH21S6kZOrmqKGK9MQxZ9BvlZpqVXe82lq7uTdG2/ais911AaLkOXqnFFJUHcS59D1NtgoFGdzOnjJIgk8aoFx226qbWrKW7128F3WFb07oP3m65xfb5QoneXb4MeWMHtOjv5Vv4DOjm1Cry0MY6TRGxArgqaEo6skBwzOfc1C3OOZYs0gItDe95mEwywnsF+QA/UgrpLnpJ4k4SDL3jQBSDU6Vek5+WFzeWXCFC+8YABp3dlk8SY8mMXzWJqKU8s7w2gLVuGqb+GogGYj2cStXfAUipz16SD6T6Go5+tTlU97G5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156858; c=relaxed/relaxed;
	bh=OY/nKIFipbhUneBZ6EWbb2qdOnB0mX9Xjv8WIqIqTe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTlNgrNl14Dzq3NvB6bCu7NKXAyOYTbEt+aVjqgDEfDh8ilH4oM8wadvabe660gzILOfBGS0jaayKKp2YItlj4fukntzBGjs58jQ4tv2A4ozXFFqJUUM5Zos1Wi5KYoue+JqihgVJWji2aGEMZTXGGEEIKKN271CkqlHkSVGVUkuaJ1aG4fkG0PY7Od6RzcxFqLNylWMj4erRQWViOabYXuFhKQgTIrsaEVG0zhMK6/9boGLqWTd2x2DWgihmwJem+7VeO4CaeF8klZivXCS7GkpSpGQ85Ta63oQWFoZPC4of0R4LtwOYvaxzgKrPHakeOu3RJyir1qeEZO826iNvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JHVEs9/F; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JHVEs9/F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjh2N2Lz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OY
	/nKIFipbhUneBZ6EWbb2qdOnB0mX9Xjv8WIqIqTe0=; b=JHVEs9/FcCLjbRxwb6
	ZtPbxyG9rUTPsqqbK3MYQOLZzliU00LrGUeqZDcuTkE2rK74s0NJ2I1WGzX+hOPH
	wvx5yHDAb1Pg+ZCdSDljZ+kMspehvDecSf+YOJ9/uOWY/3H335c+u+nheJ5iAXCQ
	QAZSAAaK/772fZWEtudMEywHI=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnVwncZuFqLzE4DA--.33198S2;
	Wed, 28 Oct 2026 11:07:09 +0800 (CST)
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
Subject: [PATCH v5 08/16] PCI: dwc: fu740: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:44 +0800
Message-ID: <20261028030652.2917756-9-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030652.2917756-1-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
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
X-CM-TRANSID:_____wDnVwncZuFqLzE4DA--.33198S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDXrWkJw4Dtr4rZFWUArb_yoWfZrbE9F
	yDGr97ArWDKr9Yy3W2kwn3JFykZa47WF1jgayftFZxZFn7Ww10qrykXFZ8AF4kWFZxXF97
	Jr1qyF48Jay7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtZXo5UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x3jh2rhZt3GFwAA3z
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
index 6c7ce16031704..00ec69a091647 100644
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


