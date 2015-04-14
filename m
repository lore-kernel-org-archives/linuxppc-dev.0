Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5907A1A1183
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:29:28 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so126418634pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 22:29:26 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] tty/hvc: remove celleb-only beat driver
Date: Tue, 14 Apr 2015 15:28:46 +1000
Message-Id: <1428989326-7637-3-git-send-email-dja@axtens.net>
In-Reply-To: <1428989326-7637-1-git-send-email-dja@axtens.net>
References: <1428989326-7637-1-git-send-email-dja@axtens.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.cz>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The beat hvc driver is only used by celleb.
celleb has been dropped [1], so drop the drivers.

[1] http://patchwork.ozlabs.org/patch/451730/

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.cz>
CC: Valentin Rothberg <valentinrothberg@gmail.com>
CC: mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Daniel Axtens <dja@axtens.net>

---
v2: get name of ozlab*s*.org right. Sorry all.
---
 drivers/tty/hvc/Kconfig    |   7 ---
 drivers/tty/hvc/Makefile   |   1 -
 drivers/tty/hvc/hvc_beat.c | 134 ---------------------------------------------
 3 files changed, 142 deletions(-)
 delete mode 100644 drivers/tty/hvc/hvc_beat.c

diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 8902f9b..2509d05 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -42,13 +42,6 @@ config HVC_RTAS
 	help
 	  IBM Console device driver which makes use of RTAS
 
-config HVC_BEAT
-	bool "Toshiba's Beat Hypervisor Console support"
-	depends on PPC_CELLEB
-	select HVC_DRIVER
-	help
-	  Toshiba's Cell Reference Set Beat Console device driver
-
 config HVC_IUCV
 	bool "z/VM IUCV Hypervisor console support (VM only)"
 	depends on S390
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 4ca3723..6a2702b 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_HVC_OLD_HVSI)	+= hvsi.o
 obj-$(CONFIG_HVC_RTAS)		+= hvc_rtas.o
 obj-$(CONFIG_HVC_TILE)		+= hvc_tile.o
 obj-$(CONFIG_HVC_DCC)		+= hvc_dcc.o
-obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
diff --git a/drivers/tty/hvc/hvc_beat.c b/drivers/tty/hvc/hvc_beat.c
deleted file mode 100644
index 1560d23..0000000
--- a/drivers/tty/hvc/hvc_beat.c
+++ /dev/null
@@ -1,134 +0,0 @@
-/*
- * Beat hypervisor console driver
- *
- * (C) Copyright 2006 TOSHIBA CORPORATION
- *
- * This code is based on drivers/char/hvc_rtas.c:
- * (C) Copyright IBM Corporation 2001-2005
- * (C) Copyright Red Hat, Inc. 2005
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/string.h>
-#include <linux/console.h>
-#include <asm/prom.h>
-#include <asm/hvconsole.h>
-#include <asm/firmware.h>
-
-#include "hvc_console.h"
-
-extern int64_t beat_get_term_char(uint64_t, uint64_t *, uint64_t *, uint64_t *);
-extern int64_t beat_put_term_char(uint64_t, uint64_t, uint64_t, uint64_t);
-
-struct hvc_struct *hvc_beat_dev = NULL;
-
-/* bug: only one queue is available regardless of vtermno */
-static int hvc_beat_get_chars(uint32_t vtermno, char *buf, int cnt)
-{
-	static unsigned char q[sizeof(unsigned long) * 2]
-		__attribute__((aligned(sizeof(unsigned long))));
-	static int qlen = 0;
-	u64 got;
-
-again:
-	if (qlen) {
-		if (qlen > cnt) {
-			memcpy(buf, q, cnt);
-			qlen -= cnt;
-			memmove(q + cnt, q, qlen);
-			return cnt;
-		} else {	/* qlen <= cnt */
-			int	r;
-
-			memcpy(buf, q, qlen);
-			r = qlen;
-			qlen = 0;
-			return r;
-		}
-	}
-	if (beat_get_term_char(vtermno, &got,
-		((u64 *)q), ((u64 *)q) + 1) == 0) {
-		qlen = got;
-		goto again;
-	}
-	return 0;
-}
-
-static int hvc_beat_put_chars(uint32_t vtermno, const char *buf, int cnt)
-{
-	unsigned long kb[2];
-	int rest, nlen;
-
-	for (rest = cnt; rest > 0; rest -= nlen) {
-		nlen = (rest > 16) ? 16 : rest;
-		memcpy(kb, buf, nlen);
-		beat_put_term_char(vtermno, nlen, kb[0], kb[1]);
-		buf += nlen;
-	}
-	return cnt;
-}
-
-static const struct hv_ops hvc_beat_get_put_ops = {
-	.get_chars = hvc_beat_get_chars,
-	.put_chars = hvc_beat_put_chars,
-};
-
-static int hvc_beat_useit = 1;
-
-static int hvc_beat_config(char *p)
-{
-	hvc_beat_useit = simple_strtoul(p, NULL, 0);
-	return 0;
-}
-
-static int __init hvc_beat_console_init(void)
-{
-	if (hvc_beat_useit && of_machine_is_compatible("Beat")) {
-		hvc_instantiate(0, 0, &hvc_beat_get_put_ops);
-	}
-	return 0;
-}
-
-/* temp */
-static int __init hvc_beat_init(void)
-{
-	struct hvc_struct *hp;
-
-	if (!firmware_has_feature(FW_FEATURE_BEAT))
-		return -ENODEV;
-
-	hp = hvc_alloc(0, 0, &hvc_beat_get_put_ops, 16);
-	if (IS_ERR(hp))
-		return PTR_ERR(hp);
-	hvc_beat_dev = hp;
-	return 0;
-}
-
-static void __exit hvc_beat_exit(void)
-{
-	if (hvc_beat_dev)
-		hvc_remove(hvc_beat_dev);
-}
-
-module_init(hvc_beat_init);
-module_exit(hvc_beat_exit);
-
-__setup("hvc_beat=", hvc_beat_config);
-
-console_initcall(hvc_beat_console_init);
-- 
2.1.4
