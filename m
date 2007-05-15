Return-Path: <anton@ozlabs.org>
Date: Tue, 15 May 2007 14:59:06 -0500
From: Anton Blanchard <anton@samba.org>
To: paulus@samba.org
Subject: [PATCH] Reserve threadinfo flags for perfmon2
Message-ID: <20070515195906.GB14467@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kevcorry@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Reserve two TIF flags for perfmon2 and shift them into the low 16 bits
so we can use single assembly instructions to create constants based off
them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/include/asm-powerpc/thread_info.h b/include/asm-powerpc/thread_info.h
index 3f32ca8..9d9aeca 100644
--- a/include/asm-powerpc/thread_info.h
+++ b/include/asm-powerpc/thread_info.h
@@ -113,8 +113,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		5	/* 32 bit binary */
-#define TIF_RUNLATCH		6	/* Is the runlatch enabled? */
-#define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
+#define TIF_PERFMON_WORK	6	/* work for pfm_handle_work() */
+#define TIF_PERFMON_CTXSW	7	/* perfmon needs ctxsw calls */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
@@ -123,6 +123,8 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOERROR		14	/* Force successful syscall return */
 #define TIF_RESTORE_SIGMASK	15	/* Restore signal mask in do_signal */
 #define TIF_FREEZE		16	/* Freezing for suspend */
+#define TIF_RUNLATCH		17	/* Is the runlatch enabled? */
+#define TIF_ABI_PENDING		18	/* 32/64 bit switch needed */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -131,8 +133,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
-#define _TIF_RUNLATCH		(1<<TIF_RUNLATCH)
-#define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
+#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
@@ -140,6 +142,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
+#define _TIF_RUNLATCH		(1<<TIF_RUNLATCH)
+#define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
