Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B19FCDDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 05:52:41 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: mingo@elte.hu
Subject: [PATCH 2.6.21-rc6-rt0] ns2cyc() result fix
Date: Wed, 25 Apr 2007 22:54:17 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704252354.17404.sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix the dubious use of cycles_t where cycle_t was appropriate.  On the machines
with 32-bit cycles_t (like ARM/PPC) it caused these warnings:

In file included from arch/powerpc/kernel/time.c:1045:
include/linux/clocksource.h: In function `ns2cyc':
include/linux/clocksource.h:213: warning: comparison of distinct pointer types lacks a cast
include/linux/clocksource.h:213: warning: right shift count >= width of type
include/linux/clocksource.h:213: warning: passing argument 1 of `__div64_32' from incompatible pointer type

This function and therefore usecs_to_cycles() was unlikely to return a correct
result on such machines because of the shift result truncation.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
I'm also uncertain about 'preempt_max_latency' and 'preempt_thresh' variables
being declared as 'unsigned long' -- however, looks like those are unlikely to
overflow... yet it's unclear why there's casts to 'cycle_t' (which is always
64-bit) when initializing/comparing them...

Index: linux-2.6/include/linux/clocksource.h
===================================================================
--- linux-2.6.orig/include/linux/clocksource.h
+++ linux-2.6/include/linux/clocksource.h
@@ -206,9 +206,9 @@ static inline s64 cyc2ns(struct clocksou
  * @cs:		Pointer to clocksource
  * @nsecs:	Nanoseconds
  */
-static inline cycles_t ns2cyc(struct clocksource *cs, u64 nsecs)
+static inline cycle_t ns2cyc(struct clocksource *cs, u64 nsecs)
 {
-	cycles_t ret = nsecs << cs->shift;
+	cycle_t ret = nsecs << cs->shift;
 
 	do_div(ret, cs->mult + 1);
 
