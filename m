Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 29AD9DDEEE
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 09:22:47 +1000 (EST)
Message-ID: <4669E4BD.7060002@am.sony.com>
Date: Fri, 08 Jun 2007 16:22:37 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: gregkh@suse.de
Subject: [patch] PS3: Fix USB return value
References: <20070606024407.786638029@am.sony.com>>
	<46662443.9020905@am.sony.com>
In-Reply-To: <46662443.9020905@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: owen@stampflee.com, Paul Mackerras <paulus@samba.org>,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a minor error on the return value of ps3_ehci_driver_register()
and ps3_ohci_driver_register() when running on non-PS3 systems.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
Hi Greg,

Testers found a problem with my latest PS3 USB patch.  Please
add it in.

-Geoff

 drivers/usb/host/ehci-ps3.c |    2 +-
 drivers/usb/host/ohci-ps3.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/ehci-ps3.c
+++ b/drivers/usb/host/ehci-ps3.c
@@ -227,7 +227,7 @@ static int ps3_ehci_driver_register(stru
 {
 	return firmware_has_feature(FW_FEATURE_PS3_LV1)
 		? ps3_system_bus_driver_register(drv)
-		: -ENODEV;
+		: 0;
 }
 
 static void ps3_ehci_driver_unregister(struct ps3_system_bus_driver *drv)
--- a/drivers/usb/host/ohci-ps3.c
+++ b/drivers/usb/host/ohci-ps3.c
@@ -230,7 +230,7 @@ static int ps3_ohci_driver_register(stru
 {
 	return firmware_has_feature(FW_FEATURE_PS3_LV1)
 		? ps3_system_bus_driver_register(drv)
-		: -ENODEV;
+		: 0;
 }
 
 static void ps3_ohci_driver_unregister(struct ps3_system_bus_driver *drv)
