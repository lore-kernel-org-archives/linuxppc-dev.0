Return-Path: <pc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 086161A07DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 06:13:28 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Tue, 7 Oct 2014 15:13:26 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C62636E8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 15:02:09 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s97JDP2U6291922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 19:13:25 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s97JDOmv011381
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 15:13:25 -0400
Received: from oc3241255568.ibm.com (oc3241255568.ibm.com.austin.ibm.com
 [9.41.242.49])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s97JDON9011348
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 15:13:24 -0400
Message-ID: <54343B54.4060500@us.ibm.com>
Date: Tue, 07 Oct 2014 14:13:24 -0500
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: mitigate impact of decrementer reset
References: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
In-Reply-To: <1412708517-84726-1-git-send-email-pc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER ISA defines an always-running decrementer which can be used
to schedule interrupts after a certain time interval has elapsed.
The decrementer counts down at the same frequency as the Time Base,
which is 512 MHz.  The maximum value of the decrementer is 0x7fffffff.
This works out to a maximum interval of about 4.19 seconds.

If a larger interval is desired, the kernel will set the decrementer
to its maximum value and reset it after it expires (underflows)
a sufficient number of times until the desired interval has elapsed.

The negative effect of this is that an unwanted latency spike will
impact normal processing at most every 4.19 seconds.  On an IBM
POWER8-based system, this spike was measured at about 25-30
microseconds, much of which was basic, opportunistic housekeeping
tasks that could otherwise have waited.

This patch short-circuits the reset of the decrementer, exiting after
the decrementer reset, but before the housekeeping tasks if the only
need for the interrupt is simply to reset it.  After this patch,
the latency spike was measured at about 150 nanoseconds.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
  arch/powerpc/kernel/time.c | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 368ab37..962a06b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -528,6 +528,7 @@ void timer_interrupt(struct pt_regs * regs)
  {
  	struct pt_regs *old_regs;
  	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
+	u64 now;

  	/* Ensure a positive value is written to the decrementer, or else
  	 * some CPUs will continue to take decrementer exceptions.
@@ -550,6 +551,18 @@ void timer_interrupt(struct pt_regs * regs)
  	 */
  	may_hard_irq_enable();

+	/* If this is simply the decrementer expiring (underflow) due to
+	 * the limited size of the decrementer, and not a set timer,
+	 * reset (if needed) and return
+	 */
+	now = get_tb_or_rtc();
+	if (now < *next_tb) {
+		now = *next_tb - now;
+		if (now <= DECREMENTER_MAX)
+			set_dec((int)now);
+		__get_cpu_var(irq_stat).timer_irqs_others++;
+		return;
+	}

  #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
  	if (atomic_read(&ppc_n_lost_interrupts) != 0)
-- 
2.1.2.330.g565301e
