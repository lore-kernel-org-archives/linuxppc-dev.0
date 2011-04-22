Return-Path: <fweisbec@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97B18B6F41
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Apr 2011 23:16:39 +1000 (EST)
Received: by vxi40 with SMTP id 40so525524vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Apr 2011 06:16:35 -0700 (PDT)
From: Frederic Weisbecker <fweisbec@gmail.com>
To: LPPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/5] powerpc,
	hw_breakpoints: Fix racy access to ptrace breakpoints
Date: Fri, 22 Apr 2011 15:16:27 +0200
Message-Id: <1303478187-2367-1-git-send-email-fweisbec@gmail.com>
In-Reply-To: <1302284067-7860-4-git-send-email-fweisbec@gmail.com>
References: <1302284067-7860-4-git-send-email-fweisbec@gmail.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>,
	Prasad <prasad@linux.vnet.ibm.com>, "v2.6.33.." <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(resend with ppc list in cc)

While the tracer accesses ptrace breakpoints, the child task may
concurrently exit due to a SIGKILL and thus release its breakpoints
at the same time. We can then dereference some freed pointers.

To fix this, hold a reference on the child breakpoints before
manipulating them.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Prasad <prasad@linux.vnet.ibm.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: v2.6.33.. <stable@kernel.org>
---
 arch/powerpc/kernel/ptrace.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 55613e3..4edeeb3 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1591,7 +1591,10 @@ long arch_ptrace(struct task_struct *child, long request,
 	}
 
 	case PTRACE_SET_DEBUGREG:
+		if (ptrace_get_breakpoints(child) < 0)
+			return -ESRCH;
 		ret = ptrace_set_debugreg(child, addr, data);
+		ptrace_put_breakpoints(child);
 		break;
 
 #ifdef CONFIG_PPC64
-- 
1.7.3.2
