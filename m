Return-Path: <aris@ruivo.org>
Received: from lobo.ruivo.org (lobo.ruivo.org [66.92.68.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lobo.ruivo.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2534EDDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 06:54:33 +1000 (EST)
Date: Mon, 16 Jul 2007 16:53:22 -0400
From: Aristeu Rozanski <aris@ruivo.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] adbhid: make sysrq key configurable on adb keyboards
Message-ID: <20070716205322.GD30232@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds an sysfs attribute to each handled ADB keyboard in order
to support runtime sysrq key configuration. This is needed because some
machines don't have the default sysrq key (0x69). The key will be
configurable by /sys/class/adb/keyboard<N>/sysrq_key.

Signed-of-by: Aristeu Rozanski <aris@ruivo.org>

--- linus-2.6.orig/drivers/macintosh/adbhid.c	2007-05-23 20:39:11.000000000 -0400
+++ linus-2.6/drivers/macintosh/adbhid.c	2007-05-23 20:39:41.000000000 -0400
@@ -176,7 +176,7 @@
 	/* 0x66 */ KEY_HANJA,		/* 123 */
 	/* 0x67 */ KEY_F11,		/*  87 */
 	/* 0x68 */ KEY_HANGEUL,		/* 122 */
-	/* 0x69 */ KEY_SYSRQ,		/*  99 */
+	/* 0x69 */ 0,
 	/* 0x6a */ 0,
 	/* 0x6b */ KEY_SCROLLLOCK,	/*  70 */
 	/* 0x6c */ 0,
@@ -212,6 +212,7 @@
 	char name[64];
 	char phys[32];
 	int flags;
+	int sysrq_key;
 };
 
 #define FLAG_FN_KEY_PRESSED	0x00000001
@@ -252,6 +253,64 @@
 #define ADBMOUSE_MS_A3		8	/* Mouse systems A3 trackball (handler 3) */
 #define ADBMOUSE_MACALLY2	9	/* MacAlly 2-button mouse */
 
+/* SYSRQ support */
+#ifdef CONFIG_MAGIC_SYSRQ
+#define ADBHID_DEFAULT_SYSRQ 0x69
+#define class_device_to_adbhid(x) \
+	((struct adbhid *)(container_of(x, struct adb_id, cdev))->priv)
+static ssize_t adbhid_show_sysrq_key(struct class_device *dev, char *buf)
+{
+	struct adbhid *hid = class_device_to_adbhid(dev);
+
+	return sprintf(buf, "%#x\n", hid->sysrq_key);
+}
+static ssize_t adbhid_store_sysrq_key(struct class_device *dev,
+				      const char *buf, size_t n)
+{
+	int val;
+	struct adbhid *hid = class_device_to_adbhid(dev);
+
+	val = simple_strtol(buf, NULL, 10);
+	if (val > 255)
+		return -EINVAL;
+	hid->sysrq_key = val;
+
+	return n;
+}
+
+static CLASS_DEVICE_ATTR(sysrq_key, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH,
+			 adbhid_show_sysrq_key, adbhid_store_sysrq_key);
+static inline int adbhid_key_is_sysrq(struct adbhid *hid, int keycode)
+{
+	if (unlikely(keycode == hid->sysrq_key))
+		return KEY_SYSRQ;
+	return 0;
+}
+
+static inline void adbhid_register_sysrq_attr(struct adb_id *kbd,
+					      struct adbhid *hid)
+{
+	int retval;
+
+	kbd->priv = hid;
+	retval = class_device_create_file(&kbd->cdev,
+					  &class_device_attr_sysrq_key);
+	if (retval)
+		printk(KERN_WARNING "adbhid: unable to create class device "
+		       "file\n");
+}
+static inline void adbhid_set_default_sysrq(struct adbhid *hid)
+{
+	hid->sysrq_key = ADBHID_DEFAULT_SYSRQ;
+}
+#define adbhid_set_sysrq(x) set_bit(KEY_SYSRQ, (x))
+#else	/* !CONFIG_MAGIC_SYSRQ */
+#define adbhid_key_is_sysrq(x, y) (0)
+#define adbhid_register_sysrq_attr(x, y) do { } while(0)
+#define adbhid_set_sysrq(x) do { } while(0)
+#define adbhid_set_default_sysrq(x) do { } while(0)
+#endif	/* CONFIG_MAGIC_SYSRQ */
+
 static void
 adbhid_keyboard_input(unsigned char *data, int nb, int apoll)
 {
@@ -275,7 +334,7 @@
 adbhid_input_keycode(int id, int keycode, int repeat)
 {
 	struct adbhid *ahid = adbhid[id];
-	int up_flag, key;
+	int up_flag, key = 0;
 
 	up_flag = (keycode & 0x80);
 	keycode &= 0x7f;
@@ -335,10 +394,12 @@
 #endif /* CONFIG_PPC_PMAC */
 	}
 
- 	key = adbhid[id]->keycode[keycode];
- 	if (key) {
- 		input_report_key(adbhid[id]->input, key, !up_flag);
-		input_sync(adbhid[id]->input);
+	key = adbhid_key_is_sysrq(ahid, keycode);
+	if (!key)
+		key = ahid->keycode[keycode];
+  	if (key) {
+		input_report_key(ahid->input, key, !up_flag);
+		input_sync(ahid->input);
 	} else
 		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
 		       up_flag ? "released" : "pressed");
@@ -698,6 +759,7 @@
 	hid->current_handler_id = current_handler_id;
 	hid->mouse_kind = mouse_kind;
 	hid->flags = 0;
+	adbhid_set_default_sysrq(hid);
 	input_set_drvdata(input_dev, hid);
 	input_dev->name = hid->name;
 	input_dev->phys = hid->phys;
@@ -752,6 +814,7 @@
 		for (i = 0; i < 128; i++)
 			if (hid->keycode[i])
 				set_bit(hid->keycode[i], input_dev->keybit);
+		adbhid_set_sysrq(input_dev->keybit);
 
 		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
@@ -899,6 +962,8 @@
 		adb_get_infos(id, &default_id, &cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
 					       cur_handler_id, 0);
+
+		adbhid_register_sysrq_attr(&keyboard_ids.id[i], adbhid[id]);
 	}
 
 	for (i = 0; i < buttons_ids.nids; i++) {
