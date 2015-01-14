Return-Path: <geert@linux-m68k.org>
Received: from winston.telenet-ops.be (winston.telenet-ops.be [195.130.137.75])
 by lists.ozlabs.org (Postfix) with ESMTP id 69DF61A0C78
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 01:04:32 +1100 (AEDT)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
 by winston.telenet-ops.be (Postfix) with ESMTP id 98FE71BE0F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 14:51:59 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
 Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/3] powerpc/pmac: Fix DT refcount imbalance in
 pmac_pic_probe_oldstyle
Date: Wed, 14 Jan 2015 14:51:57 +0100
Message-Id: <1421243519-6257-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421243519-6257-1-git-send-email-geert+renesas@glider.be>
References: <1421243519-6257-1-git-send-email-geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_find_node_by_name() calls of_node_put() on its "from" parameter,
which must not be done on "master", as it's still in use, and will be
released manually later.  This may cause a zero kref refcount.
Use of_get_child_by_name() instead to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linuxppc-dev@lists.ozlabs.org
---
Compile-tested only
---
 arch/powerpc/platforms/powermac/pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4c24bf60d39d2834..90ada1209c118902 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -321,7 +321,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 		max_irqs = max_real_irqs = 64;
 
 		/* We might have a second cascaded heathrow */
-		slave = of_find_node_by_name(master, "mac-io");
+		slave = of_get_child_by_name(master, "mac-io");
 
 		/* Check ordering of master & slave */
 		if (of_device_is_compatible(master, "gatwick")) {
-- 
1.9.1
