Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 2410D2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Sep 2013 19:40:04 +1000 (EST)
Received: from jacques.telenet-ops.be (jacques.telenet-ops.be [195.130.132.50])
 by wilson.telenet-ops.be (Postfix) with ESMTP id 4CC1D366AB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Sep 2013 11:40:00 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Make add_system_ram_resources() __init
Date: Sun, 15 Sep 2013 11:39:36 +0200
Message-Id: <1379237976-3241-1-git-send-email-geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add_system_ram_resources() is a subsys_initcall.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/powerpc/mm/mem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 1cf9c5b..25e0f26 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -498,7 +498,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
  * System memory should not be in /proc/iomem but various tools expect it
  * (eg kdump).
  */
-static int add_system_ram_resources(void)
+static int __init add_system_ram_resources(void)
 {
 	struct memblock_region *reg;
 
-- 
1.7.9.5
