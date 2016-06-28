Return-Path: <sam@mendozajonas.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdrc54zcwzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 13:18:29 +1000 (AEST)
Received: from mendozajonas.com (mendozajonas.com [188.166.185.233])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdrc51GRjz9sXy
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2016 13:18:29 +1000 (AEST)
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: linuxppc-dev@ozlabs.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Alistair Popple <alistair@popple.id.au>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 "# 4 . 1 . x-" <stable@vger.kernel.org>
Subject: [PATCH 1/2] tty/hvc: Use IRQF_SHARED for OPAL hvc consoles
Date: Tue, 28 Jun 2016 13:11:38 +1000
Message-Id: <20160628031139.12500-1-sam@mendozajonas.com>
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
to start properly. This is only set for consoles handled by
hvc_opal_probe(), leaving other types unaffected.

Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: <stable@vger.kernel.org> # 4.1.x-
---
 drivers/tty/hvc/hvc_console.h | 1 +
 drivers/tty/hvc/hvc_irq.c     | 7 +++++--
 drivers/tty/hvc/hvc_opal.c    | 3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 9131019..798c48d 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -60,6 +60,7 @@ struct hvc_struct {
 	struct winsize ws;
 	struct work_struct tty_resize;
 	struct list_head next;
+	unsigned long flags;
 };
 
 /* implemented by a low level driver */
diff --git a/drivers/tty/hvc/hvc_irq.c b/drivers/tty/hvc/hvc_irq.c
index c9adb05..57d9df7 100644
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
 
@@ -28,8 +31,8 @@ int notifier_add_irq(struct hvc_struct *hp, int irq)
 		hp->irq_requested = 0;
 		return 0;
 	}
-	rc = request_irq(irq, hvc_handle_interrupt, 0,
-			   "hvc_console", hp);
+	rc = request_irq(irq, hvc_handle_interrupt, hp->flags,
+			"hvc_console", hp);
 	if (!rc)
 		hp->irq_requested = 1;
 	return rc;
diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 47b54c6..b7cd0ae 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -224,6 +224,9 @@ static int hvc_opal_probe(struct platform_device *dev)
 	hp = hvc_alloc(termno, irq, ops, MAX_VIO_PUT_CHARS);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
+
+	/* hvc consoles on powernv may need to share a single irq */
+	hp->flags = IRQF_SHARED;
 	dev_set_drvdata(&dev->dev, hp);
 
 	return 0;
-- 
2.9.0
