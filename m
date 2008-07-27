Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E5AC9DDFB9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 02:22:14 +1000 (EST)
Date: Mon, 28 Jul 2008 02:22:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH] powerpc/vio: more fallout from dma_mapping_error API change
Message-Id: <20080728022214.5b97a39b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, FUJITA
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/kernel/vio.c:533: error: too few arguments to function 'dma_mapping_error'

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Compile tested for ppc64_defconfig.

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index ade8aea..49a166d 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -530,7 +530,7 @@ static dma_addr_t vio_dma_iommu_map_single(struct device *dev, void *vaddr,
 	}
 
 	ret = dma_iommu_ops.map_single(dev, vaddr, size, direction, attrs);
-	if (unlikely(dma_mapping_error(ret))) {
+	if (unlikely(dma_mapping_error(dev, ret))) {
 		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
 		atomic_inc(&viodev->cmo.allocs_failed);
 	}
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
