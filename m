Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93790C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:39:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0070206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0070206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vLdH5Tr7zF2HT
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 19:38:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42vLPs2hPwzF3Gq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 19:29:05 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 77867AE80215;
 Tue, 13 Nov 2018 03:29:01 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 10/22] powerpc/pseries/iommu: Use memory@ nodes in
 max RAM address calculation
Date: Tue, 13 Nov 2018 19:28:11 +1100
Message-Id: <20181113082823.2440-11-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181113082823.2440-1-aik@ozlabs.ru>
References: <20181113082823.2440-1-aik@ozlabs.ru>
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
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We might have memory@ nodes with "linux,usable-memory" set to zero
(for example, to replicate powernv's behaviour for GPU coherent memory)
which means that the memory needs an extra initialization but since
it can be used afterwards, the pseries platform will try mapping it
for DMA so the DMA window needs to cover those memory regions too.

This walks through the memory nodes to find the highest RAM address to
let a huge DMA window cover that too in case this memory gets onlined
later.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/pseries/iommu.c | 43 +++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 78473ac..f818737 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -967,6 +967,47 @@ struct failed_ddw_pdn {
 
 static LIST_HEAD(failed_ddw_pdn_list);
 
+static unsigned long read_n_cells(int n, const __be32 **buf)
+{
+	unsigned long result = 0;
+
+	while (n--) {
+		result = (result << 32) | of_read_number(*buf, 1);
+		(*buf)++;
+	}
+	return result;
+}
+
+static phys_addr_t ddw_memory_hotplug_max(void)
+{
+	phys_addr_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
+
+	for_each_node_by_type(memory, "memory") {
+		unsigned long start, size;
+		int ranges, n_mem_addr_cells, n_mem_size_cells, len;
+		const __be32 *memcell_buf;
+
+		memcell_buf = of_get_property(memory, "reg", &len);
+		if (!memcell_buf || len <= 0)
+			continue;
+
+		n_mem_addr_cells = of_n_addr_cells(memory);
+		n_mem_size_cells = of_n_size_cells(memory);
+
+		/* ranges in cell */
+		ranges = (len >> 2) / (n_mem_addr_cells + n_mem_size_cells);
+
+		/* these are order-sensitive, and modify the buffer pointer */
+		start = read_n_cells(n_mem_addr_cells, &memcell_buf);
+		size = read_n_cells(n_mem_size_cells, &memcell_buf);
+
+		max_addr = max_t(phys_addr_t, max_addr, start + size);
+	}
+
+	return max_addr;
+}
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -1067,7 +1108,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn,
 	}
 	/* verify the window * number of ptes will map the partition */
 	/* check largest block * page size > max memory hotplug addr */
-	max_addr = memory_hotplug_max();
+	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
 		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-- 
2.17.1

