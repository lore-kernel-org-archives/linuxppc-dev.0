Return-Path: <kalle.pokki@iki.fi>
Received: from smtp-4.hut.fi (smtp-4.hut.fi [130.233.228.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A515A67BDF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 23:41:12 +1000 (EST)
Date: Thu, 19 Oct 2006 15:25:55 +0300 (EEST)
From: kalle.pokki@iki.fi
To: linuxppc-embedded@ozlabs.org, galak@kernel.crashing.org, panto@intracom.gr,
	vbordug@ru.mvista.com
Subject: [PATCH] CPM_UART: Fix non-console transmit
Message-ID: <Pine.OSF.4.61.0610191519020.318096@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The SMC and SCC hardware transmitter is enabled at the wrong
place. Simply writing twice to the non-console port, like

$ echo asdf > /dev/ttyCPM1
$ echo asdf > /dev/ttyCPM1

puts the shell into endless uninterruptible sleep, since the
transmitter is stopped after the first write, and is not enabled
before the shutdown function of the second write. Thus the transmit
buffers are never emptied.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
---
  drivers/serial/cpm_uart/cpm_uart_core.c |    5 ++---
  1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index 90ff96e..8f3b3e5 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -194,10 +194,8 @@ static void cpm_uart_start_tx(struct uar
  	if (cpm_uart_tx_pump(port) != 0) {
  		if (IS_SMC(pinfo)) {
  			smcp->smc_smcm |= SMCM_TX;
-			smcp->smc_smcmr |= SMCMR_TEN;
  		} else {
  			sccp->scc_sccm |= UART_SCCM_TX;
-			pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
  		}
  	}
  }
@@ -420,9 +418,10 @@ static int cpm_uart_startup(struct uart_
  	/* Startup rx-int */
  	if (IS_SMC(pinfo)) {
  		pinfo->smcp->smc_smcm |= SMCM_RX;
-		pinfo->smcp->smc_smcmr |= SMCMR_REN;
+		pinfo->smcp->smc_smcmr |= (SMCMR_REN | SMCMR_TEN);
  	} else {
  		pinfo->sccp->scc_sccm |= UART_SCCM_RX;
+		pinfo->sccp->scc_gsmrl |= (SCC_GSMRL_ENR | SCC_GSMRL_ENT);
  	}

  	if (!(pinfo->flags & FLAG_CONSOLE))
-- 
1.4.1.1
