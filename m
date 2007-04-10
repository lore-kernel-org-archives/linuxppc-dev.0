Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 845CFDDF07
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 07:56:47 +1000 (EST)
Date: Tue, 10 Apr 2007 16:56:39 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc: document max-speed and interface-type properties
Message-Id: <20070410165639.1b619c34.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since ucc_geth is being migrated to use the phylib, the existing
(undocumented) 'interface' property is being deprecated in favour
of unconjoined variations 'max-speed' and 'interface-type'.

max-speed is necessary for QE UEC devices that do not make that
information available through their programming model.

interface-type is now maintained one-to-one with definitions
in include/linux/phy.h.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
please consider for 2.6.22

 Documentation/powerpc/booting-without-of.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 88cdb59..92fa74c 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1556,6 +1556,9 @@ platforms are moved over to use the flattened-device-tree model.
    Required properties for network device_type:
    - mac-address : list of bytes representing the ethernet address.
    - phy-handle : The phandle for the PHY connected to this controller.
+   - max-speed : The maximum speed supported by the controller (in Mbit/s)
+   - interface-type : a string naming the controller/PHY interface type,
+     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", "rgmii", or "rtbi".
 
    Recommended properties:
    - linux,network-index : This is the intended "index" of this
@@ -1573,6 +1576,8 @@ platforms are moved over to use the flattened-device-tree model.
 		interrupts = <a0 0>;
 		interrupt-parent = <700>;
 		mac-address = [ 00 04 9f 00 23 23 ];
+		interface-type = "rgmii";
+		max-speed = <d#1000>;
 		rx-clock = "none";
 		tx-clock = "clk9";
 		phy-handle = <212000>;
-- 
1.5.0.1
