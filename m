Date: Tue, 14 Oct 2003 12:26:14 +0200
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Fw: [PATCH] hcd-pci.c compile fix
Message-Id: <20031014122614.036ac493.colin@colino.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Tue__14_Oct_2003_12:26:14_+0200_10304998"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Tue__14_Oct_2003_12:26:14_+0200_10304998
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Forwarding this one too :)]

> Hi,

> this patch fixes compilation of drivers/usb/core/hcd-pci.c
> with gcc 2.95.

> hth,
> --
> Colin

--Multipart_Tue__14_Oct_2003_12:26:14_+0200_10304998
Content-Type: text/plain;
 name="hcd-pci.fix.patch"
Content-Disposition: attachment;
 filename="hcd-pci.fix.patch"
Content-Transfer-Encoding: 7bit

--- drivers/usb/core/hcd-pci.c.orig	Mon Oct 13 23:30:39 2003
+++ drivers/usb/core/hcd-pci.c	Mon Oct 13 23:30:32 2003
@@ -302,10 +302,11 @@
 			dev_dbg (hcd->controller, "suspend fail, retval %d\n",
 					retval);
 		else {
-			hcd->state = USB_STATE_SUSPENDED;
 #ifdef CONFIG_PPC_PMAC
 			struct device_node	*of_node;
-
+#endif
+			hcd->state = USB_STATE_SUSPENDED;
+#ifdef CONFIG_PPC_PMAC
 			/* Disable USB PAD & cell clock for Keylargo built-in controller */
 			of_node = pci_device_to_OF_node (dev);
 			if (of_node)


--Multipart_Tue__14_Oct_2003_12:26:14_+0200_10304998--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
