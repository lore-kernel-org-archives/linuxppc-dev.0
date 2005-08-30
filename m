Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D63CF681B0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 14:49:04 +1000 (EST)
Date: Mon, 29 Aug 2005 23:48:54 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0508292348210.31749@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] cpm_uart: Fix baseaddress for SMC 1 and 2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Base addess register for SMC 1 and 2 are never initialized.
This means that they will not work unless a bootloader already
configured them.

The DPRAM already have space reserved, this patch just makes sure
the base addess register is updated correctly on initialization.

Signed-off-by: Rune Torgersen <runet@innovsys.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
commit b9ecc8e4b5db64f0b4ee36dbdd6758e4ce3c2025
tree c6d9da4a2bec187d4fc794b91441323c04642dda
parent 66256c2b92e3edafca1e86e64fcffe5c72cc39e7
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 29 Aug 2005 23:30:56 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 29 Aug 2005 23:30:56 -0500

 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -266,6 +266,7 @@ int cpm_uart_init_portdesc(void)
 	cpm_uart_ports[UART_SMC1].smcp = (smc_t *) & cpm2_immr->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcup =
 	    (smc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SMC1];
+	*(u16 *)(&cpm2_immr->im_dprambase[PROFF_SMC1_BASE]) = PROFF_SMC1;
 	cpm_uart_ports[UART_SMC1].port.mapbase =
 	    (unsigned long)&cpm2_immr->im_smc[0];
 	cpm_uart_ports[UART_SMC1].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
@@ -278,6 +279,7 @@ int cpm_uart_init_portdesc(void)
 	cpm_uart_ports[UART_SMC2].smcp = (smc_t *) & cpm2_immr->im_smc[1];
 	cpm_uart_ports[UART_SMC2].smcup =
 	    (smc_uart_t *) & cpm2_immr->im_dprambase[PROFF_SMC2];
+	*(u16 *)(&cpm2_immr->im_dprambase[PROFF_SMC2_BASE]) = PROFF_SMC2;
 	cpm_uart_ports[UART_SMC2].port.mapbase =
 	    (unsigned long)&cpm2_immr->im_smc[1];
 	cpm_uart_ports[UART_SMC2].smcp->smc_smcm |= (SMCM_RX | SMCM_TX);
