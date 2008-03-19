Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id 89F91DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:18:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/8] alpha ptrace: forced_successful_syscall_return()
In-Reply-To: Roland McGrath's message of  Wednesday,
	19 March 2008 14:17:14 -0700
	<20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-Id: <20080319211841.253E126F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:18:41 -0700 (PDT)
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

Define the forced_successful_syscall_return() macro to
pair with our force_successful_syscall_return() definition.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 include/asm-alpha/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-alpha/ptrace.h b/include/asm-alpha/ptrace.h
index 32c7a5c..1cc330b 100644
--- a/include/asm-alpha/ptrace.h
+++ b/include/asm-alpha/ptrace.h
@@ -77,6 +77,7 @@ extern void show_regs(struct pt_regs *);
   ((struct pt_regs *) (task_stack_page(task) + 2*PAGE_SIZE) - 1)
 
 #define force_successful_syscall_return() (task_pt_regs(current)->r0 = 0)
+#define forced_successful_syscall_return() (task_pt_regs(current)->r0 == 0)
 
 #endif
 
