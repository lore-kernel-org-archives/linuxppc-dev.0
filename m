Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:39 +1000
Subject: [PATCH 5/21] powerpc: Disable broken PPC_PTRACE_GETFPREGS on 32 bits
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051545.7EF17DDEF6@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The handling of PPC_PTRACE_GETFPREGS is broken on 32 bits kernel,
it will only return half of the registers. Since that call didn't
initially exist for 32 bits kernel (added recently), rather than
fixing it, let's just remove it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-29 11:34:20.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-29 11:34:35.000000000 +1000
@@ -434,6 +434,7 @@ long arch_ptrace(struct task_struct *chi
 		break;
 	}
 
+#ifdef CONFIG_PPC64
 	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
@@ -467,6 +468,7 @@ long arch_ptrace(struct task_struct *chi
 		}
 		break;
 	}
+#endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_ALTIVEC
 	case PTRACE_GETVRREGS:
