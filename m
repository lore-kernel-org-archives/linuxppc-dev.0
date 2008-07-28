Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 28 Jul 2008 10:13:14 -0500
Subject: [PATCH 1/3] powerpc: correctly hookup PTRACE_GET/SETVSRREGS for 32
	bit processes
In-Reply-To: <1217257994.262387.980049492980.qpush@coopers>
Message-Id: <20080728151314.8F05F700E2@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix bug where PTRACE_GET/SETVSRREGS are not connected for 32 bit processes.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/ptrace32.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
@@ -294,6 +294,8 @@ long compat_arch_ptrace(struct task_stru
 	case PTRACE_SETFPREGS:
 	case PTRACE_GETVRREGS:
 	case PTRACE_SETVRREGS:
+	case PTRACE_GETVSRREGS:
+	case PTRACE_SETVSRREGS:
 	case PTRACE_GETREGS64:
 	case PTRACE_SETREGS64:
 	case PPC_PTRACE_GETFPREGS:
