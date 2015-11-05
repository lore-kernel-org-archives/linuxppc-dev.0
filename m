Return-Path: <amanieu@gmail.com>
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com
 [IPv6:2a00:1450:400c:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36A791A0C87
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 11:51:55 +1100 (AEDT)
Received: by wikq8 with SMTP id q8so835952wik.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2015 16:51:51 -0800 (PST)
From: Amanieu d'Antras <amanieu@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amanieu d'Antras <amanieu@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 13/20] powerpc: Use generic compat_siginfo_t
Date: Thu,  5 Nov 2015 00:50:32 +0000
Message-Id: <1446684640-4112-14-git-send-email-amanieu@gmail.com>
In-Reply-To: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
References: <1446684640-4112-1-git-send-email-amanieu@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
---
 arch/powerpc/include/asm/compat.h | 62 ++-------------------------------------
 1 file changed, 2 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index cdc8638..f0f8392 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -124,68 +124,10 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
-#define HAVE_ARCH_COMPAT_SIGINFO_T
-#define HAVE_ARCH_COPY_SIGINFO_TO_USER32
-#define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
 #define SI_PAD_SIZE32	(128/sizeof(int) - 3)
 
-typedef struct compat_siginfo {
-	int si_signo;
-	int si_errno;
-	int si_code;
-
-	union {
-		int _pad[SI_PAD_SIZE32];
-
-		/* kill() */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			__compat_uid_t _uid;		/* sender's uid */
-		} _kill;
-
-		/* POSIX.1b timers */
-		struct {
-			compat_timer_t _tid;		/* timer id */
-			int _overrun;			/* overrun count */
-			compat_sigval_t _sigval;	/* same as below */
-			int _sys_private;	/* not to be passed to user */
-		} _timer;
-
-		/* POSIX.1b signals */
-		struct {
-			compat_pid_t _pid;		/* sender's pid */
-			__compat_uid_t _uid;		/* sender's uid */
-			compat_sigval_t _sigval;
-		} _rt;
-
-		/* SIGCHLD */
-		struct {
-			compat_pid_t _pid;		/* which child */
-			__compat_uid_t _uid;		/* sender's uid */
-			int _status;			/* exit code */
-			compat_clock_t _utime;
-			compat_clock_t _stime;
-		} _sigchld;
-
-		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGEMT */
-		struct {
-			unsigned int _addr; /* faulting insn/memory ref. */
-		} _sigfault;
-
-		/* SIGPOLL */
-		struct {
-			int _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
-			int _fd;
-		} _sigpoll;
-
-		/* SIGSYS */
-		struct {
-			unsigned int _call_addr; /* calling insn */
-			int _syscall;		 /* triggering system call number */
-			unsigned int _arch;	 /* AUDIT_ARCH_* of syscall */
-		} _sigsys;
-	} _sifields;
-} compat_siginfo_t;
+#define HAVE_ARCH_COPY_SIGINFO_TO_USER32
+#define HAVE_ARCH_COPY_SIGINFO_FROM_USER32
 
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
-- 
2.6.2
