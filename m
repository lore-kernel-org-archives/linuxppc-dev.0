Message-ID: <1856.80.7.99.14.1086887115.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 18:05:15 +0100 (BST)
Subject: [RFC][PATCH 6/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some IBM PRePs have host bridges described by residual data as
PCIBridgeRS6K.  I've no idea what's different about them, but
they seem to work the same.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c
linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-08
21:14:21.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-09
09:47:33.000000000 +0100
@@ -1297,7 +1297,8 @@
 		hostbridge = residual_find_device(PROCESSORDEVICE, NULL,
 			BridgeController, PCIBridge, -1, 0);
 		if (hostbridge &&
-			hostbridge->DeviceId.Interface == PCIBridgeIndirect) {
+			((hostbridge->DeviceId.Interface == PCIBridgeIndirect) ||
+			 (hostbridge->DeviceId.Interface == PCIBridgeRS6K))) {
 			PnP_TAG_PACKET * pkt;
 			pkt = PnP_find_large_vendor_packet(
 				res->DevicePnPHeap+hostbridge->AllocatedOffset,


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
