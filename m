Return-Path: <linuxppc-dev+bounces-22878-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34480CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 16:39:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkYn86HFDz2yVZ;
	Tue, 23 Jun 2026 02:39:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782146348;
	cv=none; b=Otvt8hSydHnQ4/ALFY/JbJ+93M0T5dsuFx62jNxloAjdflnQoVYXsrno9yciULvVH2zb/kNs4ZSS2l4eIbqGnOC1cVMax09KRtpx6uRhNqY3OZlmqp+m2zRmHUZ4gpGTtrS7GA9yBD8husFv9bJiQuzwswLf8Q0HfcZTShnr31thmUl4E6120irL9LTL/8KpmhnE3EbJ8qFnUmgn/mdmPijzdYskl1iFJ53F5OwL30/O2revq7Jrnu2a50LjhxRnpU1mwsAiNTY2/HEGX1kxEVfIJPyR6q6U53xb4PPRfo5xf9yqhs+nyj5gr7ooDDONbaQzElwF3Wj57XZCi/Ygdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782146348; c=relaxed/relaxed;
	bh=6M8qGLFhZu2RmVuNev+Lh67Tma1Rdrecr4EbGmg4TH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SeZCIp0PLKgtbccPVmDNsaggdkW0dF0L5DgW8gq3G10DxKWTP/NAUkcmw0zJtIZrfrRd3uYmBfkNZoT5p9aKoQLoHU6GdnOZVuS6bcMPN0Dr8W70dwVU0nAdDsrqfQmRfUlinRUlk4WTBv1HcjgIfFfdwwzQzj6C6NSGWgUKvznlxQd3S+EdhvkZMH0CPOLw7Nw9ijTbdJsh9cGqX7VOAndkxHGrkEfty9tzzAnkId5KURLfr4mC1eMG8cr5/H0VhVBzOGmtV24PyJGRiK6HP+YnGE16KP4q2SeL1OnBhnIYjr3WV7eQWk7OWfPcnil22khFUxue21a1aw1USvbwwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N5LJlgj+; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=N5LJlgj+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 9110 seconds by postgrey-1.37 at boromir; Tue, 23 Jun 2026 02:39:04 AEST
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkYn45j1wz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 02:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=6M
	8qGLFhZu2RmVuNev+Lh67Tma1Rdrecr4EbGmg4TH0=; b=N5LJlgj+OdZhdf0axS
	7qxesVfSX2LoR4L5JGu/U38l2d2jw1hm83Ota0nej6tERhxayyBHG+E44Cqq5X1l
	J36RFSuapwmEtSEo0HpKqgKpX/CNUaEFnwOVdIYMmPGaVouWjLjWrPq1jLzA1bJT
	Bk1OQEnua3J+DfQI/tq0P1FYg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXX5v7ZDlqTS+KFA--.19183S2;
	Tue, 23 Jun 2026 00:38:21 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	gbatra@linux.ibm.com,
	kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH] powerpc/pseries/iommu: Add check for iommu_pseries_alloc_group()
Date: Tue, 23 Jun 2026 00:38:18 +0800
Message-Id: <20260622163818.1273990-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wDXX5v7ZDlqTS+KFA--.19183S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1UGr18AF15Cw1fKr48Zwb_yoWfXFg_C3
	s7ua1kZ3y8Xrs0vF9Fyr1fGF13K398ZrZ8KF1q9a9Iva45Xw4rCa15X398GF4xury8AFZx
	Kan8t343Ga45tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNFALDUUUUU==
X-Originating-IP: [240e:604:311:e68d:9586:9dd0:bd4b:6902]
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxR1Br2o5ZP3ZsQAA3U

Add check for the return value of iommu_pseries_alloc_group()
to prevent a potential null pointer dereference.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..3b49a0f76df9 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1875,6 +1875,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	pci = PCI_DN(pdn);
 	if (!pci->table_group) {
 		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+		if (!pci->table_group)
+			return;
+
 		tbl = pci->table_group->tables[0];
 
 		iommu_table_setparms_common(tbl, pci->phb->bus->number,
-- 
2.25.1


