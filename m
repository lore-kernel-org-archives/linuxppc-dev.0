Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 12/18] powerpc/mm: Remove uses of abs_to_virt() and
 virt_to_abs()
Date: Thu, 26 Jul 2012 17:19:58 +1000
Message-Id: <1343287204-7700-12-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These days they are just __va() and __pa() respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/stab.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 9106ebb..3f8efa6 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -20,7 +20,6 @@
 #include <asm/paca.h>
 #include <asm/cputable.h>
 #include <asm/prom.h>
-#include <asm/abs_addr.h>
 
 struct stab_entry {
 	unsigned long esid_data;
@@ -257,7 +256,7 @@ void __init stabs_alloc(void)
 		memset((void *)newstab, 0, HW_PAGE_SIZE);
 
 		paca[cpu].stab_addr = newstab;
-		paca[cpu].stab_real = virt_to_abs(newstab);
+		paca[cpu].stab_real = __pa(newstab);
 		printk(KERN_INFO "Segment table for CPU %d at 0x%llx "
 		       "virtual, 0x%llx absolute\n",
 		       cpu, paca[cpu].stab_addr, paca[cpu].stab_real);
-- 
1.7.9.5
