From: Paul Ruhland <pruhland@rochester.rr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: arch/ppc/8xx_io/commproc.c brg calculation patch
Date: Fri, 7 Mar 2003 02:26:41 -0500
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xmEa+3mNnstxiM2"
Message-Id: <200303070226.41690.pruhland@rochester.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary-00=_xmEa+3mNnstxiM2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch is against the linux-2.4 denx cvs. I haven't checked
linxppc-2_4_devel tree but I imagine it is the same.  It adds a bit more
precision to the brg calculation.

Currently, the calculation simply truncates (rounds down) the brg divider
which will make the baud rate on the high side of optimal when a closer value
may exist below optimal rate.  This was causing communication with some
equipment to fail as the higher value was out of tolerance.

This patch will round down (the brg divider) if the fractional part of the
division is < .5 and round up if >= .5.

--
Paul Ruhland

--Boundary-00=_xmEa+3mNnstxiM2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.brgcalc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.brgcalc.patch"

diff -ruN linux-2.4.ORIG/arch/ppc/8xx_io/commproc.c linux-2.4/arch/ppc/8xx_io/commproc.c
--- linux-2.4.ORIG/arch/ppc/8xx_io/commproc.c	2002-09-28 05:53:19.000000000 -0400
+++ linux-2.4/arch/ppc/8xx_io/commproc.c	2003-01-18 13:34:23.000000000 -0500
@@ -404,13 +404,18 @@
 	*/
 	bp = (uint *)&cpmp->cp_brgc1;
 	bp += brg;
+
 	/* The BRG has a 12-bit counter.  For really slow baud rates (or
 	 * really fast processors), we may have to further divide by 16.
+	 *
+	 * NOTE: for integer math division, adding (divisor/2) to numerator
+	 * rounds up (if fractional part would be >= .5) for more precision
 	 */
-	if (((BRG_UART_CLK / rate) - 1) < 4096)
-		*bp = (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN;
+
+	if ((((BRG_UART_CLK + (rate/2))/ rate) - 1) < 4096)
+		*bp = ((((BRG_UART_CLK +(rate/2)) / rate) - 1) << 1) | CPM_BRG_EN;
 	else
-		*bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
+		*bp = ((((BRG_UART_CLK_DIV16 + (rate/2))/ rate) - 1) << 1) |
 						CPM_BRG_EN | CPM_BRG_DIV16;
 }


--Boundary-00=_xmEa+3mNnstxiM2--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
