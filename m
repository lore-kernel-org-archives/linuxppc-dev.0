Return-Path: <paulus@samba.org>
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: Reclaim two unused thread_info flag bits
Date: Mon, 13 Jan 2014 15:56:28 +1100
Message-Id: <1389588990-25953-2-git-send-email-paulus@samba.org>
In-Reply-To: <1389588990-25953-1-git-send-email-paulus@samba.org>
References: <1389588990-25953-1-git-send-email-paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TIF_PERFMON_WORK and TIF_PERFMON_CTXSW are completely unused.  They
appear to be related to the old perfmon2 code, which has been
superseded by the perf_event infrastructure.  This removes their
definitions so that the bits can be used for other purposes.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/thread_info.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 9854c56..fc2bf41 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -91,8 +91,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_POLLING_NRFLAG	3	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
 #define TIF_32BIT		4	/* 32 bit binary */
-#define TIF_PERFMON_WORK	5	/* work for pfm_handle_work() */
-#define TIF_PERFMON_CTXSW	6	/* perfmon needs ctxsw calls */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SINGLESTEP		8	/* singlestepping active */
 #define TIF_NOHZ		9	/* in adaptive nohz mode */
@@ -115,8 +113,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
-#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
-#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
-- 
1.8.4.2
