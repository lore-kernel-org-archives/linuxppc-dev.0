Subject: [PATCH] compile fix for cpm uart driver
From: Andreas Oberritter <obi@saftware.de>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: multipart/mixed; boundary="=-TMC5Hw1GF5Q13UkMmFaP"
Message-Id: <1090251356.1417.8.camel@shiva.saftware.de>
Mime-Version: 1.0
Date: Mon, 19 Jul 2004 17:35:56 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-TMC5Hw1GF5Q13UkMmFaP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

cpm_uart_cpm1.c doesn't compile due to a missing bracket (linuxppc-2.5
tree). Please apply.

Signed-off-by: Andreas Oberritter <obi@saftware.de>

--=-TMC5Hw1GF5Q13UkMmFaP
Content-Disposition: attachment; filename=cpm_uart_cpm1.diff
Content-Type: text/x-patch; name=cpm_uart_cpm1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== drivers/serial/cpm_uart/cpm_uart_cpm1.c 1.4 vs edited =====
--- 1.4/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-07-16 01:26:09 +02:00
+++ edited/drivers/serial/cpm_uart/cpm_uart_cpm1.c	2004-07-18 20:46:16 +02:00
@@ -138,7 +138,7 @@

 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_DPERR(dp_offset))
+	if (IS_DPERR(dp_offset)) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;

--=-TMC5Hw1GF5Q13UkMmFaP--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
