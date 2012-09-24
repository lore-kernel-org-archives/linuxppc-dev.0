Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by ozlabs.org (Postfix) with ESMTP id 3E72C2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 16:21:44 +1000 (EST)
Date: Mon, 24 Sep 2012 08:20:18 +0200
Message-Id: <201209240620.q8O6KINT029454@localhost.localdomain>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>,
 Marcelo Tosatti <marcelo@kvack.org>
Subject: [PATCH] Powerpc 8xx CPM_UART maxidl should not depend on fifo size
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

maxidl register was set to fifo size. There is no reason to set this
register to same value as fifo size. Setting it now to 0x10 by default
as in the UCC UART driver.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

--- linux-3.5-vanilla/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.5/drivers/tty/serial/cpm_uart/cpm_uart_core.c	2012-08-09 17:38:37.000000000 +0200
@@ -799,7 +799,7 @@
 	cpm_set_scc_fcr(sup);
 
 	out_be16(&sup->scc_genscc.scc_mrblr, pinfo->rx_fifosize);
-	out_be16(&sup->scc_maxidl, pinfo->rx_fifosize);
+	out_be16(&sup->scc_maxidl, 0x10);
 	out_be16(&sup->scc_brkcr, 1);
 	out_be16(&sup->scc_parec, 0);
 	out_be16(&sup->scc_frmec, 0);
@@ -873,7 +873,7 @@
 
 	/* Using idle character time requires some additional tuning.  */
 	out_be16(&up->smc_mrblr, pinfo->rx_fifosize);
-	out_be16(&up->smc_maxidl, pinfo->rx_fifosize);
+	out_be16(&up->smc_maxidl, 0x10);
 	out_be16(&up->smc_brklen, 0);
 	out_be16(&up->smc_brkec, 0);
 	out_be16(&up->smc_brkcr, 1);
