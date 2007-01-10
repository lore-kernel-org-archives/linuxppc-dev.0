Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-248.msk.skylink.ru
	[83.217.45.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5515DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 12:25:28 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/5] [POWERPC] cpm_uart: OF-related updates
Date: Wed, 10 Jan 2007 04:11:48 +0300
Message-ID: <20070110011147.20342.18565.stgit@localhost.localdomain>
In-Reply-To: <20070110011124.20342.38130.stgit@localhost.localdomain>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
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
in case of CPM1 stuff (found on most mpc8xx reference and custom
boards).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 drivers/serial/cpm_uart/cpm_uart_cpm1.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 08e55fd..3ed4622 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -40,6 +40,7 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
+#include <asm/fs_pd.h>
 
 #include <linux/serial_core.h>
 #include <linux/kernel.h>
@@ -145,7 +146,11 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 		/* was hostalloc but changed cause it blows away the */
 		/* large tlb mapping when pinning the kernel area    */
 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
+#ifdef CONFIG_PPC_MERGE
+		dma_addr = (u32)cpm_dpram_phys(mem_addr);
+#else
 		dma_addr = (u32)mem_addr;
+#endif
 	} else
 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
 					      GFP_KERNEL);
@@ -205,7 +210,7 @@ int __init cpm_uart_init_portdesc(void)
 	    (unsigned long)&cpmp->cp_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC1;
 #endif
 
@@ -217,7 +222,7 @@ int __init cpm_uart_init_portdesc(void)
 	    (unsigned long)&cpmp->cp_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
-	cpm_uart_ports[UART_SMC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SMC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SMC2;
 #endif
 
@@ -231,7 +236,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC1].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC1].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC1].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC1;
 #endif
 
@@ -245,7 +250,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC2].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC2].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC2].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC2;
 #endif
 
@@ -259,7 +264,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC3].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC3].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC3].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC3;
 #endif
 
@@ -273,7 +278,7 @@ int __init cpm_uart_init_portdesc(void)
 	    ~(UART_SCCM_TX | UART_SCCM_RX);
 	cpm_uart_ports[UART_SCC4].sccp->scc_gsmrl &=
 	    ~(SCC_GSMRL_ENR | SCC_GSMRL_ENT);
-	cpm_uart_ports[UART_SCC4].port.uartclk = (((bd_t *) __res)->bi_intfreq);
+	cpm_uart_ports[UART_SCC4].port.uartclk = uart_clock();
 	cpm_uart_port_map[cpm_uart_nr++] = UART_SCC4;
 #endif
 	return 0;
