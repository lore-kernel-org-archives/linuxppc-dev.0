Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 0D918DDF84
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:21:39 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQD00867ELWHS40@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 23 Oct 2007 09:20:20 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQD0044WELWN930@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Tue, 23 Oct 2007 09:20:20 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQD00JLHELVDN61@l-daemon> for linuxppc-dev@ozlabs.org;
	Tue, 23 Oct 2007 09:20:19 -0600 (MDT)
Date: Tue, 23 Oct 2007 09:20:25 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Bugfix to commit 18dabf473e15850c0dbc8ff13ac1e2806d542c15
To: linux-kernel@vger.kernel.org, Jens@secretlab.ca,
	"Axboe <jens.axboe"@oracle.com, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>, paulus@samba.org
Message-id: <20071023151929.12090.3835.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Fixup for commit 18dabf473e15850c0dbc8ff13ac1e2806d542c15.  Changes to
dma_map_sg where done in asm-x86/dma-mapping_32.h, but were not mirrored
in include/asm-powerpc/dma-mapping.h

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Linus, I cannot build an arch/powerpc kernel without this patch.

Cheers,
g.

 include/asm-powerpc/dma-mapping.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 65be95d..fd33ce4 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -285,9 +285,9 @@ dma_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	BUG_ON(direction == DMA_NONE);
 
 	for_each_sg(sgl, sg, nents, i) {
-		BUG_ON(!sg->page);
+		BUG_ON(!sg_page(sg));
 		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
-		sg->dma_address = page_to_bus(sg->page) + sg->offset;
+		sg->dma_address = sg_phys(sg);
 	}
 
 	return nents;
