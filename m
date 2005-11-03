Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 404726867C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Nov 2005 05:37:39 +1100 (EST)
From: "Heiko Schocher" <hs@denx.de>
To: "Dan Malek" <dan@embeddededge.com>
Date: Thu, 3 Nov 2005 19:37:31 +0100
Message-ID: <AHEILKONAKAEJPHNMOPNOEGDCDAA.hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <e192e9e7fa764d69dc8e4f4d4391a447@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: Fix SCC Uart write problem after 2. open()
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On Wed Nov 2 03:08:30 EST 2005 Dan Malek wrote:

>> The following Patch will fix this problem.
> This patch just covers up a driver bug, find and fix the real bug.

i think i found it.

Please have a look at the following patch against current Linux 2.6
tree.

thanks
Heiko Schocher

[PATCH] ppc32: update fix: SCC write after 2nd open().

we never reinitialize the buffer descriptor or the
SCC.

Signed-off-by: Heiko Schocher <hs@denx.de>

---

 drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c
b/drivers/serial/cpm_uart/cpm_uart_core.c
index 25825f2..e03369c 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -163,7 +163,6 @@ static void cpm_uart_start_tx(struct uar
 			smcp->smc_smcmr |= SMCMR_TEN;
 		} else {
 			sccp->scc_sccm |= UART_SCCM_TX;
-			pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
 		}
 	}
 }
@@ -397,7 +396,7 @@ static int cpm_uart_startup(struct uart_
 	}

 	if (!(pinfo->flags & FLAG_CONSOLE))
-		cpm_line_cr_cmd(line,CPM_CR_INIT_TRX);
+		cpm_line_cr_cmd(line,CPM_CR_RESTART_TX);
 	return 0;
 }

@@ -442,9 +441,8 @@ static void cpm_uart_shutdown(struct uar
 			sccp->scc_sccm &= ~(UART_SCCM_TX | UART_SCCM_RX);
 		}

-		/* Shut them really down and reinit buffer descriptors */
+		/* Shut them really down */
 		cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
-		cpm_uart_initbd(pinfo);
 	}
 }
