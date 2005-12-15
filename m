Return-Path: <dtor_core@ameritech.net>
Received: from smtp103.sbc.mail.re2.yahoo.com (smtp103.sbc.mail.re2.yahoo.com
	[68.142.229.102]) by ozlabs.org (Postfix) with SMTP id 5E3A868802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 14:50:09 +1100 (EST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Date: Wed, 14 Dec 2005 22:43:27 -0500
References: <20051213223659.GB20017@hansmi.ch>
	<d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
	<20051214233108.GA20127@hansmi.ch>
In-Reply-To: <20051214233108.GA20127@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512142243.28390.dtor_core@ameritech.net>
Cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 14 December 2005 18:31, Michael Hanselmann wrote:
> This patch adds support for relayfs to the appletouch driver to make debugging
> easier.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> > Initializing with 0/NULL adds to the size of the image for no reason.
> 
> Does gcc automatically initialize them to that value?

Yes, global and static variables are guaranteed to be initialized with 0.

Couple of more comments:

1. I don't think that relayfs parameter worth an entry in sysfs.
2. We should not signal error condition in appletouch_open if
   appletouch_relayfs_init fails - the devce is still functioning fine.
   Just emit a warning.
3. I must be missing something but I do not see rcb being used anywhere...

The adjusted patch is below. I am still not sure if this really should be
in mainline. Was it ever used?

-- 
Dmitry

From: Michael Hanselmann <linux-kernel@hansmi.ch>

Input: appletouch - add relayfs support

This patch adds support for relayfs to the appletouch driver to make
debugging easier.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/input/appletouch.txt |    2 +
 drivers/usb/input/appletouch.c     |   61 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

Index: work/Documentation/input/appletouch.txt
===================================================================
--- work.orig/Documentation/input/appletouch.txt
+++ work/Documentation/input/appletouch.txt
@@ -77,6 +77,8 @@ full tracing (each sample is being trace
 		or
 	echo "1" > /sys/module/appletouch/parameters/debug
 
+To make debugging easier, the driver also supports the relayfs filesystem.
+
 Links:
 ------
 
Index: work/drivers/usb/input/appletouch.c
===================================================================
--- work.orig/drivers/usb/input/appletouch.c
+++ work/drivers/usb/input/appletouch.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2005      Stelian Pop (stelian@popies.net)
  * Copyright (C) 2005      Frank Arnold (frank@scirocco-5v-turbo.de)
  * Copyright (C) 2005      Peter Osterlund (petero2@telia.com)
+ * Copyright (C) 2005      Parag Warudkar (parag.warudkar@gmail.com)
+ * Copyright (C) 2005      Michael Hanselmann (linux-kernel@hansmi.ch)
  *
  * Thanks to Alex Harper <basilisk@foobox.net> for his inputs.
  *
@@ -35,6 +37,10 @@
 #include <linux/input.h>
 #include <linux/usb_input.h>
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+#include <linux/relayfs_fs.h>
+#endif
+
 /* Apple has powerbooks which have the keyboard with different Product IDs */
 #define APPLE_VENDOR_ID		0x05AC
 
@@ -73,6 +79,7 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
+
 /*
  * multiplication factor for the X and Y coordinates.
  * We try to keep the touchpad aspect ratio while still doing only simple
@@ -124,7 +131,7 @@ struct atp {
 		if (debug) printk(format, ##a);				\
 	} while (0)
 
-MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold");
+MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Parag Warudkar, Michael Hanselmann");
 MODULE_DESCRIPTION("Apple PowerBooks USB touchpad driver");
 MODULE_LICENSE("GPL");
 
@@ -132,6 +139,51 @@ static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+#if defined(CONFIG_RELAYFS_FS) || defined(CONFIG_RELAYFS_FS_MODULE)
+static int relayfs;
+module_param(relayfs, int, 0);
+MODULE_PARM_DESC(relayfs, "Activate relayfs support");
+
+static struct rchan *rch;
+
+static inline void atp_relayfs_dump(struct atp *dev)
+{
+	/* "rch" is NULL if relayfs is disabled */
+	if (rch && dev->data)
+		relay_write(rch, dev->data, dev->urb->actual_length);
+}
+
+static int appletouch_relayfs_init(void)
+{
+	if (relayfs) {
+
+		rch = relay_open("atpdata", NULL, 256, 256, NULL);
+		if (!rch) {
+			printk(KERN_WARNING
+				"appletouch: Failed to enable Relayfs.\n");
+			return -ENOMEM;
+		}
+
+		printk(KERN_INFO "appletouch: Relayfs enabled.\n");
+	}
+
+	return 0;
+}
+
+static void appletouch_relayfs_exit(void)
+{
+	if (rch) {
+		printk(KERN_INFO "appletouch: Relayfs disabled\n");
+		relay_close(rch);
+		rch = NULL;
+	}
+}
+#else
+static inline void atp_relayfs_dump(struct atp *dev) { }
+static int appletouch_relayfs_init(void) { return 0; }
+static void appletouch_relayfs_exit(void) { }
+#endif
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -194,6 +246,8 @@ static void atp_complete(struct urb* urb
 		goto exit;
 	}
 
+	atp_relayfs_dump(dev);
+
 	/* reorder the sensors values */
 	for (i = 0; i < 8; i++) {
 		/* X values */
@@ -301,7 +355,10 @@ static int atp_open(struct input_dev *in
 	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
 		return -EIO;
 
+	appletouch_relayfs_init();
+
 	dev->open = 1;
+
 	return 0;
 }
 
@@ -310,6 +367,8 @@ static void atp_close(struct input_dev *
 	struct atp *dev = input->private;
 
 	usb_kill_urb(dev->urb);
+	appletouch_relayfs_exit();
+
 	dev->open = 0;
 }
 
