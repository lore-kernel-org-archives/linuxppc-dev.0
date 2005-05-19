Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 2CC3A679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 03:58:42 +1000 (EST)
Received: from ltnmail.xyplex.com (ltnmail.xyplex.com [140.179.176.25])
	by mailman.xyplex.com (8.9.3+Sun/8.9.3) with ESMTP id NAA29733
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 May 2005 13:59:40 -0400 (EDT)
Message-ID: <428CD40C.201@mrv.com>
Date: Thu, 19 May 2005 13:59:40 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050518170949.GA6766@gate.ebshome.net>
In-Reply-To: <20050518170949.GA6766@gate.ebshome.net>
Content-Type: multipart/mixed; boundary="------------030805000609010604000806"
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
--------------030805000609010604000806
Content-Type: multipart/alternative;
	boundary="------------070302030306030601020309"


--------------070302030306030601020309
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a patch to fix a problem that occurs at high baud rates in the 
cpm uart interrupt handling.

In cpm_uart_int(), the existing code reads the event register, processes 
the events, and then clears bits in the event register before returning. 
The problem here is that sometimes event processing generates new events 
quite quickly (i.e. at higher baud rates, the transmit interrupt handler 
puts another character into an SCC's transmit buffer and the SCC clears 
the READY bit almost immediately). In this case, the second interrupt 
can be missed because the scc_scce event register gets cleared after 
processing the first. The port can get hung.

The fix adds a while loop. It reads the event register saving its value 
in the local variable 'events' (as before) then clears the event 
register in the device immediately. It processes the events and tests 
the event register again handling new events that might get generated 
during handling.

Any comment ?

Guillaume.

-- 

=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------070302030306030601020309
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=us-ascii">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
<font size="2" face="Arial">This is a patch to fix a problem that
occurs at high baud rates in the cpm uart interrupt handling.<br>
<br>
In</font><b> <font size="2" face="Arial">cpm_uart_int()</font></b><font
 size="2" face="Arial">,
the existing code reads the event register, processes the events, and
then clears bits in the event register before returning. The problem
here is that sometimes event processing generates new events quite
quickly (i.e. at higher baud rates, the transmit interrupt handler puts
another character into an SCC's transmit buffer and the SCC clears the
READY bit almost immediately). In this case, the second interrupt can
be missed because the scc_scce event register gets cleared after
processing the first. The port can get hung.</font>
<p><font size="2" face="Arial">The fix adds a while loop. It reads the
event register saving its value in the local variable 'events' (as
before) then clears the event register in the device immediately. It
processes the events and tests the event register again handling new
events that might get generated during handling.<br>
</font></p>
<p><font size="2" face="Arial">Any comment ?<br>
</font></p>
<p><font size="2" face="Arial">Guillaume.<br>
</font></p>
-- <br>
<pre class="moz-signature" cols="72">=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated" href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
</body>
</html>

--------------070302030306030601020309--

--------------030805000609010604000806
Content-Type: text/plain;
 name="cpm_uart_core.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpm_uart_core.patch"

diff -Nru linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c
--- linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-19 13:48:58.000000000 -0400
@@ -335,23 +335,25 @@
 	pr_debug("CPM uart[%d]:IRQ\n", port->line);
 
 	if (IS_SMC(pinfo)) {
-		events = smcp->smc_smce;
+	    while ((events = smcp->smc_smce) & (SMCM_BRKE | SMCM_RX | SMCM_TX)) {
+		smcp->smc_smce = events;
 		if (events & SMCM_BRKE)
-			uart_handle_break(port);
+		    uart_handle_break(port);
 		if (events & SMCM_RX)
-			cpm_uart_int_rx(port, regs);
+		    cpm_uart_int_rx(port, regs);
 		if (events & SMCM_TX)
-			cpm_uart_int_tx(port, regs);
-		smcp->smc_smce = events;
+		    cpm_uart_int_tx(port, regs);
+	    }
 	} else {
-		events = sccp->scc_scce;
+	    while ((events = sccp->scc_scce) & (UART_SCCM_BRKE | UART_SCCM_RX | UART_SCCM_TX)) {
+		sccp->scc_scce = events;
 		if (events & UART_SCCM_BRKE)
-			uart_handle_break(port);
+		    uart_handle_break(port);
 		if (events & UART_SCCM_RX)
-			cpm_uart_int_rx(port, regs);
+		    cpm_uart_int_rx(port, regs);
 		if (events & UART_SCCM_TX)
-			cpm_uart_int_tx(port, regs);
-		sccp->scc_scce = events;
+		    cpm_uart_int_tx(port, regs);
+	    }
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }

--------------030805000609010604000806--
