Return-Path: <dtor@insightbb.com>
Received: from mxsf02.insightbb.com (mxsf02.insightbb.com [74.128.0.63])
	by ozlabs.org (Postfix) with ESMTP id 0F7F8DDEC7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 16:09:55 +1100 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
Date: Mon, 29 Oct 2007 01:09:48 -0400
References: <1193222676.4510.5.camel@johannes.berg>
	<200710281054.31303.dmitry.torokhov@gmail.com>
	<1193584081.5197.17.camel@johannes.berg>
In-Reply-To: <1193584081.5197.17.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710290109.49604.dtor@insightbb.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Anton Ekblad <valderman@gmail.com>,
	Joseph Jezak <josejx@woodpecker.gentoo.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 28 October 2007 11:08, Johannes Berg wrote:
> 
> > I was hoping that FOUNTAIN_TP_ONLY_PRODUCT_ID (0x30A) behaves similar
> > to Geyser in this regard. If you know that this assumption is incorrect
> > then we need to rename atp_is_older_fountain() to atp_is_fountain()
> > anf add this product ID to it.
> 
> Ah ok, I forgot about that one. If I were to venture a guess I'd say
> that they renamed it to geyser because of this idle behaviour
> "technology upgrade", but I can't say, nor do I know anybody with such a
> version, sorry.

OK then let's play safe and don't touch fountains at all. How about the
patch below?

-- 
Dmitry

Input: appletouch - idle reset logic broke older Fountains

Fountains do not support change mode request and therefore
should be excluded from idle reset attempts.

Also:
 - do not re-submit URB when we decide that toucvhpad needs to be
   reinicialized
 - do not repeat size detection when reinitializing the touchpad
 - Add missing KERN_* prefixes to messages

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/mouse/appletouch.c |  125 ++++++++++++++++++++++++---------------
 1 file changed, 77 insertions(+), 48 deletions(-)

Index: work/drivers/input/mouse/appletouch.c
===================================================================
--- work.orig/drivers/input/mouse/appletouch.c
+++ work/drivers/input/mouse/appletouch.c
@@ -129,12 +129,12 @@ MODULE_DEVICE_TABLE (usb, atp_table);
  */
 #define ATP_THRESHOLD	 5
 
-/* MacBook Pro (Geyser 3 & 4) initialization constants */
-#define ATP_GEYSER3_MODE_READ_REQUEST_ID 1
-#define ATP_GEYSER3_MODE_WRITE_REQUEST_ID 9
-#define ATP_GEYSER3_MODE_REQUEST_VALUE 0x300
-#define ATP_GEYSER3_MODE_REQUEST_INDEX 0
-#define ATP_GEYSER3_MODE_VENDOR_VALUE 0x04
+/* Geyser initialization constants */
+#define ATP_GEYSER_MODE_READ_REQUEST_ID		1
+#define ATP_GEYSER_MODE_WRITE_REQUEST_ID	9
+#define ATP_GEYSER_MODE_REQUEST_VALUE		0x300
+#define ATP_GEYSER_MODE_REQUEST_INDEX		0
+#define ATP_GEYSER_MODE_VENDOR_VALUE		0x04
 
 /* Structure to hold all of our device specific stuff */
 struct atp {
@@ -142,9 +142,11 @@ struct atp {
 	struct usb_device *	udev;		/* usb device */
 	struct urb *		urb;		/* usb request block */
 	signed char *		data;		/* transferred data */
-	int			open;		/* non-zero if opened */
-	struct input_dev	*input;		/* input dev */
-	int			valid;		/* are the sensors valid ? */
+	struct input_dev *	input;		/* input dev */
+	unsigned char		open;		/* non-zero if opened */
+	unsigned char		valid;		/* are the sensors valid ? */
+	unsigned char		size_detect_done;
+	unsigned char		overflowwarn;	/* overflow warning printed? */
 	int			x_old;		/* last reported x/y, */
 	int			y_old;		/* used for smoothing */
 						/* current value of the sensors */
@@ -153,7 +155,6 @@ struct atp {
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 						/* accumulated sensors */
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
-	int			overflowwarn;	/* overflow warning printed? */
 	int			datalen;	/* size of an USB urb transfer */
 	int			idlecount;      /* number of empty packets */
 	struct work_struct      work;
@@ -170,7 +171,7 @@ struct atp {
 
 #define dprintk(format, a...)						\
 	do {								\
-		if (debug) printk(format, ##a);				\
+		if (debug) printk(KERN_DEBUG format, ##a);				\
 	} while (0)
 
 MODULE_AUTHOR("Johannes Berg, Stelian Pop, Frank Arnold, Michael Hanselmann");
@@ -188,6 +189,15 @@ static int debug = 1;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static inline int atp_is_fountain(struct atp *dev)
+{
+	u16 productId = le16_to_cpu(dev->udev->descriptor.idProduct);
+
+	return productId == FOUNTAIN_ANSI_PRODUCT_ID ||
+	       productId == FOUNTAIN_ISO_PRODUCT_ID ||
+	       productId == FOUNTAIN_TP_ONLY_PRODUCT_ID;
+}
+
 /* Checks if the device a Geyser 2 (ANSI, ISO, JIS) */
 static inline int atp_is_geyser_2(struct atp *dev)
 {
@@ -211,52 +221,63 @@ static inline int atp_is_geyser_3(struct
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
+ * coming from it.
+ */
 static void atp_reinit(struct work_struct *work)
 {
 	struct atp *dev = container_of(work, struct atp, work);
 	struct usb_device *udev = dev->udev;
+	int retval;
 
 	dev->idlecount = 0;
-	atp_geyser3_init(udev);
+
+	atp_geyser_init(udev);
+
+	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
+	if (retval) {
+		err("%s - usb_submit_urb failed with result %d",
+		    __FUNCTION__, retval);
+	}
 }
 
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
@@ -337,7 +358,7 @@ static void atp_complete(struct urb* urb
 		break;
 	case -EOVERFLOW:
 		if(!dev->overflowwarn) {
-			printk("appletouch: OVERFLOW with data "
+			printk(KERN_WARNING "appletouch: OVERFLOW with data "
 				"length %d, actual length is %d\n",
 				dev->datalen, dev->urb->actual_length);
 			dev->overflowwarn = 1;
@@ -426,15 +447,17 @@ static void atp_complete(struct urb* urb
 		dev->x_old = dev->y_old = -1;
 		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
 
-		if (atp_is_geyser_3(dev)) /* No 17" Macbooks (yet) */
+		if (dev->size_detect_done ||
+		    atp_is_geyser_3(dev)) /* No 17" Macbooks (yet) */
 			goto exit;
 
 		/* 17" Powerbooks have extra X sensors */
-		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
-			if (!dev->xy_cur[i]) continue;
+		for (i = (atp_is_geyser_2(dev) ? 15 : 16); i < ATP_XSENSORS; i++) {
+			if (!dev->xy_cur[i])
+				continue;
 
-			printk("appletouch: 17\" model detected.\n");
-			if(atp_is_geyser_2(dev))
+			printk(KERN_INFO "appletouch: 17\" model detected.\n");
+			if (atp_is_geyser_2(dev))
 				input_set_abs_params(dev->input, ABS_X, 0,
 						     (20 - 1) *
 						     ATP_XFACT - 1,
@@ -444,10 +467,10 @@ static void atp_complete(struct urb* urb
 						     (ATP_XSENSORS - 1) *
 						     ATP_XFACT - 1,
 						     ATP_FUZZ, 0);
-
 			break;
 		}
 
+		dev->size_detect_done = 1;
 		goto exit;
 	}
 
@@ -479,7 +502,7 @@ static void atp_complete(struct urb* urb
 			dev->y_old = y;
 
 			if (debug > 1)
-				printk("appletouch: X: %3d Y: %3d "
+				printk(KERN_DEBUG "appletouch: X: %3d Y: %3d "
 				       "Xz: %3d Yz: %3d\n",
 				       x, y, x_z, y_z);
 
@@ -507,19 +530,25 @@ static void atp_complete(struct urb* urb
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
+	 * work on Fountain touchpads.
+	 */
+	if (!atp_is_fountain(dev)) {
+		if (!x && !y && !key) {
+			dev->idlecount++;
+			if (dev->idlecount == 10) {
+				dev->valid = 0;
+				schedule_work(&dev->work);
+				/* Don't resubmit urb here, wait for reinit */
+				return;
+			}
+		} else
+			dev->idlecount = 0;
+	}
 
 exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
@@ -593,12 +622,12 @@ static int atp_probe(struct usb_interfac
 	else
 		dev->datalen = 81;
 
-	if (atp_is_geyser_3(dev)) {
+	if (!atp_is_fountain(dev)) {
 		/* switch to raw sensor mode */
-		if (atp_geyser3_init(udev))
+		if (atp_geyser_init(udev))
 			goto err_free_devs;
 
-		printk("appletouch Geyser 3 inited.\n");
+		printk(KERN_INFO "appletouch: Geyser mode initialized.\n");
 	}
 
 	dev->urb = usb_alloc_urb(0, GFP_KERNEL);
