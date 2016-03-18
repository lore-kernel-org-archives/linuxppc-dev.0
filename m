Return-Path: <sam@mendozajonas.com>
Received: from mendozajonas.com (mendozajonas.com [188.166.185.233])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR6NV53MpzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 12:00:58 +1100 (AEDT)
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/hvc: Use IRQF_SHARED for hvc consoles
Date: Fri, 18 Mar 2016 11:54:43 +1100
Message-Id: <1458262483-15149-1-git-send-email-sam@mendozajonas.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 2def86a7200c
("hvc: Convert to using interrupts instead of opal events")
enabled the use of interrupts in the hvc_driver for OPAL platforms.
However on machines with more than one hvc console, any console after
the first will fail to register an interrupt handler in
notifier_add_irq() since all consoles share the same IRQ number but do
not set the IRQF_SHARED flag:

[   51.179907] genirq: Flags mismatch irq 31. 00000000 (hvc_console) vs.
00000000 (hvc_console)
[   51.180010] hvc_open: request_irq failed with rc -16.

This error propagates up to hvc_open() and the console is closed, but
OPAL will still generate interrupts that are not handled, leading to
rcu_sched stall warnings.

Set IRQF_SHARED when calling request_irq, allowing additional consoles
to start properly.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: <stable@vger.kernel.org> # 4.1.x-
---
 drivers/tty/hvc/hvc_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_irq.c b/drivers/tty/hvc/hvc_irq.c
index c9adb05..621263a 100644
--- a/drivers/tty/hvc/hvc_irq.c
+++ b/drivers/tty/hvc/hvc_irq.c
@@ -14,6 +14,9 @@ static irqreturn_t hvc_handle_interrupt(int irq, void *dev_instance)
 	/* if hvc_poll request a repoll, then kick the hvcd thread */
 	if (hvc_poll(dev_instance))
 		hvc_kick();
+	/* We're safe to always return IRQ_HANDLED as the hvcd thread will
+	 * iterate through each hvc_struct
+	 */
 	return IRQ_HANDLED;
 }
 
@@ -28,7 +31,7 @@ int notifier_add_irq(struct hvc_struct *hp, int irq)
 		hp->irq_requested = 0;
 		return 0;
 	}
-	rc = request_irq(irq, hvc_handle_interrupt, 0,
+	rc = request_irq(irq, hvc_handle_interrupt, IRQF_SHARED,
 			   "hvc_console", hp);
 	if (!rc)
 		hp->irq_requested = 1;
-- 
2.7.3
