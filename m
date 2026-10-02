Return-Path: <linuxppc-dev+bounces-28764-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF8CCA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 16:17:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxDT60FQfz30MY;
	Sat, 03 Oct 2026 02:17:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790957849;
	cv=none; b=RkGFKPTuh+h/jFBPb5MxCCs740GKNU2oIKjfwkEB39+XergntHtMH+96QLHSzyUPQn9JUzoJ1oroARzMevMJcNccNXGGDRzU0yDYJ9sWNyEjcQEpRa0hECFbBpgm55oXWf/gTAU4GVwDGjM0t0sIuOpCfNhpZj9r1CqQWaICRhEo1b41RiGs936Mw0AvyqHEDtcwBfLU2IBb3+8VGFvDnkZzJWv9/eGENG2B2l21IXFLiEtKbGrj1H5Ev3oM6+WLGnpBayCyK3xhooiquWImbK9AWkvEKeYN9vRWSrxMyi4lpre9yxPXoIfcbi2luwV6qJycTGJQ68EEymeJbAQqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790957849; c=relaxed/relaxed;
	bh=inUXALtHTvzEHgf8GUFS30DP/3xlzvolY7NUu3QFipU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbVg0FaZ9RyI/I3YNFchQC6fjoNiKnZQ7kDpOTqUxaOhuU9i/082LOv5L6AJvtwi2NeRB9aF5oG6Gy3Kyeo5lpCptypzZs4KWfi6/EQtCPJHs0S8l3O/eKvB6vyYz0gvGvZE1WbpjC4mZ+2GX2ouxHUXROSEQC9RhXyO9nWxg16wDqGvu6867XlQE1QFUETWbmaL5taNR2HrDRc76pYPmHB/lNTHeXZMk8dmr8CPkxQljrqBosDl0S+MxBUyDtzJ9Kay34qh7TV9197BjljD6v1RdGYsimz9O10ey5iurIxLi0Wu+C41BhlQescu6eyFSoxZUJLH1IR6yt2D+iAC0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4HGhjKj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::d; helo=mail-ej2-x0d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z4HGhjKj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:34::d; helo=mail-ej2-x0d.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej2-x0d.google.com (mail-ej2-x0d.google.com [IPv6:2a00:1450:4864:34::d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxDT41HdNz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:17:26 +1000 (AEST)
Received: by mail-ej2-x0d.google.com with SMTP id a640c23a62f3a-c2e320322edso6706866b.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790957841; x=1791562641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=inUXALtHTvzEHgf8GUFS30DP/3xlzvolY7NUu3QFipU=;
        b=Z4HGhjKjGoq2+mGPPppvX90oiGzcYEL+pIVsiGwv1iXFNRnIsWSlO03xBmEg6ZjJsC
         LESyEma6ZtfoLENLzgX7OeRRLAcehcklQmLCGhBWj5MDkUv6vFwGj5ejwCKMfvLMSu3G
         Z73xHghONAx1pR2FIFLt4+5sbT0WsfKE9JAqaNa3lq1wuNaPoUK0SLm5oVtoGAe8izFA
         GvablOmAv8r2paTDABsuToaV7J3XwvCycjik12lZLWiqM3HuYwSV9A3USQ5LP93bmajm
         MljtGoLP4oka/01eeDYd0THHt6thiP/QSOEIC77+geLu2WjbLQn4wsYFuDaSfbdxaT7j
         4KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790957841; x=1791562641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=inUXALtHTvzEHgf8GUFS30DP/3xlzvolY7NUu3QFipU=;
        b=RtZirEVcIsryU5UyD5VykD92l+hFPuM1hudbFng1jUeUcS3ikywqwNFWRVrf1xcFbk
         YYVPmwEbIsSK79qxzd6c8PaxE6rc5wqC/JbdFJhSfCdzJQb9IL/X1yIM8f0Uv+x2jw9Z
         Z7WGAfeqPdLdPU/lV7eeaJ6HTP81+NpD2N5F/q9IcGyvREh52DxhssEBUDb/mP1iZFS6
         wEtbk256zwpnLJMcvwjEtngAQeYFBPnwYT8HX92I4Kq+w7FG59KKnNQQ+42isU1lEBXy
         u3ZVvfPCBhQFAbb+EQnD6wUqNsOvc/arbokdgEbjR8eLo0F0BNiekCC85p71S+nWOlnX
         tlNQ==
X-Forwarded-Encrypted: i=1; AKwUvByM0HXgsdCjCfEb38mwTwlkseeK4z96JTVs3HXE8IDbYP+DHAQ/8kNXIZ9l36F8n3zIbKPvlJDY5NO0624=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjqtiZ0kjPYIUaaPeU6Jw5Le/5E+vKisWuasdJFWQeww+OK91P
	N8gJeBLxFgcF8CKU0ph/xXE6O+S0l6drtcU5gGnGN7S92F9XKnBIvsLo
X-Gm-Gg: AYBFou18B4FgMvkGOfeVX3Vmlzy2QgM9kYoYMSep86enEQaqDjiMgPrybfc3cAira0F
	FGNwhK7+FFMNdocPOSbaJU/aqo33i9RHZokD/+dp69G/Mh5P5U6X1Ur6AT78cNmtqXHOkyvvhv9
	/Ea4KSDSBG6im/fbNXIgcQYTSBJQRFCbRmymcP+5JrCZvBgw7wy1WiV4o4wWmFkfH164frwpbVu
	Bu/ba+rntm4Mf8MJs6X40tLcqQY/pC9VceUivV75wvb3k/9UVtgRL+FZewvNLAXAbivI28m/iky
	SLnGDZF/F5Uoby3HGsszcT3SCv8kUIegTlyxuBT4t6tBPql9YT7b9ShIjKi/Ajf2SDA42tUb7eo
	pD6iuEuqS9F/JpwEDlRSFopM0umQebx1rWxZmJi1ykBwhv0q2vi6gDv5ZHThE6wxpMkveuEYfcs
	9ztlU665AIKbbmRpKt5HbIVKF8oAwVpRo8GW7SywZbRnyK5l9OG7GdZgXj6+0a2/EnK9+Ql0IRx
	op9a24hGExaUS4viEh6dxZefd1Cq/anHJezgHhK7g==
X-Received: by 2002:a17:906:4fc5:b0:c26:1649:47b4 with SMTP id a640c23a62f3a-c2e4afee0demr267257866b.42.1790957841298;
        Fri, 02 Oct 2026 09:17:21 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf5f4e4sm106437166b.42.2026.10.02.09.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:17:19 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 7/7] hvc: add an M3000 firmware console backend
Date: Fri,  2 Oct 2026 18:14:29 +0200
Message-ID: <20261002161515.932316-8-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002161515.932316-1-linmag7@gmail.com>
References: <20261002161515.932316-1-linmag7@gmail.com>
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

Provide hvc0 through the IKKAKU Open Firmware pseudo-console, validating
model and console properties before matching. Serialize firmware calls,
keep the bounce buffer in locked mappings and poll input each open tick.

Keep output buffers const and bound no-progress retries because HVC
retries EAGAIN indefinitely. A stalled firmware call remains unbounded.
Use the existing SPARC p1275 interface and HVC output contract.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 MAINTAINERS                 |   6 ++
 drivers/tty/hvc/Kconfig     |  10 +++
 drivers/tty/hvc/Makefile    |   2 +
 drivers/tty/hvc/hvc_m3000.c | 167 ++++++++++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+)
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
index 98880e357941..5b0277deb7c9 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -11,3 +11,5 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVC_RISCV_SBI)	+= hvc_riscv_sbi.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+
+obj-$(CONFIG_HVC_M3000) += hvc_m3000.o
diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
new file mode 100644
index 000000000000..0ef4c888a6a2
--- /dev/null
+++ b/drivers/tty/hvc/hvc_m3000.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Experimental M3000 Open Firmware pseudo-console backend. */
+#include <linux/console.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <asm/oplib.h>
+#include <asm/spitfire.h>
+#include "hvc_console.h"
+
+#define M3000_WRITE_ATTEMPTS 8
+
+static int m3000_stdin;
+static bool m3000_ready;
+/* Keep firmware buffers within the locked kernel image mappings. */
+static u8 m3000_buffer[256];
+static DEFINE_RAW_SPINLOCK(m3000_buffer_lock);
+static struct timer_list m3000_poll_timer;
+static bool m3000_poll_active;
+
+/*
+ * HVC's idle backoff can exceed the firmware input FIFO's capacity.
+ * Wake its worker each tick while open; keep PROM calls out of the timer.
+ */
+static void m3000_poll_tick(struct timer_list *timer)
+{
+	if (!READ_ONCE(m3000_poll_active))
+		return;
+	hvc_kick();
+	mod_timer(&m3000_poll_timer, jiffies + 1);
+}
+
+static int m3000_open(struct hvc_struct *hp, int data)
+{
+	WRITE_ONCE(m3000_poll_active, true);
+	mod_timer(&m3000_poll_timer, jiffies + 1);
+	return 0;
+}
+
+static void m3000_close(struct hvc_struct *hp, int data)
+{
+	WRITE_ONCE(m3000_poll_active, false);
+	timer_delete_sync(&m3000_poll_timer);
+}
+
+static ssize_t m3000_io(u8 *in, const u8 *out, size_t count)
+{
+	unsigned long args[7], flags;
+	bool input = in != NULL;
+	int ret;
+
+	if (!count)
+		return 0;
+	count = min_t(size_t, count, input ? 1 : sizeof(m3000_buffer));
+	/* Serialize the bounce buffer; p1275 separately serializes firmware. */
+	raw_spin_lock_irqsave(&m3000_buffer_lock, flags);
+	if (!input)
+		memcpy(m3000_buffer, out, count);
+	args[0] = (unsigned long)(input ? "read" : "write");
+	args[1] = 3;
+	args[2] = 1;
+	args[3] = (unsigned int)(input ? m3000_stdin : prom_stdout);
+	args[4] = (unsigned long)m3000_buffer;
+	args[5] = count;
+	args[6] = (unsigned long)-1;
+	p1275_cmd_direct(args);
+	ret = (int)args[6];
+	if (ret > 0 && ret <= count && input)
+		memcpy(in, m3000_buffer, ret);
+	raw_spin_unlock_irqrestore(&m3000_buffer_lock, flags);
+	if (ret == -2 || ret == 0)
+		return input ? 0 : -EAGAIN;
+	if (ret < 0 || ret > count)
+		return -EIO;
+	return ret;
+}
+
+static ssize_t m3000_get(u32 termno, u8 *buf, size_t count)
+{
+	return m3000_io(buf, NULL, count);
+}
+
+static ssize_t m3000_put(u32 termno, const u8 *buf, size_t count)
+{
+	ssize_t ret;
+	int attempt;
+
+	/*
+	 * HVC retries -EAGAIN forever, so drop this chunk without logging when
+	 * the no-progress budget expires. This cannot bound a stalled firmware
+	 * call or lock acquisition.
+	 */
+	for (attempt = 0; attempt < M3000_WRITE_ATTEMPTS; attempt++) {
+		ret = m3000_io(NULL, buf, count);
+		if (ret != -EAGAIN)
+			return ret;
+		cpu_relax();
+	}
+	return -EIO;
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
+					 const char *expected)
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
+	phandle node;
+	int ret;
+
+	if (tlb_type != sparc64_vii)
+		return -ENODEV;
+	if (!m3000_property_matches(prom_finddevice("/"), "model", "IKKAKU"))
+		return -ENODEV;
+	m3000_stdin = prom_getint(prom_chosen_node, "stdin");
+	if (!m3000_stdin || m3000_stdin == -1 || !prom_stdout || prom_stdout == -1)
+		return -ENODEV;
+	node = prom_inst2pkg(prom_stdout);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	node = prom_inst2pkg(m3000_stdin);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	ret = hvc_instantiate(0, 0, &m3000_ops);
+	if (ret < 0)
+		return ret;
+	m3000_ready = true;
+	return 0;
+}
+console_initcall(m3000_console_init);
+
+static int __init m3000_tty_init(void)
+{
+	struct hvc_struct *hp;
+
+	if (!m3000_ready)
+		return -ENODEV;
+	timer_setup(&m3000_poll_timer, m3000_poll_tick, 0);
+	hp = hvc_alloc(0, 0, &m3000_ops, sizeof(m3000_buffer));
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	hp->ws.ws_row = 24;
+	hp->ws.ws_col = 80;
+	pr_info("M3000: firmware-backed hvc0 tty ready (serialized, polled input)\n");
+	return 0;
+}
+device_initcall(m3000_tty_init);
-- 
2.43.0


