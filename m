Message-Id: <m13QqLg-001SzbC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: decrementer_count, count_period_num, and count_period_den has disappeared
To: linuxppc-embedded@lists.linuxppc.org
Date: Mon, 21 Aug 2000 08:06:40 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It appears the decrementer_count, count_period_num, and
count_period_den variables from arch/ppc/kernel/time.c have changed.
This is causing arch/ppc/kernel/m8260_setup.c to not compile.

m8260_setup.c: In function `abort':
m8260_setup.c:105: warning: `noreturn' function does return
m8260_setup.c: In function `m8260_calibrate_decr':
m8260_setup.c:116: `decrementer_count' undeclared (first use in this function)
m8260_setup.c:116: (Each undeclared identifier is reported only once
m8260_setup.c:116: for each function it appears in.)
m8260_setup.c:117: `count_period_num' undeclared (first use in this function)
m8260_setup.c:118: `count_period_den' undeclared (first use in this function)

I believe that decrementer_count was renamed to tb_ticks_per_jiffy, and
count_period_num/count_period_den are converted somehow into tb_to_us.

Could someone tell me the relationship between
count_period_num/count_period_den and tb_to_us?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
