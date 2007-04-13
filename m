Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7461DDEDC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 16:25:51 +1000 (EST)
Date: Fri, 13 Apr 2007 01:25:42 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070413012542.343eb848.kim.phillips@freescale.com>
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

interface-type is now maintained one-to-one with definitions
in include/linux/phy.h.  If not specified, "mii" is assumed.

max-speed is available for users to override the interface-derived
speed, e.g. rgmii at 100Mbit/s.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
moved to recommended section (from required), removed sgmii, added rgmii-id.

please consider for 2.6.22

 Documentation/powerpc/booting-without-of.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 88cdb59..cb8c6fb 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1562,6 +1562,10 @@ platforms are moved over to use the flattened-device-tree model.
      network device.  This is used by the bootwrapper to interpret
      MAC addresses passed by the firmware when no information other
      than indices is available to associate an address with a device.
+   - interface-type : a string naming the controller/PHY interface type,
+     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "tbi", or "rtbi".
+   - max-speed : The maximum speed supported by the controller (in Mbit/s)
+     this is used if the user wants to override the interface-derived speed.
 
    Example:
 	ucc@2000 {
@@ -1573,6 +1577,7 @@ platforms are moved over to use the flattened-device-tree model.
 		interrupts = <a0 0>;
 		interrupt-parent = <700>;
 		mac-address = [ 00 04 9f 00 23 23 ];
+		interface-type = "rgmii";
 		rx-clock = "none";
 		tx-clock = "clk9";
 		phy-handle = <212000>;
-- 
1.5.0.1
