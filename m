Message-ID: <38C79955.9D538D7D@inu.se>
Date: Thu, 09 Mar 2000 13:30:13 +0100
From: Björn Lundberg <bjorn.lundberg@inu.se>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Steve Calfee <calfee@kerbango.com>,
        "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>,
        "Brad Parker (USB850)" <brad@parker.boston.ma.us>
Subject: Re: USB driver for MPC850/823
References: <4.2.2.20000308153704.00a601f0@mail.kerbango.com> <38C7368A.7B28E61E@netx4.com>
Content-Type: multipart/mixed;
 boundary="------------6376250C3F190CBC4CC417E9"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------6376250C3F190CBC4CC417E9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The simple reason (makes me blush) why buffers in SDRAM didn't work was
beacuse I omitted to flush the cache. (Thanks Brad and Malek)

I did a quick change and an even quicker test.
Patch attached.

Cheers
 Bjorn

Dan Malek wrote:
>
snip
>
> When using the CPM on the 8xx, you have to be careful about the cache
> attributes on the pages as the 8xx doesn't have bus snooping to ensure
> coherency.  I use a couple of different methods to get memory allocated
> in the kernel for the CPM, sometimes they are cached and require software
> management, other times not cached.  Depends upon how it is used.
>
--------------6376250C3F190CBC4CC417E9
Content-Type: text/plain; charset=us-ascii;
 name="patch-8xxhci.c-SDRAM.diff"
Content-Disposition: inline;
 filename="patch-8xxhci.c-SDRAM.diff"
Content-Transfer-Encoding: 7bit

--- ../usb.8xx_io/8xxhci.c	Tue Mar  7 13:31:50 2000
+++ 8xxhci.c	Thu Mar  9 13:06:43 2000
@@ -55,8 +55,10 @@

 #ifdef BUF_IN_DPRAM
 #define BD_BUFADDR(bdp)	((unsigned char*)((bdp)->cbd_bufaddr))
+#define BD_RELEASE(bdpbuf)
 #else	/* buffs in sdram */
 #define BD_BUFADDR(bdp)	((unsigned char*)__va((bdp)->cbd_bufaddr))
+#define BD_RELEASE(bdpbuf) flush_dcache_range((int)bdpbuf, (int)bdpbuf + PKT_BUF_SIZE)
 #endif

 #define	MY_USMOD	(USMOD_HOST | USMOD_EN)	/* | USMOD_TEST) */
@@ -314,6 +316,7 @@
 	return 0;
 }

+#if NOT_USED
 /*
  * Lets define a set of functions that can help us terminate messages
  * that are put here for periodic (rescheduled) transfer
@@ -346,6 +349,7 @@

 	remove_wait_queue(&terminate_wakeup, &wait);
 }
+#endif

 /*
  * Called from outside to stop an interrupt message
@@ -353,9 +357,8 @@
 int cpm_hci_release_irq(struct usb_device *usb_dev, void *_irp)
 {
 	struct cpm_hci_irp	*irp = (struct cpm_hci_irp*)_irp;
-	struct cpm_hci *cpm_hci = irp->dev->cpm_hci;
 	struct cpm_hci_device	*dev = usb_to_cpm_hci(usb_dev);
-	unsigned long flags;
+	// unsigned long flags;

 	if (!irp)
 		return USB_ST_INTERNALERROR;
@@ -602,8 +605,7 @@
 {
 	struct cpm_hci_irp	*irp = (struct cpm_hci_irp*)_irp;
 	struct cpm_hci_device	*dev = usb_to_cpm_hci(usb_dev);
-	struct cpm_hci *cpm_hci = irp->dev->cpm_hci;
-	unsigned long flags;
+	// unsigned long flags;

 	if (!irp) {
 		printk("USB: cpm_hci_terminate_bulk irp == NULL\n");
@@ -846,6 +848,7 @@
 	bdpbuf[0] = tok;
 	bdpbuf[1] = (__u8)(tok_data & 0x00ff);
 	bdpbuf[2] = (__u8)(tok_data >> 8);
+	BD_RELEASE(bdpbuf);
 	bdp->cbd_datlen = 3;
 	bdp->cbd_sc &= BD_USB_TX_WRAP;		/* clear all but wrap-bit */
 	bdp->cbd_sc |= (BD_USB_TX_LAST);	/* this is the last buffer in msg */
@@ -872,6 +875,7 @@
 	bdpbuf[0] = PID_SOF;
 	bdpbuf[1] = (__u8)(tok_data & 0x00ff);
 	bdpbuf[2] = (__u8)(tok_data >> 8);
+	BD_RELEASE(bdpbuf);
 	bdp->cbd_datlen = 3;
 	bdp->cbd_sc &= BD_USB_TX_WRAP;		/* clear all but wrap-bit */
 	bdp->cbd_sc |= (BD_USB_TX_LAST);	/* this is the last buffer in msg */
@@ -894,6 +898,7 @@

 	bdp->cbd_datlen = n;
 	memcpy(BD_BUFADDR(bdp), irp->data + irp->datadone, n);
+	BD_RELEASE(BD_BUFADDR(bdp));
 	bdp->cbd_sc &= BD_USB_TX_WRAP;		/* clear all but wrap-bit */
 	bdp->cbd_sc |= (BD_USB_TX_LAST);	/* this is the last buffer in msg */
 	bdp->cbd_sc |= (BD_USB_TX_INTR);	/* generate interrupt */
@@ -1063,6 +1068,7 @@
 			pr_debug("cpm_hci_do_resend: memcpy( %p, %p, %d)\n",
 			       BD_BUFADDR(bdp), BD_BUFADDR(bdp_failed), bdp_failed->cbd_datlen);
 			memcpy(BD_BUFADDR(bdp), BD_BUFADDR(bdp_failed), bdp_failed->cbd_datlen);
+			BD_RELEASE(BD_BUFADDR(bdp));
 			bdp->cbd_datlen = bdp_failed->cbd_datlen;

 			/* get all but wrap- and status-bits
@@ -1160,6 +1166,7 @@
 			// pr_debug("cpm_hci_do_resend: memcpy( %p, %p, %d)\n",
 			//        BD_BUFADDR(bdp), irp->bdp[i].buf, irp->bdp[i].datlen);
 			memcpy(BD_BUFADDR(bdp), irp->bdp[i].buf, irp->bdp[i].datlen);
+			BD_RELEASE(BD_BUFADDR(bdp));

 			bdp->cbd_datlen = irp->bdp[i].datlen;

@@ -1204,6 +1211,7 @@
 			bdp = next_tx_bd(bdp, cpm_hci);
 			bdp->cbd_datlen = irp->cmdlen;
 			memcpy(BD_BUFADDR(bdp), &irp->cmd, irp->cmdlen);
+			BD_RELEASE(BD_BUFADDR(bdp));
 			/*
 			 * We'll use the tx irq the wakeupcall
 			 */

--------------6376250C3F190CBC4CC417E9--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
