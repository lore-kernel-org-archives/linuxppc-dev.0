Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGkvx1zmBzDrKC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 05:57:32 +1100 (AEDT)
Subject: [PATCH 2/2] powerpc-ps3: Improve a size determination in two functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <36a8ba41-7f1e-31f8-5d32-19e04393b181@users.sourceforge.net>
Message-ID: <caf62593-9a36-e73c-2224-9f61338f694d@users.sourceforge.net>
Date: Tue, 17 Oct 2017 20:56:53 +0200
MIME-Version: 1.0
In-Reply-To: <36a8ba41-7f1e-31f8-5d32-19e04393b181@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Oct 2017 20:15:17 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/powerpc/platforms/ps3/mm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index b0f34663b1ae..257de451e324 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -524,8 +524,7 @@ static int dma_sb_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 	int result;
 	struct dma_chunk *c;
 
-	c = kzalloc(sizeof(struct dma_chunk), GFP_ATOMIC);
-
+	c = kzalloc(sizeof(*c), GFP_ATOMIC);
 	if (!c) {
 		result = -ENOMEM;
 		goto fail_alloc;
@@ -570,8 +569,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 
 	DBG(KERN_ERR "%s: phy=%#lx, lpar%#lx, len=%#lx\n", __func__,
 	    phys_addr, ps3_mm_phys_to_lpar(phys_addr), len);
-	c = kzalloc(sizeof(struct dma_chunk), GFP_ATOMIC);
-
+	c = kzalloc(sizeof(*c), GFP_ATOMIC);
 	if (!c) {
 		result = -ENOMEM;
 		goto fail_alloc;
-- 
2.14.2
