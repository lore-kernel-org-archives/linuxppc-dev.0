Return-Path: <aris@mandriva.com>
Received: from oops.ghostprotocols.net
	(cm-net-cwb-C8B06F68.dynamic.brdterra.com.br [200.176.111.104])
	by ozlabs.org (Postfix) with ESMTP id 8D2A9679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 01:38:23 +1100 (EST)
Date: Mon, 20 Feb 2006 11:18:35 -0300
From: Aristeu Sergio Rozanski Filho <aris@mandriva.com>
To: =?iso-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitech.se>
Subject: Re: SCCx UART status on 8xx
Message-ID: <20060220141830.GA7228@oops.ghostprotocols.net>
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CC4F@ratatosk.combitechsystems.com>
Cc: fbl@conectiva.com.br, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Feb 20, 2006 at 02:37:23PM +0100, Björn Östby wrote:
> Hello,
> I'm messing with a mpc823e based board trying to enable the SCC3 UART. I'm using the 2.4.25 denx linux_ppc kernel and I've got SMC1 for console and SMC2 up and running but I'm in desperate need of another rs232 port (which is on SCC3 on my board). 
> Reading quite a lot of old posts on this mailing list got me confused whether the SCCx UART support in the kernel is ready to be used on 8xx or if there will take a large amount of hacking to get things going (reading the header of 8xx_io/uart.c got me wondering even more).
> Current situation is that I have enabled the SCC3 UART in the kernel, set the correct CTS, RTS and CD signal options and finally disabled the SPI which (on my board at least) can override the UART on the third SCC port. During boot up I get the standard output:
> 
> >ttyS0 at 0x0280 is on SMC1 using BRG1
> >ttyS1 at 0x0380 is on SMC2 using BRG2
> >ttyS2 at 0x0200 is on SCC3 using BRG3
> 
> Writing to ttyS0 and ttyS1 works fine (the result pop up in the receiving terminal) but when trying ttyS2 nothing happens. I've checked the Tx signal and it appears as if data is sent (the signal gets noisy when starting the write procedure). I may also add that restaring the write application causes the kernel to hang (for ttyS2 only of course).
> 
> I've read some posts saying that Linux don't init other uart ports than the console port and that is the potential problem here, but it is unclear if this statement is true or not. I can also add to the problem description that my SMC2 port works fine for writing, but reading just hangs in the read() call. So, can anyone confirm any status on the SMCx and SCCx UART drivers for 2.4?
please try the two attached patches. the first one configures each SCC to
one BRG. the second one, makes use always of dpram memory. we're working on a
decent fix.
Marcelo: if you find the first one ok, you may apply it, but don't apply the
second

-- 
Aristeu


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpm_uart-configure_brgs_properly.patch"

Index: stable/drivers/serial/cpm_uart/cpm_uart_cpm1.c
===================================================================
--- stable.orig/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2006-02-17 17:11:37.000000000 -0200
+++ stable/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2006-02-17 17:15:57.000000000 -0200
@@ -139,24 +139,31 @@
 void scc1_lineif(struct uart_cpm_port *pinfo)
 {
 	/* XXX SCC1: insert port configuration here */
+	cpmp->cp_sicr &= 0xFFFFFFC0;
 	pinfo->brg = 1;
 }
 
 void scc2_lineif(struct uart_cpm_port *pinfo)
 {
 	/* XXX SCC2: insert port configuration here */
+	cpmp->cp_sicr &= 0xFFFFC0FF;
+	cpmp->cp_sicr |= 0x00000900;
 	pinfo->brg = 2;
 }
 
 void scc3_lineif(struct uart_cpm_port *pinfo)
 {
 	/* XXX SCC3: insert port configuration here */
+	cpmp->cp_sicr &= 0xFFC0FFFF;
+	cpmp->cp_sicr |= 0x00140000;
 	pinfo->brg = 3;
 }
 
 void scc4_lineif(struct uart_cpm_port *pinfo)
 {
 	/* XXX SCC4: insert port configuration here */
+	cpmp->cp_sicr &= 0xC0FFFFFF;
+	cpmp->cp_sicr |= 0x1BFFFFFF;
 	pinfo->brg = 4;
 }
 

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="serial_alloc_bootmem.patch"

Index: stable/drivers/serial/cpm_uart/cpm_uart_core.c
===================================================================
--- stable.orig/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-07 15:30:42.000000000 -0200
+++ stable/drivers/serial/cpm_uart/cpm_uart_core.c	2005-12-08 12:39:11.000000000 -0200
@@ -467,6 +467,7 @@
 	/* free interrupt handler */
 	free_irq(port->irq, port);
 
+#if 0
 	/* If the port is not the console, disable Rx and Tx. */
 	if (!(pinfo->flags & FLAG_CONSOLE)) {
 		/* Wait for all the BDs marked sent */
@@ -492,6 +493,7 @@
 		/* Shut them really down */
 		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
 	}
+#endif 
 }
 
 static void cpm_uart_set_termios(struct uart_port *port,
@@ -896,7 +898,7 @@
 		pinfo->sccp->scc_gsmrl &= ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	}
 
-	ret = cpm_uart_allocbuf(pinfo, 0);
+	ret = cpm_uart_allocbuf(pinfo, 1);
 
 	if (ret)
 		return ret;
@@ -912,10 +914,12 @@
 
 static void cpm_uart_release_port(struct uart_port *port)
 {
+#if 0
 	struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
 
 	if (!(pinfo->flags & FLAG_CONSOLE))
 		cpm_uart_freebuf(pinfo);
+#endif
 }
 
 /*

--dDRMvlgZJXvWKvBx--
