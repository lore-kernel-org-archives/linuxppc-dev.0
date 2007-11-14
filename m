Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 07E13DDE1C
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 00:41:51 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 280FEF491B5
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 14:41:49 +0100 (CET)
Subject: [PATCH v2] using mii-bitbang on different processor ports - update
	the booting-without-of.txt-file
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com
Date: Wed, 14 Nov 2007 14:41:34 +0100
Message-Id: <1195047694.3334.4.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch updates the booting-without-of.txt-file.
There is a description for the case
if mdio data and clock pins are on different processor ports.
It extends the "[PATCH v3] using mii-bitbang on different processor ports".

Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
Signed-off-by: Scott Wood <scottwood@freescale.com>
--

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 497d8d8..084d31b 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1936,11 +1936,15 @@ platforms are moved over to use the flattened-device-tree model.
 
    Currently defined compatibles:
    fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
-   fsl,cpm2-mdio-bitbang (reg is port C registers)
+   fsl,cpm2-mdio-bitbang
 
    Properties for fsl,cpm2-mdio-bitbang:
-   fsl,mdio-pin : pin of port C controlling mdio data
-   fsl,mdc-pin : pin of port C controlling mdio clock
+   The first reg resource is the I/O port register block on which MDIO
+   resides.  The second reg resource is the I/O port register block on
+   which MDC resides.  If there is only one reg resource, it is used for
+   both MDIO and MDC.
+   fsl,mdio-pin : pin of chosen port for controlling mdio data
+   fsl,mdc-pin : pin of chosen port for controlling mdio clock
 
    Example:
