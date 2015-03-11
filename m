Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 291A31A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:27:34 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 11 Mar 2015 16:27:32 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 28D82357805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:27:31 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B6RMi820906154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:27:31 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B6QvCn018956
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:26:57 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH SLOF] pci-properties: Remove redundant call to device-type
Date: Wed, 11 Mar 2015 17:26:32 +1100
Message-Id: <1426055192-28691-1-git-send-email-aik@ozlabs.ru>
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

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I'll wait for a couple of days and push it to github if nobody objects.
Ben suggested that the linux guest must not rely on device_type in the common
case.

---
 slof/fs/pci-properties.fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.0.0
