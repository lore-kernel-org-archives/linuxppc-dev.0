Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp03.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE834B71C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Sep 2011 23:07:48 +1000 (EST)
Received: from /spool/local by br.ibm.com with XMail ESMTP
	for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
	Tue, 20 Sep 2011 10:07:39 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8KD6kqg3203242
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2011 10:06:46 -0300
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
	by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8KD7M9j009385
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2011 10:07:23 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: reserve iommu page 0
Date: Tue, 20 Sep 2011 10:07:24 -0300
Message-Id: <1316524044-5260-1-git-send-email-cascardo@linux.vnet.ibm.com>
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

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/kernel/iommu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 961bb03..53411bc 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -501,6 +501,9 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	tbl->it_map = page_address(page);
 	memset(tbl->it_map, 0, sz);
 
+	if (tbl->it_offset == 0)
+		set_bit(0, tbl->it_map);
+		
 	tbl->it_hint = 0;
 	tbl->it_largehint = tbl->it_halfpoint;
 	spin_lock_init(&tbl->it_lock);
-- 
1.7.4.4
