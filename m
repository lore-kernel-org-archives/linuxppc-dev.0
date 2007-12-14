Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F098DE0B8
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:52:23 +1100 (EST)
Date: Thu, 13 Dec 2007 22:52:20 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/6] optimize account_system_vtime
In-Reply-To: <mm-cpu-0@bga.com>
Message-Id: <mm-cpu-6@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have multiple calls to has_feature being inlined, but gcc can't
be sure that the store via get_paca() doesn't alias the path to
cur_cpu_spec->feature.

Reorder to put the calls to read_purr and read_spurr adjacent to each
other.  To add a sense of consistency, reorder the remaining lines to
perform parallel steps on purr and scaled purr of each line instead of
calculating and then using one value before going on to the next.

In addition, we can tell gcc that no SPURR means no PURR.  The test is
completely hidden in the PURR case, and in the !PURR case the second test
is eliminated resulting in the simple register copy in the out-of-line
branch.

Further, gcc sees get_paca()->system_time referenced several times and
allocates a register to address it (shadowing r13) instead of caching its
value.  Reading into a local varable saves the shadow of r13 and removes
a potentially duplicate load (between the nested if and its parent).

Signed-off-by: Milton Miller <miltonm@bga.com>
---
The purr and spurr fields of the paca are only used in this c code,
but system_time and user_time are also used in asm and I decided to
leave all of these fields in the paca.

Index: kernel/arch/powerpc/kernel/time.c
===================================================================
--- kernel.orig/arch/powerpc/kernel/time.c	2007-12-13 21:58:10.000000000 -0600
+++ kernel/arch/powerpc/kernel/time.c	2007-12-13 22:00:36.000000000 -0600
@@ -219,7 +219,11 @@ static u64 read_purr(void)
  */
 static u64 read_spurr(u64 purr)
 {
-	if (cpu_has_feature(CPU_FTR_SPURR))
+	/*
+	 * cpus without PURR won't have a SPURR
+	 * We already know the former when we use this, so tell gcc
+	 */
+	if (cpu_has_feature(CPU_FTR_PURR) && cpu_has_feature(CPU_FTR_SPURR))
 		return mfspr(SPRN_SPURR);
 	return purr;
 }
@@ -230,29 +234,30 @@ static u64 read_spurr(u64 purr)
  */
 void account_system_vtime(struct task_struct *tsk)
 {
-	u64 now, nowscaled, delta, deltascaled;
+	u64 now, nowscaled, delta, deltascaled, sys_time;
 	unsigned long flags;
 
 	local_irq_save(flags);
 	now = read_purr();
-	delta = now - get_paca()->startpurr;
-	get_paca()->startpurr = now;
 	nowscaled = read_spurr(now);
+	delta = now - get_paca()->startpurr;
 	deltascaled = nowscaled - get_paca()->startspurr;
+	get_paca()->startpurr = now;
 	get_paca()->startspurr = nowscaled;
 	if (!in_interrupt()) {
 		/* deltascaled includes both user and system time.
 		 * Hence scale it based on the purr ratio to estimate
 		 * the system time */
+		sys_time = get_paca()->system_time;
 		if (get_paca()->user_time)
-			deltascaled = deltascaled * get_paca()->system_time /
-			     (get_paca()->system_time + get_paca()->user_time);
-		delta += get_paca()->system_time;
+			deltascaled = deltascaled * sys_time /
+			     (sys_time + get_paca()->user_time);
+		delta += sys_time;
 		get_paca()->system_time = 0;
 	}
 	account_system_time(tsk, 0, delta);
-	get_paca()->purrdelta = delta;
 	account_system_time_scaled(tsk, deltascaled);
+	get_paca()->purrdelta = delta;
 	get_paca()->spurrdelta = deltascaled;
 	local_irq_restore(flags);
 }
