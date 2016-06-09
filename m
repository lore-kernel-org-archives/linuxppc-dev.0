Return-Path: <keescook@chromium.org>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQd6Y3bt9zDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 07:02:29 +1000 (AEST)
Received: by mail-pa0-x22e.google.com with SMTP id ec8so16603064pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jun 2016 14:02:29 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 James Hogan <james.hogan@imgtec.com>, Jeff Dike <jdike@addtoit.com>,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 "Maciej W. Rozycki" <macro@imgtec.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>,
 user-mode-linux-devel@lists.sourceforge.net,
 Will Deacon <will.deacon@arm.com>, x86@kernel.org
Subject: [PATCH 05/14] seccomp: recheck the syscall after RET_TRACE
Date: Thu,  9 Jun 2016 14:01:55 -0700
Message-Id: <1465506124-21866-6-git-send-email-keescook@chromium.org>
In-Reply-To: <1465506124-21866-1-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When RET_TRACE triggers, a tracer may change a syscall into something that
should be filtered by seccomp. This re-runs seccomp after a trace event
to make sure things continue to pass.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 kernel/seccomp.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 14a37d71b612..54d15eb2b701 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -556,7 +556,8 @@ void secure_computing_strict(int this_syscall)
 #else
 
 #ifdef CONFIG_SECCOMP_FILTER
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
 	int data;
@@ -588,6 +589,10 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		goto skip;
 
 	case SECCOMP_RET_TRACE:
+		/* We've been put in this state by the ptracer already. */
+		if (recheck_after_trace)
+			return 0;
+
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
 			syscall_set_return_value(current,
@@ -611,6 +616,15 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
 		if (this_syscall < 0)
 			goto skip;
 
+		/*
+		 * Recheck the syscall, since it may have changed. This
+		 * intentionally uses a NULL struct seccomp_data to force
+		 * a reload of all registers. This does not goto skip since
+		 * a skip would have already been reported.
+		 */
+		if (__seccomp_filter(this_syscall, NULL, true))
+			return -1;
+
 		return 0;
 
 	case SECCOMP_RET_ALLOW:
@@ -629,7 +643,8 @@ skip:
 	return -1;
 }
 #else
-static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd)
+static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
+			    const bool recheck_after_trace)
 {
 	BUG();
 }
@@ -652,7 +667,7 @@ int __secure_computing(const struct seccomp_data *sd)
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
 		return 0;
 	case SECCOMP_MODE_FILTER:
-		return __seccomp_filter(this_syscall, sd);
+		return __seccomp_filter(this_syscall, sd, false);
 	default:
 		BUG();
 	}
-- 
2.7.4
