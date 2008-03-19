Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id 86CAADE0E2
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:17:54 +1100 (EST)
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/8] ptrace: forced_successful_syscall_return() macro
Message-Id: <20080319211714.8B14226F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:17:14 -0700 (PDT)
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

This adds the forced_successful_syscall_return() macro, a mate to
force_successful_syscall_return() to test rather than set the condition.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/linux/ptrace.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index ebe0c17..9272e63 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -124,8 +124,13 @@ int generic_ptrace_pokedata(struct task_struct *tsk, long addr, long data);
  * is a no-op and the spurious error condition needs to be filtered out by some
  * other means (e.g., in user-level, by passing an extra argument to the
  * syscall handler, or something along those lines).
+ *
+ * On architectures that define force_successful_syscall_return(),
+ * forced_successful_syscall_return() should also be defined.
+ * It returns nonzero if force_successful_syscall_return() was just used.
  */
 #define force_successful_syscall_return() do { } while (0)
+#define forced_successful_syscall_return() 0
 #endif
 
 /*
