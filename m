Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id E9624679EF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 05:33:52 +1000 (EST)
Message-ID: <428CEA55.1040904@mrv.com>
Date: Thu, 19 May 2005 15:34:45 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <20050518170949.GA6766@gate.ebshome.net> <428CD40C.201@mrv.com>
	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>
In-Reply-To: <2376d87e3df664106a6cf626f9575d90@embeddededge.com>
Content-Type: multipart/mixed; boundary="------------050905080500040904070804"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: fix cpm_uart_int() missing interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050905080500040904070804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Is it better like this ?

Dan Malek wrote:

>
> On May 19, 2005, at 1:59 PM, Guillaume Autran wrote:
>
>> Any comment ?
>
>
> The idea is fine.  Read Documentation/CodingStyle and try again .....
>
> Thanks.
>
>
>     -- Dan
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------050905080500040904070804
Content-Type: text/plain;
 name="cpm_uart_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_core.patch"

diff -Nru linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c
--- linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-19 15:31:03.000000000 -0400
@@ -335,23 +335,25 @@
 	pr_debug("CPM uart[%d]:IRQ\n", port->line);
 
 	if (IS_SMC(pinfo)) {
-		events = smcp->smc_smce;
-		if (events & SMCM_BRKE)
-			uart_handle_break(port);
-		if (events & SMCM_RX)
-			cpm_uart_int_rx(port, regs);
-		if (events & SMCM_TX)
-			cpm_uart_int_tx(port, regs);
-		smcp->smc_smce = events;
+		while ((events = smcp->smc_smce) & (SMCM_BRKE | SMCM_RX | SMCM_TX)) {
+			smcp->smc_smce = events;
+			if (events & SMCM_BRKE)
+				uart_handle_break(port);
+			if (events & SMCM_RX)
+				cpm_uart_int_rx(port, regs);
+			if (events & SMCM_TX)
+				cpm_uart_int_tx(port, regs);
+		}
 	} else {
-		events = sccp->scc_scce;
-		if (events & UART_SCCM_BRKE)
-			uart_handle_break(port);
-		if (events & UART_SCCM_RX)
-			cpm_uart_int_rx(port, regs);
-		if (events & UART_SCCM_TX)
-			cpm_uart_int_tx(port, regs);
-		sccp->scc_scce = events;
+		while ((events = sccp->scc_scce) & (UART_SCCM_BRKE | UART_SCCM_RX | UART_SCCM_TX)) {
+			sccp->scc_scce = events;
+			if (events & UART_SCCM_BRKE)
+				uart_handle_break(port);
+			if (events & UART_SCCM_RX)
+				cpm_uart_int_rx(port, regs);
+			if (events & UART_SCCM_TX)
+				cpm_uart_int_tx(port, regs);
+		}
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }

--------------050905080500040904070804--
