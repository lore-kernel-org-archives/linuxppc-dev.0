Date: Thu, 29 Jul 2004 22:34:44 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [6/9] Support for old IBM PReP boxes
Message-ID: <20040729213444.GA5907@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This adds support for the "PCIBridgeRS6K" bridge type in residual
data to prep_find_bridges() - this is for the 7043-240.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c linux-2.6.6/arch/ppc/platforms/prep_pci.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_pci.c	2004-06-08 21:14:21.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_pci.c	2004-06-09 09:47:33.000000000 +0100
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
