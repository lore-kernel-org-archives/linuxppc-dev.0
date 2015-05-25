Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0141.outbound.protection.outlook.com [65.55.169.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7AF8C1A0773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 03:40:19 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <madalin.bucur@freescale.com>, Igal Liberman
 <igal.liberman@freescale.com>
Subject: [PATCH] powerpc/fsl: Add FMan Port 10G compatibles
Date: Mon, 25 May 2015 16:30:46 +0300
Message-ID: <1432560646-19424-1-git-send-email-igal.liberman@freescale.com>
Reply-To: <igal.liberman@freescale.com>
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

From: Igal Liberman <igal.liberman@freescale.com>

This patch adds two boolean properties to FMan Port.
FMan has 3 types of ports:
	- 1G ports
		By default, all ports support 1G rate
	- 10G Ports
		Port which use 10G hardware, and configured as 10G
	- 10G Best effort ports
		Ports which use 1G hardware, configured as 10G, in this case,
		the rate is not guaranteed.
The new properties help to distinguish the different type of ports.

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>

---
 .../devicetree/bindings/powerpc/fsl/fman.txt       |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index edda55f..76a7cba 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -189,6 +189,19 @@ PROPERTIES
 		Definition: There is one reg region describing the port
 		configuration registers.
 
+- 10G-support
+		Usage: optional
+		Value type: boolean
+		Definition: The default port rate is 1G.
+		If this property exists, the port is configured as 10G port.
+
+- best-effort-port
+		Usage: optional
+		Value type: boolean
+		Definition: Can be defined only if 10G-support is set.
+		This property marks a best-effort 10G port (1G hardware
+		configured as 10G, 10G rate is not guaranteed).
+
 EXAMPLE
 
 port@a8000 {
-- 
1.7.9.5
