Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C1031400AD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 May 2014 14:26:48 +1000 (EST)
Message-ID: <1399695993.4481.47.camel@pasglop>
Subject: Re: [PATCH] powerpc: irq work racing with timer interrupt can
 result in timer interrupt hang
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Sat, 10 May 2014 14:26:33 +1000
In-Reply-To: <536CA561.8010803@linux.vnet.ibm.com>
References: <20140509174712.55fe72d0@kryten>
 <536CA561.8010803@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulmck@linux.vnet.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-05-09 at 15:22 +0530, Preeti U Murthy wrote:
> in __timer_interrupt() outside the _else_ loop? This will ensure that no
> matter what, before exiting timer interrupt handler we check for pending
> irq work.

We still need to make sure that set_next_event() doesn't move the
dec beyond the next tick if there is a pending timer... maybe we
can fix it like this:

static int decrementer_set_next_event(unsigned long evt,
				      struct clock_event_device *dev)
{
	__get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;

	/* Don't adjust the decrementer if some irq work is pending */
	if (!test_irq_work_pending())
		set_dec(evt);

	return 0;
}

Along with a single occurrence of:

	if (test_irq_work_pending())
		set_dec(1);

At the end of __timer_interrupt(), outside if the current else {}
case, this should work, don't you think ?

What about this completely untested patch ?

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 122a580..ba7e83b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -503,12 +503,13 @@ void __timer_interrupt(void)
                now = *next_tb - now;
                if (now <= DECREMENTER_MAX)
                        set_dec((int)now);
-               /* We may have raced with new irq work */
-               if (test_irq_work_pending())
-                       set_dec(1);
                __get_cpu_var(irq_stat).timer_irqs_others++;
        }
 
+       /* We may have raced with new irq work */
+       if (test_irq_work_pending())
+               set_dec(1);
+
 #ifdef CONFIG_PPC64
        /* collect purr register values often, for accurate calculations */
        if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
@@ -813,15 +814,11 @@ static void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
                                      struct clock_event_device *dev)
 {
-       /* Don't adjust the decrementer if some irq work is pending */
-       if (test_irq_work_pending())
-               return 0;
        __get_cpu_var(decrementers_next_tb) = get_tb_or_rtc() + evt;
-       set_dec(evt);
 
-       /* We may have raced with new irq work */
-       if (test_irq_work_pending())
-               set_dec(1);
+       /* Don't adjust the decrementer if some irq work is pending */
+       if (!test_irq_work_pending())
+               set_dec(evt);
 
        return 0;
 }
