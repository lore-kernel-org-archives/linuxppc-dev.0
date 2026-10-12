Return-Path: <linuxppc-dev+bounces-29311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08078CA9EDE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 18:49:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3RMK4PsXz3c5X;
	Tue, 13 Oct 2026 05:49:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791830941;
	cv=none; b=Pf/B2+Luo2cDaGprHgXMUUDk294BwX0gR3KgsDBT5VsykwdO0EFxHiqcoqZnq+hehv61H+KCojMm20dakpmCbSESuXYclsdbxdU2IXBB56TalHjb8JXzD2Z2Fbg1ciV2hyjJkOzpC6y6BrV1/JSEIQjs4VDymOlMqHyH52X++BDLxNeWHB9E00+hXbYhEMpGThU4MDBYCzhvks8GHiCmIwHfB8Wu0/IGdvedCJzWRzHRDYxNP0Jc/hZ3VxXC1HqhlRdBfwP+9FPJsfSH7Pwh+d0zBaxeBm6O9wMhuIcG9XlryoHawfx+QHvek/dZgUlaDSQTQGikRef2phtaeX0y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791830941; c=relaxed/relaxed;
	bh=610aJOS3KSFxDHW6+rlhqi/OovTQRCQD2t1rd5FNkxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTGRs7FZiylF3rSu8bpeLsPxDnabauAdh3hzsU2N7UNa/rcHL6AUAyt9XBQvtmhPJe6D70a4gNXO8iYg5ETmp9ZIfkQCDOLjeGNI7iV7DpZoeC6KGodzAXP2Ua5ZNmE2Q6g5nb/Tm1USJbLPs2GMrRZRcNI5eOuWtoKAHSMmys+IjJRSap2jEBxqBpuje54rfCbpxX2QGhw1cV76CTXwN1Q9Ff1lGmHMIDsBYNLHo6mfQw98VDO3Jc34+rSRr1OLJCmtYTWwLYSkepjgXbU/gb2N58jqrMeEZkqdvsmArukUGkq+pn541pxKyImQ+h+nMXkE5Dgq+u7LwF81t5Xyxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlCbRLDA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlCbRLDA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3RMG6XR1z3c2W
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 05:48:58 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c2e6df2742cso324705466b.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830935; x=1792435735; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=610aJOS3KSFxDHW6+rlhqi/OovTQRCQD2t1rd5FNkxQ=;
        b=UlCbRLDAMmIrmQ5XwvZPyVBvADmMd9+orgX3ve6P65cOEKXGHvg5mbXcBMY8smvq8R
         fKRbewsuTCtxSouDLWntUKdtRIoCdW+nldioIQPQjchx/mleiEwOnI7H3bGJYVtQkKaT
         q4wbIoYdIgr9pBoEC9FB8It5BRtu3E3weh56RUX7od/eyWKfD2nSBVTDc/qvxBsTSAAw
         BS/MMYAonD53m5wDiubAQM6GEPDjo+gvPEZM2HRFfvacURLgEvqlnH5hCaLVJK8pmDSv
         GwyZiysXU6jvgDsjILGFue520sUGu2fM79DYuI/OOq9wTpONGFR2c7RpImjmXAkOSQKW
         4C2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830935; x=1792435735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=610aJOS3KSFxDHW6+rlhqi/OovTQRCQD2t1rd5FNkxQ=;
        b=HaHGKfTea8SdmvYAkV63X005KiWFAX0nfYus9+nd+DxBAlHgAsASKUkoFYdLjII5dh
         UqlYsHxEaEyoFi27Eb4LpTRZ0mHANscfZHcA1izGfc4/wdJR1KOpdaAq1FjCSyOyOsfN
         Lt/gaf1Yvncgw/0DxvSwM4RaA6BDt3kgVfhDvQytUbZHCgOQzci/a5XeQPMbfMZh8fao
         /pB3Z0yQUpEDwEBb9njFMKAh6x6UozgbzlaOCDmycrqcEStyaWv1YCnLVQ8gfHmkD/n8
         7X9TO0wLqoq6PlGqLRBznOohWMcdVb+YOVyKkGGJVssot0s0FqVxwhRsxtiJz8qiQ/G4
         8TYg==
X-Forwarded-Encrypted: i=1; AKwUvByaVFUXELJKzJGTMPKV+dIpJ/QLRbzZEoh//k5NkXzmXK+BuFP066ymqnDi+yhCWjBjB5A6o5npWe3UE/Q=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIH1XLHlnlYhWmhFDXBdjeUKWl930EX25Qbw9hI1ChsLGVxXqxW
	do4cWE4btsTybDY1oQVugp1eXujXzxEPe19jCd/fVGNqFw4GSSPQz1CU
X-Gm-Gg: AYBFou1zeGYOPb4JshPmJrO+ld8HnA+gm5YmzOSjILJdKnlICenpBPXbPue4cm77Y7A
	EdtZY/uY0fl29NepbvuTdCbOWIa2DrIPX8p9XOafRdoFIKdsJV4BBfU1fVo8FkA+ql77tHw36xr
	TorVBYBmo2avTUiAjSp6QSs7QuZy4l42EntJkjUeC4HbSYK/GNjnkwZIAHfXmPPOolwEvJvjQV2
	xJ/2WFp4hEPIxmwYz9cact7iLPNypRg3mmYiJ6U37ohiRKXamn77OZBPE9xgzUc0nRrxs6z1IiT
	lIj31xC1tlHaAdi6IOF4fIzZjGCjJ88vpd/Np3GtdDojaGo6Pi3FCgempu1P0f2Cv0XoyhaYfbJ
	KrbKqFKNGSxZYZOdmWx1WgtOn3HiSlo19NR/Liwfshyz/NNEaZ7uqJftkl/AZ0LT1BFdcgR7ob8
	xAJlnKVYi5+m4R+QDDRYClNcAFXp6ijasDs0cEP93LmVtUETkJ5cfhW1GBjKpsErlemDyUG2xaK
	3w3lS+/e2NCzz7hyYB4xu1sUYvZpPsmLPJcu9vx5A==
X-Received: by 2002:a17:907:3f8e:b0:c29:f5d5:5aa7 with SMTP id a640c23a62f3a-c31aa0c0ae8mr963057166b.49.1791830935522;
        Mon, 12 Oct 2026 11:48:55 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:55 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v3 8/8] hvc: add an M3000 firmware console backend
Date: Mon, 12 Oct 2026 20:48:09 +0200
Message-ID: <20261012184826.986050-9-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
the firmware model and console endpoints before registering it. Keep
firmware buffers in locked kernel mappings and serialize their use in
atomic console contexts through the existing SPARC p1275 interface.

Poll input while the TTY is open and synchronize close with timer
rearming. Return zero on no progress so HVC retries buffered TTY output
but drops stalled console chunks instead of spinning indefinitely.
A firmware call that does not return remains unbounded.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 MAINTAINERS                 |   6 ++
 drivers/tty/hvc/Kconfig     |  10 ++
 drivers/tty/hvc/Makefile    |   1 +
 drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..5bc9b1cabd0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10728,6 +10728,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-laptop.c
 
+FUJITSU M3000 FIRMWARE CONSOLE
+M:	Magnus Lindholm <linmag7@gmail.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/hvc/hvc_m3000.c
+
 FUJITSU TABLET EXTRAS
 M:	Robert Gerlach <khnz@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 5866195de26a..0feb7ec98f4f 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -134,3 +134,13 @@ config HVCS
 	  will depend on arch specific APIs exported from hvcserver.ko
 	  which will also be compiled when this driver is built as a
 	  module.
+
+config HVC_M3000
+	bool "M3000 firmware pseudo-console"
+	depends on SPARC64_VII
+	select HVC_DRIVER
+	help
+	  Provide hvc0 using Open Firmware stdin/stdout on IKKAKU only.
+	  Input is polled; no native UART registers are accessed.
+	  Firmware calls are serialized and use a locked-image bounce buffer.
+	  Say Y to use the M3000 firmware pseudo-console as hvc0.
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 98880e357941..38c8cf349053 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVC_RISCV_SBI)	+= hvc_riscv_sbi.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+obj-$(CONFIG_HVC_M3000)		+= hvc_m3000.o
diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
new file mode 100644
index 000000000000..e2150d479308
--- /dev/null
+++ b/drivers/tty/hvc/hvc_m3000.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * M3000 Open Firmware pseudo-console backend.
+ * Copyright (C) 2026 Magnus Lindholm
+ */
+#include <linux/cleanup.h>
+#include <linux/console.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <asm/oplib.h>
+#include <asm/spitfire.h>
+#include "hvc_console.h"
+
+#define M3000_PROM_IO_ARGS	3
+#define M3000_PROM_IO_RETURNS	1
+#define M3000_PROM_ERROR		(-1)
+#define M3000_PROM_NO_DATA	(-2)
+
+struct m3000_console {
+	struct timer_list poll_timer;
+	struct mutex poll_mutex; /* Serialize open against synchronous close. */
+	raw_spinlock_t buffer_lock;
+	spinlock_t poll_lock; /* Protect active state and timer rearming. */
+	int stdin;
+	u8 buffer[256];
+	bool ready;
+	bool poll_active;
+};
+
+/* Keep the firmware buffer within the locked kernel image mappings. */
+static struct m3000_console m3000_consoles[] = {
+	{
+		.buffer_lock = __RAW_SPIN_LOCK_UNLOCKED(m3000_consoles[0].buffer_lock),
+		.poll_mutex = __MUTEX_INITIALIZER(m3000_consoles[0].poll_mutex),
+		.poll_lock = __SPIN_LOCK_UNLOCKED(m3000_consoles[0].poll_lock),
+	},
+};
+
+static struct m3000_console *m3000_console(u32 termno)
+{
+	if (termno >= ARRAY_SIZE(m3000_consoles))
+		return NULL;
+	return &m3000_consoles[termno];
+}
+
+/*
+ * HVC's idle backoff can exceed the firmware input FIFO's capacity.
+ * Wake its worker each tick while open; keep PROM calls out of the timer.
+ */
+static void m3000_poll_tick(struct timer_list *timer)
+{
+	struct m3000_console *con = timer_container_of(con, timer, poll_timer);
+
+	guard(spinlock_irqsave)(&con->poll_lock);
+	if (con->poll_active) {
+		hvc_kick();
+		mod_timer(&con->poll_timer, jiffies + 1);
+	}
+}
+
+static int m3000_open(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+
+	if (!con)
+		return -ENODEV;
+	guard(mutex)(&con->poll_mutex);
+	guard(spinlock_irqsave)(&con->poll_lock);
+	con->poll_active = true;
+	mod_timer(&con->poll_timer, jiffies + 1);
+	return 0;
+}
+
+static void m3000_close(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+
+	if (!con)
+		return;
+	guard(mutex)(&con->poll_mutex);
+	scoped_guard(spinlock_irqsave, &con->poll_lock)
+		con->poll_active = false;
+	/* Block reopen until the callback has finished and cannot rearm. */
+	timer_delete_sync(&con->poll_timer);
+}
+
+static ssize_t m3000_io(struct m3000_console *con, u8 *in,
+			const u8 *out, size_t count)
+{
+	unsigned long args[3 + M3000_PROM_IO_ARGS + M3000_PROM_IO_RETURNS];
+	int ret;
+
+	if (!count)
+		return 0;
+	count = min(count, in ? 1 : sizeof(con->buffer));
+	/* Console writes can run with interrupts disabled; this lock cannot sleep. */
+	scoped_guard(raw_spinlock_irqsave, &con->buffer_lock) {
+		if (!in)
+			memcpy(con->buffer, out, count);
+		args[0] = (unsigned long)(in ? "read" : "write");
+		args[1] = M3000_PROM_IO_ARGS;
+		args[2] = M3000_PROM_IO_RETURNS;
+		args[3] = (unsigned int)(in ? con->stdin : prom_stdout);
+		args[4] = (unsigned long)con->buffer;
+		args[5] = count;
+		args[6] = (unsigned long)M3000_PROM_ERROR;
+		p1275_cmd_direct(args);
+		ret = (int)args[6];
+		if (ret > 0 && ret <= count && in)
+			memcpy(in, con->buffer, ret);
+	}
+	if (ret == M3000_PROM_NO_DATA || ret == 0)
+		return 0;
+	if (ret < 0 || ret > count)
+		return -EIO;
+	return ret;
+}
+
+static ssize_t m3000_get(u32 termno, u8 *buf, size_t count)
+{
+	struct m3000_console *con = m3000_console(termno);
+
+	return con ? m3000_io(con, buf, NULL, count) : -ENODEV;
+}
+
+static ssize_t m3000_put(u32 termno, const u8 *buf, size_t count)
+{
+	struct m3000_console *con = m3000_console(termno);
+
+	/* HVC retries zero for TTY writes but drops stalled console output. */
+	return con ? m3000_io(con, NULL, buf, count) : -ENODEV;
+}
+
+static const struct hv_ops m3000_ops = {
+	.get_chars = m3000_get,
+	.put_chars = m3000_put,
+	.notifier_add = m3000_open,
+	.notifier_del = m3000_close,
+	.notifier_hangup = m3000_close,
+};
+
+static bool __init m3000_property_matches(phandle node, const char *prop,
+					  const char *expected)
+{
+	char value[64];
+	int len;
+
+	len = prom_getproperty(node, prop, value, sizeof(value) - 1);
+	if (len <= 0)
+		return false;
+	value[len] = '\0';
+	return !strcmp(value, expected);
+}
+
+static int __init m3000_console_init(void)
+{
+	struct m3000_console *con = &m3000_consoles[0];
+	phandle node;
+	int ret;
+
+	if (tlb_type != sparc64_vii)
+		return -ENODEV;
+	if (!m3000_property_matches(prom_finddevice("/"), "model", "IKKAKU"))
+		return -ENODEV;
+	con->stdin = prom_getint(prom_chosen_node, "stdin");
+	if (!con->stdin || con->stdin == -1 || !prom_stdout || prom_stdout == -1)
+		return -ENODEV;
+	node = prom_inst2pkg(prom_stdout);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	node = prom_inst2pkg(con->stdin);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	ret = hvc_instantiate(0, 0, &m3000_ops);
+	if (ret < 0)
+		return ret;
+	con->ready = true;
+	return 0;
+}
+console_initcall(m3000_console_init);
+
+static int __init m3000_tty_init(void)
+{
+	struct m3000_console *con = &m3000_consoles[0];
+	struct hvc_struct *hp;
+
+	if (!con->ready)
+		return -ENODEV;
+	timer_setup(&con->poll_timer, m3000_poll_tick, 0);
+	hp = hvc_alloc(0, 0, &m3000_ops, sizeof(con->buffer));
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	hp->ws.ws_row = 24;
+	hp->ws.ws_col = 80;
+	return 0;
+}
+device_initcall(m3000_tty_init);

