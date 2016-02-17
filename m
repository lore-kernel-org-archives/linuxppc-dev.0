Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D247D1A358C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 15:43:18 +1100 (AEDT)
Received: by mail-pf0-x230.google.com with SMTP id q63so4286449pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:43:18 -0800 (PST)
Message-ID: <1455684191.3089.3.camel@gmail.com>
Subject: Fix BUG_ON() reporting in real mode on powerpc
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@samba.org>
Date: Wed, 17 Feb 2016 15:43:11 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

I ran into this issue while debugging an early boot problem.
The system hit a BUG_ON() but report bug failed to print the
line number and file name. The reason being that the system
was running in real mode and report_bug() searches for
addresses in the PAGE_OFFSET+ region

Suggested-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/traps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b6becc7..8f28120 100644
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
@@ -1158,8 +1159,13 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 				== NOTIFY_STOP)
 			goto bail;
 
+		if (!(regs->msr & MSR_IR))
+			bugaddr = regs->nip + PAGE_OFFSET;
+		else
+			bugaddr = regs->nip;
+
 		if (!(regs->msr & MSR_PR) &&  /* not user-mode */
-		    report_bug(regs->nip, regs) == BUG_TRAP_TYPE_WARN) {
+		    report_bug(bugaddr, regs) == BUG_TRAP_TYPE_WARN) {
 			regs->nip += 4;
 			goto bail;
 		}
-- 
2.5.0
