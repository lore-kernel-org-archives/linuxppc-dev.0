Date: Mon, 27 May 2002 14:03:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Another OCP enet patch
Message-ID: <20020527040330.GH16537@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin, please consider the patch below.  It removes your recently
added ocp-dma.h and instead makes the ocp enet driver uses the DMA
direction constants from pci.h.

I realise that logically the OCP enet driver, and the
consistent_sync() has nothing to do with PCI.  However using the pci.h
constants seems a better approach than defining new constants with the
same values, when the switch in consistent_sync() explicitly checks
against the PCI constants.

In the longer term consistent_sync() itself should be changed not to
reference the PCI constants - in fact the PCI constants should
probably be moved and renamed since they have no inherent connection
with PCI at all.

Oh, I also change the consistent_sync() in the Tx routine to be
PCI_DMA_TODEVICE rather than BIDIRECTIONAL, since there is no need to
invalidate the cache here, a writeback is all that's necessary.

diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c
--- /home/dgibson/kernel/linuxppc_2_4_devel/drivers/net/ibm_ocp/ibm_ocp_enet.c	Fri May 24 11:19:23 2002
+++ linux-grinch/drivers/net/ibm_ocp/ibm_ocp_enet.c	Mon May 27 13:57:27 2002
@@ -165,6 +165,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/types.h>
+#include <linux/pci.h>

 #include <asm/processor.h>	/* Processor type for cache alignment. */
 #include <asm/bitops.h>
@@ -172,7 +173,6 @@
 #include <asm/dma.h>
 #include <asm/irq.h>
 #include <asm/ocp.h>
-#include <asm/ocp-dma.h>

 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -476,7 +476,7 @@
 	 * interrupt.
 	 */
 	fep->tx_skb[fep->tx_slot] = skb;
-	consistent_sync((void *) skb->data, skb->len, DMA_BIDIRECTIONAL);
+	consistent_sync((void *) skb->data, skb->len, PCI_DMA_TODEVICE);

 	ctrl = EMAC_TX_CTRL_DFLT;
 	if ((NUM_TX_BUFF - 1) == fep->tx_slot)
@@ -974,8 +974,8 @@
 				skb_reserve(fep->rx_skb[i], skb_res);

 			consistent_sync((void *) fep->rx_skb[i]->
-					    data, DESC_RX_BUF_SIZE,
-					    DMA_BIDIRECTIONAL);
+					data, DESC_RX_BUF_SIZE,
+					PCI_DMA_BIDIRECTIONAL);
 			ptr = (char *) virt_to_phys(fep->rx_skb[i]->data);
 		}
 		fep->rx_desc[i].ctrl = MAL_RX_CTRL_EMPTY | MAL_RX_CTRL_INTR |	/*could be smarter about this to avoid ints at high loads */
diff -urN /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp-dma.h linux-grinch/include/asm-ppc/ocp-dma.h
--- /home/dgibson/kernel/linuxppc_2_4_devel/include/asm-ppc/ocp-dma.h	Tue May 21 10:27:14 2002
+++ linux-grinch/include/asm-ppc/ocp-dma.h	Thu Jan 01 10:00:00 1970
@@ -1,49 +0,0 @@
-/*
- * ocp-dma.h
- *
- *
- * 	Current Maintainer
- *      Armin Kuster akuster@pacbell.net
- *      May, 2002
- *
- *
- *
- * This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *	Version 1.0 (05/16/02) - A. Kuster
- *	Initial version	 -
- *
- */
-
-#ifdef __KERNEL__
-#ifndef __OCP_DMA_H__
-#define __OCP_DMA_H__
-
-
-/* This defines the direction arg to the DMA mapping routines. */
-#define DMA_BIDIRECTIONAL	0
-#define DMA_TODEVICE		1
-#define DMA_FROMDEVICE		2
-#define DMA_NONE		3
-
-#endif				/* __OCP_DMA_H__ */
-#endif				/* __KERNEL__ */
-

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
