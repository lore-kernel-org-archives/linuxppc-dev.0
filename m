Return-Path: <roland@redhat.com>
Received: from QMTA06.emeryville.ca.mail.comcast.net
	(qmta06.emeryville.ca.mail.comcast.net [76.96.30.56])
	by ozlabs.org (Postfix) with ESMTP id B8AB5DE083
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 08:19:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/8] ia64 ptrace: forced_successful_syscall_return()
In-Reply-To: Roland McGrath's message of  Wednesday,
	19 March 2008 14:17:14 -0700
	<20080319211714.8B14226F995@magilla.localdomain>
References: <20080319211714.8B14226F995@magilla.localdomain>
Message-Id: <20080319211914.AFE0E26F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:19:14 -0700 (PDT)
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
 include/asm-ia64/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-ia64/ptrace.h b/include/asm-ia64/ptrace.h
index 4b2a8d4..5e82915 100644
--- a/include/asm-ia64/ptrace.h
+++ b/include/asm-ia64/ptrace.h
@@ -276,6 +276,7 @@ struct switch_stack {
    * On ia64, we can clear the user's pt_regs->r8 to force a successful syscall.
    */
 # define force_successful_syscall_return()	(task_pt_regs(current)->r8 = 0)
+# define forced_successful_syscall_return()	(task_pt_regs(current)->r8 == 0)
 
   struct task_struct;			/* forward decl */
   struct unw_frame_info;		/* forward decl */
