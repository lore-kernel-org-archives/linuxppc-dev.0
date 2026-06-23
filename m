Return-Path: <linuxppc-dev+bounces-22930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92E0CDB46F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 14:30:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl6t32qzcz2y1Y;
	Wed, 24 Jun 2026 00:30:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782225019;
	cv=none; b=gUBPz7VVz1aOn8IxaNutTKcf2xNilPmjusq0dNOOHB/eqDTv0Fgcm64LcXY1ioqcF84uRge6DjORLIna68zyNosWMSC+bnR/RnlflTxmJNLqNBAyQBK4qOcihlqmlRH0dnghuMNCAJuRPJxOJNM3IqEQPGjl1+XGYwgzMSI0Egvx8gzHx06nVuFSO9T4rVj57q408lwmftcBUhwA86UJF9NkNhc6yluYSN3I91IuEvK30CMXnCqDf0B9fJ7iQyGjrhElLisSzokngY7b4fVBb27KrEOHtc1EPqWzeJ04EDjpv/P4DLHRgT2GIr2ULjLVToNBMwYYE8o/fq6C8qiy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782225019; c=relaxed/relaxed;
	bh=pQO5VjXJcC4HPlZ6Ah+8CJVijHxVAyJdB8wO2DL1CAg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6S1woSkzKkbb2WErZfRcsab0oZaXmZLnoLsg+Qxr/CDOLaw8zJdNbCkAnyF+D7o/TbhrEBj3ulPzMohME/Ob5mz9n4cK8A3fD8EuZsS5+GfTbt7RGve0iXrMHOgtwZH5AZwk4NTYacsH9tAE0rKh4jVedV79Z/y5t2T7Zo5h33q7Vvni6bo1dkjm7aD+dMflPey00ijtOzJjPIFGwT6XMnwKFqgQYSvWm/GFg1AWbGXHpV37F6CGF7rvLSTf7nKI3Xvmnmm8P9sg+zkPeXiX8boUht1A4Bdp+nbjDjqEkaxrxJj7fWJKRAzk0P8hngATVPLb0/6DJ6a0wzYEuwgYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KVRzMdJI; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=KVRzMdJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=haoxiang_li2024@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl6t00P1jz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 00:30:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pQ
	O5VjXJcC4HPlZ6Ah+8CJVijHxVAyJdB8wO2DL1CAg=; b=KVRzMdJIVKuzQ8u1wZ
	Iuycs+jp6O+oE7UKyeRo6p12sd0SHWlMy4HyieaG5EF4fDqFBQMJ9D473Ws1uxVf
	eV9i+WYO/4tXFlYhJS1zIuksu9BHouZj+Z/DhpSHP8WAR1zQ8s91N6yKa7ATIvAo
	3Tv5h6BtXjfw2klL5nhWse4lc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBHj+1AmDpq_zBUFQ--.34764S2;
	Tue, 23 Jun 2026 22:29:22 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: gbatra@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	kees@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>
Subject: [PATCH v2] powerpc/pseries/iommu: Add check for iommu_pseries_alloc_group()
Date: Tue, 23 Jun 2026 22:29:18 +0800
Message-Id: <20260623142918.2287696-1-haoxiang_li2024@163.com>
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
X-CM-TRANSID:_____wBHj+1AmDpq_zBUFQ--.34764S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJryUWFWruFyDXr1fWrykXwb_yoW8ZF15pF
	s8tFZrtF95Jry0vanava4jqw4xZw4vqrWrXw43Ka9YyasxXry8G3Z7XrySvrs7GFWDGF12
	yw4vqrn8Zrs3JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piMKZJUUUUU=
X-Originating-IP: [240e:604:311:e68d:298a:1bbc:177b:53c8]
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7gJfzWo6mEIYmQAA31

Add check for the return value of iommu_pseries_alloc_group()
to prevent potential null pointer dereferences.

Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
- Changes in v2:
  - Add check for other callsites. Thanks, Gaurav!
---
 arch/powerpc/platforms/pseries/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..d97bde96dd4d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -684,6 +684,9 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
 	pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+	if (!pci->table_group)
+		return;
+
 	tbl = pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
@@ -872,6 +875,9 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	if (!ppci->table_group) {
 		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
+		if (!ppci->table_group)
+			return;
+
 		tbl = ppci->table_group->tables[0];
 
 		iommu_table_setparms_common(tbl, ppci->phb->bus->number,
@@ -909,6 +915,9 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
 		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
+		if (!PCI_DN(dn)->table_group)
+			return;
+
 		tbl = PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
 
@@ -1875,6 +1884,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
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


