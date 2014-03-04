Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Check that all cpu features are in the possible map
Date: Tue,  4 Mar 2014 13:44:39 +1100
Message-Id: <1393901079-25319-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpu_has_feature() has an optimisation where it maintains a map of
possible cpu features. This allows the compiler to determine at compile
time that some cpu_has_feature() checks will always return 0, and
therefore the code guarded by the check can be elided.

However we have no logic to check whether the set of cpu features in the
current cpu spec are in the possible map. Although that should never
happen, if it does things are likely to go badly. So add a check and
print a warning.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/cputable.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c8dd5d..eb31713 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2255,6 +2255,15 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 	}
 #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
 
+	/*
+	 * Check that all CPU features are in the possible mask. We don't want
+	 * to WARN() because we're called very early, and doing so will kill
+	 * the machine, so just printk() instead.
+	 */
+	if (t->cpu_features != (t->cpu_features & CPU_FTRS_POSSIBLE))
+		printk("WARNING: cpu spec contains impossible features! 0x%lx\n",
+			(t->cpu_features & ~CPU_FTRS_POSSIBLE));
+
 	return t;
 }
 
-- 
1.8.3.2
