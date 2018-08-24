Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xcd6206HzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 20:16:26 +1000 (AEST)
Message-Id: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of
 __ioremap(_PAGE_NO_CACHE)
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Aug 2018 10:16:22 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

_PAGE_NO_CACHE is a target specific flag. Prefer generic functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/video/fbdev/chipsfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index f103665cad43..48fbc22d6867 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -401,7 +401,7 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
 #ifdef CONFIG_PPC
-	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
+	p->screen_base = ioremap_wc(addr, 0x200000);
 #else
 	p->screen_base = ioremap(addr, 0x200000);
 #endif
-- 
2.13.3
