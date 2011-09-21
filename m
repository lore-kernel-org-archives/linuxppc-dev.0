Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp01.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7B8F6B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Sep 2011 23:06:37 +1000 (EST)
Received: from mailhub3.br.ibm.com (mailhub3.br.ibm.com [9.18.232.110])
	by e24smtp01.br.ibm.com (8.14.4/8.13.1) with ESMTP id p8LEOGx8032648
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2011 10:24:16 -0400
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8LD9aST954524
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2011 10:09:42 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8LD6JiU022677
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2011 10:06:19 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2] powerpc: reserve iommu page 0
Date: Wed, 21 Sep 2011 10:06:12 -0300
Message-Id: <1316610372-5795-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: alexander.h.duyck@intel.com, nhorman@redhat.com,
	linux-kernel@vger.kernel.org, jesse.brandeburg@intel.com,
	Paul Mackerras <paulus@samba.org>,
	Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some devices have a dma-window that starts at the address 0. This allows
DMA addresses to be mapped to this address and returned to drivers as a
valid DMA address. Some drivers may not behave well in this case, since
the address 0 is considered an error or not allocated.

The solution to avoid this kind of error from happening is reserve the
page addressed as 0 so it cannot be allocated for a DMA mapping.

Ben Herrenschmidt deserves the credit for this patch. He pointed out the
solution and what code would do the job.

v2:
Add a comment in the code.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---

Resending, since it was recommended to add a comment about this
particular code.

---
 arch/powerpc/kernel/iommu.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 961bb03..8395301 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -501,6 +501,14 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	tbl->it_map = page_address(page);
 	memset(tbl->it_map, 0, sz);
 
+	/*
+	 * Reserve page 0 so it will not be used for any mappings.
+	 * This avoids buggy drivers that consider page 0 to be invalid
+	 * to crash the machine or even lose data.
+	*/
+	if (tbl->it_offset == 0)
+		set_bit(0, tbl->it_map);
+		
 	tbl->it_hint = 0;
 	tbl->it_largehint = tbl->it_halfpoint;
 	spin_lock_init(&tbl->it_lock);
-- 
1.7.4.4
