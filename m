Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3699A606A31A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XXxyUugR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVGx26DVz30MZ;
	Tue, 27 Oct 2026 23:31:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104297;
	cv=none; b=bTL6yBPDc/zX6ON1zzk8d0N8Fy/eZAzV3eJOrq0wpZti6rKOpRCc7RN03P8FBm8sn/RIUG9C5vL/T4U8/1tl92ItTmQ8SkMkdzOifxVlI2pxEm7IxrtBph3bJm92Y8Hoq/crzh57oQOjck39mvgBOZifT8Zc5rpcH5t9MizUS1Tpglfq9JdaZd9N0YnJ16eOamfwol09UwlF+RChcyRdFAiK43odx6StPnhu7XPu5POrTE8s8bo6Xs+wQCjkluiDMSzLK9JwqccRAhqRTOwL6rSXK2EItIDsJcWc3eSd6Rn6XMVLdV8qx4bLraZnAPhS3oyXIlWsCdKK5RmQOLxcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104297; c=relaxed/relaxed;
	bh=saWYwAO+ESgTqoqpuWDp5pJj1fm4a4bUC7bN/MBxH8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V19mnZiyKONhh3L+mwhoqmEoq+ZqEKZj7rVLvvHtJ/lfGYK69c36gWLGBLuaTjbRON1xHPtKYZncKRp40uicBecMtAPjLnPfL1avc5B4x0SkZ0U33iJ8mQSHSstuoub31Mx6r4WHYokt7z9D3bHciL96KtvmVBRamSDTrsIqDJvp/HYxzxL/jZzDZcMtjLq4jaLR/mqOfIfp1+iG8yQ3OJvY9mvaVX7011rgeaJnSJSPjG6OHYXto9cNzIj2nOMtIlgBPpjVOqxdV4QeJXgwYSQRUn69ncXGFlccbegUEqBQtdRWD8QwB67xNCrrXTm6NhKulVQ5B4vg7eSwkzdxtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XXxyUugR; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=XXxyUugR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVGv5ghRz3bV5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:31:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=sa
	WYwAO+ESgTqoqpuWDp5pJj1fm4a4bUC7bN/MBxH8s=; b=XXxyUugRyVSO/VWHRU
	5foORZsJn70jb/MqKM1iUx1MIVHh1fjY7dqXqTvBihmd0iN0VBccCtph2+HbAO8M
	IhBlLQyW7Pl5hNKEfEx930OOzH9v9fQw+uwyvgFYyWSZAh+IWPJqomhspeVGcloa
	sQg/zYUqMwdB+nbqQJaXbfV3g=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Dz_umOBqUsqlCw--.64541S9;
	Tue, 27 Oct 2026 20:28:38 +0800 (CST)
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
Subject: [PATCH v4 07/16] PCI: dwc: eswin: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:18 +0800
Message-ID: <20261027122827.2725643-8-18255117159@163.com>
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
X-CM-TRANSID:_____wD3Dz_umOBqUsqlCw--.64541S9
X-Coremail-Antispam: 1Uf129KBjvdXoWruF45Aw18JF1fAr1xWw1rZwb_yoWDCFX_ua
	4DCr9rArWUGF9Ik3WSvw4fZF9Fya4xZw129a4rAF9xZFn2gr1jvFnFqFWDAFy7uF1kJr97
	Jr1qvFyIkFyUJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNHq2PUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BY22WrgmPYZCQAA3h
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
index ce8d64f8a395..3d3275237f3f 100644
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


