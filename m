Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 58CA12C00A1
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Nov 2013 15:01:58 +1100 (EST)
Message-ID: <1384401703.3806.12.camel@pasglop>
Subject: [PATCH] powerpc: fix __get_user_pages_fast() irq handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Thu, 14 Nov 2013 15:01:43 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

__get_user_pages_fast() may be called with interrupts disabled (see e.g.
get_futex_key() in kernel/futex.c) and therefore should use local_irq_save()
and local_irq_restore() instead of local_irq_disable()/enable().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

(Was originally sent to lkml only, sending to linuxppc-dev so patchwork gets it)

 arch/powerpc/mm/gup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/gup.c b/arch/powerpc/mm/gup.c
index 6936547..c5f734e 100644
--- a/arch/powerpc/mm/gup.c
+++ b/arch/powerpc/mm/gup.c
@@ -123,6 +123,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr, len, end;
 	unsigned long next;
+	unsigned long flags;
 	pgd_t *pgdp;
 	int nr = 0;
 
@@ -156,7 +157,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * So long as we atomically load page table pointers versus teardown,
 	 * we can follow the address down to the the page and take a ref on it.
 	 */
-	local_irq_disable();
+	local_irq_save(flags);
 
 	pgdp = pgd_offset(mm, addr);
 	do {
@@ -179,7 +180,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			break;
 	} while (pgdp++, addr = next, addr != end);
 
-	local_irq_enable();
+	local_irq_restore(flags);
 
 	return nr;
 }
-- 
1.8.3.4

