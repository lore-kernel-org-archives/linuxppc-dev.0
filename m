Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 29AA61A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 11:20:22 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id e127so20304079pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 16:20:22 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [RESEND][PATCH] Fix BUG_ON() reporting in real mode on PPC
Date: Thu, 18 Feb 2016 11:20:04 +1100
Message-Id: <1455754804-16459-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resending to remove whitespace issues created by email client

Changelog:
    Don't add PAGE_OFFSET blindly, check if REGION_ID is 0

I ran into this issue while debugging an early boot problem.
The system hit a BUG_ON() but report bug failed to print the
line number and file name. The reason being that the system
was running in real mode and report_bug() searches for
addresses in the PAGE_OFFSET+ region

Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/traps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b6becc7..4de4fe7 100644
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
@@ -1158,8 +1159,12 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 				== NOTIFY_STOP)
 			goto bail;
 
+		bugaddr = regs->nip;
+		if ((REGION_ID(bugaddr) == 0) && !(regs->msr & MSR_IR))
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
