Return-Path: <Dongsheng.Wang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 456DF2C0135
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 16:27:27 +1100 (EST)
Received: from mail128-va3 (localhost [127.0.0.1])	by
 mail128-va3-R.bigfish.com (Postfix) with ESMTP id 203AB4C00A7	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 05:27:22 +0000 (UTC)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 2/2] powerpc/mpic_timer: fix convert ticks to time
 subtraction overflow
Date: Mon, 6 Jan 2014 13:23:31 +0800
Message-ID: <1388985811-32495-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1388985811-32495-1-git-send-email-dongsheng.wang@freescale.com>
References: <1388985811-32495-1-git-send-email-dongsheng.wang@freescale.com>
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

In some cases tmp_sec may be greater than ticks, because in the process
of calculation ticks and tmp_sec will be rounded.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
v2:
Add the new patch in v2.

diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
index 70dcf9c..9d9b062 100644
--- a/arch/powerpc/sysdev/mpic_timer.c
+++ b/arch/powerpc/sysdev/mpic_timer.c
@@ -97,8 +97,11 @@ static void convert_ticks_to_time(struct timer_group_priv *priv,
 	time->tv_sec = (__kernel_time_t)div_u64(ticks, priv->timerfreq);
 	tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
 
-	time->tv_usec = (__kernel_suseconds_t)
-		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
+	time->tv_usec = 0;
+
+	if (tmp_sec <= ticks)
+		time->tv_usec = (__kernel_suseconds_t)
+			div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
 
 	return;
 }
-- 
1.8.5
