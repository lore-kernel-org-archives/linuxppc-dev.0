Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Mon, 28 Jul 2008 10:13:14 -0500
Subject: [PATCH 3/3] powerpc: fix setting the wrong thread_struct for ptrace
	get/set VSX regs
In-Reply-To: <1217257994.262387.980049492980.qpush@coopers>
Message-Id: <20080728151314.C62D6700EB@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In PTRACE_GET/SETVSRREGS, we should be using the thread we are
ptracing rather than current.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/ptrace.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -374,7 +374,7 @@ static int vsr_get(struct task_struct *t
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
-		buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
+		buf[i] = target->thread.fpr[i][TS_VSRLOWOFFSET];
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
@@ -393,7 +393,7 @@ static int vsr_set(struct task_struct *t
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 buf, 0, 32 * sizeof(double));
 	for (i = 0; i < 32 ; i++)
-		current->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+		target->thread.fpr[i][TS_VSRLOWOFFSET] = buf[i];
 
 
 	return ret;
