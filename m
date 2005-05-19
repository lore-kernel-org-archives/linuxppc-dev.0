Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 1D816679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 06:26:06 +1000 (EST)
Message-ID: <428CF693.5030100@mrv.com>
Date: Thu, 19 May 2005 16:26:59 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <20050518170949.GA6766@gate.ebshome.net> <428CD40C.201@mrv.com>
	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>
	<428CEA55.1040904@mrv.com>
	<5e493590088edcf959e30390363e798d@embeddededge.com>
In-Reply-To: <5e493590088edcf959e30390363e798d@embeddededge.com>
Content-Type: multipart/mixed; boundary="------------000003050200060607070200"
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
--------------000003050200060607070200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

You are right, moving the event clearing statement is much easier and 
cleaner. Let the interrupt be the loop.
Thanks Dan !


Dan Malek wrote:

>
> On May 19, 2005, at 3:34 PM, Guillaume Autran wrote:
>
>> Is it better like this ?
>
>
> Yes, but now I see one problem with it.  :-)
>
> We have to clear all events even though we may not
> handle all of them.  Your while loop filters only the events
> we process, but there could be others causing the interrupt
> which will never get cleared.  In this case we end up with
> an infinite interrupt loop where we don't process anything,
> but we don't make the interrupt go away, either.   It may be
> easier to forget the loop, just read/clear the event register
> up front, then process based on the events based upon
> what we found. It's what we tend to do in the other drivers.
>
> The functions called to do the rx/tx processing have loops
> in them to process all of the data they find, so it isn't likely
> you have left anything behind.  If you want to try to save
> the interrupt overhead, change it to do/while, check again
> at the end before the exit.
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


--------------000003050200060607070200
Content-Type: text/plain;
 name="cpm_uart_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_core.patch"

diff -Nru linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c
--- linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-19 16:23:13.000000000 -0400
@@ -336,22 +336,22 @@
 
 	if (IS_SMC(pinfo)) {
 		events = smcp->smc_smce;
+		smcp->smc_smce = events;
 		if (events & SMCM_BRKE)
 			uart_handle_break(port);
 		if (events & SMCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & SMCM_TX)
 			cpm_uart_int_tx(port, regs);
-		smcp->smc_smce = events;
 	} else {
 		events = sccp->scc_scce;
+		sccp->scc_scce = events;
 		if (events & UART_SCCM_BRKE)
 			uart_handle_break(port);
 		if (events & UART_SCCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events & UART_SCCM_TX)
 			cpm_uart_int_tx(port, regs);
-		sccp->scc_scce = events;
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }

--------------000003050200060607070200--
