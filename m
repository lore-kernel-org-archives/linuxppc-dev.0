Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B684DDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 07:26:16 +1000 (EST)
Date: Mon, 23 Apr 2007 16:26:10 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4 v5] powerpc: document phy-connection-type property
Message-Id: <20070423162610.5cbf0e4e.kim.phillips@freescale.com>
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
of 'phy-connection-type'.

phy-connection-type is now maintained one-to-one with definitions
in include/linux/phy.h, albeit in the form of a string.
If not specified, "mii" is assumed.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
moved phy-connection-type below phy-handle

 Documentation/powerpc/booting-without-of.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 88cdb59..76b4fa0 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1562,6 +1562,9 @@ platforms are moved over to use the flattened-device-tree model.
      network device.  This is used by the bootwrapper to interpret
      MAC addresses passed by the firmware when no information other
      than indices is available to associate an address with a device.
+   - phy-connection-type : a string naming the controller/PHY interface type,
+     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", "tbi",
+     or "rtbi".
 
    Example:
 	ucc@2000 {
@@ -1576,6 +1579,7 @@ platforms are moved over to use the flattened-device-tree model.
 		rx-clock = "none";
 		tx-clock = "clk9";
 		phy-handle = <212000>;
+		phy-connection-type = "gmii";
 		pio-handle = <140001>;
 	};
 
-- 
1.5.0.3
