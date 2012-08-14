Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 122B32C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Aug 2012 01:00:36 +1000 (EST)
Date: Tue, 14 Aug 2012 16:26:28 +0200
Message-Id: <201208141426.q7EEQSPc003956@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>,
 Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] Powerpc 8xx CPM_UART delay in receive
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

I'm not sure who to address this Patch to either

It fixes a delay issue with CPM UART driver on Powerpc MPC8xx.
The problem is that with the actual code, the driver waits 32 IDLE patterns before returning the received data to the upper level. It means for instance about 1 second at 300 bauds.
This fix limits to one byte the waiting period.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

--- linux-3.5-vanilla/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-08-09 17:38:37.000000000 +0200
@@ -798,7 +799,7 @@
 	cpm_set_scc_fcr(sup);
 
 	out_be16(&sup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
-	out_be16(&sup->scc_maxidl, pinfo->rx_fifosize);
+	out_be16(&sup->scc_maxidl, 1);
 	out_be16(&sup->scc_brkcr, 1);
 	out_be16(&sup->scc_parec, 0);
 	out_be16(&sup->scc_frmec, 0);
@@ -872,7 +873,7 @@
 
 	/* Using idle character time requires some additional tuning.  */
 	out_be16(&up->smc_mrblr, pinfo->rx_fifosize);
-	out_be16(&up->smc_maxidl, pinfo->rx_fifosize);
+	out_be16(&up->smc_maxidl, 1);
 	out_be16(&up->smc_brklen, 0);
 	out_be16(&up->smc_brkec, 0);
 	out_be16(&up->smc_brkcr, 1);
