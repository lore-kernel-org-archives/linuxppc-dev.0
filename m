Return-Path: <srs0=ogv3=5z=fossix.org=santosh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsKcn5D8YzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:44:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wsKcn1zqcz8t64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 17:44:57 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wsKcm4bKBz9s7m
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 17:44:56 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id y7so21330366pfd.3
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 00:44:56 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: naveen.n.rao@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/time: Fix tracing in time.c
Date: Tue, 20 Jun 2017 13:14:47 +0530
Message-Id: <20170620074447.15532-1-santosh@fossix.org>
In-Reply-To: <20170620070200.d53qywt6fce6b6e5@naverao1-tp.localdomain>
References: <20170620070200.d53qywt6fce6b6e5@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since trace_clock is in a different file and already marked with notrace,
enable tracing in time.c by removing it from the disabled list in Makefile.
Also annotate clocksource read functions and sched_clock with notrace.

Testing: Timer and ftrace selftests run with different trace clocks.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/Makefile | 2 --
 arch/powerpc/kernel/time.c   | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e132902..0845eeb 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -25,8 +25,6 @@ CFLAGS_REMOVE_cputable.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_prom_init.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_btext.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_prom.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
-# timers used by tracing
-CFLAGS_REMOVE_time.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)
 endif
 
 obj-y				:= cputable.o ptrace.o syscalls.o \
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 2b33cfa..896ba1a 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(tb_to_ns);
  * the high 64 bits of a * b, i.e. (a * b) >> 64, where a and b
  * are 64-bit unsigned numbers.
  */
-unsigned long long sched_clock(void)
+notrace unsigned long long sched_clock(void)
 {
 	if (__USE_RTC())
 		return get_rtc();
@@ -823,12 +823,12 @@ void read_persistent_clock(struct timespec *ts)
 }
 
 /* clocksource code */
-static u64 rtc_read(struct clocksource *cs)
+static notrace u64 rtc_read(struct clocksource *cs)
 {
 	return (u64)get_rtc();
 }
 
-static u64 timebase_read(struct clocksource *cs)
+static notrace u64 timebase_read(struct clocksource *cs)
 {
 	return (u64)get_tb();
 }
-- 
2.9.4
