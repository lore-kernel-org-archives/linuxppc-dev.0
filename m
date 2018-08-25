Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41yLGN13c4zDqws
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2018 00:32:43 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND 3/3] drivers/block/z2ram: use ioremap_wt() instead of
 __ioremap(_PAGE_WRITETHRU)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180825142702.77FD7104918@pc16082vm.idsi0.si.c-s.fr>
Date: Sat, 25 Aug 2018 16:27:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_PAGE_WRITETHRU is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/block/z2ram.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index d0c5bc4e0703..cfbd70520eeb 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -190,8 +190,7 @@ static int z2_open(struct block_device *bdev, fmode_t mode)
 			vfree(vmalloc (size));
 		}
 
-		vaddr = (unsigned long) __ioremap (paddr, size, 
-						   _PAGE_WRITETHRU);
+		vaddr = (unsigned long)ioremap_wt(paddr, size);
 
 #else
 		vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);
-- 
2.17.1
