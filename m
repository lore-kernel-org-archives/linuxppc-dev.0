Return-Path: <anton@samba.org>
Message-Id: <20111124060847.366751627@samba.org>
Date: Thu, 24 Nov 2011 17:07:20 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, johnstul@us.ibm.com,
 miltonm@bga.com
Subject: [PATCH 4/6] powerpc/time: Remove unnecessary sanity check of
 decrementer expiration
References: <20111124060716.362614789@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The clockevents code uses max_delta_ns to avoid calling a
clockevent with too large a value.

Remove the redundant version of this in the timer_interrupt
code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/time.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/time.c	2011-11-17 10:12:28.891690395 +1100
+++ linux-build/arch/powerpc/kernel/time.c	2011-11-17 10:13:54.241143987 +1100
@@ -572,7 +572,6 @@ void timer_interrupt(struct pt_regs * re
 	struct pt_regs *old_regs;
 	struct decrementer_clock *decrementer =  &__get_cpu_var(decrementers);
 	struct clock_event_device *evt = &decrementer->event;
-	u64 now;
 
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
@@ -607,16 +606,9 @@ void timer_interrupt(struct pt_regs * re
 		get_lppaca()->int_dword.fields.decr_int = 0;
 #endif
 
-	now = get_tb_or_rtc();
-	if (now >= decrementer->next_tb) {
-		decrementer->next_tb = ~(u64)0;
-		if (evt->event_handler)
-			evt->event_handler(evt);
-	} else {
-		now = decrementer->next_tb - now;
-		if (now <= DECREMENTER_MAX)
-			set_dec((int)now);
-	}
+	decrementer->next_tb = ~(u64)0;
+	if (evt->event_handler)
+		evt->event_handler(evt);
 
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES) && hvlpevent_is_pending())
