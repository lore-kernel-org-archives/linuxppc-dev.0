Date: Tue, 27 Jul 2004 17:54:47 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: question about specific patch to cpm_uart_core.c for SMC reloc
Message-ID: <Pine.LNX.4.60.0407271750550.7567@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   torsten demke sent me a set of patches for SMC1 relocation and they
included the following addition to cpm_uart_core.c:

diff -purN
linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_core.c
linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_core.c
---
linuxppc-2.6.7-bk1.1248-org/drivers/serial/cpm_uart/cpm_uart_core.c
2004-07-20 10:57:37.000000000 +0200
+++ linuxppc-2.6.7-bk1.1248/drivers/serial/cpm_uart/cpm_uart_core.c
2004-07-20 11:02:21.000000000 +0200
@@ -743,6 +743,15 @@ static void cpm_uart_init_smc(struct uar
         pinfo->smcup->smc_rbase = (u_char *)pinfo->rx_bd_base -
DPRAM_BASE;
         pinfo->smcup->smc_tbase = (u_char *)pinfo->tx_bd_base -
DPRAM_BASE;

+#if defined (CONFIG_SHMC) && defined (CONFIG_UCODE_PATCH)
+       up->smc_rbptr = pinfo->smcup->smc_rbase;
+       up->smc_tbptr = pinfo->smcup->smc_tbase;
+       up->smc_rstate = 0;
+       up->smc_tstate = 0;
+       up->smc_brkcr = 1;              /* number of break chars */
+       up->smc_brkec = 0;
+#endif
+

   AFAICT, the added code at the bottom is because, when you relocate
SMC1, you lose some functionality.  is there, somewhere, i can read
up on what the above is fixing?  thanks.  i think that's the last
piece of the puzzle -- all the rest of the changes make sense.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
