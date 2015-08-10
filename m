Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
 [209.85.212.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4FE01A1BF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:55:11 +1000 (AEST)
Received: by wibhh20 with SMTP id hh20so142974249wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 02:55:08 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: mingo@kernel.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Tejun Heo <tj@kernel.org>,
 Michael Turquette <mturquette@linaro.org>,
 Anton Blanchard <anton@samba.org>, Christoph Lameter <cl@linux.com>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 Kevin Hao <haokexin@gmail.com>, Cyril Bur <cyrilbur@gmail.com>
Subject: [PATCH 65/74] powerpc/time: Migrate to new 'set-state' interface
Date: Mon, 10 Aug 2015 11:52:22 +0200
Message-Id: <1439200352-26767-65-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
References: <55C87382.4070309@linaro.org>
 <1439200352-26767-1-git-send-email-daniel.lezcano@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Viresh Kumar <viresh.kumar@linaro.org>

Migrate powerpc driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

We weren't doing anything in ->set_mode(ONSHOT) and so
set_state_oneshot() isn't implemented.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/powerpc/kernel/time.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4392250..1be1092 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -99,16 +99,17 @@ static struct clocksource clocksource_timebase = {
 
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev);
-static void decrementer_set_mode(enum clock_event_mode mode,
-				 struct clock_event_device *dev);
+static int decrementer_shutdown(struct clock_event_device *evt);
 
 struct clock_event_device decrementer_clockevent = {
-	.name           = "decrementer",
-	.rating         = 200,
-	.irq            = 0,
-	.set_next_event = decrementer_set_next_event,
-	.set_mode       = decrementer_set_mode,
-	.features       = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
+	.name			= "decrementer",
+	.rating			= 200,
+	.irq			= 0,
+	.set_next_event		= decrementer_set_next_event,
+	.set_state_shutdown	= decrementer_shutdown,
+	.tick_resume		= decrementer_shutdown,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_C3STOP,
 };
 EXPORT_SYMBOL(decrementer_clockevent);
 
@@ -862,11 +863,10 @@ static int decrementer_set_next_event(unsigned long evt,
 	return 0;
 }
 
-static void decrementer_set_mode(enum clock_event_mode mode,
-				 struct clock_event_device *dev)
+static int decrementer_shutdown(struct clock_event_device *dev)
 {
-	if (mode != CLOCK_EVT_MODE_ONESHOT)
-		decrementer_set_next_event(DECREMENTER_MAX, dev);
+	decrementer_set_next_event(DECREMENTER_MAX, dev);
+	return 0;
 }
 
 /* Interrupt handler for the timer broadcast IPI */
-- 
1.9.1
