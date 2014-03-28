Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D49D91400B1
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:45 +1100 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:43 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4976F3578058
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2aRBo4391240
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:27 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2aeAZ017108
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/7] tty/hvc_opal: Kick the HVC thread on OPAL console events
Date: Fri, 28 Mar 2014 13:36:32 +1100
Message-Id: <1395974192-820-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The firmware can notify us when new input data is available, so
let's make sure we wakeup the HVC thread in that case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/tty/hvc/hvc_opal.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 6496872..e4f92c1 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -61,6 +61,7 @@ static struct hvc_opal_priv *hvc_opal_privs[MAX_NR_HVC_CONSOLES];
 /* For early boot console */
 static struct hvc_opal_priv hvc_opal_boot_priv;
 static u32 hvc_opal_boot_termno;
+static bool hvc_opal_event_registered;
 
 static const struct hv_ops hvc_opal_raw_ops = {
 	.get_chars = opal_get_chars,
@@ -161,6 +162,18 @@ static const struct hv_ops hvc_opal_hvsi_ops = {
 	.tiocmset = hvc_opal_hvsi_tiocmset,
 };
 
+static int hvc_opal_console_event(struct notifier_block *nb,
+				  unsigned long events, void *change)
+{
+	if (events & OPAL_EVENT_CONSOLE_INPUT)
+		hvc_kick();
+	return 0;
+}
+
+static struct notifier_block hvc_opal_console_nb = {
+	.notifier_call	= hvc_opal_console_event,
+};
+
 static int hvc_opal_probe(struct platform_device *dev)
 {
 	const struct hv_ops *ops;
@@ -170,6 +183,7 @@ static int hvc_opal_probe(struct platform_device *dev)
 	unsigned int termno, boot = 0;
 	const __be32 *reg;
 
+
 	if (of_device_is_compatible(dev->dev.of_node, "ibm,opal-console-raw")) {
 		proto = HV_PROTOCOL_RAW;
 		ops = &hvc_opal_raw_ops;
@@ -213,12 +227,18 @@ static int hvc_opal_probe(struct platform_device *dev)
 		dev->dev.of_node->full_name,
 		boot ? " (boot console)" : "");
 
-	/* We don't do IRQ yet */
+	/* We don't do IRQ ... */
 	hp = hvc_alloc(termno, 0, ops, MAX_VIO_PUT_CHARS);
 	if (IS_ERR(hp))
 		return PTR_ERR(hp);
 	dev_set_drvdata(&dev->dev, hp);
 
+	/* ...  but we use OPAL event to kick the console */
+	if (!hvc_opal_event_registered) {
+		opal_notifier_register(&hvc_opal_console_nb);
+		hvc_opal_event_registered = true;
+	}
+
 	return 0;
 }
 
@@ -259,6 +279,10 @@ module_init(hvc_opal_init);
 
 static void __exit hvc_opal_exit(void)
 {
+	if (hvc_opal_event_registered)
+		opal_notifier_unregister(&hvc_opal_console_nb);
+	hvc_opal_event_registered = false;
+
 	platform_driver_unregister(&hvc_opal_driver);
 }
 module_exit(hvc_opal_exit);
-- 
1.8.3.2
