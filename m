Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id 0CBA4DE375
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:20:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6/8] ptrace: arch_ptrace -ENOSYS return
In-Reply-To: Roland McGrath's message of  Wednesday,
	19 March 2008 14:17:14 -0700
	<20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-Id: <20080319212024.EA03126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:20:24 -0700 (PDT)
Cc: linux-arch@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	sparclinux@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The arch_ptrace and compat_arch_ptrace functions can now return
-ENOSYS for requests they do not actually implement in arch
code.  Returning -ENOSYS replaces the calls to ptrace_request
and compat_ptrace_request.  This leaves more latitude for the
machine-independent ptrace implementation code to change without
requiring any more updates in the arch code.

This change has no effect on the old arch code that still calls
ptrace_request or compat_ptrace_request.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 kernel/ptrace.c |   42 ++++++++++++++++++++++++++----------------
 1 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 67e392e..60b2b57 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -574,18 +574,21 @@ asmlinkage long sys_ptrace(long request, long pid, long addr, long data)
 		 */
 		if (!ret)
 			arch_ptrace_attach(child);
-		goto out_put_task_struct;
+	} else {
+		ret = ptrace_check_attach(child, request == PTRACE_KILL);
+		/*
+		 * Let the arch handler inspect it first.  It returns
+		 * -ENOSYS if this is not an arch-specific request.
+		 */
+		if (!ret) {
+			ret = arch_ptrace(child, request, addr, data);
+			if (ret == -ENOSYS &&
+			    !forced_successful_syscall_return())
+				ret = ptrace_request(child, request,
+						     addr, data);
+		}
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		goto out_put_task_struct;
-
-	ret = arch_ptrace(child, request, addr, data);
-	if (ret < 0)
-		goto out_put_task_struct;
-
- out_put_task_struct:
 	put_task_struct(child);
  out:
 	unlock_kernel();
@@ -697,14 +700,21 @@ asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
 		 */
 		if (!ret)
 			arch_ptrace_attach(child);
-		goto out_put_task_struct;
+	} else {
+		ret = ptrace_check_attach(child, request == PTRACE_KILL);
+		/*
+		 * Let the arch handler inspect it first.  It returns
+		 * -ENOSYS if this is not an arch-specific request.
+		 */
+		if (!ret) {
+			ret = compat_arch_ptrace(child, request, addr, data);
+			if (ret == -ENOSYS &&
+			    !forced_successful_syscall_return())
+				ret = compat_ptrace_request(child, request,
+							    addr, data);
+		}
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (!ret)
-		ret = compat_arch_ptrace(child, request, addr, data);
-
- out_put_task_struct:
 	put_task_struct(child);
  out:
 	unlock_kernel();
