Message-Id: <m13Qrpt-001SzbC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Re: decrementer_count, count_period_num, and count_period_den has
To: paubert@iram.es (Gabriel Paubert), linuxppc-embedded@lists.linuxppc.org
Date: Mon, 21 Aug 2000 09:41:57 -0400 (EDT)
In-Reply-To: <Pine.HPX.4.10.10008211412090.15550-100000@gra-ux1.iram.es> from "Gabriel Paubert" at Aug 21, 2000 02:18:19 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does this patch make sense?


dell 200} bk diffs -r1.7 -u arch/ppc/kernel/m8260_setup.c
===== arch/ppc/kernel/m8260_setup.c 1.7 vs 1.10 =====
--- 1.7/arch/ppc/kernel/m8260_setup.c   Wed Aug  2 12:53:58 2000
+++ 1.10/arch/ppc/kernel/m8260_setup.c  Mon Aug 21 09:34:30 2000
@@ -113,9 +113,8 @@

        freq = (binfo->bi_busfreq * 1000000);
         divisor = 4;
-        decrementer_count = freq / HZ / divisor;
-        count_period_num = divisor;
-        count_period_den = freq / 1000000;
+       tb_ticks_per_jiffy = freq / divisor / HZ;
+       tb_to_us = mulhwu_scale_factor(freq / divisor, 1000000);
 }

 /* The 8260 has an internal 1-second timer update register that

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
