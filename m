Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH 4/8] 44x: Removing dead CONFIG_PPC47x
Date: Thu,  1 Dec 2011 18:39:20 +1100
Message-Id: <1322725164-4391-5-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christoph Egger <siccegge@cs.fau.de>

CONFIG_PPC47x doesn't exist in Kconfig and no 476 processor calls this
function ppc44x_pin_tlb() as it has it's own ppc47x_pin_tlb().

This code is probably an artifact of the original 476 code that
shouldn't have made it upstream.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/44x_mmu.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
index f60e006..5d4e3ff 100644
--- a/arch/powerpc/mm/44x_mmu.c
+++ b/arch/powerpc/mm/44x_mmu.c
@@ -78,11 +78,7 @@ static void __init ppc44x_pin_tlb(unsigned int virt, unsigned int phys)
 		"tlbwe	%1,%3,%5\n"
 		"tlbwe	%0,%3,%6\n"
 	:
-#ifdef CONFIG_PPC47x
-	: "r" (PPC47x_TLB2_S_RWX),
-#else
 	: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_TLB_G),
-#endif
 	  "r" (phys),
 	  "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
 	  "r" (entry),
-- 
1.7.6.4
