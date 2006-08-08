Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A55AE67B52
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 01:49:53 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-167-1.ctame704.dsl.brasiltelecom.net.br [201.25.167.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 70BF510009
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 11:49:49 -0400 (EDT)
Date: Tue, 8 Aug 2006 12:49:37 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] adbhid: make KEY_SYSRQ configurable on ADB based machines
Message-ID: <20060808154937.GC3363@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds a sysfs entry on /sys/class/adb/keyboard0/sysrq_key to
configure which key will be mapped to KEY_SYSRQ. This is needed to make
sysrq usable on machines which doesn't have current sysrq key. This
patch and the previous two ones has been tested for some days in my
machine without problems.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Index: ppc-2.6/drivers/macintosh/adbhid.c
===================================================================
--- ppc-2.6.orig/drivers/macintosh/adbhid.c	2006-08-04 09:45:43.000000000 -0300
+++ ppc-2.6/drivers/macintosh/adbhid.c	2006-08-04 09:52:06.000000000 -0300
@@ -61,6 +61,47 @@
 	.notifier_call	= adb_message_handler,
 };
 
+/* SYSRQ support */
+#ifdef CONFIG_MAGIC_SYSRQ
+static int adbhid_sysrq_key = 0x69;
+
+static ssize_t adbhid_show_sysrq_key(struct class_device *dev, char *buf)
+{
+	return sprintf(buf, "%#x\n", adbhid_sysrq_key);
+}
+static ssize_t adbhid_store_sysrq_key(struct class_device *dev,
+				      const char *buf, size_t n)
+{
+	int val;
+
+	val = simple_strtol(buf, NULL, 10);
+	if (val > 255)
+		return -EINVAL;
+	adbhid_sysrq_key = val;
+
+	return n;
+}
+
+static CLASS_DEVICE_ATTR(sysrq_key, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,
+			 adbhid_show_sysrq_key, adbhid_store_sysrq_key);
+static inline int adbhid_key_is_sysrq(int keycode)
+{
+	if (unlikely(keycode == adbhid_sysrq_key))
+		return KEY_SYSRQ;
+	return 0;
+}
+
+static inline void adbhid_register_sysrq_attr(struct class_device *dev)
+{
+	class_device_create_file(dev, &class_device_attr_sysrq_key);
+}
+#define adbhid_set_sysrq(x) set_bit(KEY_SYSRQ, (x))
+#else	/* !CONFIG_MAGIC_SYSRQ */
+#define adbhid_key_is_sysrq(x) (0)
+#define adbhid_register_sysrq_attr(x) do { } while(0)
+#define adbhid_set_sysrq(x) do { } while(0)
+#endif	/* CONFIG_MAGIC_SYSRQ */
+
 /* Some special keys */
 #define ADB_KEY_DEL		0x33
 #define ADB_KEY_CMD		0x37
@@ -176,7 +217,7 @@
 	/* 0x66 */ KEY_HANJA,		/* 123 */
 	/* 0x67 */ KEY_F11,		/*  87 */
 	/* 0x68 */ KEY_HANGEUL,		/* 122 */
-	/* 0x69 */ KEY_SYSRQ,		/*  99 */
+	/* 0x69 */ 0,
 	/* 0x6a */ 0,
 	/* 0x6b */ KEY_SCROLLLOCK,	/*  70 */
 	/* 0x6c */ 0,
@@ -275,7 +316,7 @@
 adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	struct adbhid *ahid = adbhid[id];
-	int up_flag, key;
+	int up_flag, key = 0;
 
 	up_flag = (keycode & 0x80);
 	keycode &= 0x7f;
@@ -336,7 +377,9 @@
 #endif /* CONFIG_PPC_PMAC */
 	}
 
-	key = adbhid[id]->keycode[keycode];
+	key = adbhid_key_is_sysrq(keycode);
+	if (!key)
+		key = adbhid[id]->keycode[keycode];
 	if (key) {
 		input_regs(adbhid[id]->input, regs);
 		input_report_key(adbhid[id]->input, key, !up_flag);
@@ -759,6 +802,7 @@
 		for (i = 0; i < 128; i++)
 			if (hid->keycode[i])
 				set_bit(hid->keycode[i], input_dev->keybit);
+		adbhid_set_sysrq(input_dev->keybit);
 
 		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
@@ -901,6 +945,8 @@
 		adb_get_infos(id, &default_id, &cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
 					       cur_handler_id, 0);
+
+		adbhid_register_sysrq_attr(keyboard_ids.device[i]);
 	}
 
 	for (i = 0; i < buttons_ids.nids; i++) {
