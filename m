Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 580971A0784
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:03:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 11 Mar 2015 23:03:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 183282CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:03:03 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2BD2shU45547604
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:03:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2BD2TSF005349
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 00:02:29 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH slof v2] pci-properties: Remove redundant call to device-type
Date: Thu, 12 Mar 2015 00:02:02 +1100
Message-Id: <1426078922-22972-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment SLOF adds a "device_type" property automatically for
every single PCI device based on its class even if there is no SLOF
driver for such a device. OF1275 says that "device_type" is for
implemented interfaces only. A side effect of this is virtio-balloon
getting device_type=="memory" while it should not have.

This removes automatic call to device-type from the common PCI code.
Since now, we rely on existing SLOF PCI drivers to call device-type if
needed. virtio-blk/net, e1000, ohci/ehci/xhci do this. virtio-scsi
does not create the property for itself but disks on its bus do.
virtio-ballon won't get the device_type property as there is no driver
for it.

While we are here, remove device-type from usb-mouse as well.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* removed usb mouse as well - slof does not implement it
---
 slof/fs/pci-properties.fs | 2 +-
 slof/fs/usb/dev-mouse.fs  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/slof/fs/pci-properties.fs b/slof/fs/pci-properties.fs
index a19c651..9efa87e 100644
--- a/slof/fs/pci-properties.fs
+++ b/slof/fs/pci-properties.fs
@@ -565,7 +565,7 @@
 \ ***************************************************************************************
 \ set up common properties for devices and bridges
 : pci-common-props ( addr -- )
-        dup pci-class-name 2dup device-name device-type
+        dup pci-class-name device-name
         dup pci-vendor@    encode-int s" vendor-id"      property
         dup pci-device@    encode-int s" device-id"      property
         dup pci-revision@  encode-int s" revision-id"    property
diff --git a/slof/fs/usb/dev-mouse.fs b/slof/fs/usb/dev-mouse.fs
index 278a7c0..f6acd7e 100644
--- a/slof/fs/usb/dev-mouse.fs
+++ b/slof/fs/usb/dev-mouse.fs
@@ -6,7 +6,6 @@ sudev slof-dev>port l@ dup set-unit encode-phys " reg" property
 sudev slof-dev>udev @ VALUE udev
 
 s" usb-mouse" device-name
-s" mouse" device-type
 
 \ .S cr
 \     dup slof-dev>udev dup . @ . cr
-- 
2.0.0
