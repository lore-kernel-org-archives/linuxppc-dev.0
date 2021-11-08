Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31C1C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 04:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA1F60EE0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 04:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBA1F60EE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hnctn3mKsz3cQj
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Nov 2021 15:04:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=107.174.27.60; helo=ozlabs.ru;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Received: from ozlabs.ru (unknown [107.174.27.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Hncsv6WPqz2yNK
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Nov 2021 15:03:31 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 7053C80C59;
 Sun,  7 Nov 2021 23:03:28 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel 1/3] powerpc/pseries/ddw: Revert "Extend upper limit
 for huge DMA window for persistent memory"
Date: Mon,  8 Nov 2021 15:03:17 +1100
Message-Id: <20211108040320.3857636-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211108040320.3857636-1-aik@ozlabs.ru>
References: <20211108040320.3857636-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Leonardo Bras <leobras.c@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts commit 54fc3c681ded9437e4548e2501dc1136b23cfa9a
which does not allow 1:1 mapping even for the system RAM which
is usually possible.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 49b401536d29..64385d6f33c2 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1094,15 +1094,6 @@ static phys_addr_t ddw_memory_hotplug_max(void)
 	phys_addr_t max_addr = memory_hotplug_max();
 	struct device_node *memory;
 
-	/*
-	 * The "ibm,pmemory" can appear anywhere in the address space.
-	 * Assuming it is still backed by page structs, set the upper limit
-	 * for the huge DMA window as MAX_PHYSMEM_BITS.
-	 */
-	if (of_find_node_by_type(NULL, "ibm,pmemory"))
-		return (sizeof(phys_addr_t) * 8 <= MAX_PHYSMEM_BITS) ?
-			(phys_addr_t) -1 : (1ULL << MAX_PHYSMEM_BITS);
-
 	for_each_node_by_type(memory, "memory") {
 		unsigned long start, size;
 		int n_mem_addr_cells, n_mem_size_cells, len;
-- 
2.30.2

