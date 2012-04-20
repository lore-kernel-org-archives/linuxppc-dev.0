Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AFAFB703B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 13:29:54 +1000 (EST)
Message-ID: <1334892582.31646.1.camel@pasglop>
Subject: [PATCH 2/3] irq: Add IRQ_TYPE_DEFAULT for use by PIC drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 20 Apr 2012 13:29:42 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is meant typically to allow a PIC driver's irq domain map() callback
to establish sane defaults for the interrupt (and make sure that the HW
and the irq_desc are in sync as far as the trigger is concerned).

The irq core may not call the set_trigger callback if it thinks the
trigger is already set to the right setting, so we need to ensure new
descriptors are properly synchronized with the hardware.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/irq.h |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7810406..b27cfcf 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -49,6 +49,12 @@ typedef	void (*irq_preflow_handler_t)(struct irq_data *data);
  * IRQ_TYPE_LEVEL_LOW		- low level triggered
  * IRQ_TYPE_LEVEL_MASK		- Mask to filter out the level bits
  * IRQ_TYPE_SENSE_MASK		- Mask for all the above bits
+ * IRQ_TYPE_DEFAULT		- For use by some PICs to ask irq_set_type
+ *				  to setup the HW to a sane default (used
+ *                                by irqdomain map() callbacks to synchronize
+ *                                the HW state and SW flags for a newly
+ *                                allocated descriptor).
+ *
  * IRQ_TYPE_PROBE		- Special flag for probing in progress
  *
  * Bits which can be modified via irq_set/clear/modify_status_flags()
@@ -77,6 +83,7 @@ enum {
 	IRQ_TYPE_LEVEL_LOW	= 0x00000008,
 	IRQ_TYPE_LEVEL_MASK	= (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH),
 	IRQ_TYPE_SENSE_MASK	= 0x0000000f,
+	IRQ_TYPE_DEFAULT	= IRQ_TYPE_SENSE_MASK,
 
 	IRQ_TYPE_PROBE		= 0x00000010,
 
