Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id 0E68F679F1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 May 2005 06:35:42 +1000 (EST)
Message-ID: <428CF8D3.2070006@mrv.com>
Date: Thu, 19 May 2005 16:36:35 -0400
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Guillaume Autran <gautran@mrv.com>
References: <20050518170949.GA6766@gate.ebshome.net>
	<428CD40C.201@mrv.com>	<2376d87e3df664106a6cf626f9575d90@embeddededge.com>	<428CEA55.1040904@mrv.com>	<5e493590088edcf959e30390363e798d@embeddededge.com>
	<428CF693.5030100@mrv.com>
In-Reply-To: <428CF693.5030100@mrv.com>
Content-Type: multipart/alternative;
	boundary="------------060507000607080108040300"
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
--------------060507000607080108040300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

One thought though, if the event register is cleared _before_  the event 
is processed (clearing the cause), will the cpm set the bit again 
(before we have time to clear the cause) ? That would generate 2 
interrupts for the same event ? Am I right ?


Guillaume Autran wrote:

> You are right, moving the event clearing statement is much easier and 
> cleaner. Let the interrupt be the loop.
> Thanks Dan !
>
>
> Dan Malek wrote:
>
>>
>> On May 19, 2005, at 3:34 PM, Guillaume Autran wrote:
>>
>>> Is it better like this ?
>>
>>
>>
>> Yes, but now I see one problem with it.  :-)
>>
>> We have to clear all events even though we may not
>> handle all of them.  Your while loop filters only the events
>> we process, but there could be others causing the interrupt
>> which will never get cleared.  In this case we end up with
>> an infinite interrupt loop where we don't process anything,
>> but we don't make the interrupt go away, either.   It may be
>> easier to forget the loop, just read/clear the event register
>> up front, then process based on the events based upon
>> what we found. It's what we tend to do in the other drivers.
>>
>> The functions called to do the rx/tx processing have loops
>> in them to process all of the data they find, so it isn't likely
>> you have left anything behind.  If you want to try to save
>> the interrupt overhead, change it to do/while, check again
>> at the end before the exit.
>>
>> Thanks.
>>
>>
>>     -- Dan
>>
>
>------------------------------------------------------------------------
>
>diff -Nru linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c
>--- linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-07 01:20:31.000000000 -0400
>+++ linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-19 16:23:13.000000000 -0400
>@@ -336,22 +336,22 @@
> 
> 	if (IS_SMC(pinfo)) {
> 		events = smcp->smc_smce;
>+		smcp->smc_smce = events;
> 		if (events & SMCM_BRKE)
> 			uart_handle_break(port);
> 		if (events & SMCM_RX)
> 			cpm_uart_int_rx(port, regs);
> 		if (events & SMCM_TX)
> 			cpm_uart_int_tx(port, regs);
>-		smcp->smc_smce = events;
> 	} else {
> 		events = sccp->scc_scce;
>+		sccp->scc_scce = events;
> 		if (events & UART_SCCM_BRKE)
> 			uart_handle_break(port);
> 		if (events & UART_SCCM_RX)
> 			cpm_uart_int_rx(port, regs);
> 		if (events & UART_SCCM_TX)
> 			cpm_uart_int_tx(port, regs);
>-		sccp->scc_scce = events;
> 	}
> 	return (events) ? IRQ_HANDLED : IRQ_NONE;
> }
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------060507000607080108040300
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
One thought though, if the event register is cleared _before_&nbsp; the
event is processed (clearing the cause), will the cpm set the bit again
(before we have time to clear the cause) ? That would generate 2
interrupts for the same event ? Am I right ?<br>
<br>
<br>
Guillaume Autran wrote:<br>
<blockquote type="cite" cite="mid428CF693.5030100@mrv.com">You are
right, moving the event clearing statement is much easier and cleaner.
Let the interrupt be the loop.
  <br>
Thanks Dan !
  <br>
  <br>
  <br>
Dan Malek wrote:
  <br>
  <br>
  <blockquote type="cite"><br>
On May 19, 2005, at 3:34 PM, Guillaume Autran wrote:
    <br>
    <br>
    <blockquote type="cite">Is it better like this ?
      <br>
    </blockquote>
    <br>
    <br>
Yes, but now I see one problem with it.&nbsp; :-)
    <br>
    <br>
We have to clear all events even though we may not
    <br>
handle all of them.&nbsp; Your while loop filters only the events
    <br>
we process, but there could be others causing the interrupt
    <br>
which will never get cleared.&nbsp; In this case we end up with
    <br>
an infinite interrupt loop where we don't process anything,
    <br>
but we don't make the interrupt go away, either.&nbsp;&nbsp; It may be
    <br>
easier to forget the loop, just read/clear the event register
    <br>
up front, then process based on the events based upon
    <br>
what we found. It's what we tend to do in the other drivers.
    <br>
    <br>
The functions called to do the rx/tx processing have loops
    <br>
in them to process all of the data they find, so it isn't likely
    <br>
you have left anything behind.&nbsp; If you want to try to save
    <br>
the interrupt overhead, change it to do/while, check again
    <br>
at the end before the exit.
    <br>
    <br>
Thanks.
    <br>
    <br>
    <br>
&nbsp;&nbsp;&nbsp; -- Dan
    <br>
    <br>
  </blockquote>
  <br>
  <pre wrap="">
<hr width="90%" size="4">
diff -Nru linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c
--- linux-2.6.12-rc4.org/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-07 01:20:31.000000000 -0400
+++ linux-2.6.12-rc4.new/drivers/serial/cpm_uart/cpm_uart_core.c	2005-05-19 16:23:13.000000000 -0400
@@ -336,22 +336,22 @@
 
 	if (IS_SMC(pinfo)) {
 		events = smcp-&gt;smc_smce;
+		smcp-&gt;smc_smce = events;
 		if (events &amp; SMCM_BRKE)
 			uart_handle_break(port);
 		if (events &amp; SMCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events &amp; SMCM_TX)
 			cpm_uart_int_tx(port, regs);
-		smcp-&gt;smc_smce = events;
 	} else {
 		events = sccp-&gt;scc_scce;
+		sccp-&gt;scc_scce = events;
 		if (events &amp; UART_SCCM_BRKE)
 			uart_handle_break(port);
 		if (events &amp; UART_SCCM_RX)
 			cpm_uart_int_rx(port, regs);
 		if (events &amp; UART_SCCM_TX)
 			cpm_uart_int_tx(port, regs);
-		sccp-&gt;scc_scce = events;
 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }
  </pre>
  <pre wrap="">
<hr width="90%" size="4">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated" href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
</body>
</html>

--------------060507000607080108040300--
