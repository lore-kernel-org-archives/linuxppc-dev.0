Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 31 Mar 2009 14:34:04 +1100
Subject: [PATCH] powerpc/pmac: Fix internal modem IRQ on Wallstreet PowerBook
Message-Id: <20090331033442.7D891DDEE3@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The (relatively) new pmac_zilog driver doesn't use the pre-munged
IRQ numbers from the macio_dev unlike other macio things, it
directly maps it off the OF device-tree.

It does that because it can be initialized much earlier than the
registration of the macio devices, in order to get a serial
console early.

Unfortunately, that means that it "misses" some fixups done
by the macio layer to work around missing interrupt descriptions
in the device-tree of the Wallstreet machines.

This patch brings the necessary workaround into the pmac_zilog
driver itself to bring it back to working condition.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---


 drivers/serial/pmac_zilog.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- linux-work.orig/drivers/serial/pmac_zilog.c	2009-03-31 14:15:13.000000000 +1100
+++ linux-work/drivers/serial/pmac_zilog.c	2009-03-31 14:31:34.000000000 +1100
@@ -1538,6 +1538,21 @@ no_dma:
 	uap->port.type = PORT_PMAC_ZILOG;
 	uap->port.flags = 0;
 
+	/*
+	 * Fixup for the port on Gatwick for which the device-tree has
+	 * missing interrupts. Normally, the macio_dev would contain
+	 * fixed up interrupt info, but we use the device-tree directly
+	 * here due to early probing so we need the fixup too.
+	 */
+	if (uap->port.irq == NO_IRQ &&
+	    np->parent && np->parent->parent &&
+	    of_device_is_compatible(np->parent->parent, "gatwick")) {
+		/* IRQs on gatwick are offset by 64 */
+		uap->port.irq = irq_create_mapping(NULL, 64 + 15);
+		uap->tx_dma_irq = irq_create_mapping(NULL, 64 + 4);
+		uap->rx_dma_irq = irq_create_mapping(NULL, 64 + 5);
+	}
+
 	/* Setup some valid baud rate information in the register
 	 * shadows so we don't write crap there before baud rate is
 	 * first initialized.
