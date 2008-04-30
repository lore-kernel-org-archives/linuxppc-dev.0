Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b9d0702fda100e5a3a09ec258f7b6f701f9985e1.1209525676.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Make emergency stack safe for current_thread_info() use
Date: Wed, 30 Apr 2008 13:21:45 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The current_thread_info() macro, used by preempt_count(), assumes the
stack is THREAD_SIZE aligned. It should probably also be THREAD_SIZE
in size.

The emergency stack currently isn't either of these things, which could
potentially cause problems anytime we're running on the emergency
stack. That includes when we detect a bad kernel stack pointer, and also
during early_setup_secondary().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---
Booted on P6 LPAR and QS21.


 arch/powerpc/kernel/setup_64.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index dff6308..25e3fd8 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -487,9 +487,12 @@ static void __init emergency_stack_init(void)
 	 */
 	limit = min(0x10000000UL, lmb.rmo_size);
 
-	for_each_possible_cpu(i)
-		paca[i].emergency_sp =
-		__va(lmb_alloc_base(HW_PAGE_SIZE, 128, limit)) + HW_PAGE_SIZE;
+	for_each_possible_cpu(i) {
+		unsigned long sp;
+		sp  = lmb_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
+		sp += THREAD_SIZE;
+		paca[i].emergency_sp = __va(sp);
+	}
 }
 
 /*
-- 
1.5.5
