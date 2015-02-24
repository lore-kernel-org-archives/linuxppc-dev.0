Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71C9D1A0DC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 14:30:53 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, sam.bobroff@au1.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Russell King <linux@arm.linux.org.uk>, peterz@infradead.org,
 Don Zickus <dzickus@redhat.com>
Subject: [PATCH 7/7] powerpc: Serialise BUG and WARNs with
 die_spin_lock_{irqsave, irqrestore}
Date: Tue, 24 Feb 2015 14:30:34 +1100
Message-Id: <1424748634-9153-8-git-send-email-anton@samba.org>
In-Reply-To: <1424748634-9153-1-git-send-email-anton@samba.org>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
Cc: x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A simple kernel module was used to create concurrent WARNs and BUGs:

http://ozlabs.org/~anton/junkcode/warnstorm.tar.gz

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/traps.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 4cc1e72..f779557 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1114,6 +1114,39 @@ static int emulate_math(struct pt_regs *regs)
 static inline int emulate_math(struct pt_regs *regs) { return -1; }
 #endif
 
+static bool __report_bug(unsigned long bugaddr, struct pt_regs *regs)
+{
+	const struct bug_entry *bug;
+	unsigned long flags;
+	int err;
+
+	if (!is_valid_bugaddr(bugaddr))
+		return false;
+
+	bug = find_bug(bugaddr);
+	if (!bug)
+		return false;
+
+	if (is_warning_bug(bug)) {
+		die_spin_lock_irqsave(flags);
+		report_bug(bugaddr, regs);
+		die_spin_unlock_irqrestore(flags);
+
+		regs->nip += 4;
+
+		return true;
+	}
+
+	flags = oops_begin(regs);
+	report_bug(bugaddr, regs);
+	err = SIGTRAP;
+	if (__die("Exception in kernel mode", regs, err))
+		err = 0;
+	oops_end(flags, regs, err);
+
+	return true;
+}
+
 void __kprobes program_check_exception(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -1138,11 +1171,9 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 				== NOTIFY_STOP)
 			goto bail;
 
-		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
-		    report_bug(regs->nip, regs) == BUG_TRAP_TYPE_WARN) {
-			regs->nip += 4;
+		if (!user_mode(regs) && __report_bug(regs->nip, regs))
 			goto bail;
-		}
+
 		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 		goto bail;
 	}
@@ -1157,11 +1188,8 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 		 * -  A tend is illegally attempted.
 		 * -  writing a TM SPR when transactional.
 		 */
-		if (!user_mode(regs) &&
-		    report_bug(regs->nip, regs) == BUG_TRAP_TYPE_WARN) {
-			regs->nip += 4;
+		if (!user_mode(regs) && __report_bug(regs->nip, regs))
 			goto bail;
-		}
 		/* If usermode caused this, it's done something illegal and
 		 * gets a SIGILL slap on the wrist.  We call it an illegal
 		 * operand to distinguish from the instruction just being bad
-- 
2.1.0
