Return-Path: <linuxppc-dev+bounces-29656-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29D6CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 13:50:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j70RS6q7Mz2yD8;
	Mon, 19 Oct 2026 00:49:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792331396;
	cv=none; b=kr4uR3+FVQxH1wHeIZsrm3BawglpSyqUL51ufnovKgiAT3PlDP+e682Z+hVHUIuE0E8siIr2Vt4MKemIRWR5Vf0qas7FSt3ljNcLmqyf20Ba9+BVOEwviPUlQs2pI/aPvRljCvZsANmoAGeoJS9lRgnY+80ndvFDCQBuJ1vGtSWjr/4Qt1+RE8Mp446z7mfI6ECtEuc8CWGwsllps8hrlz8WH5+PBCkWiD+x/6KZuUXOiI8Qptvjzaa2BAV5Hev61DRLyP4lWMTOPQghM6mMPtBNLBuD7rkC5aNgc0kIFfJyVhLMzMySGfc+gqwsBciD0P9jk4Hk8CREiCnRPMkUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792331396; c=relaxed/relaxed;
	bh=lpRhgnnQ3c69BKtA52SSfn2OKHjIwq2qtwMcYorMrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LP1duBoywbT2c754hrabFS2icanL64fDbnPp4CrWshHfpvTVrn+kFjDaLDVEgi6ksnASdaRyPe/nIHzNO3QmbLkUu+zSTiYxGclZyFd0KYE4H3ad9LJ6Sr/wFz0CRPFfqz4O+7zAFJa3ZY1X4aDb2XP3CPz8rkGoS743eZyTEgCWIP2cn2RKJXicMUcfeA0s47NyCsg1JPcxxMyectGg1sJ2ZXdSvei7Y7V6kvt0G7BkqEhMdpIVQgJZLp6YX3Abta5HP4RFhxKZ9mu3SiGIdf07HjcBVEZfkCscWTG/e1cRbQ+Q4a8CP/veWv2jaVNCd8kxVFFI42ErCybv/ADRTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IW/dyFYx; dkim-atps=neutral; spf=pass (client-ip=209.85.218.48; helo=mail-ej1-f48.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IW/dyFYx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.218.48; helo=mail-ej1-f48.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j70RR6BVbz2xqh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 00:49:55 +1100 (AEDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2055573c8cso147218566b.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331390; x=1792936190; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpRhgnnQ3c69BKtA52SSfn2OKHjIwq2qtwMcYorMrto=;
        b=IW/dyFYxhV9QtvsvEq+w1/lI12aOFfbh06weFYq0/4a1X1lE5LtyAgz98sMd8BhYko
         mLGrbr8y6CzCYe1qROcIwHRU4DPLpdzPGOItneTxd1pA5h1bsnqD/3NEaInM7dB3R/2h
         ZvgrEvPDZ6CmjN2ETfA0uRNkLsToSk1bd9bPftGGxTCpgs1QOHh+9t4u2++EzedfmqvA
         jBetflyfhaFqAjFwicrv1cmDBW7OrCuSyMrxH+0Vc8srPfazCg5LzkXx5T+h/qtRH3H1
         XSFtxVmbFvTM3XDul6uzTA/MNKpaQOcTx+Wn+D+5mqz2KwvK0lRo8KX0Ofb2Be3X7by2
         /0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331390; x=1792936190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpRhgnnQ3c69BKtA52SSfn2OKHjIwq2qtwMcYorMrto=;
        b=rVD7ety9ZpG5boG/cOIAkFehvgGHKI8WCqXGa5mTq7xhZBnMp8oL+9DWpeTzhl1m6K
         z1VCsjGuBYaHNKv9yEAi/OplqAYyynSPJpvRaN96+uA2MeCFP+PQ4+yYLElpOVp0EEJ5
         1zOCatHxBL2NnqBeAQh0IRUPs9ywgC7N7TJQpKhVf/LiJjR7JUny5gQ0ZgMcO+I/YPFt
         mF1Pw/dVt6DKAdLVhXi5IoQIRMtEQlWdLLteXCEg7E9jCdhBtqBpuvsPH9l5qlzQ1yz9
         aVEHDvut0IwX8JeT2VZhBx+/Zvp3dZNLtjP2ZXcMCZwxTHz0EPUCfK2T4qdKqAoTHQV9
         eW0w==
X-Forwarded-Encrypted: i=1; AKwUvBzFwG41vDVR/ZXCG/HFjOG1YZMZRgIiV+qrS2SGmiTOf7MQxD/dAcBwKTSx09W6EMuf/9fPJEftN8M8AgY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKeWgK88GEpkkyxLE7JPl4LNstMcja2vhxDB37KzTMRk/bPwK0t
	yNTH4ZqFJR3ZrPomKfKpROtZLVLQwn0C6C71JUo925eWbWTkjipwXMkW
X-Gm-Gg: AYBFou0ZNLX7Tn/rIPrVTFzUTpqjHm7yZ04H5/3MBajrH3BOlv9n77UvBvkl9/N3dla
	y1UkOMyGPpcDm43R0rAhoLc3CttpcvRabTtllOd6qsrxh9DBXluwzam1JRGwrKY5El/fE8WoO/N
	VsmEFJQaGMu10fkuLuBACygD3ztj+0QOyqV2tTzOfVd6EJODmmXzKOFJYDB4Wnz5QuoWj3Lalot
	Vqnyo3tUo6s1n2vrXx00ZCwnBKp0yGRf5gh23PM4GhtRYOSYUgk9dVabGD9zS6waIVkw1VIcqp6
	Tvzp+vEBg3xHDKQHE0gTXIbw43uZCG0Sug2k/8llcpTHWSQzGadnpctBsVd3uTORVw3Q6Ecx1MM
	e6Bk3bKfSscrICdlZyrj8nJAoJucKLO/x8Li8QRstPWWMISYqzTmSJDA2GjX8JywgmUNMeN0RiO
	JD6gzeawSxuJHSfFzxygeXWire6CTuNl97Fth823o71jwXl+YWGFeYFZ47LsifUG3estXg4ttJs
	Eb1BWZbZcZC0mnZuE2rZ7+kxwc/BBQWbUgrQ3AP
X-Received: by 2002:a17:907:1c8f:b0:c26:1649:47a5 with SMTP id a640c23a62f3a-c419f121280mr341217266b.27.1792331390333;
        Sun, 18 Oct 2026 06:49:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:48 -0700 (PDT)
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
Subject: [PATCH v4 10/10] hvc: add an M3000 firmware console backend
Date: Sun, 18 Oct 2026 15:45:12 +0200
Message-ID: <20261018134738.1016106-11-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                 |   7 ++
 drivers/tty/hvc/Kconfig     |  11 ++
 drivers/tty/hvc/Makefile    |   1 +
 drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..21e4f4e558bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10728,6 +10728,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-laptop.c
 
+FUJITSU M3000 FIRMWARE CONSOLE
+M:	Magnus Lindholm <linmag7@gmail.com>
+L:	linux-serial@vger.kernel.org
+L:	sparclinux@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/hvc/hvc_m3000.c
+
 FUJITSU TABLET EXTRAS
 M:	Robert Gerlach <khnz@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 5866195de26a..d940fa0d68e0 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -134,3 +134,14 @@ config HVCS
 	  will depend on arch specific APIs exported from hvcserver.ko
 	  which will also be compiled when this driver is built as a
 	  module.
+
+config HVC_M3000
+	bool "M3000 firmware pseudo-console"
+	depends on SPARC64
+	select HVC_DRIVER
+	help
+	  Provide hvc0 using Open Firmware stdin/stdout on the Fujitsu M3000
+	  (IKKAKU platform).
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
-- 
2.43.0


