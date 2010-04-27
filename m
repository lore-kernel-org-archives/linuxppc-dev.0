Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CBA4B7E2C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 07:11:25 +1000 (EST)
Message-Id: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
Subject: [patch 1/1] powerpc: add rcu_read_lock() to gup_fast() implementation
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Tue, 27 Apr 2010 14:10:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Cc: npiggin@suse.de, riel@redhat.com, a.p.zijlstra@chello.nl,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <a.p.zijlstra@chello.nl>

The powerpc page table freeing relies on the fact that IRQs hold off an
RCU grace period, this is currently true for all existing RCU
implementations but is not an assumption Paul wants to support.

Therefore, also take the RCU read lock along with disabling IRQs to ensure
the RCU grace period does at least cover these lookups.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Requested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Rik van Riel <riel@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/mm/gup.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN arch/powerpc/mm/gup.c~powerpc-add-rcu_read_lock-to-gup_fast-implementation arch/powerpc/mm/gup.c
--- a/arch/powerpc/mm/gup.c~powerpc-add-rcu_read_lock-to-gup_fast-implementation
+++ a/arch/powerpc/mm/gup.c
@@ -142,6 +142,7 @@ int get_user_pages_fast(unsigned long st
 	 * So long as we atomically load page table pointers versus teardown,
 	 * we can follow the address down to the the page and take a ref on it.
 	 */
+	rcu_read_lock();
 	local_irq_disable();
 
 	pgdp = pgd_offset(mm, addr);
@@ -162,6 +163,7 @@ int get_user_pages_fast(unsigned long st
 	} while (pgdp++, addr = next, addr != end);
 
 	local_irq_enable();
+	rcu_read_unlock();
 
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
@@ -171,6 +173,7 @@ int get_user_pages_fast(unsigned long st
 
 slow:
 		local_irq_enable();
+		rcu_read_unlock();
 slow_irqon:
 		pr_devel("  slow path ! nr = %d\n", nr);
 
_
