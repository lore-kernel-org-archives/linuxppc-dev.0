Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqBcd5Pq0zF1Mn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 04:23:13 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id z81so13251999wmb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Feb 2018 09:23:13 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH 19/21] powerpc: Add missing prototypes for
 hw_breakpoint_handler & arch_unregister_hw_breakpoint
Date: Sun, 25 Feb 2018 18:22:34 +0100
Message-Id: <20180225172236.29650-20-malat@debian.org>
In-Reply-To: <20180225172236.29650-1-malat@debian.org>
References: <20180225172236.29650-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 5aae8a537080 ("powerpc, hw_breakpoints: Implement hw_breakpoints
for 64-bit server processors") function hw_breakpoint_handler and
arch_unregister_hw_breakpoint were added without function prototypes in
hw_breakpoint.h header.

Fix the following warning(s) (treated as error in W=1):

  AR      init/built-in.o
arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for ‘arch_unregister_hw_breakpoint’ [-Werror=missing-prototypes]
 void arch_unregister_hw_breakpoint(struct perf_event *bp)
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/kernel/hw_breakpoint.c:209:5: error: no previous prototype for ‘hw_breakpoint_handler’ [-Werror=missing-prototypes]
 int hw_breakpoint_handler(struct die_args *args)
     ^~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/include/asm/hw_breakpoint.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index ac6432d9be46..90c708e5e7c4 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -66,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
+void arch_unregister_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 extern void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
 
@@ -82,6 +83,7 @@ static inline void hw_breakpoint_disable(void)
 	__set_breakpoint(&brk);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
+int hw_breakpoint_handler(struct die_args *args);
 
 #else	/* CONFIG_HAVE_HW_BREAKPOINT */
 static inline void hw_breakpoint_disable(void) { }
-- 
2.11.0
