Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HBD3KyvzDsQL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:12 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id d8so152742pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 4/6] powerpc/xmon: avoid tripping SMP hardlockup watchdog
Date: Fri, 29 Sep 2017 13:29:40 +1000
Message-Id: <20170929032942.4321-5-npiggin@gmail.com>
In-Reply-To: <20170929032942.4321-1-npiggin@gmail.com>
References: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SMP hardlockup watchdog cross-checks other CPUs for lockups,
which causes xmon headaches because it's assuming interrupts
hard disabled means no watchdog troubles. Try to improve that by
calling touch_nmi_watchdog() in obvious places where secondaries
are spinning.

Also annotate these spin loops with spin_begin/end calls.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 33351c6704b1..d9a12102b111 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -530,14 +530,19 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
  waiting:
 	secondary = 1;
+	spin_begin();
 	while (secondary && !xmon_gate) {
 		if (in_xmon == 0) {
-			if (fromipi)
+			if (fromipi) {
+				spin_end();
 				goto leave;
+			}
 			secondary = test_and_set_bit(0, &in_xmon);
 		}
-		barrier();
+		spin_cpu_relax();
+		touch_nmi_watchdog();
 	}
+	spin_end();
 
 	if (!secondary && !xmon_gate) {
 		/* we are the first cpu to come in */
@@ -568,21 +573,25 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		mb();
 		xmon_gate = 1;
 		barrier();
+		touch_nmi_watchdog();
 	}
 
  cmdloop:
 	while (in_xmon) {
 		if (secondary) {
+			spin_begin();
 			if (cpu == xmon_owner) {
 				if (!test_and_set_bit(0, &xmon_taken)) {
 					secondary = 0;
+					spin_end();
 					continue;
 				}
 				/* missed it */
 				while (cpu == xmon_owner)
-					barrier();
+					spin_cpu_relax();
 			}
-			barrier();
+			spin_cpu_relax();
+			touch_nmi_watchdog();
 		} else {
 			cmd = cmds(regs);
 			if (cmd != 0) {
-- 
2.13.3
