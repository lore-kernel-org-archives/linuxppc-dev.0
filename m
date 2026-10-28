Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A5606A325
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Oct 2026 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mfHPLhUE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDsjm1cdyz30g6;
	Wed, 28 Oct 2026 14:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793156859;
	cv=none; b=HSXMCicM2m2inbCe/+FSqM81j+OExjDHNB5QMVYtJRDEA4iycetVbGRBhP21WJ1k3qVs3xFkY43EQqAe2x495YIfvMZhultk71VTsFmBQUNAutOcGnlwHtAd3KbhHKLXr7YBF3WoAyc9aKTwmfzgeyzXa3O8iTaQJX9FfIbLeDDOVroFbxnc43XJkH8D3R++MVEFsbE4PJ8ogENaRb0BShugzYArbPUwrPTfcmQdlZD+cXo3xpjTfuwFM1FerQfFQEI8D6DRMEcJgJLfOX1WJND6PSliGe5id6XTkLlGx1ylCd3wCsfYR3qyH5FtuUyh4K+H9LlUwWrTIBgzJf7xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793156859; c=relaxed/relaxed;
	bh=nw4a8GdF8Rm29zjnqIJ6ENwjtf0jPmRW0n0sSDEi4cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASN5hYeQlaxTdfXM5yQRbGHaCWatkye71c7KSICN1OtDVNqqyRiYj1jZUHjfXhgNwHN709y/lXn5DnkSZfhUNzymof+2fU+FtZfMhwbD7s3RDYYKdU38KmaIurWLMe5TmNl3msZBnxk8/W07zuX6TLJ2JtK5CJldX+drGbTWMJuhc3/LY2A88k0q4dZ9zG16AZqSsqnUsp+Jpcj3Oi+53IjLMWO3x1zThmscAMtOj+q8S/Z3c4cdAMky0KvvGMkREUIYCQFTHd4mNAMUh/9PaynUA82zSo75OevEYqp7sQ6180LlRi7tnWPX7wKGVpaY2vVLstASQsaiH5hKo8BUBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mfHPLhUE; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mfHPLhUE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDsjh6sjCz30St
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 14:07:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nw
	4a8GdF8Rm29zjnqIJ6ENwjtf0jPmRW0n0sSDEi4cM=; b=mfHPLhUEBNSyABWGzy
	f3gCIUpgfmhhwV89Nf+l+zP5PJdFVM30klupuAmjToA4LdU+y+paXyoXz7EwhF01
	l08XZyiSLPaSvAOtRaReUJfutCxQ1qwwDBRGp2orAr+N1vlLpashVmPD72Oc54Nq
	UbBpmG7egMdLUrQjb2Q2FLJx4=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDnD07QZuFqZiY4DA--.60713S9;
	Wed, 28 Oct 2026 11:07:04 +0800 (CST)
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
Subject: [PATCH v5 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Wed, 28 Oct 2026 11:06:43 +0800
Message-ID: <20261028030652.2917756-8-18255117159@163.com>
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
X-CM-TRANSID:_____wDnD07QZuFqZiY4DA--.60713S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45Aw18JF1fAr1xWw1rZwb_yoWDCwcE9a
	4qkrZrAr4UGF9Ik3WSvw4fZF9Fya4xZw1j9a4rJF9xZFn2gr1jvFnFqFWDAFnru3WkJr93
	Jr1qvFyIkFWUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNE_MPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xnihmrhZtnE5QAA3D
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eswin_pcie_link_up() is the .link_up callback, so it is called on every
link state poll. Replace the dw_pcie_find_capability() call with
dw_pcie_get_pcie_cap() so that the capability list is walked only once,
and store the offset in a u8 as everywhere else.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-eswin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
index 1bb44696057e4..d08277e8cc690 100644
--- a/drivers/pci/controller/dwc/pcie-eswin.c
+++ b/drivers/pci/controller/dwc/pcie-eswin.c
@@ -84,7 +84,7 @@ static int eswin_pcie_start_link(struct dw_pcie *pci)
 
 static bool eswin_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u8 offset = dw_pcie_get_pcie_cap(pci);
 	u16 val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 
 	return val & PCI_EXP_LNKSTA_DLLLA;
-- 
2.43.0


