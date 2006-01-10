Return-Path: <bgill@freescale.com>
Date: Tue, 10 Jan 2006 13:16:28 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: david@gibson.dropbear.id.au
Message-ID: <Pine.LNX.4.61.0601101305380.25461@cde-tx32-ldt329.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] dtc: Update flat OF doc for new mdio properties
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add device-type and compatible as required fields for mdio node; add eTSEC
to ethernet model options.

Signed-off-by: Becky Bruce <Becky.bruce@freescale.com>

---
commit 411a8d127af0305a9f81b893bb8e64a94031ec4f
tree d88ace9ae751e7ef53b1171230cd1bfe8d446fab
parent 986c272d66da52a952758c0d1c9f58f67e2b2251
author Becky Bruce <becky.bruce@freescale.com> Tue, 10 Jan 2006 13:04:31 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 10 Jan 2006 13:04:31 -0600

 Documentation/booting-without-of.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/booting-without-of.txt b/Documentation/booting-without-of.txt
index 1be1760..60d5b7a 100644
--- a/Documentation/booting-without-of.txt
+++ b/Documentation/booting-without-of.txt
@@ -1162,6 +1162,9 @@ platforms are moved over to use the flat
 
   Required properties:
     - reg : Offset and length of the register set for the device
+    - device_type : Should be "mdio"
+    - compatible : Should define the compatible device type for the
+      mdio.  Currently, this is most likely to be "gianfar"
 
   Example:
 
@@ -1179,7 +1182,7 @@ platforms are moved over to use the flat
   Required properties:
 
     - device_type : Should be "network"
-    - model : Model of the device.  Can be "TSEC" or "FEC"
+    - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
     - compatible : Should be "gianfar"
     - reg : Offset and length of the register set for the device
     - address : List of bytes representing the ethernet address of
@@ -1317,6 +1320,8 @@ not necessary as they are usually the sa
 
 		mdio@24520 {
 			reg = <24520 20>;
+			device_type = "mdio"; 
+			compatible = "gianfar";
 
 			ethernet-phy@0 {
 				linux,phandle = <2452000>
