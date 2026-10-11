Return-Path: <linuxppc-dev+bounces-29201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D26CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 19:58:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2rxQ5T7Bz3bwd;
	Mon, 12 Oct 2026 06:58:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748682;
	cv=none; b=Uh1YZdwUBi21ODtYfqzIn8cVQsnd8UEdE2sRNosXC7ImY77ReR+qrPaXjoEjXI1LYq64JYD08O6fFEqpQ2r3ULQGmzQ7CzRihzrn35xp94PZsXROFbpY714b0kct3Ddoz0ULqRhKquZDABmbSB12ABFsA3wP3p7KHG6waVdpQtWGNO2yluRU0SsHNIogsrhYx8Ylu5zIUowXyqQc6l0OLJXeIR1MBT6GvELbqFMWM1OCwMoJko+fWvFnkunRVhYfmDw4nQU+L2IrzJK+VxjhV31pkU+IprtZZOUxEpZieELCG3Tzy3C59V+84qrpP6ewfqAx5jmtwn36Rby4uNFa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748682; c=relaxed/relaxed;
	bh=anERnWHtuXwEcIQ8AkUzNcW+B0MsW+CJ1YCPxhosgmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZmfN93CDzkMLbmLbEcQhTvoB9UeKh7U9sDB2SPotN7sEVXq1YJrDHv0weTAhJi3FVpH35cq3baWFpqvvhOr+2RwSEdd9hwi+qVktoEPeuX+oNyTnn2oMJrSBGzGfD41h1pncuXmlGvWKU5lWK+GEqAngibTZef0KOJYGd+e0ZlYZL4ROnD5TLygdbAZYzFcPCS9FgTa/+ZbTU/Zf4qBRzEPDJMGPyHJqc1/Rkz4p6/tXqinN+MRQo/eGibuT0aM8XeYAJI+2q0qPbQFO5CIUJcQWTOUdMs0+/2nHbg262rlXQKFWmLQZI5naeW7hgjdxXNx1NQ68S5Sr6D+PJtbmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMki68TI; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMki68TI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rxP51Z4z3c1L
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 06:58:01 +1100 (AEDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-c2e3846d1caso220308266b.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 12:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748678; x=1792353478; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anERnWHtuXwEcIQ8AkUzNcW+B0MsW+CJ1YCPxhosgmo=;
        b=QMki68TI0y/EGCWIhS6nk7XU+RQUYorQyS3RJIFc5FszrflCAosT+dyDwcrc+dQ4ga
         ErYJqbtxQFI42jJ3xNhBYOhGS4H8UozEuWj9lSkFhl7ouZWMGrk00jh4evvADmaYq/hk
         86czK1HT4V+/GZCUphM8rFTuygTsa6EV+GaY/qvsRS+CWxMHu1XQRm66Icwon2HcVtMk
         U6DhXZ6ADHvnxKGizxJKIqooe7xFpdXeK0G6fgkqoz+Bm9kS9p+E2Wjgq1y+syHQ7szm
         VL1Cp482N3NnkP7DzXG/YVaUgLof+n8NjPw8qgGbA80AgoSWQfzimyfZHCxd1Vt8FgOm
         VVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748678; x=1792353478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anERnWHtuXwEcIQ8AkUzNcW+B0MsW+CJ1YCPxhosgmo=;
        b=GeWQAECXtXOdxJGGG6ewwNw74kOHcFhK9+FHTHoSLi0f9azIPrTrCAYzsNHC41HOqt
         bxf2ln9+5RXN56T7+aVoa5f2VKvIOqN2yWfrWvtX1LavblXJQmFwu9tHz360Lg41Rpf4
         +m0lt6zliwHzA5CYUMBhCKwP9BJb7L+imfZ8SRHdbkt6hA+n/B/EsMfT4zDxqzCsmKGZ
         G7IWPrbjQyXmMVYuIqzatEwUYnF88DcaL2QyCVbLfROvS5JhDnbui3hqEB/UD3dzZYVw
         dAzOMGVaoIT5O4ZROu64nygXioj0HmqSngvDwaprRRiRelTgD2ePqxw3mUv5WlL3gfUr
         OH6A==
X-Forwarded-Encrypted: i=1; AKwUvBzgzPenqSnfkZzvif6BSQkpWoQGK0shfS86jDq3c2PlNvp2youNuEIP+DGZQ6cvb9BNPIqwvm/dI45VYqs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI0fYxRED17uB6vEAv0/BmEGQDNJ4DrMJbVY+ucr+J8BFYq5bFy
	QWrNtLCUuDqFLohPPeLOUSI6kK/eCKIIHVyFZgh3nI9pPXp9rQpuDUlXGFRPC3bL
X-Gm-Gg: AYBFou0iRdfa5Z3BoCug1BCkOGJxUG2tQcIX26K4PjKV+O56Ng2XEfIE1Xex/gSuLCZ
	ywDwxifkS8kIuvolK7eJAtHPjKCl7XFecqGnvVgJ5PO3WktxRWUMyzyJ1/mrynDsPJnygD4s1VT
	N8HxgSXFETDCrJNH0FTfYH+AqOkicW3coRVCnR6Pg/pk4Cw4QAtG+n2YC+4pbOsHrgDdguqt0e3
	mGiYLRBw2mwsWVFbezH6jwsagVcCej8l9gjLiBODqxoBU1LGJBb2w31tvqWP+IoVCMd7UIjj0uG
	s4ij1L+Y2BVsngn21bPxHB2BhASxL/p6TN5H+d/6Qhp+K3YCmt1PvuV2Vm/MTUEmkqm6OSWoM4T
	rVOLr7qpAjB3Mvlw3l9zoOKPHLum3p95VX6KahehGiPFnkEx2jjCWq2SGjaYw1tg2GobLBQmcL5
	zSUceA3xUKm5LIy+v2GUPowc0P36hyJ7zALubgKBwYG5rHMYr52F06zz5ezjiwJKbx8rGYCvu6I
	Y5UhmBdWqKM5GG2gThHctr6DxtlFn95U9316qQk
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr851073766b.7.1791748678067;
        Sun, 11 Oct 2026 12:57:58 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:56 -0700 (PDT)
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
Subject: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
Date: Sun, 11 Oct 2026 21:55:58 +0200
Message-ID: <20261011195729.981243-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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
 drivers/tty/hvc/hvc_m3000.c | 205 ++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
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
index 000000000000..1285e2db2fab
--- /dev/null
+++ b/drivers/tty/hvc/hvc_m3000.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * M3000 Open Firmware pseudo-console backend.
+ * Copyright (C) 2026 Magnus Lindholm
+ */
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
+struct m3000_console {
+	int stdin;
+	bool ready;
+	u8 buffer[256];
+	raw_spinlock_t buffer_lock;
+	struct timer_list poll_timer;
+	struct mutex poll_mutex; /* Serialize open against synchronous close. */
+	spinlock_t poll_lock; /* Protect active state and timer rearming. */
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&con->poll_lock, flags);
+	if (con->poll_active) {
+		hvc_kick();
+		mod_timer(&con->poll_timer, jiffies + 1);
+	}
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+}
+
+static int m3000_open(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+	unsigned long flags;
+
+	if (!con)
+		return -ENODEV;
+	mutex_lock(&con->poll_mutex);
+	spin_lock_irqsave(&con->poll_lock, flags);
+	con->poll_active = true;
+	mod_timer(&con->poll_timer, jiffies + 1);
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+	mutex_unlock(&con->poll_mutex);
+	return 0;
+}
+
+static void m3000_close(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+	unsigned long flags;
+
+	if (!con)
+		return;
+	mutex_lock(&con->poll_mutex);
+	spin_lock_irqsave(&con->poll_lock, flags);
+	con->poll_active = false;
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+	/* Block reopen until the callback has finished and cannot rearm. */
+	timer_delete_sync(&con->poll_timer);
+	mutex_unlock(&con->poll_mutex);
+}
+
+static ssize_t m3000_io(struct m3000_console *con, u8 *in,
+			const u8 *out, size_t count)
+{
+	unsigned long args[7], flags;
+	bool input = in;
+	int ret;
+
+	if (!count)
+		return 0;
+	count = min(count, input ? 1 : sizeof(con->buffer));
+	/* Console writes can run with interrupts disabled; this lock cannot sleep. */
+	raw_spin_lock_irqsave(&con->buffer_lock, flags);
+	if (!input)
+		memcpy(con->buffer, out, count);
+	args[0] = (unsigned long)(input ? "read" : "write");
+	args[1] = 3;
+	args[2] = 1;
+	args[3] = (unsigned int)(input ? con->stdin : prom_stdout);
+	args[4] = (unsigned long)con->buffer;
+	args[5] = count;
+	args[6] = (unsigned long)-1;
+	p1275_cmd_direct(args);
+	ret = (int)args[6];
+	if (ret > 0 && ret <= count && input)
+		memcpy(in, con->buffer, ret);
+	raw_spin_unlock_irqrestore(&con->buffer_lock, flags);
+	if (ret == -2 || ret == 0)
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
-- 
2.43.0


