Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [83.217.33.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CD5B9DE04F
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 06:41:05 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 1/7] POWERPC cpm_uart: OF-related fix for CPM1
Date: Wed, 24 Jan 2007 22:40:49 +0300
Message-ID: <20070124194049.3385.34442.stgit@localhost.localdomain>
In-Reply-To: <20070124193402.3385.79090.stgit@localhost.localdomain>
References: <20070124193402.3385.79090.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This makes cpm uart able to work using OF-passed parameters
in case of CPM stuff (found on most mpc8xx reference and custom
boards). The idea is to keep ppc stuff working yet making it able to be
used for powerpc.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 08e55fd..925fb60 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -40,6 +40,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/fs_pd.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -145,7 +146,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 		/* was hostalloc but changed cause it blows away the */
 		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
-		dma_addr = (u32)mem_addr;
+		dma_addr = (u32)cpm_dpram_phys(mem_addr);
 	} else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);
@@ -205,7 +206,7 @@ int __init cpm_uart_init_portdesc(void)
 	    (unsigned long)&cpmp->cp_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -217,7 +218,7 @@ int __init cpm_uart_init_portdesc(void)
 	    (unsigned long)&cpmp->cp_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -231,7 +232,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -245,7 +246,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -259,7 +260,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -273,7 +274,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 	return 0;
