Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1786DDDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 06:10:18 +1000 (EST)
Date: Mon, 24 Sep 2007 15:09:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/2] bootwrapper: Add PlanetCore firmware support.
Message-ID: <20070924200949.GC21347@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a library that board code can use to extract information from the
PlanetCore configuration keys.  PlanetCore is used on various boards from
Embedded Planet.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Resent, with dt_set_mac_address -> dt_fixup_mac_address.

 arch/powerpc/boot/Makefile     |    2 +-
 arch/powerpc/boot/planetcore.c |  166 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/planetcore.h |   49 ++++++++++++
 3 files changed, 216 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/planetcore.c
 create mode 100644 arch/powerpc/boot/planetcore.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index cffef14..9ec785c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,7 +45,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
-		cpm-serial.c stdlib.c
+		cpm-serial.c stdlib.c planetcore.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
diff --git a/arch/powerpc/boot/planetcore.c b/arch/powerpc/boot/planetcore.c
new file mode 100644
index 0000000..0d8558a
--- /dev/null
+++ b/arch/powerpc/boot/planetcore.c
@@ -0,0 +1,166 @@
+/*
+ * PlanetCore configuration data support functions
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "stdio.h"
+#include "stdlib.h"
+#include "ops.h"
+#include "planetcore.h"
+#include "io.h"
+
+/* PlanetCore passes information to the OS in the form of
+ * a table of key=value strings, separated by newlines.
+ *
+ * The list is terminated by an empty string (i.e. two
+ * consecutive newlines).
+ *
+ * To make it easier to parse, we first convert all the
+ * newlines into null bytes.
+ */
+
+void planetcore_prepare_table(char *table)
+{
+	do {
+		if (*table == '\n')
+			*table = 0;
+
+		table++;
+	} while (*(table - 1) || *table != '\n');
+
+	*table = 0;
+}
+
+const char *planetcore_get_key(const char *table, const char *key)
+{
+	int keylen = strlen(key);
+
+	do {
+		if (!strncmp(table, key, keylen) && table[keylen] == '=')
+			return table + keylen + 1;
+
+		table += strlen(table) + 1;
+	} while (strlen(table) != 0);
+
+	return NULL;
+}
+
+int planetcore_get_decimal(const char *table, const char *key, u64 *val)
+{
+	const char *str = planetcore_get_key(table, key);
+	if (!str)
+		return 0;
+
+	*val = strtoull(str, NULL, 10);
+	return 1;
+}
+
+int planetcore_get_hex(const char *table, const char *key, u64 *val)
+{
+	const char *str = planetcore_get_key(table, key);
+	if (!str)
+		return 0;
+
+	*val = strtoull(str, NULL, 16);
+	return 1;
+}
+
+static u64 mac_table[4] = {
+	0x000000000000,
+	0x000000800000,
+	0x000000400000,
+	0x000000c00000,
+};
+
+void planetcore_set_mac_addrs(const char *table)
+{
+	u8 addr[4][6];
+	u64 int_addr;
+	u32 i;
+	int j;
+
+	if (!planetcore_get_hex(table, PLANETCORE_KEY_MAC_ADDR, &int_addr))
+		return;
+
+	for (i = 0; i < 4; i++) {
+		u64 this_dev_addr = (int_addr & ~0x000000c00000) |
+		                    mac_table[i];
+
+		for (j = 5; j >= 0; j--) {
+			addr[i][j] = this_dev_addr & 0xff;
+			this_dev_addr >>= 8;
+		}
+
+		dt_fixup_mac_address(i, addr[i]);
+	}
+}
+
+static char prop_buf[MAX_PROP_LEN];
+
+void planetcore_set_stdout_path(const char *table)
+{
+	char *path;
+	const char *label;
+	void *node, *chosen;
+
+	label = planetcore_get_key(table, PLANETCORE_KEY_SERIAL_PORT);
+	if (!label)
+		return;
+
+	node = find_node_by_prop_value_str(NULL, "linux,planetcore-label",
+	                                   label);
+	if (!node)
+		return;
+
+	path = get_path(node, prop_buf, MAX_PROP_LEN);
+	if (!path)
+		return;
+
+	chosen = finddevice("/chosen");
+	if (!chosen)
+		chosen = create_node(NULL, "chosen");
+	if (!chosen)
+		return;
+
+	setprop_str(chosen, "linux,stdout-path", path);
+}
+
+void planetcore_set_serial_speed(const char *table)
+{
+	void *chosen, *stdout;
+	u64 baud;
+	u32 baud32;
+	int len;
+
+	chosen = finddevice("/chosen");
+	if (!chosen)
+		return;
+
+	len = getprop(chosen, "linux,stdout-path", prop_buf, MAX_PROP_LEN);
+	if (len <= 0)
+		return;
+
+	stdout = finddevice(prop_buf);
+	if (!stdout) {
+		printf("planetcore_set_serial_speed: "
+		       "Bad /chosen/linux,stdout-path.\r\n");
+
+		return;
+	}
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_SERIAL_BAUD,
+	                            &baud)) {
+		printf("planetcore_set_serial_speed: No SB tag.\r\n");
+		return;
+	}
+
+	baud32 = baud;
+	setprop(stdout, "current-speed", &baud32, 4);
+}
diff --git a/arch/powerpc/boot/planetcore.h b/arch/powerpc/boot/planetcore.h
new file mode 100644
index 0000000..0d4094f
--- /dev/null
+++ b/arch/powerpc/boot/planetcore.h
@@ -0,0 +1,49 @@
+#ifndef _PPC_BOOT_PLANETCORE_H_
+#define _PPC_BOOT_PLANETCORE_H_
+
+#include "types.h"
+
+#define PLANETCORE_KEY_BOARD_TYPE   "BO"
+#define PLANETCORE_KEY_BOARD_REV    "BR"
+#define PLANETCORE_KEY_MB_RAM       "D1"
+#define PLANETCORE_KEY_MAC_ADDR     "EA"
+#define PLANETCORE_KEY_FLASH_SPEED  "FS"
+#define PLANETCORE_KEY_IP_ADDR      "IP"
+#define PLANETCORE_KEY_KB_NVRAM     "NV"
+#define PLANETCORE_KEY_PROCESSOR    "PR"
+#define PLANETCORE_KEY_PROC_VARIANT "PV"
+#define PLANETCORE_KEY_SERIAL_BAUD  "SB"
+#define PLANETCORE_KEY_SERIAL_PORT  "SP"
+#define PLANETCORE_KEY_SWITCH       "SW"
+#define PLANETCORE_KEY_TEMP_OFFSET  "TC"
+#define PLANETCORE_KEY_TARGET_IP    "TIP"
+#define PLANETCORE_KEY_CRYSTAL_HZ   "XT"
+
+/* Prepare the table for processing, by turning all newlines
+ * into NULL bytes.
+ */
+void planetcore_prepare_table(char *table);
+
+/* Return the value associated with a given key in text,
+ * decimal, or hex format.
+ *
+ * Returns zero/NULL on failure, non-zero on success.
+ */
+const char *planetcore_get_key(const char *table, const char *key);
+int planetcore_get_decimal(const char *table, const char *key, u64 *val);
+int planetcore_get_hex(const char *table, const char *key, u64 *val);
+
+/* Updates the device tree local-mac-address properties based
+ * on the EA tag.
+ */
+void planetcore_set_mac_addrs(const char *table);
+
+/* Sets the linux,stdout-path in the /chosen node.  This requires the
+ * linux,planetcore-label property in each serial node.
+ */
+void planetcore_set_stdout_path(const char *table);
+
+/* Sets the current-speed property in the serial node. */
+void planetcore_set_serial_speed(const char *table);
+
+#endif
-- 
1.5.3.1
