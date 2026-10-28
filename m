Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19160731CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bIxsEJpf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjf42KGz2xlZ;
	Wed, 28 Oct 2026 14:07:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156854;
	cv=none; b=W895/oV6Qodpq+0qckRVGV356EFGrPmb/cseMnlZbsr6qv/Ue+Um8wIWQSSNuarOuQ0w8SWaNjDuPZhHGIKiiZI8NAiNfzHU8nsBSYkE5DPa5FSQEM6gXaW/VkKZmvwXW6NrxodWiZt1AA0HAiM1lc7M+qKb3aIiRR97nuGgtIK3n3vhwij4VIJvgWh+un0xNhSE4+uJKt2FoMCSrp2u/6X+icR/15ler7dr2uUywSq+DDk+KwMzehaKrhNClrvavWz0kk11KtHGxKPyixllK4qo8l+UmjENMdPXpfWJoJT9W9t0OPlDs/SYzKysfuJaInsnHwQmrY2llMnxUKdpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156854; c=relaxed/relaxed;
	bh=tnof3xP7PItMivWd2BFSiA/M5yZlXFkryB98XPi7W/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TLeB5kUTD6VSkTMu1i1I/oHqeeH26SCcU0UQi7KDm4PphmIV5mzqMHRZ9Ufbpx3o9WZXxE0BrPnFJoQ7AXuX0+FbF8xZP0AKgc3R45WxB6y9q9km3BcpBNm1KX4nQd97ZO28/J9YisIy8fu08ggebPoK12BBN4UGSdTbqWiHTaeUdIIEBEeAALFZYl7I8rPjuwSfP+pWmxr/yndZAYwmEICkzjWYAbJRnvxcvXw8J6N3g2uqtiyZVPvHwxR2qJTVfR8EUca2vmTKvnX+HgxGwRjSI+HbWSdc/e2QeJeQdqxqXdmzicgXK1Mtb/kVecTPHy1LwT74gFwQyM1O5RtkcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bIxsEJpf; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=bIxsEJpf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjZ4YHGz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=tn
	of3xP7PItMivWd2BFSiA/M5yZlXFkryB98XPi7W/Q=; b=bIxsEJpfxRkV2FpHly
	U0V/n13hcy4H+VcXsozQLSJscEqHzeRDNeppX+qjrcGJCbh7yI8KnZss+KFFvylM
	9UYtdi51n0Ci6fj2DZqcQL0YOgtVJpeyaTOjoYSs37QnxdNq5wh3rIa9hrBiAOL6
	soQ9hKHVWath5V5n830zknt6k=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S8;
	Wed, 28 Oct 2026 11:07:03 +0800 (CST)
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
	Hans Zhang <18255117159@163.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v5 06/16] PCI: dwc: rockchip: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:42 +0800
Message-ID: <20261028030652.2917756-7-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S8
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWrXr4xGF4kKFyDXw47Arb_yoWkZrbE93
	4UursrZrW8GrZYkan2y3yfXF98Za47ur1jga9YyF9xZFn2vr18Xr97X398AFn8GrnrZr97
	Kr1qvr48GFW3JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNMa0PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BjihmrhZtjP5QAA3P
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

rockchip_pcie_enable_l0s() is called from rockchip_pcie_host_init(),
i.e. from the .init callback, which runs after the controller clocks and
resets have been enabled. Replace the capability search with
dw_pcie_get_pcie_cap(), which reads and caches the offset at this very
point.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index bd86e32cc2b15..6d87da43cd6f0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -374,7 +374,7 @@ static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 	u32 cap, lnkcap;
 
 	/* Enable L0S capability for all SoCs */
-	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	cap = dw_pcie_get_pcie_cap(pci);
 	if (cap) {
 		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
 		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
-- 
2.43.0


