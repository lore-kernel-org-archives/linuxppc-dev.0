Return-Path: <B16394@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9E542C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 17:50:32 +1100 (EST)
Received: from mail19-am1 (localhost [127.0.0.1])	by mail19-am1-R.bigfish.com
 (Postfix) with ESMTP id 76A94420321	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 23 Jan 2013 06:50:26 +0000 (UTC)
Received: from AM1EHSMHS019.bigfish.com (unknown [10.3.201.230])	by
 mail19-am1.bigfish.com (Postfix) with ESMTP id B2990120116	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2013 06:50:24 +0000 (UTC)
Received: from b16394-desktop.ap.freescale.net
 (b16394-desktop.ap.freescale.net [10.232.132.33])	by az84smr01.freescale.net
 (8.14.3/8.14.0) with ESMTP id r0N6oHgY022588	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 23:50:18 -0700
From: Vakul Garg <vakul@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] crypto: caam - Added property fsl,
 sec-era in SEC4.0 device tree binding.
Date: Wed, 23 Jan 2013 12:17:47 +0530
Message-ID: <1358923667-2118-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This new property defines the era of the particular SEC version.
The compatible property in device tree "crypto" node has been updated
not to contain SEC era numbers.

Signed-off-by: Vakul Garg <vakul@freescale.com>
---
 .../devicetree/bindings/crypto/fsl-sec4.txt        |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
index fc9ce6f..dc40055 100644
--- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
+++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
@@ -54,8 +54,13 @@ PROPERTIES
    - compatible
       Usage: required
       Value type: <string>
-      Definition: Must include "fsl,sec-v4.0". Also includes SEC
-           ERA versions (optional) with which the device is compatible.
+      Definition: Must include "fsl,sec-v4.0"
+
+   - fsl,sec-era
+      Usage: required
+      Value type: <u32>
+      Definition: A standard property. Define the 'ERA' of the SEC
+          device.
 
    - #address-cells
        Usage: required
@@ -107,7 +112,8 @@ PROPERTIES
 
 EXAMPLE
 	crypto@300000 {
-		compatible = "fsl,sec-v4.0", "fsl,sec-era-v2.0";
+		compatible = "fsl,sec-v4.0";
+		fsl,sec-era = <0x2>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x300000 0x10000>;
-- 
1.7.7.6
