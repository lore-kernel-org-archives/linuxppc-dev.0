Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4Xp1bX7zDrVV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:58:01 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/24] powerpc/mm: Fix reporting of kernel execute faults
Date: Wed, 19 Jul 2017 14:49:34 +1000
Message-Id: <20170719044946.22030-12-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We currently test for is_exec and DSISR_PROTFAULT but that doesn't
make sense as this is the wrong error bit to test for an execute
permission failure.

In fact, we had code that would return early if we had an exec
fault in kernel mode so I think that was just dead code anyway.

Finally the location of that test is awkward and prevents further
simplifications.

So instead move that test into a helper along with the existing
early test for kernel exec faults and out of range accesses,
and put it all in a "bad_kernel_fault()" helper. While at it
test the correct error bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e8d6acc888c5..aead07cf8a5b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -180,6 +180,20 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 	return MM_FAULT_CONTINUE;
 }
 
+/* Is this a bad kernel fault ? */
+static bool bad_kernel_fault(bool is_exec, unsigned long error_code,
+			     unsigned long address)
+{
+	if (is_exec && (error_code & (DSISR_NOEXEC_OR_G | DSISR_KEYFAULT))) {
+		printk_ratelimited(KERN_CRIT "kernel tried to execute"
+				   " exec-protected page (%lx) -"
+				   "exploit attempt? (uid: %d)\n",
+				   address, from_kuid(&init_user_ns,
+						      current_uid()));
+	}
+	return is_exec || (address >= TASK_SIZE);
+}
+
 /*
  * Define the correct "is_write" bit in error_code based
  * on the processor family
@@ -252,7 +266,7 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
 	 */
-	if (!is_user && (is_exec || (address >= TASK_SIZE)))
+	if (unlikely(!is_user && bad_kernel_fault(is_exec, error_code, address)))
 		return SIGSEGV;
 
 	/* We restore the interrupt state now */
@@ -491,11 +505,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return 0;
 	}
 
-	if (is_exec && (error_code & DSISR_PROTFAULT))
-		printk_ratelimited(KERN_CRIT "kernel tried to execute NX-protected"
-				   " page (%lx) - exploit attempt? (uid: %d)\n",
-				   address, from_kuid(&init_user_ns, current_uid()));
-
 	return SIGSEGV;
 }
 NOKPROBE_SYMBOL(__do_page_fault);
-- 
2.13.3
