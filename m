Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E2411A08CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 21:28:28 +1000 (AEST)
Received: by pdbep18 with SMTP id ep18so44377151pdb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 04:28:26 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Christoph Lameter <cl@linux.com>, Cyril Bur <cyrilbur@gmail.com>,
 Michael Turquette <mturquette@linaro.org>,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/23] powerpc/time: Migrate to new 'set-state' interface
Date: Thu, 16 Jul 2015 16:56:25 +0530
Message-Id: <4eb5253c39b903f1c314825cb80d8f3bec141682.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437044517.git.viresh.kumar@linaro.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 arch/powerpc/kernel/time.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 43922509a483..1be1092c7204 100644
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
2.4.0
