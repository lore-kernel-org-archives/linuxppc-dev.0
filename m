Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13884B7DBF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 12:38:00 +1000 (EST)
Subject: [PATCH] Fix UART clocks on 440SPe
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 12:22:50 +1000
Message-ID: <1273630970.21352.85.camel@pasglop>
Mime-Version: 1.0
Cc: Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code to fixup the serial ports on 440SPe uses the incorrect
addresses for these. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'm surprised nobody noticed, serial is pretty busted for me without
that patch :-)

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index 27db893..627de25 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -544,9 +544,9 @@ void ibm440spe_fixup_clocks(unsigned int sys_clk,
 	unsigned int plb_clk = __ibm440eplike_fixup_clocks(sys_clk, tmr_clk, 1);
 
 	/* serial clocks beed fixup based on int/ext */
-	eplike_fixup_uart_clk(0, "/plb/opb/serial@10000200", ser_clk, plb_clk);
-	eplike_fixup_uart_clk(1, "/plb/opb/serial@10000300", ser_clk, plb_clk);
-	eplike_fixup_uart_clk(2, "/plb/opb/serial@10000600", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(0, "/plb/opb/serial@f0000200", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(1, "/plb/opb/serial@f0000300", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(2, "/plb/opb/serial@f0000600", ser_clk, plb_clk);
 }
 
 void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
