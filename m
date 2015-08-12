Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62D0C1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:08:59 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org,
	axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
 alex.williamson@redhat.com, grundler@parisc-linux.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Subject: [PATCH 04/31] x86/pci-nommu: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:23 +0200
Message-Id: <1439363150-8661-5-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Just remove a BUG_ON, the code handles them just fine as-is.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-nommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/pci-nommu.c b/arch/x86/kernel/pci-nommu.c
index da15918..a218059 100644
--- a/arch/x86/kernel/pci-nommu.c
+++ b/arch/x86/kernel/pci-nommu.c
@@ -63,7 +63,6 @@ static int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
 	WARN_ON(nents == 0 || sg[0].length == 0);
 
 	for_each_sg(sg, s, nents, i) {
-		BUG_ON(!sg_page(s));
 		s->dma_address = sg_phys(s);
 		if (!check_addr("map_sg", hwdev, s->dma_address, s->length))
 			return 0;
-- 
1.9.1
