Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 00B992C008F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 01:30:35 +1000 (EST)
Date: Tue, 14 Aug 2012 16:26:26 +0200
Message-Id: <201208141426.q7EEQQmD003947@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>,
 Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] Powerpc 8xx CPM_UART desynchronisation
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm not sure who to address this Patch to.

It fixes a desynchronisation problem with CPM UART driver on Powerpc MPC8xx.
The problem happens if data is received before the device is open by the user application.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

--- linux-3.5-vanilla/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-08-09 17:38:37.000000000 +0200
@@ -417,6 +417,7 @@
 			clrbits32(&pinfo->sccp->scc_gsmrl, SCC_GSMRL_ENR);
 			clrbits16(&pinfo->sccp->scc_sccm, UART_SCCM_RX);
 		}
+		cpm_uart_initbd(pinfo);
 		cpm_line_cr_cmd(pinfo, CPM_CR_INIT_TRX);
 	}
 	/* Install interrupt handler. */
