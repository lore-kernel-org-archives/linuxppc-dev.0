Date: Fri, 07 Feb 2003 14:36:50 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: [PATCH] 8xx_io/uart.c
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLKEALFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Found a bug in the serial driver. my_console_write() uses the wrong address in early console writes.
Removed some warnings as well.

Please can you change TX_NUM_FIFO to 8 and TX_BUF_SIZE to 96,
since chars are lost when pasting text into the console otherwise.

   Jocke

Index: arch/ppc/8xx_io/uart.c
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/arch/ppc/8xx_io/uart.c,v
retrieving revision 1.3
diff -u -r1.3 uart.c
--- arch/ppc/8xx_io/uart.c	21 Nov 2002 15:16:27 -0000	1.3
+++ arch/ppc/8xx_io/uart.c	7 Feb 2003 13:23:23 -0000
@@ -2309,7 +2309,10 @@
 		/* if a LF, also do CR... */
 		if (*s == 10) {
 			while (bdp->cbd_sc & BD_SC_READY);
-			cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
+			if ((uint)(bdp->cbd_bufaddr) > (uint)IMAP_ADDR)
+				cp = (u_char *)(bdp->cbd_bufaddr);
+			else
+				cp = info->tx_va_base + ((bdp - info->tx_bd_base) * TX_BUF_SIZE);
 			*cp = 13;
 			bdp->cbd_datlen = 1;
 			bdp->cbd_sc |= BD_SC_READY;
@@ -3000,10 +3003,10 @@
 	bdp->cbd_bufaddr = iopa(mem_addr);
 	(bdp+1)->cbd_bufaddr = iopa(mem_addr+4);

-	consinfo.rx_va_base = mem_addr;
-	consinfo.rx_bd_base = bdp;
-	consinfo.tx_va_base = mem_addr + 4;
-	consinfo.tx_bd_base = bdp+1;
+	consinfo.rx_va_base = (unsigned char *)mem_addr;
+	consinfo.rx_bd_base = (cbd_t *)bdp;
+	consinfo.tx_va_base = (unsigned char *)(mem_addr + 4);
+	consinfo.tx_bd_base = (cbd_t *)(bdp+1);

 	/* For the receive, set empty and wrap.
 	 * For transmit, set wrap.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
