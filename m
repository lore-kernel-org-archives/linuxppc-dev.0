Return-Path: <SRS0+7c2a2ee449df3546049e+430+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (unknown [213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 216B52BD46
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Oct 2004 04:15:28 +1000 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1098870636.6159.13.camel@gaston>
References: <1098870636.6159.13.camel@gaston>
Content-Type: multipart/mixed; boundary="=-QIMpEcVLyt2PN9UkixTO"
Message-Id: <1098899446.13633.1861.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Wed, 27 Oct 2004 18:50:46 +0100
Cc: fedora-ppc@lists.infradead.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Test patch for sleep on Aluminium PowerBooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-QIMpEcVLyt2PN9UkixTO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-10-27 at 19:50 +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> This is an experimental patch against 2.6.9. It concerns the ATI based
> Aluminium PowerBook. The nVidia based ones aren't concerned at all, and
> the iBook G4 will have to wait a bit more for me to get the video wakeup
> code right.

Works for me, thanks. Works better if I have the attached patch too. 

Xorg doesn't seem to receive mouse events from the USB mouse after
resume, but 'od -t x1 /dev/input/mice' does continue to work after
resume. I'll investigate that one further.

-- 
dwmw2

--=-QIMpEcVLyt2PN9UkixTO
Content-Disposition: inline; filename=linux-2.6.9-usbsuspend.patch
Content-Type: text/x-patch; name=linux-2.6.9-usbsuspend.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/drivers/usb/core/hub.c.susp	2004-10-27 17:30:39.796999176 +0100
+++ linux-2.6.9/drivers/usb/core/hub.c	2004-10-27 17:31:49.991979112 +0100
@@ -1527,12 +1527,12 @@ static int __usb_suspend_device (struct 
 			 * even for drivers that can't suspend.
 			 */
 			if (!driver->suspend || state > PM_SUSPEND_MEM) {
-#if 1
+#if 0
 				dev_warn(&intf->dev, "resume is unsafe!\n");
 #else
-				down_write(&usb_bus_type.rwsem);
+				down_write(&usb_bus_type.subsys.rwsem);
 				device_release_driver(&intf->dev);
-				up_write(&usb_bus_type.rwsem);
+				up_write(&usb_bus_type.subsys.rwsem);
 #endif
 			}
 		}

--=-QIMpEcVLyt2PN9UkixTO--
