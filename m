Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.4.115])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 778C167A04
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 May 2006 19:42:44 +1000 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4H9gbmc021567
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 11:42:37 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx016.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4H9gTCW021471
	for <linuxppc-embedded@ozlabs.org>; Wed, 17 May 2006 11:42:29 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Does the CPM uart driver need more memory barriers ?
Date: Wed, 17 May 2006 11:43:58 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eBvaEip77pfJIK3"
Message-Id: <200605171143.58674.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_eBvaEip77pfJIK3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

while trying to debug a serial port issue, I found out some code might seemed 
to miss write memory barriers. Does the volatile keyword guarantee that gcc 
will no reorder memory writes, or is the attached patched needed ?

Best regards,

Laurent Pinchart

--Boundary-00=_eBvaEip77pfJIK3
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpm_wmb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpm_wmb.patch"

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index b7bf4c6..545f56c 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1032,6 +1032,7 @@ static void cpm_uart_console_write(struc
 		*cp = *s;
 
 		bdp->cbd_datlen = 1;
+		wmb();
 		bdp->cbd_sc |= BD_SC_READY;
 
 		if (bdp->cbd_sc & BD_SC_WRAP)
@@ -1048,6 +1049,7 @@ static void cpm_uart_console_write(struc
 
 			*cp = 13;
 			bdp->cbd_datlen = 1;
+			wmb();
 			bdp->cbd_sc |= BD_SC_READY;
 
 			if (bdp->cbd_sc & BD_SC_WRAP)

--Boundary-00=_eBvaEip77pfJIK3--
