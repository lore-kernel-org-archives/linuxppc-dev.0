Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D06EA67B85
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 08:34:49 +1000 (EST)
Date: Mon, 25 Sep 2006 19:34:39 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] adbhid: make KEY_SYSRQ configurable on ADB based machines
Message-ID: <20060925223439.GB23526@cathedrallabs.org>
References: <20060808154937.GC3363@cathedrallabs.org>
	<20060920134459.GC23803@cathedrallabs.org>
	<20060920053656.GA28326@cynthia.pants.nu>
	<20060925223057.GA23526@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060925223057.GA23526@cathedrallabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hi Brad,
> > The only thing I see is that each ADB keyboard device will have an entry
> > in sysfs to change the sysrq key, but they will all set the same global.
> > It's a little misleading, but I don't think it's a major issue. And
> > before anyone asks, I have in fact had multiple ADB keyboards attached
> > to a single machine. It was useful for multi-player games.
> what about this updated patch?
If I attach the patch surely will help... :P

--- linus-2.6.orig/drivers/macintosh/adbhid.c	2006-09-25 15:14:58.000000000 -0300
+++ linus-2.6/drivers/macintosh/adbhid.c	2006-09-25 15:16:35.000000000 -0300
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
@@ -252,6 +253,58 @@
 #define ADBMOUSE_MS_A3		8	/* Mouse systems A3 trackball (handler 3) */
 #define ADBMOUSE_MACALLY2	9	/* MacAlly 2-button mouse */
 
+/* SYSRQ support */
+#ifdef CONFIG_MAGIC_SYSRQ
+#define ADBHID_DEFAULT_SYSRQ 0x69
+#define class_device_to_adbhid(x) ((struct adbhid *)(x->class_data))
+
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
+static inline void adbhid_register_sysrq_attr(struct adbhid *hid,
+					      struct class_device *dev)
+{
+	dev->class_data = hid;
+	class_device_create_file(dev, &class_device_attr_sysrq_key);
+}
+#define adbhid_set_sysrq(x) set_bit(KEY_SYSRQ, (x))
+static inline void adbhid_set_default_sysrq(struct adbhid *hid)
+{
+	hid->sysrq_key = ADBHID_DEFAULT_SYSRQ;
+}
+#else	/* !CONFIG_MAGIC_SYSRQ */
+#define adbhid_key_is_sysrq(x, y) (0)
+#define adbhid_register_sysrq_attr(x, y) do { } while(0)
+#define adbhid_set_sysrq(x) do { } while(0)
+#define adbhid_set_default_sysrq(x) do { } while(0)
+#endif	/* CONFIG_MAGIC_SYSRQ */
+
 static void
 adbhid_keyboard_input(unsigned char *data, int nb, struct pt_regs *regs, int apoll)
 {
@@ -275,7 +328,7 @@
 adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	struct adbhid *ahid = adbhid[id];
-	int up_flag, key;
+	int up_flag, key = 0;
 
 	up_flag = (keycode & 0x80);
 	keycode &= 0x7f;
@@ -336,7 +389,9 @@
 #endif /* CONFIG_PPC_PMAC */
 	}
 
-	key = adbhid[id]->keycode[keycode];
+	key = adbhid_key_is_sysrq(adbhid[id], keycode);
+	if (!key)
+		key = adbhid[id]->keycode[keycode];
 	if (key) {
 		input_regs(adbhid[id]->input, regs);
 		input_report_key(adbhid[id]->input, key, !up_flag);
@@ -705,6 +760,7 @@
 	hid->current_handler_id = current_handler_id;
 	hid->mouse_kind = mouse_kind;
 	hid->flags = 0;
+	adbhid_set_default_sysrq(hid);
 	input_dev->private = hid;
 	input_dev->name = hid->name;
 	input_dev->phys = hid->phys;
@@ -759,6 +815,7 @@
 		for (i = 0; i < 128; i++)
 			if (hid->keycode[i])
 				set_bit(hid->keycode[i], input_dev->keybit);
+		adbhid_set_sysrq(input_dev->keybit);
 
 		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
@@ -901,6 +958,8 @@
 		adb_get_infos(id, &default_id, &cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
 					       cur_handler_id, 0);
+
+		adbhid_register_sysrq_attr(adbhid[id], keyboard_ids.device[i]);
 	}
 
 	for (i = 0; i < buttons_ids.nids; i++) {
