Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gxK4CGmzF0qS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 21:02:29 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id m68so3958232pfm.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 03:02:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 2/4] powerpc/64s: sreset panic if there is no debugger or
 crash dump handlers
Date: Fri, 16 Mar 2018 20:02:10 +1000
Message-Id: <20180316100212.5110-3-npiggin@gmail.com>
In-Reply-To: <20180316100212.5110-1-npiggin@gmail.com>
References: <20180316100212.5110-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

system_reset_exception does most of its own crash handling now,
invoking the debugger or crash dumps if they are registered. If not,
then it goes through to die() to print stack traces, and then is
supposed to panic (according to comments).

However after die() prints oopses, it does its own handling which
doesn't allow system_reset_exception to panic (e.g., it may just
kill the current process). This patch causes sreset exceptions to
return from die after it prints messages but before acting.

This also stops die from invoking the debugger on 0x100 crashes.
system_reset_exception similarly calls the debugger. It had been
thought this was harmless (because if the debugger was disabled,
neither call would fire, and if it was enabled the first call
would return). However in some cases like xmon 'X' command, the
debugger returns 0, which currently causes it to be entered
again (first in system_reset_exception, then in die), which is
confusing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/traps.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1e48d157196a..b0ac57fa5056 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -208,6 +208,12 @@ static void oops_end(unsigned long flags, struct pt_regs *regs,
 	}
 	raw_local_irq_restore(flags);
 
+	/*
+	 * system_reset_excption handles debugger, crash dump, panic, for 0x100
+	 */
+	if (TRAP(regs) == 0x100)
+		return;
+
 	crash_fadump(regs, "die oops");
 
 	if (kexec_should_crash(current))
@@ -272,8 +278,13 @@ void die(const char *str, struct pt_regs *regs, long err)
 {
 	unsigned long flags;
 
-	if (debugger(regs))
-		return;
+	/*
+	 * system_reset_excption handles debugger, crash dump, panic, for 0x100
+	 */
+	if (TRAP(regs) != 0x100) {
+		if (debugger(regs))
+			return;
+	}
 
 	flags = oops_begin(regs);
 	if (__die(str, regs, err))
-- 
2.16.1
