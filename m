Return-Path: <thlin@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E91A1007D1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2011 08:32:56 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p45ExdX6031045
	for <linuxppc-dev@ozlabs.org>; Thu, 5 May 2011 08:59:39 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p45MXvVk041594
	for <linuxppc-dev@ozlabs.org>; Thu, 5 May 2011 16:33:57 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p45MWnTl011775
	for <linuxppc-dev@ozlabs.org>; Thu, 5 May 2011 16:32:49 -0600
Subject: [PATCH 2/2] powerpc/pseries: Add support for IO event interrupts
From: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 May 2011 17:32:48 -0500
Message-ID: <1304634768.5943.4.camel@flin.austin.ibm.com>
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


From: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>

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

Change log:
- Fixed compilation errors
- Fix comments to be docbook compliant
- Fix some code format

Signed-off-by: Tseng-Hui (Frank) Lin <thlin@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/io_event_irq.h       |   54 ++++++
 arch/powerpc/platforms/pseries/Kconfig        |   18 ++
 arch/powerpc/platforms/pseries/Makefile       |    1 +
 arch/powerpc/platforms/pseries/io_event_irq.c |  231 +++++++++++++++++++++++++
 4 files changed, 304 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/io_event_irq.h b/arch/powerpc/include/asm/io_event_irq.h
new file mode 100644
index 0000000..b1a9a1b
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
+struct pseries_io_event {
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
index b044922..71af4c5 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -50,6 +50,24 @@ config SCANLOG
 	tristate "Scanlog dump interface"
 	depends on RTAS_PROC && PPC_PSERIES
 
+config IO_EVENT_IRQ
+	bool "IO Event Interrupt support"
+	depends on PPC_PSERIES
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
index 4cfefba..3556e40 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_HCALL_STATS)	+= hvCall_inst.o
 obj-$(CONFIG_PHYP_DUMP)		+= phyp_dump.o
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_DTL)		+= dtl.o
+obj-$(CONFIG_IO_EVENT_IRQ)	+= io_event_irq.o
 
 ifeq ($(CONFIG_PPC_PSERIES),y)
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/powerpc/platforms/pseries/io_event_irq.c b/arch/powerpc/platforms/pseries/io_event_irq.c
new file mode 100644
index 0000000..c829e60
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/io_event_irq.c
@@ -0,0 +1,231 @@
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
+ * 	.notifier_call = event_handler,
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
+static int ioei_check_exception_token;
+
+/* pSeries event log format */
+
+/* Two bytes ASCII section IDs */
+#define PSERIES_ELOG_SECT_ID_PRIV_HDR		(('P' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_HDR		(('U' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_PRIMARY_SRC	(('P' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_EXTENDED_UH	(('E' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FAILING_MTMS	(('M' << 8) | 'T')
+#define PSERIES_ELOG_SECT_ID_SECONDARY_SRC	(('S' << 8) | 'S')
+#define PSERIES_ELOG_SECT_ID_DUMP_LOCATOR	(('D' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_FW_ERROR		(('S' << 8) | 'W')
+#define PSERIES_ELOG_SECT_ID_IMPACT_PART_ID	(('L' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_LOGIC_RESOURCE_ID	(('L' << 8) | 'R')
+#define PSERIES_ELOG_SECT_ID_HMC_ID		(('H' << 8) | 'M')
+#define PSERIES_ELOG_SECT_ID_EPOW		(('E' << 8) | 'P')
+#define PSERIES_ELOG_SECT_ID_IO_EVENT		(('I' << 8) | 'E')
+#define PSERIES_ELOG_SECT_ID_MANUFACT_INFO	(('M' << 8) | 'I')
+#define PSERIES_ELOG_SECT_ID_CALL_HOME		(('C' << 8) | 'H')
+#define PSERIES_ELOG_SECT_ID_USER_DEF		(('U' << 8) | 'D')
+
+/* Vendor specific Platform Event Log Format, Version 6, section header */
+struct pseries_elog_section {
+	uint16_t id;			/* 0x00 2-byte ASCII section ID	*/
+	uint16_t length;		/* 0x02 Section length in bytes	*/
+	uint8_t version;		/* 0x04 Section version		*/
+	uint8_t subtype;		/* 0x05 Section subtype		*/
+	uint16_t creator_component;	/* 0x06 Creator component ID	*/
+	uint8_t data[];			/* 0x08 Start of section data	*/
+};
+
+static char ioei_rtas_buf[RTAS_DATA_BUF_SIZE] __cacheline_aligned;
+
+/**
+ * Find data portion of a specific section in RTAS extended event log.
+ * @elog: RTAS error/event log.
+ * @sect_id: secsion ID.
+ *
+ * Return:
+ *	pointer to the section data of the specified section
+ *	NULL if not found
+ */
+static struct pseries_elog_section *find_xelog_section(struct rtas_error_log *elog,
+						       uint16_t sect_id)
+{
+	struct rtas_ext_event_log_v6 *xelog =
+		(struct rtas_ext_event_log_v6 *) elog->buffer;
+	struct pseries_elog_section *sect;
+	unsigned char *p, *log_end;
+
+	/* Check that we understand the format */
+	if (elog->extended_log_length < sizeof(struct rtas_ext_event_log_v6) ||
+	    xelog->log_format != RTAS_V6EXT_LOG_FORMAT_EVENT_LOG ||
+	    xelog->company_id != RTAS_V6EXT_COMPANY_ID_IBM)
+		return NULL;
+
+	log_end = elog->buffer + elog->extended_log_length;
+	p = xelog->vendor_log;
+	while (p < log_end) {
+		sect = (struct pseries_elog_section *)p;
+		if (sect->id == sect_id)
+			return sect;
+		p += sect->length;
+	}
+	return NULL;
+}
+
+/**
+ * Find the data portion of an IO Event section from event log.
+ * @elog: RTAS error/event log.
+ *
+ * Return:
+ * 	pointer to a valid IO event section data. NULL if not found.
+ */
+static struct pseries_io_event * ioei_find_event(struct rtas_error_log *elog)
+{
+	struct pseries_elog_section *sect;
+
+	/* We should only ever get called for io-event interrupts, but if
+	 * we do get called for another type then something went wrong so
+	 * make some noise about it.
+	 * RTAS_TYPE_IO only exists in extended event log version 6 or later.
+	 * No need to check event log version.
+	 */
+	if (unlikely(elog->type != RTAS_TYPE_IO)) {
+		printk_once(KERN_WARNING "io_event_irq: Unexpected event type %d",
+			    elog->type);
+		return NULL;
+	}
+
+	sect = find_xelog_section(elog, PSERIES_ELOG_SECT_ID_IO_EVENT);
+	if (unlikely(!sect)) {
+		printk_once(KERN_WARNING "io_event_irq: RTAS extended event "
+			    "log does not contain an IO Event section. "
+			    "Could be a bug in system firmware!\n");
+		return NULL;
+	}
+	return (struct pseries_io_event *) &sect->data;
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
+	struct pseries_io_event *event;
+	int rtas_rc;
+
+	for (;;) {
+		rtas_rc = rtas_call(ioei_check_exception_token, 6, 1, NULL,
+				    RTAS_VECTOR_EXTERNAL_INTERRUPT,
+				    virq_to_hw(irq),
+				    RTAS_IO_EVENTS, 1 /* Time Critical */,
+				    __pa(ioei_rtas_buf),
+				    RTAS_DATA_BUF_SIZE);
+		if (rtas_rc != 0)
+			break;
+
+		event = ioei_find_event((struct rtas_error_log *)ioei_rtas_buf);
+		if (!event)
+			continue;
+
+		atomic_notifier_call_chain(&pseries_ioei_notifier_list,
+					   0, event);
+	}
+	return IRQ_HANDLED;
+}
+
+static int __init ioei_init(void)
+{
+	struct device_node *np;
+
+	ioei_check_exception_token = rtas_token("check-exception");
+	if (ioei_check_exception_token == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("IO Event IRQ not supported on this system !\n");
+		return -ENODEV;
+	}
+	np = of_find_node_by_path("/event-sources/ibm,io-events");
+	if (np) {
+		request_event_sources_irqs(np, ioei_interrupt, "IO_EVENT");
+		of_node_put(np);
+	} else {
+		pr_err("io_event_irq: No ibm,io-events on system! "
+		       "IO Event interrupt disabled.\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+machine_subsys_initcall(pseries, ioei_init);
+
