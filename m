Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8FF8B76EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Jan 2011 09:44:52 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p05MQAde018293
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 17:26:11 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0B1A6728045
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Jan 2011 17:44:45 -0500 (EST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p05Mii4p162440
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 17:44:44 -0500
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p05Mii9d026508
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jan 2011 15:44:44 -0700
Subject: [PATCH v2 3/3] powerpc: Add IO event interrupt support
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Jan 2011 16:44:43 -0600
Message-ID: <1294267483.24377.30.camel@flin.austin.ibm.com>
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

There is one ibm,io-events interrupt, but this interrupt might be used
for multiple I/O devices, each with their own separate driver. So, we
create a platform interrupt handler that will do the RTAS check-exception
call and then call the driver's interrupt handlers.

So, a driver for a device that uses IO Event interrupts will register
it's interrupt service routine (or interrupt handler) with the platform
code using pseries_ioei_register_isr(). This register function takes
a function pointer to the driver's handler.

A driver can unregister to stop receiving the IO Event interrupts using
pseries_ioei_unregister_isr(), passing it the same function pointer to the
driver's handler the driver was registered with.

The platform code registers ioei_interrupt() as the interrupt handler
for the ibm,io-events interrupt. Upon receiving an IO Event interrupt, it
pulls in the IO event from RTAS and pass the contents of the IO event
to those drivers' handlers that have registered until the IO event is
handled. Since there could be multiple drivers' handlers, drivers' handlers
are responsible to identify who the incoming IO event belongs to by checking
the event type, sub-type, and scope. A driver handler should return
IRQ_HANDLED If the IO event is handled or IRQ_NONE otherwise.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Tseng-Hui (Frank) Lin <tsenglin@us.ibm.com>
---
 arch/powerpc/include/asm/io_event_irq.h            |   54 ++++
 arch/powerpc/platforms/pseries/Kconfig             |   20 ++
 arch/powerpc/platforms/pseries/Makefile            |    1 +
 arch/powerpc/platforms/pseries/io_event_irq.c      |  260 ++++++++++++++++++++
 4 files changed, 335 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/io_event_irq.h b/arch/powerpc/include/asm/io_event_irq.h
new file mode 100644
index 0000000..447f23d
--- /dev/null
+++ b/arch/powerpc/include/asm/io_event_irq.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright 2010 Mark Nelson and Tseng-Hui (Frank) Lin, IBM Corporation
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
+#define PSERIES_IOEI_RPC_MAX_LEN 216
+
+#define PSERIES_IOEI_TYPE_ERR_DETECTED	0x01
+#define PSERIES_IOEI_TYPE_ERR_RECOVERED	0x02
+#define PSERIES_IOEI_TYPE_EVENT		0x03
+#define PSERIES_IOEI_TYPE_RPC_PASS_THRU	0x04
+
+#define PSERIES_IOEI_SUBTYPE_NOT_APP		0x00
+#define PSERIES_IOEI_SUBTYPE_REBALANCE_REQ	0x01
+#define PSERIES_IOEI_SUBTYPE_NODE_ONLINE	0x03
+#define PSERIES_IOEI_SUBTYPE_NODE_OFFLINE	0x04
+#define PSERIES_IOEI_SUBTYPE_DUMP_SIZE_CHANGE	0x05
+#define PSERIES_IOEI_SUBTYPE_TORRENT_IRV_UPDATE	0x06
+#define PSERIES_IOEI_SUBTYPE_TORRENT_HFI_CFGED	0x07
+
+#define PSERIES_IOEI_SCOPE_NOT_APP	0x00
+#define PSERIES_IOEI_SCOPE_RIO_HUB	0x36
+#define PSERIES_IOEI_SCOPE_RIO_BRIDGE	0x37
+#define PSERIES_IOEI_SCOPE_PHB		0x38
+#define PSERIES_IOEI_SCOPE_EADS_GLOBAL	0x39
+#define PSERIES_IOEI_SCOPE_EADS_SLOT	0x3A
+#define PSERIES_IOEI_SCOPE_TORRENT_HUB	0x3B
+#define PSERIES_IOEI_SCOPE_SERVICE_PROC	0x51
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
+typedef irqreturn_t (*pseries_ioei_handler_t) (struct pseries_io_event_sect_data *);
+
+extern int pseries_ioei_register_handler(pseries_ioei_handler_t handler);
+extern int pseries_ioei_unregister_handler(pseries_ioei_handler_t handler);
+
+#endif /* _ASM_POWERPC_IO_EVENT_IRQ_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index c667f0f..0f36aad 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -42,6 +42,25 @@ 	bool
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
@@ -81,3 +105,4 @@ config DTL
 	  which are accessible through a debugfs file.
 
 	  Say N if you are unsure.
+
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 046ace9..73909ca 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PHYP_DUMP)	+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
 obj-$(CONFIG_PSERIES_EVENT_LOG)	+= pseries_event_log.o
+obj-$(CONFIG_IO_EVENT_IRQ)	+= io_event_irq.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/io_event_irq.c b/arch/powerpc/platforms/pseries/io_event_irq.c
new file mode 100644
index 0000000..a39f451
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/io_event_irq.c
@@ -0,0 +1,260 @@
+/*
+ * Copyright 2010 Mark Nelson and Tseng-Hui (Frank) Lin, IBM Corporation
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
+ * drivers can register their handlers to receive events.
+ * Device drivers are expected to use pseries_ioei_register_handler()
+ * and pseries_ioei_unregister_handler() to register and unregister
+ * their interrupt handlers. Since multiple IO event types and scopes
+ * share an IO event interrupt, the interrupt handlers are called one
+ * by one until the IO event is claimed by one of the handlers.
+ * IO event interrupt handlers are expected to return IRQ_HANDLED
+ * if the IO event is handled by the handler and IRQ_NONE if the
+ * IO event does not belong to the handler.
+ */
+
+struct ioei_consumer {
+	pseries_ioei_handler_t handler;
+	struct list_head list;
+};
+
+static int ioei_supported = 0;
+
+static int ioei_check_exception_token;
+
+static LIST_HEAD(ioei_handler_list);
+static DEFINE_SPINLOCK(ioei_handler_list_lock);
+
+int pseries_ioei_register_handler(pseries_ioei_handler_t handler)
+{
+	struct ioei_consumer *iter;
+	struct ioei_consumer *cons;
+	int found;
+
+	if (!ioei_supported)
+		return -ENODEV;
+
+	cons = kmalloc(sizeof(struct ioei_consumer), GFP_KERNEL);
+
+	if (!cons)
+		return -ENOMEM;
+
+	spin_lock_irq(&ioei_handler_list_lock);
+	/* check to see if we've already registered this function.
+	 * If we have, don't register it again
+	 */
+	found = 0;
+	list_for_each_entry(iter, &ioei_handler_list, list)
+		if (iter->handler == handler) {
+			kfree(cons);
+			found = 1;
+			break;
+		}
+
+	if (!found) {
+		cons->handler = handler;
+		INIT_LIST_HEAD(&cons->list);
+		list_add(&cons->list, &ioei_handler_list);
+	}
+
+	spin_unlock_irq(&ioei_handler_list_lock);
+
+	return (found) ? -EEXIST : 0;
+}
+EXPORT_SYMBOL_GPL(pseries_ioei_register_handler);
+
+int pseries_ioei_unregister_handler(pseries_ioei_handler_t handler)
+{
+	struct ioei_consumer *iter, *temp;
+	int ret = -ENOENT;
+
+	spin_lock_irq(&ioei_handler_list_lock);
+
+	list_for_each_entry_safe(iter, temp, &ioei_handler_list, list)
+		if (iter->handler == handler) {
+			list_del(&iter->list);
+			kfree(iter);
+			ret = 0;
+			break;
+		}
+
+	spin_unlock_irq(&ioei_handler_list_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pseries_ioei_unregister_handler);
+
+static void ioei_call_handlers(struct pseries_io_event_sect_data *ioei_event)
+{
+	struct ioei_consumer *iter;
+	irqreturn_t ret = IRQ_NONE;
+
+	spin_lock(&ioei_handler_list_lock);
+	list_for_each_entry(iter, &ioei_handler_list, list) {
+		ret = iter->handler(ioei_event);
+		if (ret == IRQ_HANDLED)
+			break;
+	}
+	if (ret != IRQ_HANDLED) {
+		pr_err("io_event_irq: No one claims interrupt for IO event "
+		       "type=%d, scope=%d. Interrupt lost!\n",
+		       ioei_event->event_type, ioei_event->scope);
+	}
+	spin_unlock(&ioei_handler_list_lock);
+}
+
+/*
+ * Get the contents of IO Event section from event log.
+ * Return:
+ *	1: succeeded. ioei_buf contains a valid IO Event.
+ *	0: failed. ioei_buf does not contain a valid IO Event.
+ */
+static int ioei_get_event(struct rtas_error_log *rtas_elog,
+			  struct pseries_io_event_sect_data *ioei_buf)
+{
+	struct pseries_io_event_sect_data *event_p;
+
+	/* We should only ever get called for io-event interrupts, but if
+	 * we do get called for another type then something went wrong so
+	 * make some noise about it.
+	 * RTAS_TYPE_IO only exists in error log version 6 or later.
+	 * No need to check error log version.
+	 */
+	if (unlikely(rtas_elog->type != RTAS_TYPE_IO)) {
+		pr_warning("io_event_irq: We got called with an event type "
+			   "of %d rather than %d!\n",
+			   rtas_elog->type, RTAS_TYPE_IO);
+		WARN_ON(1);
+		return 0;
+	}
+
+	event_p = pseries_elog_find_section(
+			(struct rtas_error_log_v6ext *) &rtas_elog->buffer,
+			rtas_elog->extended_log_length,
+			PSERIES_ELOG_SECT_ID_IO_EVENT);
+	if (unlikely(!event_p)) {
+		pr_warning("io_event_irq: RTAS error log does not contain an "
+			   "IO Event section. Could be a bug in firmware!\n");
+		WARN_ON(1);
+		return 0;
+	}
+
+	/* Check buffer last so that we can log info about the lost event. */
+	if (!ioei_buf) {
+		pr_warning("io_event_irq: No memory to copy IO event. "
+			   "Event type=%d, scope=%d. Interrupt lost!\n",
+			   event_p->event_type, event_p->scope);
+		return 0;
+	}
+
+	memcpy(ioei_buf, event_p, pseries_elog_sect_data_len(event_p));
+	return 1;
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
+ * - The owner of an event is determined by the combination of scope,
+ *   event type, and sub-type. There is no easy way to pre-sort clients
+ *   by scope or event type alone. For example, Torrent ISR route change
+ *   event is reported with scope 0x00 (Not Applicatable) rather than
+ *   0x3B (Torrent-hub). It is easier to let the clients to identify
+ *   who owns the the event. This is bad for performance but we should
+ *   only have a very small number of clients.
+ */
+
+static irqreturn_t ioei_interrupt(int irq, void *dev_id)
+{
+	struct pseries_io_event_sect_data *ioei_buf;
+	int status, event_valid;
+
+	ioei_buf = kmalloc(sizeof(struct pseries_io_event_sect_data),
+			   GFP_ATOMIC);
+	/* Need to call rtas_call() to release IRQ even if kmalloc() failed. */
+	do {
+		spin_lock(&rtas_data_buf_lock);
+		status = rtas_call(ioei_check_exception_token, 6, 1, NULL,
+				   RTAS_VECTOR_EXTERNAL_INTERRUPT,
+				   virq_to_hw(irq),
+				   RTAS_IO_EVENTS, 1 /* Time Critical */,
+				   __pa(&rtas_data_buf),
+				   RTAS_DATA_BUF_SIZE);
+		if ((status == 0) &&
+		    ioei_get_event((struct rtas_error_log *) &rtas_data_buf,
+				   ioei_buf))
+			event_valid = 1;
+		else
+			event_valid = 0;
+		spin_unlock(&rtas_data_buf_lock);
+		if (event_valid)
+			ioei_call_handlers(ioei_buf);
+	} while (status == 0);
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
diff --git a/arch/powerpc/platforms/pseries/pseries_event_log.c b/arch/powerpc/platforms/pseries/pseries_event_log.c
new file mode 100644
index 0000000..c00837d
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/pseries_event_log.c
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2010 Tseng-Hui (Frank) Lin, IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+/*
+ * IBM pSerie platform event log specific functions.
+ * All data in this file is in big endian.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include <asm/rtas.h>
+
+#include "pseries_event_log.h"
+
+/*
+ * Find the size of data portation in a platform event log section.
+ */
+size_t pseries_elog_sect_data_len(void *sect_data_p)
+{
+	struct pseries_elog_section *p;
+
+	p = container_of(sect_data_p, struct pseries_elog_section, sect_data);
+	return(p->length - offsetof(struct pseries_elog_section, sect_data));
+}
+
+/*
+ * Find data portion of a specific section in extended error/event log.
+ * Return:
+ *	location of section data
+ *	NULL if not found
+ */
+void *pseries_elog_find_section(
+		struct rtas_error_log_v6ext *v6ext, size_t v6ext_len,
+		uint16_t sect_id)
+{
+	struct pseries_elog_section *sect_p;
+	uint8_t *p, *log_end;
+
+	if ((v6ext_len < sizeof(struct rtas_error_log_v6ext)) ||
+	    (v6ext->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG) ||
+	    (v6ext->company_id != RTAS_V6EXT_COMPANY_ID_IBM))
+		return NULL;
+
+	log_end = (uint8_t *) v6ext + v6ext_len;
+	p = (uint8_t *) v6ext->vendor_log;
+	while (p < log_end) {
+		sect_p = (struct pseries_elog_section *) p;
+		if (sect_p->id == sect_id)
+			return sect_p->sect_data;
+		p += sect_p->length;
+	}
+
+	return NULL;
+}
+
