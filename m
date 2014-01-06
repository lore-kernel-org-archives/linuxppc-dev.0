Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 39F802C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 16:27:14 +1100 (EST)
Received: from mail122-va3 (localhost [127.0.0.1])	by
 mail122-va3-R.bigfish.com (Postfix) with ESMTP id 7F50080290	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 05:27:07 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 1/2] powerpc/mpic_timer: fix the time is not accurate
 caused by GTCRR toggle bit
Date: Mon, 6 Jan 2014 13:23:30 +0800
Message-ID: <1388985811-32495-1-git-send-email-dongsheng.wang@freescale.com>
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
---
v2:
No change.

diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index 22d7d57..70dcf9c 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -41,6 +41,7 @@
 #define MPIC_TIMER_TCR_ROVR_OFFSET	24
 
 #define TIMER_STOP			0x80000000
+#define GTCCR_TOG			0x80000000
 #define TIMERS_PER_GROUP		4
 #define MAX_TICKS			(~0U >> 1)
 #define MAX_TICKS_CASCADE		(~0U)
@@ -327,11 +328,13 @@ void mpic_get_remain_time(struct mpic_timer *handle, struct timeval *time)
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
