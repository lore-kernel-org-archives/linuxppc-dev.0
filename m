Date: Thu, 20 Jun 2002 17:34:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Trivial cleanup in ocp_uart.c
Message-ID: <20020620073440.GC20689@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ocp_uart.c allocates private space with ocp_alloc_dev, but never uses
it.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_uart.c linux-grinch/arch/ppc/kernel/ocp_uart.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/arch/ppc/kernel/ocp_uart.c	Wed Jun 19 10:32:59 2002
+++ linux-grinch/arch/ppc/kernel/ocp_uart.c	Thu Jun 20 17:32:57 2002
@@ -99,7 +99,7 @@
 	int curr_uart = 0;

 	while (curr_uart != -ENXIO) {
-		if (!(uart_drv = ocp_alloc_dev(sizeof (struct serial_struct))))
+		if (!(uart_drv = ocp_alloc_dev(0)))
 			return -ENOMEM;
 		uart_drv->type = UART;
 		/* this returns the next uart number */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
