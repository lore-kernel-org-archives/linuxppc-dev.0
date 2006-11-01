Return-Path: <kalle.pokki@iki.fi>
Received: from host32.eke.fi (host32.eke.fi [194.100.64.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0BC6C67B89
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Nov 2006 18:52:59 +1100 (EST)
Date: Wed, 1 Nov 2006 09:52:41 +0200 (EET)
From: Kalle Pokki <kalle.pokki@iki.fi>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] CPM_UART: Fix non-console transmit
In-Reply-To: <17736.5604.615474.800258@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0611010947260.24731@host32.eke.fi>
References: <Pine.OSF.4.61.0610191549130.318096@kosh.hut.fi>
	<20061031180816.3d32c285@vitb.ru.mvista.com>
	<17736.5604.615474.800258@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 1 Nov 2006, Paul Mackerras wrote:

> Vitaly Bordug writes:
> 
> > Paul: please apply. 
> > 
> > I am recalling addressing something like the upper, but dunno why it haven't pushed 
> > upstream. Something around re-use scc/smc did not feel good with this approach, but it is 
> > much less important than the odd behavior expressed.
> 
> I don't have this patch, could someone send it to me please (and if
> you want it in 2.6.19, make sure the commentary explains what bug it
> is fixing).

Here it goes again.

Kalle
---
CPM_UART: Fix non-console transmit

The SMC and SCC hardware transmitter is enabled at the wrong
place. Simply writing twice to the non-console port, like

$ echo asdf > /dev/ttyCPM1
$ echo asdf > /dev/ttyCPM1

puts the shell into endless uninterruptible sleep, since the
transmitter is stopped after the first write, and is not enabled
before the shutdown function of the second write. Thus the transmit
buffers are never emptied.

Signed-off-by: Kalle Pokki <kalle.pokki@iki.fi>
Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
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
