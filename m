Return-Path: <anton@samba.org>
Date: Sun, 20 Oct 2013 10:26:20 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc/pseries: Fix dedicated processor partition detection
Message-ID: <20131020102620.700282d5@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


commit f13c13a00512 (powerpc: Stop using non-architected shared_proc
field in lppaca) fixed a potential issue with shared/dedicated
partition detection. The old method of detection relied on an
unarchitected field (shared_proc), and this patch switched
to using something architected (a non zero yield_count).

Unfortunately the assertion in the Linux header that yield_count
is only non zero on shared processor partitions is not true. It
turns out dedicated processor partitions can increment yield_count
and as such we falsely detect dedicated partitions as shared.

Fix the comment, and switch back to using the old method.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/lppaca.h
===================================================================
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -84,8 +84,8 @@ struct lppaca {
 	 * the processor is yielded (either because of an OS yield or a
 	 * hypervisor preempt).  An even value implies that the processor is
 	 * currently executing.
-	 * NOTE: This value will ALWAYS be zero for dedicated processors and
-	 * will NEVER be zero for shared processors (ie, initialized to a 1).
+	 * NOTE: Even dedicated processor partitions can yield so this
+	 * field cannot be used to determine if we are shared or dedicated.
 	 */
 	volatile __be32 yield_count;
 	volatile __be32 dispersion_count; /* dispatch changed physical cpu */
@@ -106,15 +106,15 @@ extern struct lppaca lppaca[];
 #define lppaca_of(cpu)	(*paca[cpu].lppaca_ptr)
 
 /*
- * Old kernels used a reserved bit in the VPA to determine if it was running
- * in shared processor mode. New kernels look for a non zero yield count
- * but KVM still needs to set the bit to keep the old stuff happy.
+ * We are using a non architected field to determine if a partition is
+ * shared or dedicated. This currently works on both KVM and PHYP, but
+ * we will have to transition to something better.
  */
 #define LPPACA_OLD_SHARED_PROC		2
 
 static inline bool lppaca_shared_proc(struct lppaca *l)
 {
-	return l->yield_count != 0;
+	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
 /*
