Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id ACDEADDF01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 02:02:46 +1100 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 061CCF49195
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 16:02:45 +0100 (CET)
Subject: [PATCH v3] using mii-bitbang on different processor ports - update
	the booting-without-of.txt-file
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
In-Reply-To: <200803101205.16158.laurentp@cse-semaphore.com>
References: <20070920220121.GF28784@loki.buserror.net>
	<20080307163747.GF10545@ld0162-tx32.am.freescale.net>
	<1205135421.3837.1.camel@p60365-ste>
	<200803101205.16158.laurentp@cse-semaphore.com>
Date: Mon, 10 Mar 2008 16:02:44 +0100
Message-Id: <1205161364.4627.12.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, netdev@vger.kernel.org
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

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
--

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 7b4e8a7..3285f58 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2003,10 +2003,14 @@ platforms are moved over to use the flattened-device-tree model.
 
    Currently defined compatibles:
    fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
-   fsl,cpm2-mdio-bitbang (reg is port C registers)
+   fsl,cpm2-mdio-bitbang
 
    Properties for fsl,cpm2-mdio-bitbang:
-   fsl,mdio-pin : pin of port C controlling mdio data
-   fsl,mdc-pin : pin of port C controlling mdio clock
+   The first reg resource is the I/O port register block on which MDC
+   resides.  The second reg resource is the I/O port register block on
+   which MDIO resides.  If there is only one reg resource, it is used for
+   both MDIO and MDC.
+   fsl,mdio-pin : pin of chosen port for controlling mdio data
+   fsl,mdc-pin : pin of chosen port for controlling mdio clock
 
    Example:
