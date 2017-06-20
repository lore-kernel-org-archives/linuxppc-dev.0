Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsHmF08Y7zDqhs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 16:21:17 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id d5so21101224pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 23:21:16 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/time: Fix tracing in time.c
Date: Tue, 20 Jun 2017 11:50:45 +0530
Message-Id: <20170620062045.1347-1-santosh@fossix.org>
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

CC: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
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
index 2b33cfa..6d10c5f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -675,7 +675,7 @@ EXPORT_SYMBOL_GPL(tb_to_ns);
  * the high 64 bits of a * b, i.e. (a * b) >> 64, where a and b
  * are 64-bit unsigned numbers.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
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
