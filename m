From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 18 Jun 2004 12:20:46 -0700
To: Sylvain Munaut <tnt@246tnt.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][RFC] MPC52xx basic support on linux 2.6 (was DMA support for MPC5xxx?)
Message-ID: <20040618192046.GA22607@zenos.farnsworth.org>
References: <20040603090635.B7347@home.com> <20040603164245.B24A9C109F@atlas.denx.de> <20040603113302.A24468@home.com> <20040603185053.GN15195@smtp.west.cox.net> <40BF87BB.4020808@246tNt.com> <20040603134804.B24468@home.com> <40C8BB6C.4040709@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <40C8BB6C.4040709@246tNt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jun 10, 2004 at 07:50:04PM +0000, Sylvain Munaut wrote:
> Here it is, slightly delayed because of hardrive crash and need to
> rename all 'Motorola' to 'Freescale' ;)
>
> It's there :
>
> http://www.246tNt.com/linux-2.5-mpc52xx-pending-20040610.diff
> bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending

FWIW, I'd like to see the above go into linux-2.5.

I found a few issues.
  - need to call uart_update_timeout
  - Maximum delay for console_write (printk) was too short
  - one missed icecube to lite5200 name change.

This patch applies on top Sylvain's patch above.

-Dale

===== drivers/serial/mpc52xx_uart.c 1.1 vs edited =====
--- 1.1/drivers/serial/mpc52xx_uart.c	2004-06-11 14:50:26 -07:00
+++ edited/drivers/serial/mpc52xx_uart.c	2004-06-17 15:28:36 -07:00
@@ -289,15 +289,18 @@
 	/* Get the lock */
 	spin_lock_irqsave(&port->lock, flags);

+	/* Update the per-port timeout */
+	uart_update_timeout(port, new->c_cflag, baud);
+
 	/* Do our best to flush TX & RX, so we don't loose anything */
 	/* But we don't wait indefinitly ! */
-	j = 1000;	/* Maximum wait */
+	j = 1000000;	/* Maximum wait */
 	/* FIXME Can't receive chars since set_termios might be called at early
 	 * boot for the console, all stuff is not yet ready to receive at that
 	 * time and that just makes the kernel oops */
 	/* while (j-- && mpc52xx_uart_int_rx_chars(port)); */
 	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
-	       j--)
+	       --j)
 		udelay(1);

 	if (!j)
@@ -588,40 +591,28 @@

 	/* Disable interrupts */
 	out_be16(&psc->mpc52xx_psc_imr, 0);
+
+	/* Wait the TX buffer to be empty */
+	j = 1000000;	/* Maximum wait */
+	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
+			j--)
+		udelay(1);

 	/* Write all the chars */
 	for ( i=0 ; i<count ; i++ ) {
-
-		/* Wait the TX buffer to be ready */
-		j = 10000;	/* Maximum wait */
-		while (!(in_be16(&psc->mpc52xx_psc_status) &
-		         MPC52xx_PSC_SR_TXRDY) &&
-		       j--)
-			udelay(1);
-
 		/* Send the char */
 		out_8(&psc->mpc52xx_psc_buffer_8, *s);

 		/* Line return handling */
-		if ( *s++ == '\n' ) {
-			/* Wait the TX buffer to be ready */
-			j = 10000;	/* Maximum wait */
-			while (!(in_be16(&psc->mpc52xx_psc_status) &
-			         MPC52xx_PSC_SR_TXRDY) &&
-			       j--)
-				udelay(1);
-
-			/* Send the char */
+		if ( *s++ == '\n' )
 			out_8(&psc->mpc52xx_psc_buffer_8, '\r');
-		}
-	}

-	/* Wait the TX buffer to be empty */
-	/* I'm not sure we really need to ... */
-	j = 10000;	/* Maximum wait */
-	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP) &&
-	       j--)
-		udelay(1);
+		/* Wait the TX buffer to be empty */
+		j = 100000;	/* Maximum wait */
+		while (!(in_be16(&psc->mpc52xx_psc_status) &
+				MPC52xx_PSC_SR_TXEMP) && j--)
+			udelay(1);
+	}

 	/* Restore interrupt state */
 	out_be16(&psc->mpc52xx_psc_imr, port->read_status_mask);
===== include/asm-ppc/mpc52xx.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/mpc52xx.h	2004-06-11 14:50:27 -07:00
+++ edited/include/asm-ppc/mpc52xx.h	2004-06-17 15:09:58 -07:00
@@ -339,7 +339,7 @@

 	volatile u8  mem_clk_sel;	/* MBAR_CDM + 0x0c  reg3 byte0 */
 	volatile u8  xlb_clk_sel;	/* MBAR_CDM + 0x0d  reg3 byte1 read only */
-	volatile u8  ipg_clk_sel;	/* MBAR_CDM + 0x0e  reg3 byte2 */
+	volatile u8  ipb_clk_sel;	/* MBAR_CDM + 0x0e  reg3 byte2 */
 	volatile u8  pci_clk_sel;	/* MBAR_CDM + 0x0f  reg3 byte3 */

 	volatile u8  ext_48mhz_en;	/* MBAR_CDM + 0x10  reg4 byte0 */
@@ -419,8 +419,8 @@
 extern bd_t __res;

 /* Platform options */
-#if defined(CONFIG_ICECUBE)
-#include <platforms/icecube.h>
+#if defined(CONFIG_LITE5200)
+#include <platforms/lite5200.h>
 #endif


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
