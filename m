To: linuxppc-embedded@lists.linuxppc.org,
	linux-usb-devel@lists.sourceforge.net
Subject: USB on PPC440GP (cache incoherent)
From: Roland Dreier <roland@topspin.com>
Date: 07 Jun 2002 16:57:01 -0700
Message-ID: <52hekebq2a.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just got USB working on my PPC440GP (IBM Ebony eval board).  I'm
using an Opti 82C861 OHCI controller, and so far I've tried an Alcor
SD card reader (mass storage) and a Belkin usbnet device.  My kernel
is 2.4.19-pre10 from the bk://ppc.bkbits.net/linuxppc_2_4_devel
BitKeeper tree.

I had to make some changes to the USB driver to get this working as
there are still some places where structures on the stack are being
used for DMA.  This causes problems on processors like the 440GP,
which are not cache coherent (you can only invalidate a whole cache
line, which can corrupt the stack).  I just changed all of these
places to use kmalloc to get memory instead.

Note that this might not work perfectly on all cache-incoherent
processors, since kmalloc could potentially allocate a chunk of memory
that is smaller than the processor's cache line size.  However it is
safe on the 440GP since the 440GP's cache line size is 32 bytes.

I've included a patch with my changes in this email.  I'm sending it
to the linuxppc-embedded list in case someone else is trying to do USB
on a 440 or 405 or similar processor.  I'm also sending it to
linux-usb-devel in the hope that these changes make it into the
mainline kernel.

Best,
  Roland

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1077  -> 1.1078
#	   drivers/usb/usb.c	1.19    -> 1.20
#	   drivers/usb/hub.c	1.14    -> 1.15
#	   drivers/usb/hub.h	1.7     -> 1.8
#	drivers/usb/storage/transport.c	1.10    -> 1.11
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/07	roland@gold.topspincom.com	1.1078
# Fix problems in USB when running on cache-incoherent cpus like PPC440GP
# (Don't do DMAs into memory allocated on stack)
# --------------------------------------------
#
diff -Nru a/drivers/usb/hub.c b/drivers/usb/hub.c
--- a/drivers/usb/hub.c	Fri Jun  7 16:35:31 2002
+++ b/drivers/usb/hub.c	Fri Jun  7 16:35:31 2002
@@ -155,7 +155,7 @@
 static int usb_hub_configure(struct usb_hub *hub, struct usb_endpoint_descriptor *endpoint)
 {
 	struct usb_device *dev = hub->dev;
-	struct usb_hub_status hubstatus;
+	struct usb_hub_status *hubstatus;
 	char portstr[USB_MAXCHILDREN + 1];
 	unsigned int pipe;
 	int i, maxp, ret;
@@ -258,27 +258,36 @@

 	dbg("port removable status: %s", portstr);

-	ret = usb_get_hub_status(dev, &hubstatus);
+        hubstatus = kmalloc(sizeof *hubstatus, GFP_KERNEL);
+        if (!hubstatus) {
+                err("Unable to allocate hubstatus");
+                kfree(hub->descriptor);
+                return -1;
+        }
+	ret = usb_get_hub_status(dev, hubstatus);
 	if (ret < 0) {
 		err("Unable to get hub status (err = %d)", ret);
+                kfree(hubstatus);
 		kfree(hub->descriptor);
 		return -1;
 	}

-	le16_to_cpus(&hubstatus.wHubStatus);
+	le16_to_cpus(&hubstatus->wHubStatus);

 	dbg("local power source is %s",
-		(hubstatus.wHubStatus & HUB_STATUS_LOCAL_POWER) ? "lost (inactive)" : "good");
+		(hubstatus->wHubStatus & HUB_STATUS_LOCAL_POWER) ? "lost (inactive)" : "good");

 	dbg("%sover-current condition exists",
-		(hubstatus.wHubStatus & HUB_STATUS_OVERCURRENT) ? "" : "no ");
+		(hubstatus->wHubStatus & HUB_STATUS_OVERCURRENT) ? "" : "no ");
+
+        kfree(hubstatus);

 	/* Start the interrupt endpoint */
 	pipe = usb_rcvintpipe(dev, endpoint->bEndpointAddress);
 	maxp = usb_maxpacket(dev, pipe, usb_pipeout(pipe));

-	if (maxp > sizeof(hub->buffer))
-		maxp = sizeof(hub->buffer);
+	if (maxp > USB_HUB_BUFFER_SIZE)
+		maxp = USB_HUB_BUFFER_SIZE;

 	hub->urb = usb_alloc_urb(0);
 	if (!hub->urb) {
@@ -357,6 +366,13 @@

 	memset(hub, 0, sizeof(*hub));

+        hub->buffer = kmalloc(USB_HUB_BUFFER_SIZE, GFP_KERNEL);
+        if (!hub->buffer) {
+                err("couldn't kmalloc hub->buffer");
+                kfree(hub);
+                return NULL;
+        }
+
 	INIT_LIST_HEAD(&hub->event_list);
 	hub->dev = dev;
 	init_MUTEX(&hub->khubd_sem);
@@ -383,6 +399,7 @@

 	spin_unlock_irqrestore(&hub_event_lock, flags);

+        kfree(hub->buffer);
 	kfree(hub);

 	return NULL;
@@ -417,6 +434,11 @@
 		hub->descriptor = NULL;
 	}

+        if (hub->buffer) {
+                kfree(hub->buffer);
+                hub->buffer = NULL;
+        }
+
 	/* Free the memory */
 	kfree(hub);
 }
@@ -782,7 +804,7 @@
 	struct list_head *tmp;
 	struct usb_device *dev;
 	struct usb_hub *hub;
-	struct usb_hub_status hubsts;
+	struct usb_hub_status *hubsts;
 	u16 hubstatus;
 	u16 hubchange;
 	u16 portstatus;
@@ -872,22 +894,28 @@
 		} /* end for i */

 		/* deal with hub status changes */
-		if (usb_get_hub_status(dev, &hubsts) < 0)
-			err("get_hub_status failed");
-		else {
-			hubstatus = le16_to_cpup(&hubsts.wHubStatus);
-			hubchange = le16_to_cpup(&hubsts.wHubChange);
-			if (hubchange & HUB_CHANGE_LOCAL_POWER) {
-				dbg("hub power change");
-				usb_clear_hub_feature(dev, C_HUB_LOCAL_POWER);
-			}
-			if (hubchange & HUB_CHANGE_OVERCURRENT) {
-				dbg("hub overcurrent change");
-				wait_ms(500);	/* Cool down */
-				usb_clear_hub_feature(dev, C_HUB_OVER_CURRENT);
-                        	usb_hub_power_on(hub);
-			}
+                hubsts = kmalloc(sizeof *hubsts, GFP_KERNEL);
+                if (!hubsts) {
+                        err("couldn't allocate hubsts");
+                } else {
+                        if (usb_get_hub_status(dev, hubsts) < 0)
+                                err("get_hub_status failed");
+                        else {
+                                hubstatus = le16_to_cpup(&hubsts->wHubStatus);
+                                hubchange = le16_to_cpup(&hubsts->wHubChange);
+                                if (hubchange & HUB_CHANGE_LOCAL_POWER) {
+                                        dbg("hub power change");
+                                        usb_clear_hub_feature(dev, C_HUB_LOCAL_POWER);
+                                }
+                                if (hubchange & HUB_CHANGE_OVERCURRENT) {
+                                        dbg("hub overcurrent change");
+                                        wait_ms(500);	/* Cool down */
+                                        usb_clear_hub_feature(dev, C_HUB_OVER_CURRENT);
+                                        usb_hub_power_on(hub);
+                                }
+                        }
 		}
+                kfree(hubsts);
 		up(&hub->khubd_sem);
         } /* end while (1) */

@@ -995,7 +1023,7 @@
 int usb_reset_device(struct usb_device *dev)
 {
 	struct usb_device *parent = dev->parent;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descriptor;
 	int i, ret, port = -1;

 	if (!parent) {
@@ -1044,17 +1072,19 @@
 	 * If nothing changed, we reprogram the configuration and then
 	 * the alternate settings.
 	 */
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, &descriptor,
-			sizeof(descriptor));
+        descriptor = kmalloc(sizeof *descriptor, GFP_KERNEL);
+	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, descriptor,
+                                 sizeof *descriptor);
 	if (ret < 0)
 		return ret;

-	le16_to_cpus(&descriptor.bcdUSB);
-	le16_to_cpus(&descriptor.idVendor);
-	le16_to_cpus(&descriptor.idProduct);
-	le16_to_cpus(&descriptor.bcdDevice);
+	le16_to_cpus(&descriptor->bcdUSB);
+	le16_to_cpus(&descriptor->idVendor);
+	le16_to_cpus(&descriptor->idProduct);
+	le16_to_cpus(&descriptor->bcdDevice);

-	if (memcmp(&dev->descriptor, &descriptor, sizeof(descriptor))) {
+	if (memcmp(&dev->descriptor, descriptor, sizeof *descriptor)) {
+                kfree(descriptor);
 		usb_destroy_configuration(dev);

 		ret = usb_get_device_descriptor(dev);
@@ -1083,6 +1113,7 @@

 		return 1;
 	}
+        kfree(descriptor);

 	ret = usb_set_configuration(dev, dev->actconfig->bConfigurationValue);
 	if (ret < 0) {
diff -Nru a/drivers/usb/hub.h b/drivers/usb/hub.h
--- a/drivers/usb/hub.h	Fri Jun  7 16:35:31 2002
+++ b/drivers/usb/hub.h	Fri Jun  7 16:35:31 2002
@@ -120,13 +120,15 @@

 struct usb_device;

+/* add 1 bit for hub status change and add 7 bits to round up to byte boundary */
+#define USB_HUB_BUFFER_SIZE ((USB_MAXCHILDREN + 1 + 7) / 8)
+
 struct usb_hub {
 	struct usb_device *dev;

 	struct urb *urb;		/* Interrupt polling pipe */

-	char buffer[(USB_MAXCHILDREN + 1 + 7) / 8]; /* add 1 bit for hub status change */
-					/* and add 7 bits to round up to byte boundary */
+        char *buffer;
 	int error;
 	int nerrors;

diff -Nru a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
--- a/drivers/usb/storage/transport.c	Fri Jun  7 16:35:31 2002
+++ b/drivers/usb/storage/transport.c	Fri Jun  7 16:35:31 2002
@@ -723,7 +723,7 @@

 		/* use the new buffer we have */
 		old_request_buffer = srb->request_buffer;
-		srb->request_buffer = srb->sense_buffer;
+		srb->request_buffer = kmalloc(18, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);

 		/* set the buffer length for transfer */
 		old_request_bufflen = srb->request_bufflen;
@@ -733,8 +733,14 @@
 		old_sg = srb->use_sg;
 		srb->use_sg = 0;

-		/* issue the auto-sense command */
-		temp_result = us->transport(us->srb, us);
+                if (srb->request_buffer) {
+                        /* issue the auto-sense command */
+                        temp_result = us->transport(us->srb, us);
+                        memcpy(srb->sense_buffer, srb->request_buffer, 18);
+                        kfree(srb->request_buffer);
+                } else {
+                        temp_result = USB_STOR_TRANSPORT_ERROR;
+                }

 		/* let's clean up right away */
 		srb->request_buffer = old_request_buffer;
@@ -1041,9 +1047,12 @@
 int usb_stor_Bulk_max_lun(struct us_data *us)
 {
 	unsigned char data;
+        unsigned char *buffer;
 	int result;
 	int pipe;

+        buffer = kmalloc(sizeof data, GFP_KERNEL);
+
 	/* issue the command -- use usb_control_msg() because
 	 *  the state machine is not yet alive */
 	pipe = usb_rcvctrlpipe(us->pusb_dev, 0);
@@ -1051,7 +1060,9 @@
 				 US_BULK_GET_MAX_LUN,
 				 USB_DIR_IN | USB_TYPE_CLASS |
 				 USB_RECIP_INTERFACE,
-				 0, us->ifnum, &data, sizeof(data), HZ);
+				 0, us->ifnum, buffer, sizeof(data), HZ);
+        data = *buffer;
+        kfree(buffer);

 	US_DEBUGP("GetMaxLUN command result is %d, data is %d\n",
 		  result, data);
@@ -1077,41 +1088,54 @@

 int usb_stor_Bulk_transport(Scsi_Cmnd *srb, struct us_data *us)
 {
-	struct bulk_cb_wrap bcb;
-	struct bulk_cs_wrap bcs;
+	struct bulk_cb_wrap *bcb;
+	struct bulk_cs_wrap *bcs;
 	int result;
 	int pipe;
 	int partial;
+        int ret = USB_STOR_TRANSPORT_ERROR;
+
+        bcb = kmalloc(sizeof *bcb, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+        if (!bcb) {
+                return USB_STOR_TRANSPORT_ERROR;
+        }
+        bcs = kmalloc(sizeof *bcs, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+        if (!bcs) {
+                kfree(bcb);
+                return USB_STOR_TRANSPORT_ERROR;
+        }

 	/* set up the command wrapper */
-	bcb.Signature = cpu_to_le32(US_BULK_CB_SIGN);
-	bcb.DataTransferLength = cpu_to_le32(usb_stor_transfer_length(srb));
-	bcb.Flags = srb->sc_data_direction == SCSI_DATA_READ ? 1 << 7 : 0;
-	bcb.Tag = srb->serial_number;
-	bcb.Lun = srb->cmnd[1] >> 5;
+	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
+	bcb->DataTransferLength = cpu_to_le32(usb_stor_transfer_length(srb));
+	bcb->Flags = srb->sc_data_direction == SCSI_DATA_READ ? 1 << 7 : 0;
+	bcb->Tag = srb->serial_number;
+	bcb->Lun = srb->cmnd[1] >> 5;
 	if (us->flags & US_FL_SCM_MULT_TARG)
-		bcb.Lun |= srb->target << 4;
-	bcb.Length = srb->cmd_len;
+		bcb->Lun |= srb->target << 4;
+	bcb->Length = srb->cmd_len;

 	/* construct the pipe handle */
 	pipe = usb_sndbulkpipe(us->pusb_dev, us->ep_out);

 	/* copy the command payload */
-	memset(bcb.CDB, 0, sizeof(bcb.CDB));
-	memcpy(bcb.CDB, srb->cmnd, bcb.Length);
+	memset(bcb->CDB, 0, sizeof(bcb->CDB));
+	memcpy(bcb->CDB, srb->cmnd, bcb->Length);

 	/* send it to out endpoint */
 	US_DEBUGP("Bulk command S 0x%x T 0x%x Trg %d LUN %d L %d F %d CL %d\n",
-		  le32_to_cpu(bcb.Signature), bcb.Tag,
-		  (bcb.Lun >> 4), (bcb.Lun & 0x0F),
-		  bcb.DataTransferLength, bcb.Flags, bcb.Length);
-	result = usb_stor_bulk_msg(us, &bcb, pipe, US_BULK_CB_WRAP_LEN,
+		  le32_to_cpu(bcb->Signature), bcb->Tag,
+		  (bcb->Lun >> 4), (bcb->Lun & 0x0F),
+		  bcb->DataTransferLength, bcb->Flags, bcb->Length);
+	result = usb_stor_bulk_msg(us, bcb, pipe, US_BULK_CB_WRAP_LEN,
 				   &partial);
 	US_DEBUGP("Bulk command transfer result=%d\n", result);

 	/* if the command was aborted, indicate that */
-	if (result == -ENOENT)
-		return USB_STOR_TRANSPORT_ABORTED;
+	if (result == -ENOENT) {
+                ret = USB_STOR_TRANSPORT_ABORTED;
+                goto out;
+        }

 	/* if we stall, we need to clear it before we go on */
 	if (result == -EPIPE) {
@@ -1119,25 +1143,30 @@
 		result = usb_stor_clear_halt(us, pipe);

 		/* if the command was aborted, indicate that */
-		if (result == -ENOENT)
-			return USB_STOR_TRANSPORT_ABORTED;
+		if (result == -ENOENT) {
+			ret = USB_STOR_TRANSPORT_ABORTED;
+                        goto out;
+                }
 		result = -EPIPE;
 	} else if (result) {
 		/* unknown error -- we've got a problem */
-		return USB_STOR_TRANSPORT_ERROR;
+		ret = USB_STOR_TRANSPORT_ERROR;
+                goto out;
 	}

 	/* if the command transfered well, then we go to the data stage */
 	if (result == 0) {
 		/* send/receive data payload, if there is any */
-		if (bcb.DataTransferLength) {
+		if (bcb->DataTransferLength) {
 			usb_stor_transfer(srb, us);
 			result = srb->result;
 			US_DEBUGP("Bulk data transfer result 0x%x\n", result);

 			/* if it was aborted, we need to indicate that */
-			if (result == US_BULK_TRANSFER_ABORTED)
-				return USB_STOR_TRANSPORT_ABORTED;
+			if (result == US_BULK_TRANSFER_ABORTED) {
+				ret = USB_STOR_TRANSPORT_ABORTED;
+                                goto out;
+                        }
 		}
 	}

@@ -1150,12 +1179,14 @@

 	/* get CSW for device status */
 	US_DEBUGP("Attempting to get CSW...\n");
-	result = usb_stor_bulk_msg(us, &bcs, pipe, US_BULK_CS_WRAP_LEN,
+	result = usb_stor_bulk_msg(us, bcs, pipe, US_BULK_CS_WRAP_LEN,
 				   &partial);

 	/* if the command was aborted, indicate that */
-	if (result == -ENOENT)
-		return USB_STOR_TRANSPORT_ABORTED;
+	if (result == -ENOENT) {
+		ret = USB_STOR_TRANSPORT_ABORTED;
+                goto out;
+        }

 	/* did the attempt to read the CSW fail? */
 	if (result == -EPIPE) {
@@ -1163,17 +1194,21 @@
 		result = usb_stor_clear_halt(us, pipe);

 		/* if the command was aborted, indicate that */
-		if (result == -ENOENT)
-			return USB_STOR_TRANSPORT_ABORTED;
+		if (result == -ENOENT) {
+			ret = USB_STOR_TRANSPORT_ABORTED;
+                        goto out;
+                }

 		/* get the status again */
 		US_DEBUGP("Attempting to get CSW (2nd try)...\n");
-		result = usb_stor_bulk_msg(us, &bcs, pipe,
+		result = usb_stor_bulk_msg(us, bcs, pipe,
 					   US_BULK_CS_WRAP_LEN, &partial);

 		/* if the command was aborted, indicate that */
-		if (result == -ENOENT)
-			return USB_STOR_TRANSPORT_ABORTED;
+		if (result == -ENOENT) {
+			ret = USB_STOR_TRANSPORT_ABORTED;
+                        goto out;
+                }

 		/* if it fails again, we need a reset and return an error*/
 		if (result == -EPIPE) {
@@ -1181,48 +1216,60 @@
 			result = usb_stor_clear_halt(us, pipe);

 			/* if the command was aborted, indicate that */
-			if (result == -ENOENT)
-				return USB_STOR_TRANSPORT_ABORTED;
-			return USB_STOR_TRANSPORT_ERROR;
+			if (result == -ENOENT) {
+				ret = USB_STOR_TRANSPORT_ABORTED;
+                                goto out;
+                        }
+			ret = USB_STOR_TRANSPORT_ERROR;
+                        goto out;
 		}
 	}

 	/* if we still have a failure at this point, we're in trouble */
 	US_DEBUGP("Bulk status result = %d\n", result);
 	if (result) {
-		return USB_STOR_TRANSPORT_ERROR;
+		ret = USB_STOR_TRANSPORT_ERROR;
+                goto out;
 	}

 	/* check bulk status */
 	US_DEBUGP("Bulk status Sig 0x%x T 0x%x R %d Stat 0x%x\n",
-		  le32_to_cpu(bcs.Signature), bcs.Tag,
-		  bcs.Residue, bcs.Status);
-	if (bcs.Signature != cpu_to_le32(US_BULK_CS_SIGN) ||
-	    bcs.Tag != bcb.Tag ||
-	    bcs.Status > US_BULK_STAT_PHASE || partial != 13) {
+		  le32_to_cpu(bcs->Signature), bcs->Tag,
+		  bcs->Residue, bcs->Status);
+	if (bcs->Signature != cpu_to_le32(US_BULK_CS_SIGN) ||
+	    bcs->Tag != bcb->Tag ||
+	    bcs->Status > US_BULK_STAT_PHASE || partial != 13) {
 		US_DEBUGP("Bulk logical error\n");
-		return USB_STOR_TRANSPORT_ERROR;
+		ret = USB_STOR_TRANSPORT_ERROR;
+                goto out;
 	}

 	/* based on the status code, we report good or bad */
-	switch (bcs.Status) {
+	switch (bcs->Status) {
 		case US_BULK_STAT_OK:
 			/* command good -- note that data could be short */
-			return USB_STOR_TRANSPORT_GOOD;
+			ret = USB_STOR_TRANSPORT_GOOD;
+                        goto out;

 		case US_BULK_STAT_FAIL:
 			/* command failed */
-			return USB_STOR_TRANSPORT_FAILED;
+			ret = USB_STOR_TRANSPORT_FAILED;
+                        goto out;

 		case US_BULK_STAT_PHASE:
 			/* phase error -- note that a transport reset will be
 			 * invoked by the invoke_transport() function
 			 */
-			return USB_STOR_TRANSPORT_ERROR;
+			ret = USB_STOR_TRANSPORT_ERROR;
+                        goto out;
 	}

 	/* we should never get here, but if we do, we're in trouble */
-	return USB_STOR_TRANSPORT_ERROR;
+
+ out:
+        kfree(bcb);
+        kfree(bcs);
+	return ret;
 }

 /***********************************************************************
diff -Nru a/drivers/usb/usb.c b/drivers/usb/usb.c
--- a/drivers/usb/usb.c	Fri Jun  7 16:35:31 2002
+++ b/drivers/usb/usb.c	Fri Jun  7 16:35:31 2002
@@ -1787,16 +1787,23 @@
 {
 	int i = 5;
 	int result;
+        void *tmp_buf;

-	memset(buf,0,size);	// Make sure we parse really received data
+        tmp_buf = kmalloc(size, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
+        if (!tmp_buf) {
+          return -ENOMEM;
+        }
+	memset(tmp_buf,0,size);	// Make sure we parse really received data

 	while (i--) {
 		if ((result = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
 			USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-			(type << 8) + index, 0, buf, size, HZ * GET_TIMEOUT)) > 0 ||
+			(type << 8) + index, 0, tmp_buf, size, HZ * GET_TIMEOUT)) > 0 ||
 		     result == -EPIPE)
 			break;	/* retry if the returned length was 0; flaky device */
 	}
+        memcpy(buf, tmp_buf, size);
+        kfree(tmp_buf);
 	return result;
 }


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
