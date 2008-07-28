Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 28 Jul 2008 10:13:14 -0500
Subject: [PATCH 2/3] powerpc: fix ptrace buffer size for VSX
In-Reply-To: <1217257994.262387.980049492980.qpush@coopers>
Message-Id: <20080728151314.C06AA700E9@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix cut-and-paste error in the size setting for ptrace buffers for VSX.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/ptrace.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -913,15 +913,13 @@ long arch_ptrace(struct task_struct *chi
 	case PTRACE_GETVSRREGS:
 		return copy_regset_to_user(child, &user_ppc_native_view,
 					   REGSET_VSX,
-					   0, (32 * sizeof(vector128) +
-					       sizeof(u32)),
+					   0, 32 * sizeof(double),
 					   (void __user *) data);
 
 	case PTRACE_SETVSRREGS:
 		return copy_regset_from_user(child, &user_ppc_native_view,
 					     REGSET_VSX,
-					     0, (32 * sizeof(vector128) +
-						 sizeof(u32)),
+					     0, 32 * sizeof(double),
 					     (const void __user *) data);
 #endif
 #ifdef CONFIG_SPE
