Return-Path: <srs0=s2bh=aq=linux.vnet.ibm.com=ego@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtpkM4vtPzDqZB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 18:40:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xtpkM4QGdz8vJV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 18:40:11 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xtpkM0fJpz9sPr
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2017 18:40:10 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8F8dft8047506
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2017 04:40:08 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d04tq0nrg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Sep 2017 04:40:08 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 15 Sep 2017 04:40:08 -0400
Date: Fri, 15 Sep 2017 14:10:02 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: Possible bug in commit f3b3f28493d9
Reply-To: ego@linux.vnet.ibm.com
References: <20170914045707.GA25715@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170914045707.GA25715@fergus.ozlabs.ibm.com>
Message-Id: <20170915084002.GA4964@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On Thu, Sep 14, 2017 at 02:57:07PM +1000, Paul Mackerras wrote:
> Commit f3b3f28493d9 ("powerpc/powernv/idle: Don't override
> default/deepest directly in kernel", 2017-03-22) made the following
> change in pnv_cpu_offline() in arch/powerpc/platforms/powernv/idle.c:
> 
> -	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
>  		srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
>  					pnv_deepest_stop_psscr_mask);
>  	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
>  		srr1 = power7_winkle();
>

This patch follows an earlier patch with commit 900612315788
("powerpc/powernv/smp: Add busy-wait loop as fall back for
CPU-Hotplug") to ensure that when platform idle states aren't
available, the offlined CPUs spin in a busy while loop.


> Which seems to be saying that previously, on POWER9 we would always
> call power9_idle_stop(), but now we might possibly call
> power7_idle_insn() to do a nap or sleep or rvwinkle instruction.
>


On POWER9, none of the platform idle states (stop states) exposed by
the skiboot have OPAL_PM_[NAP/SLEEP/WINKLE]_ENABLED set in their
respective flags. Hence we will never enter those "else if"
conditions.


> Is this really what was meant?  Nap, sleep and rvwinkle are illegal
> instructions on POWER9.  It looks to me as if that statement needs to
> be restructured to do what the commit description says, which is to
> call power9_idle_stop if we have found a valid stop state, and
> otherwise to poll.
> At present we are relying on idle_states not not having any of the
> nap/sleep/winkle bits set in it.  Is that guaranteed on POWER9?  If so
> it is at least deserving of a comment.

How about the following patch

---------------------------x8---------x8---------------------------------
>From a17e4f71bfc9d208c45335acb47fc2b3a9f61923 Mon Sep 17 00:00:00 2001
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Date: Fri, 15 Sep 2017 13:32:04 +0530
Subject: [PATCH] powerpc/powernv/idle: Restructure pnv_cpu_offline for readability

The current code for handling CPU offline will call a function to put
a CPU in a stop state if this is a POWER9 CPU and if a suitable stop
state is found. If one of these conditions fails, it checks for the
OPAL flags for the idle state to see if winkle, fastsleep, nap are
available (which shouldn't be available on POWER9) and finally put the
CPU into a busy while loop.

This code gives an impression that we are exploring the possibility of
putting the CPUs into fastsleep/nap/winkle on POWER9 even though that
is not possible and is illegal.

Hence rewrite the code to seperately handle the offline for POWER9 and
pre-POWER9 CPUs.

This patch introduces no functional change. Just restructures the code
for improved readability.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 70 +++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index a553aee..67b5475 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -380,6 +380,29 @@ void power9_idle_type(unsigned long stop_psscr_val,
 }
 
 /*
+ * offline_idle_loop: Offlined CPUs will busy-idle on platforms that
+ *	don't have any platform idle state enabled.
+ *
+ * @cpu: The cpu that is offlined.
+ *
+ * Returns 0 since the srr1 wasn't lost as we didn't execute any
+ * platform idle.
+ *
+ */
+unsigned long offline_idle_loop(unsigned int cpu)
+{
+	/* This is the fallback method. We emulate snooze */
+	while (!generic_check_cpu_restart(cpu)) {
+		HMT_low();
+		HMT_very_low();
+	}
+
+	HMT_medium();
+
+	return 0;
+}
+
+/*
  * Used for ppc_md.power_save which needs a function with no parameters
  */
 void power9_idle(void)
@@ -391,6 +414,9 @@ void power9_idle(void)
 /*
  * pnv_cpu_offline: A function that puts the CPU into the deepest
  * available platform idle state on a CPU-Offline.
+ * If no platform idle state is available, the CPU busy waits.
+ * (see offline_idle_loop())
+ *
  * interrupts hard disabled and no lazy irq pending.
  */
 unsigned long pnv_cpu_offline(unsigned int cpu)
@@ -400,32 +426,30 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 
 	__ppc64_runlatch_off();
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300) && deepest_stop_found) {
-		unsigned long psscr;
-
-		psscr = mfspr(SPRN_PSSCR);
-		psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
-						pnv_deepest_stop_psscr_val;
-		srr1 = power9_idle_stop(psscr);
-
-	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
-		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
-		srr1 = power7_idle_insn(PNV_THREAD_WINKLE);
-	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
-		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
-		srr1 = power7_idle_insn(PNV_THREAD_SLEEP);
-	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
-		srr1 = power7_idle_insn(PNV_THREAD_NAP);
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (deepest_stop_found) {
+			unsigned long psscr;
+
+			psscr = mfspr(SPRN_PSSCR);
+			psscr = (psscr & ~pnv_deepest_stop_psscr_mask) |
+				pnv_deepest_stop_psscr_val;
+			srr1 = power9_idle_stop(psscr);
+		} else {
+			srr1 = offline_idle_loop(cpu);
+		}
 	} else {
-		/* This is the fallback method. We emulate snooze */
-		while (!generic_check_cpu_restart(cpu)) {
-			HMT_low();
-			HMT_very_low();
+		if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
+		    (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
+			srr1 = power7_idle_insn(PNV_THREAD_WINKLE);
+		} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
+			 (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
+			srr1 = power7_idle_insn(PNV_THREAD_SLEEP);
+		} else if (idle_states & OPAL_PM_NAP_ENABLED) {
+			srr1 = power7_idle_insn(PNV_THREAD_NAP);
+		} else {
+			srr1 = offline_idle_loop(cpu);
 		}
-		srr1 = 0;
-		HMT_medium();
 	}
-
 	__ppc64_runlatch_on();
 
 	return srr1;
-- 
1.9.4





> 
> Paul.
> 
