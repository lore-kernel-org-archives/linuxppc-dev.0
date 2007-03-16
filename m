Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 497B1DE52B
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:28:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2GHSm3F004404
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:28:48 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHSlJx009940
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:47 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH96YQ001396
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:09:06 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id C4240AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:28:46 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHSkR6029820
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:28:46 -0500
Date: Fri, 16 Mar 2007 12:28:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/17] Document the linux,network-index property.
Message-ID: <20070316172846.GF29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To allow more robust association of each network device node with an
index (such as is used by the firmware or an EEPROM to indicate MAC
addresses), a network device's node may specify the index explicitly.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 6d5a5a0..ab5ed46 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1165,6 +1165,13 @@ platforms are moved over to use the flattened-device-tree model.
     - phy-handle : The phandle for the PHY connected to this ethernet
       controller.
 
+  Recommended properties:
+
+    - linux,network-index : This is the intended "index" of this
+      network device.  This is used by the bootwrapper to interpret
+      MAC addresses passed by the firmware when no information other
+      than indices is available to associate an address with a device.
+
   Example:
 
 	ethernet@24000 {
@@ -1533,6 +1540,12 @@ platforms are moved over to use the flattened-device-tree model.
    - mac-address : list of bytes representing the ethernet address.
    - phy-handle : The phandle for the PHY connected to this controller.
 
+   Recommended properties:
+   - linux,network-index : This is the intended "index" of this
+     network device.  This is used by the bootwrapper to interpret
+     MAC addresses passed by the firmware when no information other
+     than indices is available to associate an address with a device.
+
    Example:
 	ucc@2000 {
 		device_type = "network";
-- 
1.5.0.3
