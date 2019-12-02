Return-Path: <SRS0=Td3a=ZY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDC8C432C3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 02:11:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11781206E4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 02:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11781206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47R7sK1qTyzDqRL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Dec 2019 13:11:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
X-Greylist: delayed 579 seconds by postgrey-1.36 at bilbo;
 Mon, 02 Dec 2019 13:09:38 AEDT
Received: from ozlabs.ru (unknown [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 47R7pq0XB8zDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2019 13:09:38 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A286BAE807DF;
 Sun,  1 Dec 2019 20:58:58 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 2/4] powerpc/powernv/ioda: Allow smaller TCE table
 levels
Date: Mon,  2 Dec 2019 12:59:51 +1100
Message-Id: <20191202015953.127902-3-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202015953.127902-1-aik@ozlabs.ru>
References: <20191202015953.127902-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now the minimum allocation size for a TCE table level is PAGE_SIZE (64k)
as this is the minimum for alloc_pages(). The limit was set in POWER8
where we did not have sparse RAM so we did not need sparse TCE tables.
On POWER9 we have gaps in the phys address space for which using multi
level TCE tables makes sense. The problem with that is that 64K per level
is too much for 2 levels and 1GB pages as it exceeds the hardware limit
of 55bits so we need smaller levels.

This drops the minimum level size to 4K.

For a machine with 2 CPUs, top RAM address 0x4000.0000.0000
(each node gets 32TiB) and 1GiB IOMMU pages:
Before the patch: 512KiB or 8 pages.
After the patch: 3 pages: one level1 + 2xlevel2 tables, each can map
up to 64k>>3<<30 = 8TiB of physical space.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index a0b9c0c23ed2..f9931a5aebe4 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -37,7 +37,7 @@ static __be64 *pnv_alloc_tce_level(int nid, unsigned int shift)
 	__be64 *addr;
 
 	tce_mem = alloc_pages_node(nid, GFP_ATOMIC | __GFP_NOWARN,
-			shift - PAGE_SHIFT);
+			shift > PAGE_SHIFT ? shift - PAGE_SHIFT : 0);
 	if (!tce_mem) {
 		pr_err("Failed to allocate a TCE memory, level shift=%d\n",
 				shift);
@@ -282,7 +282,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 	/* Adjust direct table size from window_size and levels */
 	entries_shift = (entries_shift + levels - 1) / levels;
 	level_shift = entries_shift + 3;
-	level_shift = max_t(unsigned int, level_shift, PAGE_SHIFT);
+	level_shift = max_t(unsigned int, level_shift, 12); /* 4K is minimum */
 
 	if ((level_shift - 3) * levels + page_shift >= 55)
 		return -EINVAL;
-- 
2.17.1

