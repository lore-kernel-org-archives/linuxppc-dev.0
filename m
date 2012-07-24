Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B2A8C2C007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 17:47:45 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q6O7lfrm018103
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 02:47:42 -0500
Message-ID: <1343116058.3715.20.camel@pasglop>
Subject: [PATCH] hvc_vio: Improve registration of udbg backend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 24 Jul 2012 17:47:38 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries hvterm driver only registers a udbg backend (for xmon and
other low level debugging mechanisms) when hvc0 is recognized as the
firmware console at boot time, not if it's detected later on, for
example because the firmware is using a graphics card.

This can make debugging challenging especially under X11, and there's
really no good reason for that limitation, so let's hookup udbg
whenever hvc0 is detected instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/drivers/tty/hvc/hvc_vio.c b/drivers/tty/hvc/hvc_vio.c
index ee30779..070c0ee6 100644
--- a/drivers/tty/hvc/hvc_vio.c
+++ b/drivers/tty/hvc/hvc_vio.c
@@ -230,6 +230,69 @@ static const struct hv_ops hvterm_hvsi_ops = {
 	.tiocmset = hvterm_hvsi_tiocmset,
 };
 
+static void udbg_hvc_putc(char c)
+{
+	int count = -1;
+
+	if (!hvterm_privs[0])
+		return;
+
+	if (c == '\n')
+		udbg_hvc_putc('\r');
+
+	do {
+		switch(hvterm_privs[0]->proto) {
+		case HV_PROTOCOL_RAW:
+			count = hvterm_raw_put_chars(0, &c, 1);
+			break;
+		case HV_PROTOCOL_HVSI:
+			count = hvterm_hvsi_put_chars(0, &c, 1);
+			break;
+		}
+	} while(count == 0);
+}
+
+static int udbg_hvc_getc_poll(void)
+{
+	int rc = 0;
+	char c;
+
+	if (!hvterm_privs[0])
+		return -1;
+
+	switch(hvterm_privs[0]->proto) {
+	case HV_PROTOCOL_RAW:
+		rc = hvterm_raw_get_chars(0, &c, 1);
+		break;
+	case HV_PROTOCOL_HVSI:
+		rc = hvterm_hvsi_get_chars(0, &c, 1);
+		break;
+	}
+	if (!rc)
+		return -1;
+	return c;
+}
+
+static int udbg_hvc_getc(void)
+{
+	int ch;
+
+	if (!hvterm_privs[0])
+		return -1;
+
+	for (;;) {
+		ch = udbg_hvc_getc_poll();
+		if (ch == -1) {
+			/* This shouldn't be needed...but... */
+			volatile unsigned long delay;
+			for (delay=0; delay < 2000000; delay++)
+				;
+		} else {
+			return ch;
+		}
+	}
+}
+
 static int __devinit hvc_vio_probe(struct vio_dev *vdev,
 				   const struct vio_device_id *id)
 {
@@ -289,6 +352,13 @@ static int __devinit hvc_vio_probe(struct vio_dev *vdev,
 		return PTR_ERR(hp);
 	dev_set_drvdata(&vdev->dev, hp);
 
+	/* register udbg if it's not there already for console 0 */
+	if (hp->index == 0 && !udbg_putc) {
+		udbg_putc = udbg_hvc_putc;
+		udbg_getc = udbg_hvc_getc;
+		udbg_getc_poll = udbg_hvc_getc_poll;
+	}
+
 	return 0;
 }
 
@@ -331,59 +401,6 @@ static void __exit hvc_vio_exit(void)
 }
 module_exit(hvc_vio_exit);
 
-static void udbg_hvc_putc(char c)
-{
-	int count = -1;
-
-	if (c == '\n')
-		udbg_hvc_putc('\r');
-
-	do {
-		switch(hvterm_priv0.proto) {
-		case HV_PROTOCOL_RAW:
-			count = hvterm_raw_put_chars(0, &c, 1);
-			break;
-		case HV_PROTOCOL_HVSI:
-			count = hvterm_hvsi_put_chars(0, &c, 1);
-			break;
-		}
-	} while(count == 0);
-}
-
-static int udbg_hvc_getc_poll(void)
-{
-	int rc = 0;
-	char c;
-
-	switch(hvterm_priv0.proto) {
-	case HV_PROTOCOL_RAW:
-		rc = hvterm_raw_get_chars(0, &c, 1);
-		break;
-	case HV_PROTOCOL_HVSI:
-		rc = hvterm_hvsi_get_chars(0, &c, 1);
-		break;
-	}
-	if (!rc)
-		return -1;
-	return c;
-}
-
-static int udbg_hvc_getc(void)
-{
-	int ch;
-	for (;;) {
-		ch = udbg_hvc_getc_poll();
-		if (ch == -1) {
-			/* This shouldn't be needed...but... */
-			volatile unsigned long delay;
-			for (delay=0; delay < 2000000; delay++)
-				;
-		} else {
-			return ch;
-		}
-	}
-}
-
 void __init hvc_vio_init_early(void)
 {
 	struct device_node *stdout_node;
