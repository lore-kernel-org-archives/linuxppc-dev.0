Return-Path: <dtor@insightbb.com>
Received: from mxsf01.insightbb.com (mxsf01.insightbb.com [74.128.0.71])
	by ozlabs.org (Postfix) with ESMTP id 6B61CDDF15
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 16:10:20 +1100 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
Date: Sun, 28 Oct 2007 01:00:12 -0400
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710260905k4c6391b2j7c3d8528cc8198b0@mail.gmail.com>
	<1193430697.15686.1.camel@johannes.berg>
In-Reply-To: <1193430697.15686.1.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710280100.13304.dtor@insightbb.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 26 October 2007 16:31, Johannes Berg wrote:
> 
> > Johannes, and what is product ID for your touchpad?
> 
> It's 0x20e, listed as 'fountain'
>

OK, then maybe instead of reverting the change outright we could try the
patch below?

-- 
Dmitry

Input: appletouch - idle reset logic broke older Fountains

Older models of fountains do not support change mode request and
therefore shoudl be excluded from idle reset attempts.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mouse/appletouch.c |   83 +++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 34 deletions(-)

Index: work/drivers/input/mouse/appletouch.c
===================================================================
--- work.orig/drivers/input/mouse/appletouch.c
+++ work/drivers/input/mouse/appletouch.c
@@ -130,11 +130,11 @@ MODULE_DEVICE_TABLE (usb, atp_table);
 #define ATP_THRESHOLD	 5
 
 /* MacBook Pro (Geyser 3 & 4) initialization constants */
-#define ATP_GEYSER3_MODE_READ_REQUEST_ID 1
-#define ATP_GEYSER3_MODE_WRITE_REQUEST_ID 9
-#define ATP_GEYSER3_MODE_REQUEST_VALUE 0x300
-#define ATP_GEYSER3_MODE_REQUEST_INDEX 0
-#define ATP_GEYSER3_MODE_VENDOR_VALUE 0x04
+#define ATP_GEYSER_MODE_READ_REQUEST_ID		1
+#define ATP_GEYSER_MODE_WRITE_REQUEST_ID	9
+#define ATP_GEYSER_MODE_REQUEST_VALUE		0x300
+#define ATP_GEYSER_MODE_REQUEST_INDEX		0
+#define ATP_GEYSER_MODE_VENDOR_VALUE		0x04
 
 /* Structure to hold all of our device specific stuff */
 struct atp {
@@ -188,6 +188,14 @@ static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static inline int atp_is_old_fountain(struct atp *dev)
+{
+	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
+
+	return productId == FOUNTAIN_ANSI_PRODUCT_ID ||
+	       productId == FOUNTAIN_ISO_PRODUCT_ID;
+}
+
 /* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
 static inline int atp_is_geyser_2(struct atp *dev)
 {
@@ -211,52 +219,55 @@ static inline int atp_is_geyser_3(struct
 }
 
 /*
- * By default Geyser 3 device sends standard USB HID mouse
+ * By default newer Geyser devices send standard USB HID mouse
  * packets (Report ID 2). This code changes device mode, so it
  * sends raw sensor reports (Report ID 5).
  */
-static int atp_geyser3_init(struct usb_device *udev)
+static int atp_geyser_init(struct usb_device *udev)
 {
 	char data[8];
 	int size;
 
 	size = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-			ATP_GEYSER3_MODE_READ_REQUEST_ID,
+			ATP_GEYSER_MODE_READ_REQUEST_ID,
 			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			ATP_GEYSER3_MODE_REQUEST_VALUE,
-			ATP_GEYSER3_MODE_REQUEST_INDEX, &data, 8, 5000);
+			ATP_GEYSER_MODE_REQUEST_VALUE,
+			ATP_GEYSER_MODE_REQUEST_INDEX, &data, 8, 5000);
 
 	if (size != 8) {
 		err("Could not do mode read request from device"
-		    " (Geyser 3 mode)");
+		    " (Geyser Raw mode)");
 		return -EIO;
 	}
 
 	/* Apply the mode switch */
-	data[0] = ATP_GEYSER3_MODE_VENDOR_VALUE;
+	data[0] = ATP_GEYSER_MODE_VENDOR_VALUE;
 
 	size = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-			ATP_GEYSER3_MODE_WRITE_REQUEST_ID,
+			ATP_GEYSER_MODE_WRITE_REQUEST_ID,
 			USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			ATP_GEYSER3_MODE_REQUEST_VALUE,
-			ATP_GEYSER3_MODE_REQUEST_INDEX, &data, 8, 5000);
+			ATP_GEYSER_MODE_REQUEST_VALUE,
+			ATP_GEYSER_MODE_REQUEST_INDEX, &data, 8, 5000);
 
 	if (size != 8) {
 		err("Could not do mode write request to device"
-		    " (Geyser 3 mode)");
+		    " (Geyser Raw mode)");
 		return -EIO;
 	}
 	return 0;
 }
 
-/* Reinitialise the device if it's a geyser 3 */
+/*
+ * Reinitialise the device. This usually stops stream of empty packets
+ * coming form it.
+ */
 static void atp_reinit(struct work_struct *work)
 {
 	struct atp *dev = container_of(work, struct atp, work);
 	struct usb_device *udev = dev->udev;
 
 	dev->idlecount = 0;
-	atp_geyser3_init(udev);
+	atp_geyser_init(udev);
 }
 
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
@@ -507,19 +518,23 @@ static void atp_complete(struct urb* urb
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
-	/* Many Geysers will continue to send packets continually after
-	   the first touch unless reinitialised. Do so if it's been
-	   idle for a while in order to avoid waking the kernel up
-	   several hundred times a second */
-
-	if (!x && !y && !key) {
-		dev->idlecount++;
-		if (dev->idlecount == 10) {
-			dev->valid = 0;
-			schedule_work(&dev->work);
-		}
-	} else
-		dev->idlecount = 0;
+	/*
+	 * Many Geysers will continue to send packets continually after
+	 * the first touch unless reinitialised. Do so if it's been
+	 * idle for a while in order to avoid waking the kernel up
+	 * several hundred times a second. Re-initialization does not
+	 * work on older versions of Fountain touchpads.
+	 */
+	if (!atp_is_old_fountain(dev)) {
+		if (!x && !y && !key) {
+			dev->idlecount++;
+			if (dev->idlecount == 10) {
+				dev->valid = 0;
+				schedule_work(&dev->work);
+			}
+		} else
+			dev->idlecount = 0;
+	}
 
 exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
@@ -593,12 +608,12 @@ static int atp_probe(struct usb_interfac
 	else
 		dev->datalen = 81;
 
-	if (atp_is_geyser_3(dev)) {
+	if (!atp_is_old_fountain(dev)) {
 		/* switch to raw sensor mode */
-		if (atp_geyser3_init(udev))
+		if (atp_geyser_init(udev))
 			goto err_free_devs;
 
-		printk("appletouch Geyser 3 inited.\n");
+		printk(KERN_INFO "appletouch: Geyser mode initialized.\n");
 	}
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
