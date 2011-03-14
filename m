Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87D671007D5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Mar 2011 07:29:42 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EK32X0027189
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:03:02 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E3EC16E8039
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:38 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EKTcGK1626224
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 16:29:38 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EKTcLx019118
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 17:29:38 -0300
Subject: [PATCH v3 3/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Mar 2011 15:29:36 -0500
Message-ID: <1300134576.803.17.camel@flin.austin.ibm.com>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds support for handling IO Event interrupts which come
through at the /event-sources/ibm,io-events device tree node.

The interrupts come through ibm,io-events device tree node are generated
by the firmware to report IO events. The firmware uses the same interrupt
to report multiple types of events for multiple devices. Each device may
have its own event handler. This patch implements a plateform interrupt
handler that is triggered by the IO event interrupts come through
ibm,io-events device tree node, pull in the IO events from RTAS and call
device event handlers registered in the notifier list.

Device event handlers are expected to use atomic_notifier_chain_register()
and atomic_notifier_chain_unregister() to register/unregister their
event handler in pseries_ioei_notifier_list list with IO event interrupt.
Device event handlers are responsible to identify if the event belongs
to the device event handler. The device event handle should return NOTIFY_OK
after the event is handled if the event belongs to the device event handler,
or NOTIFY_DONE otherwise.

Change log from V2:
- Re-implement interrupt call list with atomic notifier.

platforms/pseries/io_event_irq.c:
- Move IO Event data copy to ioei_interrupt(). Rename ioei_get_event()
  to ioei_find_event().
- Remove unused ioei_call_handlers(), pseries_ioei_register_handler(),
  pseries_ioei_unregister_handler() as the functions are replaced by
  notifier.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
---
 arch/powerpc/include/asm/io_event_irq.h       |   54 +++++++
 arch/powerpc/platforms/pseries/Kconfig        |   19 ++
 arch/powerpc/platforms/pseries/Makefile       |    1 +
 arch/powerpc/platforms/pseries/io_event_irq.c |  207 +++++++++++++++++++++++++
 4 files changed, 281 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/io_event_irq.h b/arch/powerpc/include/asm/io_event_irq.h
new file mode 100644
index 0000000..cbaef02
--- /dev/null
+++ b/arch/powerpc/include/asm/io_event_irq.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright 2010, 2011 Mark Nelson and Tseng-Hui (Frank) Lin, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_POWERPC_IO_EVENT_IRQ_H
+#define _ASM_POWERPC_IO_EVENT_IRQ_H
+
+#include <linux/types.h>
+#include <linux/notifier.h>
+
+#define PSERIES_IOEI_RPC_MAX_LEN 216
+
+#define PSERIES_IOEI_TYPE_ERR_DETECTED		0x01
+#define PSERIES_IOEI_TYPE_ERR_RECOVERED		0x02
+#define PSERIES_IOEI_TYPE_EVENT			0x03
+#define PSERIES_IOEI_TYPE_RPC_PASS_THRU		0x04
+
+#define PSERIES_IOEI_SUBTYPE_NOT_APP		0x00
+#define PSERIES_IOEI_SUBTYPE_REBALANCE_REQ	0x01
+#define PSERIES_IOEI_SUBTYPE_NODE_ONLINE	0x03
+#define PSERIES_IOEI_SUBTYPE_NODE_OFFLINE	0x04
+#define PSERIES_IOEI_SUBTYPE_DUMP_SIZE_CHANGE	0x05
+#define PSERIES_IOEI_SUBTYPE_TORRENT_IRV_UPDATE	0x06
+#define PSERIES_IOEI_SUBTYPE_TORRENT_HFI_CFGED	0x07
+
+#define PSERIES_IOEI_SCOPE_NOT_APP		0x00
+#define PSERIES_IOEI_SCOPE_RIO_HUB		0x36
+#define PSERIES_IOEI_SCOPE_RIO_BRIDGE		0x37
+#define PSERIES_IOEI_SCOPE_PHB			0x38
+#define PSERIES_IOEI_SCOPE_EADS_GLOBAL		0x39
+#define PSERIES_IOEI_SCOPE_EADS_SLOT		0x3A
+#define PSERIES_IOEI_SCOPE_TORRENT_HUB		0x3B
+#define PSERIES_IOEI_SCOPE_SERVICE_PROC		0x51
+
+/* Platform Event Log Format, Version 6, data portition of IO event section */
+struct pseries_io_event_sect_data {
+	uint8_t event_type;		/* 0x00 IO-Event Type		*/
+	uint8_t rpc_data_len;		/* 0x01 RPC data length		*/
+	uint8_t scope;			/* 0x02 Error/Event Scope	*/
+	uint8_t event_subtype;		/* 0x03 I/O-Event Sub-Type	*/
+	uint32_t drc_index;		/* 0x04 DRC Index		*/
+	uint8_t rpc_data[PSERIES_IOEI_RPC_MAX_LEN];
+					/* 0x08 RPC Data (0-216 bytes,	*/
+					/* padded to 4 bytes alignment)	*/
+};
+
+extern struct atomic_notifier_head pseries_ioei_notifier_list;
+
+#endif /* _ASM_POWERPC_IO_EVENT_IRQ_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 5b3da4b..d44af70 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -52,6 +52,25 @@ 	bool
	depends on PPC_PSERIES && RTAS_ERROR_LOGGING
	default n

+config IO_EVENT_IRQ
+	bool "IO Event Interrupt support"
+	depends on PPC_PSERIES
+	select PSERIES_EVENT_LOG
+	default y
+	help
+	  Select this option, if you want to enable support for IO Event
+	  interrupts. IO event interrupt is a mechanism provided by RTAS
+	  to return information about hardware error and non-error events
+	  which may need OS attention. RTAS returns events for multiple
+	  event types and scopes. Device drivers can register their handlers
+	  to receive events.
+
+	  This option will only enable the IO event platform code. You
+	  will still need to enable or compile the actual drivers
+	  that use this infrastruture to handle IO event interrupts.
+
+	  Say Y if you are unsure.
+
 config LPARCFG
 	bool "LPAR Configuration Data"
 	depends on PPC_PSERIES || PPC_ISERIES
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index fc52378..5070a45 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PHYP_DUMP)		+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
 obj-$(CONFIG_PSERIES_EVENT_LOG)	+= pseries_event_log.o
+obj-$(CONFIG_IO_EVENT_IRQ)	+= io_event_irq.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/io_event_irq.c b/arch/powerpc/platforms/pseries/io_event_irq.c
new file mode 100644
index 0000000..7d963b5
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/io_event_irq.c
@@ -0,0 +1,207 @@
+/*
+ * Copyright 2010 2011 Mark Nelson and Tseng-Hui (Frank) Lin, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+
+#include <asm/machdep.h>
+#include <asm/rtas.h>
+#include <asm/irq.h>
+#include <asm/io_event_irq.h>
+
+#include "pseries.h"
+#include "pseries_event_log.h"
+
+/*
+ * IO event interrupt is a mechanism provided by RTAS to return
+ * information about hardware error and non-error events. Device
+ * drivers can register their event handlers to receive events.
+ * Device drivers are expected to use atomic_notifier_chain_register()
+ * and atomic_notifier_chain_unregister() to register and unregister
+ * their event handlers. Since multiple IO event types and scopes
+ * share an IO event interrupt, the event handlers are called one
+ * by one until the IO event is claimed by one of the handlers.
+ * The event handlers are expected to return NOTIFY_OK if the
+ * event is handled by the event handler or NOTIFY_DONE if the
+ * event does not belong to the handler.
+ *
+ * Usage:
+ *
+ * Notifier function:
+ * #include <asm/io_event_irq.h>
+ * int event_handler(struct notifier_block *nb, unsigned long val, void *data) {
+ * 	p = (struct pseries_io_event_sect_data *) data;
+ * 	if (! is_my_event(p->scope, p->event_type)) return NOTIFY_DONE;
+ * 		:
+ * 		:
+ * 	return NOTIFY_OK;
+ * }
+ * struct notifier_block event_nb = {
+ * 	.notifier_call = event_handler;
+ * }
+ *
+ * Registration:
+ * atomic_notifier_chain_register(&pseries_ioei_notifier_list, &event_nb);
+ *
+ * Unregistration:
+ * atomic_notifier_chain_unregister(&pseries_ioei_notifier_list, &event_nb);
+ */
+
+ATOMIC_NOTIFIER_HEAD(pseries_ioei_notifier_list);
+EXPORT_SYMBOL_GPL(pseries_ioei_notifier_list);
+
+static int ioei_supported = 0;
+
+static int ioei_check_exception_token;
+
+/*
+ * Find the data portion of an IO Event section from event log.
+ * Return:
+ * 	pointer to a valid IO event section data. NULL if not found.
+ */
+static struct pseries_io_event_sect_data *
+		ioei_find_event(struct rtas_error_log *rtas_elog)
+{
+	struct pseries_io_event_sect_data *event_p;
+
+	/* We should only ever get called for io-event interrupts, but if
+	 * we do get called for another type then something went wrong so
+	 * make some noise about it.
+	 * RTAS_TYPE_IO only exists in extended event log version 6 or later.
+	 * No need to check event log version.
+	 */
+	if (unlikely(rtas_elog->type != RTAS_TYPE_IO)) {
+		pr_warning("io_event_irq: We got called with an event type "
+			   "of %d rather than %d!\n",
+			   rtas_elog->type, RTAS_TYPE_IO);
+		WARN_ON(1);
+		return NULL;
+	}
+
+	event_p = pseries_elog_find_sect_data(
+			(struct rtas_ext_event_log_v6 *) &rtas_elog->buffer,
+			rtas_elog->extended_log_length,
+			PSERIES_ELOG_SECT_ID_IO_EVENT);
+	if (unlikely(!event_p)) {
+		pr_warning("io_event_irq: RTAS extended event log does not "
+			   "contain an IO Event section. Could be a bug in "
+			   "system firmware!\n");
+		WARN_ON(1);
+		return NULL;
+	}
+	return event_p;
+}
+
+/*
+ * PAPR:
+ * - check-exception returns the first found error or event and clear that
+ *   error or event so it is reported once.
+ * - Each interrupt returns one event. If a plateform chooses to report
+ *   multiple events through a single interrupt, it must ensure that the
+ *   interrupt remains asserted until check-exception has been used to
+ *   process all out-standing events for that interrupt.
+ *
+ * Implementation notes:
+ * - Events must be processed in the order they are returned. Hence,
+ *   sequential in nature.
+ * - The owner of an event is determined by combinations of scope,
+ *   event type, and sub-type. There is no easy way to pre-sort clients
+ *   by scope or event type alone. For example, Torrent ISR route change
+ *   event is reported with scope 0x00 (Not Applicatable) rather than
+ *   0x3B (Torrent-hub). It is better to let the clients to identify
+ *   who owns the the event.
+ */
+
+static irqreturn_t ioei_interrupt(int irq, void *dev_id)
+{
+	struct pseries_io_event_sect_data *ioei_buf, *event_p;
+	int rtas_status, notifier_status;
+
+	ioei_buf = kmalloc(sizeof(struct pseries_io_event_sect_data),
+			     GFP_KERNEL);
+	/* Do not check kmalloc() return code here. We need to call	*/
+	/* rtas_call() to release interrupt even if kmalloc() failed.	*/
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		rtas_status = rtas_call(ioei_check_exception_token, 6, 1, NULL,
+					RTAS_VECTOR_EXTERNAL_INTERRUPT,
+					virq_to_hw(irq),
+					RTAS_IO_EVENTS, 1 /* Time Critical */,
+					__pa(&rtas_data_buf),
+					RTAS_DATA_BUF_SIZE);
+		if (rtas_status == 0)
+			event_p = ioei_find_event((struct rtas_error_log *)
+						  &rtas_data_buf);
+		else
+			event_p = NULL;
+		if (event_p) {
+			if (ioei_buf)
+				memcpy(ioei_buf, event_p,
+				       pseries_elog_sect_data_len(event_p));
+			else
+				pr_warning("io_event_irq: No memory to copy "
+					   "IO event. Event type=%d, scope=%d. "
+					   "Interrupt lost!\n",
+					   event_p->event_type, event_p->scope);
+		}
+		spin_unlock(&rtas_data_buf_lock);
+		if (event_p) {
+			notifier_status = atomic_notifier_call_chain(
+						&pseries_ioei_notifier_list,
+						0, ioei_buf);
+			if (notifier_status == NOTIFY_DONE)
+				pr_warning("io_event_irq: No one claims "
+					   "interrupt for IO event type=%d, "
+					   "scope=%d. Interrupt lost!\n",
+					   ioei_buf->event_type,
+					   ioei_buf->scope);
+		}
+	} while (rtas_status == 0);
+
+	if (ioei_buf)
+		kfree(ioei_buf);
+	return IRQ_HANDLED;
+}
+
+static int __init pseries_ioei_init_irq(void)
+{
+	struct device_node *np;
+
+	ioei_supported = 0;
+	ioei_check_exception_token = rtas_token("check-exception");
+	if (ioei_check_exception_token == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("io_event_irq: No check-exception on system! "
+			   "IO Event interrupt disabled.\n");
+		return -ENODEV;
+	}
+
+	np = of_find_node_by_path("/event-sources/ibm,io-events");
+	if (np) {
+		request_event_sources_irqs(np, ioei_interrupt, "IO_EVENT");
+		of_node_put(np);
+	} else {
+		pr_warning("io_event_irq: No ibm,io-events on system! "
+			   "IO Event interrupt disabled.\n");
+		return -ENODEV;
+	}
+
+	ioei_supported = 1;
+
+	return 0;
+}
+
+machine_device_initcall(pseries, pseries_ioei_init_irq);
+
