Return-Path: <aaro.koskinen@iki.fi>
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
 [62.142.5.107])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjkYQ1K1yzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 05:59:22 +1000 (AEST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND 1/2] drivers: macintosh: rack-meter: limit idle ticks
 to total ticks
Date: Sun, 10 Apr 2016 22:53:47 +0300
Message-Id: <1460318028-28056-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Limit idle ticks to total ticks. This prevents the annoying rackmeter
leds fully ON / OFF blinking state that happens on fully idling
G5 Xserve systems.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/macintosh/rack-meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/macintosh/rack-meter.c b/drivers/macintosh/rack-meter.c
index caaec65..ba7e330 100644
--- a/drivers/macintosh/rack-meter.c
+++ b/drivers/macintosh/rack-meter.c
@@ -227,6 +227,7 @@ static void rackmeter_do_timer(struct work_struct *work)
 
 	total_idle_ticks = get_cpu_idle_time(cpu);
 	idle_ticks = (unsigned int) (total_idle_ticks - rcpu->prev_idle);
+	idle_ticks = min(idle_ticks, total_ticks);
 	rcpu->prev_idle = total_idle_ticks;
 
 	/* We do a very dumb calculation to update the LEDs for now,
-- 
2.7.2
