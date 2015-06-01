Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0133.outbound.protection.outlook.com [207.46.100.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B36A31A0C2A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 02:15:01 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>, <madalin.bucur@freescale.com>, Igal Liberman
 <igal.liberman@freescale.com>
Subject: [v2] powerpc/fsl: Add FMan Port 10G compatibles
Date: Mon, 1 Jun 2015 15:06:51 +0300
Message-ID: <1433160411-27621-1-git-send-email-igal.liberman@freescale.com>
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

v2 - Addressed feedback from Scott:
	Replaced "10G-support" with "fsl,fman-10g-port"
	Replaced "best-effort-port" with "fsl,fman-best-effort-port"

Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
Change-Id: If1ac160fbedc0cfd058f46ae8d8e3a50d3ecebb2
---
 .../devicetree/bindings/powerpc/fsl/fman.txt       |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
index edda55f..1fc5328 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
@@ -189,6 +189,19 @@ PROPERTIES
 		Definition: There is one reg region describing the port
 		configuration registers.
 
+- fsl,fman-10g-port
+		Usage: optional
+		Value type: boolean
+		Definition: The default port rate is 1G.
+		If this property exists, the port is s 10G port.
+
+- fsl,fman-best-effort-port
+		Usage: optional
+		Value type: boolean
+		Definition: Can be defined only if 10G-support is set.
+		This property marks a best-effort 10G port (10G port that
+		may not be capable of line rate).
+
 EXAMPLE
 
 port@a8000 {
-- 
1.7.9.5
