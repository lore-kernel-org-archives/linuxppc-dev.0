Subject: Re: [PATCH] Take two of the new serial uart driver.
From: David Woodhouse <dwmw2@infradead.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <40BF3206.8030705@intracom.gr>
References: <40BF3206.8030705@intracom.gr>
Content-Type: text/plain
Message-Id: <1086279704.15845.1.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 03 Jun 2004 17:21:45 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-06-03 at 17:13 +0300, Pantelis Antoniou wrote:
> The following patch updates the new CPM1/CPM2 uart driver.
>
> Its main features are:

Works for me on WindRiver PowerQUICC II once I make it build:

--- cpm_uart_cpm2.c~	2004-06-03 16:50:03.841824208 +0100
+++ cpm_uart_cpm2.c	2004-06-03 16:55:58.019980944 +0100
@@ -47,7 +47,7 @@

 /**************************************************************/

-void cpm_line_cr_cmd(int line)
+void cpm_line_cr_cmd(int line, int cmd)
 {
 	volatile cpm_cpm2_t *cp = cpmp;
 	ulong val;
@@ -243,7 +243,7 @@

 	pr_debug("CPM uart[-]:init portdesc\n");

-	cpm_uartnr = 0;
+	cpm_uart_nr = 0;
 #ifdef CONFIG_SERIAL_CPM_SMC1
 	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) & immap->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcup =
@@ -253,7 +253,7 @@
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SMC1;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif

 #ifdef CONFIG_SERIAL_CPM_SMC2
@@ -265,7 +265,7 @@
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SMC2;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif

 #ifdef CONFIG_SERIAL_CPM_SCC1
@@ -279,7 +279,7 @@
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SCC1;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif

 #ifdef CONFIG_SERIAL_CPM_SCC2
@@ -293,7 +293,7 @@
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SCC2;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif

 #ifdef CONFIG_SERIAL_CPM_SCC3
@@ -307,7 +307,7 @@
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SCC3;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif

 #ifdef CONFIG_SERIAL_CPM_SCC4
@@ -321,7 +321,7 @@
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
-	cpm_uartport_map[cpm_uartnr++] = UART_SCC4;
+	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif

 	return 0;


--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
