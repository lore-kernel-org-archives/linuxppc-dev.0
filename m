Message-Id: <m13RDKd-001SzbC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Patch to arch/ppc/kernel/m8260_setup.c
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 22 Aug 2000 08:39:07 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In order to get things to compile for the MPC8260, the following
patch was needed:

dell 377} bk diffs -r1.7 -u arch/ppc/kernel/m8260_setup.c
===== arch/ppc/kernel/m8260_setup.c 1.7 vs 1.8 =====
--- 1.7/arch/ppc/kernel/m8260_setup.c   Wed Aug  2 12:53:58 2000
+++ 1.8/arch/ppc/kernel/m8260_setup.c   Mon Aug 21 21:17:00 2000
@@ -113,9 +113,8 @@

        freq = (binfo->bi_busfreq * 1000000);
         divisor = 4;
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+        tb_ticks_per_jiffy = freq / (divisor * HZ);
+        tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
 }

 /* The 8260 has an internal 1-second timer update register that

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
