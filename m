Return-Path: <roland@redhat.com>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [204.127.192.84])
	by ozlabs.org (Postfix) with ESMTP id C5726DDEC9
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 10:00:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: FULL_REGS on exec
Message-Id: <20070924235244.2F3BB4D04B7@magilla.localdomain>
Date: Mon, 24 Sep 2007 16:52:44 -0700 (PDT)
Cc: David Woodhouse <dwmw2@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


When PTRACE_O_TRACEEXEC is used, a ptrace call to fetch the registers at
the PTRACE_EVENT_EXEC stop (PTRACE_PEEKUSR) will oops in CHECK_FULL_REGS.
With recent versions, "gdb --args /bin/sh -c 'exec /bin/true'" and "run" at
the (gdb) prompt is sufficient to produce this.  I also have written an
isolated test case, see https://bugzilla.redhat.com/show_bug.cgi?id=301791#c15.

This change fixes the problem by clearing the low bit of pt_regs.trap in
start_thread so that FULL_REGS is true again.  This is correct since all of
the GPRs that "full" refers to are cleared in start_thread.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/process.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e477c9d..fd799d2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -605,6 +605,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	regs->ccr = 0;
 	regs->gpr[1] = sp;
 
+	/*
+	 * We have just cleared all the nonvolatile GPRs, so make
+	 * FULL_REGS(regs) return true.  This is necessary to allow
+	 * ptrace to examine the thread immediately after exec.
+	 */
+	regs->trap &= ~1UL;
+
 #ifdef CONFIG_PPC32
 	regs->mq = 0;
 	regs->nip = start;
