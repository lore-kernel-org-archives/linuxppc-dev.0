Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F64B1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:24 +1000 (AEST)
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
Subject: [PATCH 13/31] sparc/ldc: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:32 +0200
Message-Id: <1439363150-8661-14-git-send-email-hch@lst.de>
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

Use

    sg_phys(sg) & PAGE_MASK

instead of

    page_to_pfn(sg_page(sg)) << PAGE_SHIFT

to get at the page-aligned physical address ofa SG entry, so that
we don't require a page backing for SG entries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/ldc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 1ae5eb1..0a29974 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -2051,7 +2051,7 @@ static void fill_cookies(struct cookie_state *sp, unsigned long pa,
 
 static int sg_count_one(struct scatterlist *sg)
 {
-	unsigned long base = page_to_pfn(sg_page(sg)) << PAGE_SHIFT;
+	unsigned long base = sg_phys(sg) & PAGE_MASK;
 	long len = sg->length;
 
 	if ((sg->offset | len) & (8UL - 1))
@@ -2114,7 +2114,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 	state.nc = 0;
 
 	for_each_sg(sg, s, num_sg, i) {
-		fill_cookies(&state, page_to_pfn(sg_page(s)) << PAGE_SHIFT,
+		fill_cookies(&state, sg_phys(s) & PAGE_MASK,
 			     s->offset, s->length);
 	}
 
-- 
1.9.1
