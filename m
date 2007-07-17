Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F9A8DDFB1
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 10:58:55 +1000 (EST)
To: Greg KH <greg@kroah.com>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] USB_DR device support for FSL MPC831x
Date: Tue, 17 Jul 2007 04:58:49 +0400
Message-ID: <20070717005849.23036.21497.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This adds support for USB device mode on mpc831x series. 
Devicetree node modification is required to make it work - 

dr_mode ="peripheral";

which should be commented out if host mode is desired onboot.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/sysdev/fsl_soc.c |    1 +
 include/linux/fsl_devices.h   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index c0ddc80..27a1510 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -514,6 +514,7 @@ static int __init fsl_usb_of_init(void)
 			}
 		} else if (prop && !strcmp(prop, "peripheral")) {
 			usb_data.operating_mode = FSL_USB2_DR_DEVICE;
+			usb_data.max_ep_nr = *(unsigned int*)of_get_property(np, "max_ep_nr",NULL);
 			usb_dev_dr_client = platform_device_register_simple(
 					"fsl-usb2-udc", i, r, 2);
 			if (IS_ERR(usb_dev_dr_client)) {
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 12e631f..a3feb34 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -103,6 +103,7 @@ struct fsl_usb2_platform_data {
 	enum fsl_usb2_operating_modes	operating_mode;
 	enum fsl_usb2_phy_modes		phy_mode;
 	unsigned int			port_enables;
+	unsigned int			max_ep_nr;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
