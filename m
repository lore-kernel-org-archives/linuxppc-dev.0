Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 85558140095
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2014 16:28:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id s345RxMP004769
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Apr 2014 00:28:00 -0500
Message-ID: <1396589279.5106.30.camel@pasglop>
Subject: [PATCH] powerpc/powernv: Add debugfs file to grab opalv3 trace data
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Date: Fri, 04 Apr 2014 16:27:59 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rusty Russell <rusty@rustcorp.com.au>

This adds files in debugfs that can be used to retrieve the
OPALv3 firmware "live binary traces" which can then be parsed
using a userspace tool.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/Makefile           |   2 +-
 arch/powerpc/platforms/powernv/opal-trace-types.h |  58 +++++++
 arch/powerpc/platforms/powernv/opal-trace.c       | 183 ++++++++++++++++++++++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-trace-types.h
 create mode 100644 arch/powerpc/platforms/powernv/opal-trace.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index f5d4149..e34a28d 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -2,7 +2,7 @@ obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o opal-sysparam.o
 obj-y			+= rng.o opal-dump.o opal-elog.o opal-sensor.o opal-msglog.o
 obj-y			+= subcore.o subcore-asm.o
-
+obj-$(CONFIG_DEBUG_FS)	+= opal-trace.o
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
diff --git a/arch/powerpc/platforms/powernv/opal-trace-types.h b/arch/powerpc/platforms/powernv/opal-trace-types.h
new file mode 100644
index 0000000..e9816d4
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-trace-types.h
@@ -0,0 +1,58 @@
+/* API for kernel to read trace buffer. */
+#ifndef __OPAL_TRACE_TYPES_H
+#define __OPAL_TRACE_TYPES_H
+
+#define TRACE_REPEAT 1
+#define TRACE_OVERFLOW 2
+#define TRACE_OPAL 3
+#define TRACE_FSP 4
+
+/* One per cpu, plus one for NMIs */
+struct tracebuf {
+	/* Mask to apply to get buffer offset. */
+	u64 mask;
+	/* This where the buffer starts. */
+	u64 start;
+	/* This is where writer has written to. */
+	u64 end;
+	/* This is where the writer wrote to previously. */
+	u64 last;
+	/* This is where the reader is up to. */
+	u64 rpos;
+	/* If the last one we read was a repeat, this shows how many. */
+	u32 last_repeat;
+	/* Maximum possible size of a record. */
+	u32 max_size;
+
+	char buf[/* TBUF_SZ + max_size */];
+};
+
+/* Common header for all trace entries. */
+struct trace_hdr {
+	u64 timestamp;
+	u8 type;
+	u8 len_div_8;
+	u16 cpu;
+	u8 unused[4];
+};
+
+/* Note: all other entries must be at least as large as this! */
+struct trace_repeat {
+	u64 timestamp; /* Last repeat happened at this timestamp */
+	u8 type; /* == TRACE_REPEAT */
+	u8 len_div_8;
+	u16 cpu;
+	u16 prev_len;
+	u16 num; /* Starts at 1, ie. 1 repeat, or two traces. */
+	/* Note that the count can be one short, if read races a repeat. */
+};
+
+struct trace_overflow {
+	u64 unused64; /* Timestamp is unused */
+	u8 type; /* == TRACE_OVERFLOW */
+	u8 len_div_8;
+	u8 unused[6]; /* ie. hdr.cpu is indeterminate */
+	u64 bytes_missed;
+};
+
+#endif /* __OPAL_TRACE_TYPES_H */
diff --git a/arch/powerpc/platforms/powernv/opal-trace.c b/arch/powerpc/platforms/powernv/opal-trace.c
new file mode 100644
index 0000000..e445528
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/opal-trace.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) 2013 Rusty Russell, IBM Corporation
+ *
+ * Simple debugfs file firmware_trace to read out OPALv3 trace
+ * ringbuffers.
+ */
+#include <linux/mutex.h>
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <asm/debug.h>
+
+#include "opal-trace-types.h"
+
+static DEFINE_MUTEX(tracelock);
+static struct tracebuf **tb;
+static size_t num_tb;
+
+/* Maximum possible size of record (since len is 8 bits). */
+union max_trace {
+	struct trace_hdr hdr;
+	struct trace_overflow overflow;
+	struct trace_repeat repeat;
+	char buf[255 * 8];
+};
+static union max_trace trace;
+
+static bool trace_empty(const struct tracebuf *tb)
+{
+	const struct trace_repeat *rep;
+
+	if (tb->rpos == tb->end)
+		return true;
+
+	/*
+	 * If we have a single element only, and it's a repeat buffer
+	 * we've already seen every repeat for (yet which may be
+	 * incremented in future), we're also empty.
+	 */
+	rep = (void *)tb->buf + (tb->rpos & tb->mask);
+	if (tb->end != tb->rpos + sizeof(*rep))
+		return false;
+
+	if (rep->type != TRACE_REPEAT)
+		return false;
+
+	if (rep->num != tb->last_repeat)
+		return false;
+
+	return true;
+}
+
+/* You can't read in parallel, so some locking required in caller. */
+static bool trace_get(union max_trace *t, struct tracebuf *tb)
+{
+	u64 start;
+
+	if (trace_empty(tb))
+		return false;
+
+again:
+	/*
+	 * The actual buffer is slightly larger than tbsize, so this
+	 * memcpy is always valid.
+	 */
+	memcpy(t, tb->buf + (tb->rpos & tb->mask), tb->max_size);
+
+	rmb(); /* read barrier, so we read tb->start after copying record. */
+
+	start = tb->start;
+
+	/* Now, was that overwritten? */
+	if (tb->rpos < start) {
+		/* Create overflow record. */
+		t->overflow.unused64 = 0;
+		t->overflow.type = TRACE_OVERFLOW;
+		t->overflow.len_div_8 = sizeof(t->overflow) / 8;
+		t->overflow.bytes_missed = start - tb->rpos;
+		tb->rpos += t->overflow.bytes_missed;
+		return true;
+	}
+
+	/* Repeat entries need special handling */
+	if (t->hdr.type == TRACE_REPEAT) {
+		u32 num = t->repeat.num;
+
+		/* In case we've read some already... */
+		t->repeat.num -= tb->last_repeat;
+
+		/* Record how many repeats we saw this time. */
+		tb->last_repeat = num;
+
+		/* Don't report an empty repeat buffer. */
+		if (t->repeat.num == 0) {
+			/*
+			 * This can't be the last buffer, otherwise
+			 * trace_empty would have returned true.
+			 */
+			BUG_ON(tb->end <= tb->rpos + t->hdr.len_div_8 * 8);
+			/* Skip to next entry. */
+			tb->rpos += t->hdr.len_div_8 * 8;
+			goto again;
+		}
+	} else {
+		tb->last_repeat = 0;
+		tb->rpos += t->hdr.len_div_8 * 8;
+	}
+
+	return true;
+}
+
+/* Horrible polling interface, designed for dumping. */
+static ssize_t read_opal_trace(struct file *file, char __user *ubuf,
+			       size_t count, loff_t *ppos)
+{
+	ssize_t err;
+	unsigned int i;
+
+	err = mutex_lock_interruptible(&tracelock);
+	if (err)
+		return err;
+
+	for (i = 0; i < num_tb; i++) {
+		if (trace_get(&trace, tb[i])) {
+			size_t len = trace.hdr.len_div_8 * 8;
+			if (len > count)
+				len = count;
+			if (copy_to_user(ubuf, &trace, len) != 0)
+				err = -EFAULT;
+			else
+				err = len;
+			break;
+		}
+	}
+
+	mutex_unlock(&tracelock);
+	return err;
+}
+
+static const struct file_operations opal_trace_fops = {
+	.read =		read_opal_trace,
+	.open =		simple_open,
+};
+
+static int opal_trace_init(void)
+{
+	struct device_node *dn;
+	const u64 *reg;
+	int len, i;
+
+	dn = of_find_node_by_name(NULL, "ibm,trace");
+	if (!dn)
+		return -ENODEV;
+
+	reg = of_get_property(dn, "reg", &len);
+	if (!reg) {
+		pr_warning("%s: OF node property %s::reg not found\n",
+			   __func__, dn->full_name);
+		goto fail;
+	}
+
+	num_tb = len / (sizeof(u64) * 2);
+	if (!num_tb) {
+		pr_warning("%s: OF node property %s::reg invalid length %i\n",
+			   __func__, dn->full_name, len);
+		goto fail;
+	}
+	tb = kmalloc(sizeof(*tb) * num_tb, GFP_KERNEL);
+	for (i = 0; i < num_tb; i++)
+		tb[i] = __va(be64_to_cpu(reg[i*2]));
+
+	debugfs_create_file("opal-trace", 0400, powerpc_debugfs_root,
+			    NULL, &opal_trace_fops);
+	of_node_put(dn);
+	return 0;
+
+fail:
+	of_node_put(dn);
+	return -EINVAL;
+}
+module_init(opal_trace_init);
+
