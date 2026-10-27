Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFD60A5BCD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2026 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZy/ihn8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jDVDD6kf9z2yWy;
	Tue, 27 Oct 2026 23:29:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793104156;
	cv=none; b=oyClvpl8sq1boT/yf9mNuzeUt0xzo3i17OVmn7dUjLaTIsIbxfOE0PgQVKlehK7RTVkn9hQ16G0vah+UymGvNLubF89doMqG8m9t0T2iAA754mJgVxyvFC8d1YlpYU5DQY0YrGrIJK4fKO+BCPqKuKNSRag3On5vywv3pENh7r4XOdDBdB5VFcKIdWQXXqTVjSk+9nrF2xri6Jr9gAvwZL4MiUP14qN00/LpPofBOln6xv7Ob92nXBA1zZJJ5OW0gxo/OB/8w2sxBHdgpz0+PknOaZBqoBhw+3DU04mVkHPEZMBn4EKBxYlsei5huR1NW6o9qeD8ed+Cr73OV4WiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793104156; c=relaxed/relaxed;
	bh=+WNu1ci5a6DlT+vajHNP6rNH5UkEzR2bIj3SQj7gr3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtmGvNaUtG1lD+uyzJImYRvAXl8F6BiGXzJnP+dYcFrOrIBD2RHB5yiC9wHv1uNTSq2kEg9N7I+zryrdhgMLSjcYL/oCF9vKh8V/UGy52W/WU8KQaUyXecmPfZft7zZr+KbHbAXjbWtPbIJq1mmsKM/Axsfny/25DBTDBv3aYwgBXTXgNlG44Fui8EZwKBnW6bnP7AeoQTAFSD+ampRIrLvwbPsrzNcAQxJnUTKxMNRw6czwllNqGbnTKI1DVmvB0cRZ+asSk0pFjt7+Qf55fcHb+GFe3F0WhBzd+8QUHcjB2Ye/TjpcGbHhsRhB2OKVQ99CUkXpG7pM9hffr+qL0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZy/ihn8; dkim-atps=neutral; spf=pass (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=SZy/ihn8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jDVD90vvxz2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2026 23:29:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+W
	Nu1ci5a6DlT+vajHNP6rNH5UkEzR2bIj3SQj7gr3o=; b=SZy/ihn8oSlZdUR2Zf
	/gq5NcKWpi0rocdWQASPZIRRBW8NjbvHBohneopn5Af51NJBFtjs9RW+dJc3LrPs
	cYxs3K3Sqy9GM+IpGV10kQ5BvtSGLA8qjCkGp8qCzomRO6eCgg5TswgA48/K/MY5
	4PsEg9RcVSv471TZPP4WguQnk=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnz2v5mOBqYaUSDA--.46182S7;
	Tue, 27 Oct 2026 20:28:47 +0800 (CST)
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
Subject: [PATCH v4 13/16] PCI: dwc: spacemit-k1: Use cached PCIe capability offset
Date: Tue, 27 Oct 2026 20:28:24 +0800
Message-ID: <20261027122827.2725643-14-18255117159@163.com>
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
X-CM-TRANSID:_____wDnz2v5mOBqYaUSDA--.46182S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1fWryrZrW5XrWkXry8uFg_yoWfWFcE9r
	9xJan7ArW5Gr90kan2y3WfXF90yay7Z3Wj9a1ftF9xZ3Z2vw1FqryDZFWvyF4UGrWDJr97
	Kw1qvF1rAayUKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWltUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x8422rgmP8aCgAA3q
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

k1_pcie_disable_aspm_l1() runs from the .init callback with the
controller already enabled. Replace the capability search with
dw_pcie_get_pcie_cap().

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 0564c46e2f48..a22a6d4dd2e5 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -113,7 +113,7 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	u8 offset;
 	u32 val;
 
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	offset = dw_pcie_get_pcie_cap(pci);
 	offset += PCI_EXP_LNKCAP;
 
 	dw_pcie_dbi_ro_wr_en(pci);
-- 
2.43.0


