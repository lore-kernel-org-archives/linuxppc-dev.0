Date: Tue, 1 Oct 2002 13:01:10 -0700
From: Andrew May <acmay@acmay.homeip.net>
To: linuxppc-embedded@lists.linuxppc.org
Cc: amay@viasat.com, akuster@pacbell.net
Subject: status of 2_4_devel
Message-ID: <20021001200110.GA10094@acmay.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been off doing other stuff so I haven't done a resync of the tree
since June.

First thing I ran into was a compile problem with the IBM OCP ethernet driver.
Have things really not even compiled for the 405GP since Aug 22? This little
patch should fix that problem.

==== ibm_ocp_enet.c 1.41 vs edited =====
--- 1.41/drivers/net/ibm_ocp/ibm_ocp_enet.c	Mon Sep 30 18:34:10 2002
+++ edited/ibm_ocp_enet.c	Mon Sep 30 19:45:24 2002
@@ -1195,7 +1195,7 @@
 /*	if (tmp_em0isr & EMAC_ISR_MOS ) fep->stats.ZZZ++;		*/
 /*	if (tmp_em0isr & EMAC_ISR_MOF ) fep->stats.ZZZ++;		*/

-	ppc405_bl_mac_eth_dump(dev, tmp_em0isr);
+	ppc405_bl_mac_eth_dump((struct net_device*)dev_instance, tmp_em0isr);

 	out_be32(&emacp->em0isr, tmp_em0isr);
 }

Next I ran into problems with the UART init. Looking at arch/ppc/kernel/ocp_uart.c
I was absolutely amazed. Why would you call early_serial_init with values from
rs_table when early_serial_init puts the values right back into rs_table?

When I had John post the patch to add the call to early_s..., it was to
get the base baud rate dynamically from the clock speed, so the value
didn't need to be compiled in. As it is now the code in early_uart_init
is completely pointless and just wastes space.

http://lists.linuxppc.org/linuxppc-embedded/200204/msg00129.html

ps: my home email is having problems so I cc'd my work/outlook account.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
