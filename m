Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27F1D1A042E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 13:48:10 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id yy13so21968316pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:48:10 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [RESEND][PATCH] Fix BUG_ON() reporting in real mode on PPC
Date: Thu, 18 Feb 2016 13:48:01 +1100
Message-Id: <1455763681-13663-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changelog:
    Don't use REGION_ID, breaks on some platforms
    Don't blindly add PAGE_OFFSET to bugaddr

I ran into this issue while debugging an early boot problem.
The system hit a BUG_ON() but report bug failed to print the
line number and file name. The reason being that the system
was running in real mode and report_bug() searches for
addresses in the PAGE_OFFSET+ region

Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/traps.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b6becc7..4e5c11d 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1148,6 +1148,7 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 		goto bail;
 	}
 	if (reason & REASON_TRAP) {
+		unsigned long bugaddr;
 		/* Debugger is first in line to stop recursive faults in
 		 * rcu_lock, notify_die, or atomic_notifier_call_chain */
 		if (debugger_bpt(regs))
@@ -1158,8 +1159,15 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 				== NOTIFY_STOP)
 			goto bail;
 
+		bugaddr = regs->nip;
+		/*
+		 * Fixup bugaddr for BUG_ON() in real mode
+		 */
+		if (!is_kernel_addr(bugaddr) && !(regs->msr & MSR_IR))
+			bugaddr += PAGE_OFFSET;
+
 		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
-		    report_bug(regs->nip, regs) == BUG_TRAP_TYPE_WARN) {
+		    report_bug(bugaddr, regs) == BUG_TRAP_TYPE_WARN) {
 			regs->nip += 4;
 			goto bail;
 		}
-- 
2.5.0
