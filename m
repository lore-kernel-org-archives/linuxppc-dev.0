Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 1CD1067E7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 17:16:51 +1000 (EST)
Message-ID: <42F06F62.6050509@ru.mvista.com>
Date: Wed, 03 Aug 2005 11:16:50 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: pantelis.antoniou@gmail.com
References: <42EF9022.5050707@ru.mvista.com>
	<200508030039.16107.pantelis.antoniou@gmail.com>
In-Reply-To: <200508030039.16107.pantelis.antoniou@gmail.com>
Content-Type: multipart/alternative;
	boundary="------------010405090101070708090901"
Cc: Kumar Gala <galak@freescale.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] cpm_uart: Made non-console uart work
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
--------------010405090101070708090901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Panto, Kumar,

Thank you for review.

My comments:

>On Tuesday 02 August 2005 18:24, Vitaly Bordug wrote:
>  
>
>>Kumar, Pantelis,
>>
>>    
>>
>
>[snip]
>
>Some more comments.
>
>  
>
>>diff --git a/drivers/serial/cpm_uart/cpm_uart.h 
>>    
>>
>b/drivers/serial/cpm_uart/cpm_uart.h
>  
>
>>--- a/drivers/serial/cpm_uart/cpm_uart.h
>>+++ b/drivers/serial/cpm_uart/cpm_uart.h
>>@@ -40,6 +40,8 @@
>> #define TX_NUM_FIFO	4
>> #define TX_BUF_SIZE	32
>> 
>>+#define SCC_WAIT_CLOSING 100
>>+
>> struct uart_cpm_port {
>> 	struct uart_port	port;
>> 	u16			rx_nrfifos;	
>>@@ -67,6 +69,8 @@ struct uart_cpm_port {
>> 	int			 bits;
>> 	/* Keep track of 'odd' SMC2 wirings */
>> 	int			is_portb;
>>+	/* wait on close if needed */
>>+	int 			wait_closing;
>> };
>> 
>> extern int cpm_uart_port_map[UART_NR];
>>diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c 
>>    
>>
>b/drivers/serial/cpm_uart/cpm_uart_core.c
>  
>
>>--- a/drivers/serial/cpm_uart/cpm_uart_core.c
>>+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
>>@@ -12,6 +12,7 @@
>>  * 
>>  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
>>  *            (C) 2004 Intracom, S.A.
>>+ * 	      (C) 2005 MontaVista Software, Inc. by Vitaly Bordug 
>>    
>>
><vbordug@ru.mvista.com>	
>  
>
>>  *
>>  * This program is free software; you can redistribute it and/or modify
>>  * it under the terms of the GNU General Public License as published by
>>@@ -143,10 +144,13 @@ static void cpm_uart_start_tx(struct uar
>> 	}
>> 
>> 	if (cpm_uart_tx_pump(port) != 0) {
>>-		if (IS_SMC(pinfo))
>>+		if (IS_SMC(pinfo)) {
>> 			smcp->smc_smcm |= SMCM_TX;
>>-		else
>>+			smcp->smc_smcmr |= SMCMR_TEN;
>>+		} else {
>> 			sccp->scc_sccm |= UART_SCCM_TX;
>>+			pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
>>+		}
>>    
>>
>
>Why the need to mess with the global SCC transmit enable here? 
>It's dubious IMO.
>
>  
>
But without it (at least my boards) will have TX disabled. Just look - 
we have enabled this bit in pinfo->sccp->scc_gsmrl within ..._init_scc. 
Then all will
be fine until shutdown which will clear it and related in sccp->scc_sccm 
as well. The latter will be restored in start_tx, but scc_gsmrl will 
not. This results in the only first successful transmission. 

>> 	}
>> }
>> 
>>@@ -265,13 +269,15 @@ static void cpm_uart_int_rx(struct uart_
>> 		}		/* End while (i--) */
>> 
>> 		/* This BD is ready to be used again. Clear status. get next */
>>-		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
>>+		bdp->cbd_sc &= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
>> 		bdp->cbd_sc |= BD_SC_EMPTY;
>> 
>>-		if (bdp->cbd_sc & BD_SC_WRAP)
>>-			bdp = pinfo->rx_bd_base;
>>-		else
>>-			bdp++;
>>+		if (bdp->cbd_datlen) {
>>+			if (bdp->cbd_sc & BD_SC_WRAP)
>>+				bdp = pinfo->rx_bd_base;
>>+			else
>>+				bdp++;
>>+		}
>>    
>>
>
>Why is that? Where ever we queue a buffer descriptor with zero length.
>If we ever do that we're screwed in more ways than that.
>
>  
>
I'm inclined to agree.

>> 	} /* End for (;;) */
>> 
>> 	/* Write back buffer pointer */
>>@@ -336,22 +342,22 @@ static irqreturn_t cpm_uart_int(int irq,
>> 
>> 	if (IS_SMC(pinfo)) {
>> 		events = smcp->smc_smce;
>>+		smcp->smc_smce = events;
>> 		if (events & SMCM_BRKE)
>> 			uart_handle_break(port);
>> 		if (events & SMCM_RX)
>> 			cpm_uart_int_rx(port, regs);
>> 		if (events & SMCM_TX)
>> 			cpm_uart_int_tx(port, regs);
>>-		smcp->smc_smce = events;
>> 	} else {
>> 		events = sccp->scc_scce;
>>+		sccp->scc_scce = events;
>> 		if (events & UART_SCCM_BRKE)
>> 			uart_handle_break(port);
>> 		if (events & UART_SCCM_RX)
>> 			cpm_uart_int_rx(port, regs);
>> 		if (events & UART_SCCM_TX)
>> 			cpm_uart_int_tx(port, regs);
>>-		sccp->scc_scce = events;
>>    
>>
>
>This is a good catch...
>
>  
>
>> 	}
>> 	return (events) ? IRQ_HANDLED : IRQ_NONE;
>> }
>>@@ -360,6 +366,7 @@ static int cpm_uart_startup(struct uart_
>> {
>> 	int retval;
>> 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
>>+	int line = pinfo - cpm_uart_ports;
>> 
>> 	pr_debug("CPM uart[%d]:startup\n", port->line);
>> 
>>@@ -374,18 +381,30 @@ static int cpm_uart_startup(struct uart_
>> 		pinfo->smcp->smc_smcmr |= SMCMR_REN;
>> 	} else {
>> 		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
>>+		pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENR;
>>    
>>
>dido as above.
>  
>
Yeah, this is superfluous as it has been done above.

>> 	}
>> 
>>+	cpm_line_cr_cmd(line,CPM_CR_RESTART_TX);
>> 	return 0;
>> }
>> 
>>+inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
>>+{
>>+	unsigned long orig_jiffies = jiffies;
>>+	while(1)
>>+	{
>>+		schedule_timeout(2);
>>+		if(time_after(jiffies, orig_jiffies + pinfo->wait_closing))
>>+			break;
>>+	}
>>+}
>>+
>>    
>>
>perhaps, more like...
>
>	unsigned long target_jiffies = jiffies + pinfo->wait_closing;
>
>	while (!time_after(jiffies, target_jiffies))
>   		schedule();
>
>  
>
No objections, I'll try this one.

>> /*
>>  * Shutdown the uart
>>  */
>> static void cpm_uart_shutdown(struct uart_port *port)
>> {
>> 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
>>-	int line = pinfo - cpm_uart_ports;
>> 
>> 	pr_debug("CPM uart[%d]:shutdown\n", port->line);
>> 
>>@@ -394,6 +413,12 @@ static void cpm_uart_shutdown(struct uar
>> 
>> 	/* If the port is not the console, disable Rx and Tx. */
>> 	if (!(pinfo->flags & FLAG_CONSOLE)) {
>>+		/* Wait for all the BDs marked sent */
>>+		while(!cpm_uart_tx_empty(port))
>>+			schedule_timeout(2);
>>+		if(pinfo->wait_closing)
>>+			cpm_uart_wait_until_send(pinfo);
>>+
>> 		/* Stop uarts */
>> 		if (IS_SMC(pinfo)) {
>> 			volatile smc_t *smcp = pinfo->smcp;
>>@@ -405,9 +430,6 @@ static void cpm_uart_shutdown(struct uar
>> 			sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
>> 		}
>> 
>>-		/* Shut them really down and reinit buffer descriptors */
>>-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
>>-		cpm_uart_initbd(pinfo);
>> 	}
>> }
>> 
>>@@ -569,7 +591,10 @@ static int cpm_uart_tx_pump(struct uart_
>> 		/* Pick next descriptor and fill from buffer */
>> 		bdp = pinfo->tx_cur;
>> 
>>-		p = bus_to_virt(bdp->cbd_bufaddr);
>>+		if (pinfo->dma_addr)
>>+			p=(u8*)((ulong)(pinfo->mem_addr) + bdp->cbd_bufaddr - pinfo->dma_addr);
>>+		else
>>+			p = bus_to_virt(bdp->cbd_bufaddr);
>>    
>>
>
>this looks bogus to me...
>
>  
>
Well, all the stuff works on 8272 even without this and likewise stuff, 
but don't on 866ADS, where bus_to_virt returns value not equal to where 
we allocated DMA. I didn't dig too deep to track why this happens, since 
if we're using DMA, we should remember addresses upon allocation and 
avoid using bus_to_virt.




-- 
Sincerely, 
Vitaly


--------------010405090101070708090901
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Panto, Kumar,<br>
<br>
Thank you for review.<br>
<br>
My comments:<br>
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap="">On Tuesday 02 August 2005 18:24, Vitaly Bordug wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Kumar, Pantelis,

    </pre>
  </blockquote>
  <pre wrap=""><!---->
[snip]

Some more comments.

  </pre>
  <blockquote type="cite">
    <pre wrap="">diff --git a/drivers/serial/cpm_uart/cpm_uart.h 
    </pre>
  </blockquote>
  <pre wrap=""><!---->b/drivers/serial/cpm_uart/cpm_uart.h
  </pre>
  <blockquote type="cite">
    <pre wrap="">--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -40,6 +40,8 @@
 #define TX_NUM_FIFO	4
 #define TX_BUF_SIZE	32
 
+#define SCC_WAIT_CLOSING 100
+
 struct uart_cpm_port {
 	struct uart_port	port;
 	u16			rx_nrfifos;	
@@ -67,6 +69,8 @@ struct uart_cpm_port {
 	int			 bits;
 	/* Keep track of 'odd' SMC2 wirings */
 	int			is_portb;
+	/* wait on close if needed */
+	int 			wait_closing;
 };
 
 extern int cpm_uart_port_map[UART_NR];
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c 
    </pre>
  </blockquote>
  <pre wrap=""><!---->b/drivers/serial/cpm_uart/cpm_uart_core.c
  </pre>
  <blockquote type="cite">
    <pre wrap="">--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -12,6 +12,7 @@
  * 
  *  Copyright (C) 2004 Freescale Semiconductor, Inc.
  *            (C) 2004 Intracom, S.A.
+ * 	      (C) 2005 MontaVista Software, Inc. by Vitaly Bordug 
    </pre>
  </blockquote>
  <pre wrap=""><!----><a class="moz-txt-link-rfc2396E" href="mailto:vbordug@ru.mvista.com">&lt;vbordug@ru.mvista.com&gt;</a>	
  </pre>
  <blockquote type="cite">
    <pre wrap="">  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -143,10 +144,13 @@ static void cpm_uart_start_tx(struct uar
 	}
 
 	if (cpm_uart_tx_pump(port) != 0) {
-		if (IS_SMC(pinfo))
+		if (IS_SMC(pinfo)) {
 			smcp-&gt;smc_smcm |= SMCM_TX;
-		else
+			smcp-&gt;smc_smcmr |= SMCMR_TEN;
+		} else {
 			sccp-&gt;scc_sccm |= UART_SCCM_TX;
+			pinfo-&gt;sccp-&gt;scc_gsmrl |= SCC_GSMRL_ENT;
+		}
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why the need to mess with the global SCC transmit enable here? 
It's dubious IMO.

  </pre>
</blockquote>
But without it (at least my boards) will have TX disabled. Just look -
we have enabled this bit in pinfo-&gt;sccp-&gt;scc_gsmrl within
..._init_scc. Then all will<br>
be fine until shutdown which will clear it and related in
sccp-&gt;scc_sccm as well. The latter will be restored in start_tx, but
scc_gsmrl will not. This results in the only first successful
transmission. 
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 	}
 }
 
@@ -265,13 +269,15 @@ static void cpm_uart_int_rx(struct uart_
 		}		/* End while (i--) */
 
 		/* This BD is ready to be used again. Clear status. get next */
-		bdp-&gt;cbd_sc &amp;= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV);
+		bdp-&gt;cbd_sc &amp;= ~(BD_SC_BR | BD_SC_FR | BD_SC_PR | BD_SC_OV | BD_SC_ID);
 		bdp-&gt;cbd_sc |= BD_SC_EMPTY;
 
-		if (bdp-&gt;cbd_sc &amp; BD_SC_WRAP)
-			bdp = pinfo-&gt;rx_bd_base;
-		else
-			bdp++;
+		if (bdp-&gt;cbd_datlen) {
+			if (bdp-&gt;cbd_sc &amp; BD_SC_WRAP)
+				bdp = pinfo-&gt;rx_bd_base;
+			else
+				bdp++;
+		}
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Why is that? Where ever we queue a buffer descriptor with zero length.
If we ever do that we're screwed in more ways than that.

  </pre>
</blockquote>
I'm inclined to agree.<br>
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> 	} /* End for (;;) */
 
 	/* Write back buffer pointer */
@@ -336,22 +342,22 @@ static irqreturn_t cpm_uart_int(int irq,
 
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
    </pre>
  </blockquote>
  <pre wrap=""><!---->
This is a good catch...

  </pre>
  <blockquote type="cite">
    <pre wrap=""> 	}
 	return (events) ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -360,6 +366,7 @@ static int cpm_uart_startup(struct uart_
 {
 	int retval;
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
+	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:startup\n", port-&gt;line);
 
@@ -374,18 +381,30 @@ static int cpm_uart_startup(struct uart_
 		pinfo-&gt;smcp-&gt;smc_smcmr |= SMCMR_REN;
 	} else {
 		pinfo-&gt;sccp-&gt;scc_sccm |= UART_SCCM_RX;
+		pinfo-&gt;sccp-&gt;scc_gsmrl |= SCC_GSMRL_ENR;
    </pre>
  </blockquote>
  <pre wrap=""><!---->dido as above.
  </pre>
</blockquote>
Yeah, this is superfluous as it has been done above.<br>
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <blockquote type="cite">
    <pre wrap=""> 	}
 
+	cpm_line_cr_cmd(line,CPM_CR_RESTART_TX);
 	return 0;
 }
 
+inline void cpm_uart_wait_until_send(struct uart_cpm_port *pinfo)
+{
+	unsigned long orig_jiffies = jiffies;
+	while(1)
+	{
+		schedule_timeout(2);
+		if(time_after(jiffies, orig_jiffies + pinfo-&gt;wait_closing))
+			break;
+	}
+}
+
    </pre>
  </blockquote>
  <pre wrap=""><!---->perhaps, more like...

	unsigned long target_jiffies = jiffies + pinfo-&gt;wait_closing;

	while (!time_after(jiffies, target_jiffies))
   		schedule();

  </pre>
</blockquote>
No objections, I'll try this one.<br>
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap=""></pre>
  <blockquote type="cite">
    <pre wrap=""> /*
  * Shutdown the uart
  */
 static void cpm_uart_shutdown(struct uart_port *port)
 {
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
-	int line = pinfo - cpm_uart_ports;
 
 	pr_debug("CPM uart[%d]:shutdown\n", port-&gt;line);
 
@@ -394,6 +413,12 @@ static void cpm_uart_shutdown(struct uar
 
 	/* If the port is not the console, disable Rx and Tx. */
 	if (!(pinfo-&gt;flags &amp; FLAG_CONSOLE)) {
+		/* Wait for all the BDs marked sent */
+		while(!cpm_uart_tx_empty(port))
+			schedule_timeout(2);
+		if(pinfo-&gt;wait_closing)
+			cpm_uart_wait_until_send(pinfo);
+
 		/* Stop uarts */
 		if (IS_SMC(pinfo)) {
 			volatile smc_t *smcp = pinfo-&gt;smcp;
@@ -405,9 +430,6 @@ static void cpm_uart_shutdown(struct uar
 			sccp-&gt;scc_sccm &amp;= ~(UART_SCCM_TX | UART_SCCM_RX);
 		}
 
-		/* Shut them really down and reinit buffer descriptors */
-		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
-		cpm_uart_initbd(pinfo);
 	}
 }
 
@@ -569,7 +591,10 @@ static int cpm_uart_tx_pump(struct uart_
 		/* Pick next descriptor and fill from buffer */
 		bdp = pinfo-&gt;tx_cur;
 
-		p = bus_to_virt(bdp-&gt;cbd_bufaddr);
+		if (pinfo-&gt;dma_addr)
+			p=(u8*)((ulong)(pinfo-&gt;mem_addr) + bdp-&gt;cbd_bufaddr - pinfo-&gt;dma_addr);
+		else
+			p = bus_to_virt(bdp-&gt;cbd_bufaddr);
    </pre>
  </blockquote>
  <pre wrap=""><!---->
this looks bogus to me...

  </pre>
</blockquote>
Well, all the stuff works on 8272 even without this and likewise stuff,
but don't on 866ADS, where bus_to_virt returns value not equal to where
we allocated DMA. I didn't dig too deep to track why this happens,
since if we're using DMA, we should remember addresses upon allocation
and avoid using bus_to_virt.<br>
<blockquote cite="mid200508030039.16107.pantelis.antoniou@gmail.com"
 type="cite">
  <pre wrap=""></pre>
</blockquote>
<br>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------010405090101070708090901--
