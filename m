Return-Path: <Dongsheng.Wang@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 366D12C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 13:36:40 +1100 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic_timer: fix the time calculation is not accurate
Date: Mon, 23 Dec 2013 10:33:45 +0800
Message-ID: <1387766025-46101-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

When the timer GTCCR toggle bit is inverted, we calculated the rest
of the time is not accurate. So we need to ignore this bit.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index 22d7d57..0fb70c9 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -41,6 +41,7 @@
 #define MPIC_TIMER_TCR_ROVR_OFFSET	24
 
 #define TIMER_STOP			0x80000000
+#define GTCCR_TOG			0x80000000
 #define TIMERS_PER_GROUP		4
 #define MAX_TICKS			(~0U >> 1)
 #define MAX_TICKS_CASCADE		(~0U)
@@ -96,8 +97,15 @@ static void convert_ticks_to_time(struct timer_group_priv *priv,
 	time->tv_sec = (__kernel_time_t)div_u64(ticks, priv->timerfreq);
 	tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
 
-	time->tv_usec = (__kernel_suseconds_t)
-		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
+	time->tv_usec = 0;
+
+	/*
+	 * In some cases tmp_sec may be greater than ticks, because in the
+	 * process of calculation ticks and tmp_sec will be rounded.
+	 */
+	if (tmp_sec <= ticks)
+		time->tv_usec = (__kernel_suseconds_t)
+			div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
 
 	return;
 }
@@ -327,11 +335,13 @@ void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time)
 	casc_priv = priv->timer[handle->num].cascade_handle;
 	if (casc_priv) {
 		tmp_ticks = in_be32(&priv->regs[handle->num].gtccr);
+		tmp_ticks &= ~GTCCR_TOG;
 		ticks = ((u64)tmp_ticks & UINT_MAX) * (u64)MAX_TICKS_CASCADE;
 		tmp_ticks = in_be32(&priv->regs[handle->num - 1].gtccr);
 		ticks += tmp_ticks;
 	} else {
 		ticks = in_be32(&priv->regs[handle->num].gtccr);
+		ticks &= ~GTCCR_TOG;
 	}
 
 	convert_ticks_to_time(priv, ticks, time);
-- 
1.8.5
