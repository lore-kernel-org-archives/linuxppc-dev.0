Subject: Re: BriQ & Linux 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamie Heilman <jamie@audible.transient.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040522064520.GM8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net>
	 <1085181034.6755.7.camel@gaston>
	 <20040521233523.GJ8520@audible.transient.net>
	 <1085199239.9230.4.camel@gaston>
	 <20040522064520.GM8520@audible.transient.net>
Content-Type: text/plain
Message-Id: <1085527853.15024.141.camel@gaston>
Mime-Version: 1.0
Date: Wed, 26 May 2004 09:30:54 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Picked this patch somewhere, let me know if it helps for the bogus
Tx errors. I don't know what's up with the lockup at this point, I
would expect the machine to be stable. Can you try to exercice it
using only netbooting instead of the HD or switching the HD down
to PIO mode (hdparm -d0 /dev/hda) to try to isolate the source of
the problem ?

--- linux/drivers/net/limit.pcnet32.c	2004-05-22 15:26:39.564037376 -0700
+++ linux/drivers/net/pcnet32.c	2004-05-24 12:49:23.329046344 -0700
@@ -22,8 +22,8 @@
  *************************************************************************/

 #define DRV_NAME	"pcnet32"
-#define DRV_VERSION	"1.30a"
-#define DRV_RELDATE	"05.22.2004"
+#define DRV_VERSION	"1.30b"
+#define DRV_RELDATE	"05.24.2004"
 #define PFX		DRV_NAME ": "

 static const char *version =
@@ -132,7 +132,7 @@
 };
 #define PCNET32_TEST_LEN (sizeof(pcnet32_gstrings_test) / ETH_GSTRING_LEN)

-#define PCNET32_NUM_REGS 146
+#define PCNET32_NUM_REGS 168

 #define MAX_UNITS 8	/* More are supported, limit only on options */
 static int options[MAX_UNITS];
@@ -242,6 +242,8 @@
  * v1.30   18 May 2004 Don Fry removed timer and Last Transmit Interrupt
  *	   (ltint) as they added complexity and didn't give good throughput.
  * v1.30a  22 May 2004 Don Fry limit frames received during interrupt.
+ * v1.30b  24 May 2004 Don Fry fix bogus tx carrier errors with 79c973,
+ *	   assisted by Bruce Penrod <bmpenrod@endruntechnologies.com>.
  */


@@ -889,15 +891,25 @@
     for (i=0; i<16; i += 2)
 	*buff++ = inw(ioaddr + i);

-    for (i = 0; i <= 89; i++) {
+    /* read control and status registers */
+    for (i=0; i<90; i++) {
 	*buff++ = a->read_csr(ioaddr, i);
     }

     *buff++ = a->read_csr(ioaddr, 112);
     *buff++ = a->read_csr(ioaddr, 114);

-    for (i = 0; i <= 35; i++) {
-	*buff++ = (i == 34) ? 0xdead : a->read_bcr(ioaddr, i);
+    /* read bus configuration registers */
+    for (i=0; i<36; i++) {
+	*buff++ = a->read_bcr(ioaddr, i);
+    }
+
+    /* read mii phy registers */
+    if (lp->mii) {
+	for (i=0; i<32; i++) {
+	    lp->a.write_bcr(ioaddr, 33, ((lp->mii_if.phy_id) << 5) | i);
+	    *buff++ = lp->a.read_bcr(ioaddr, 34);
+	}
     }

     if (!(csr0 & 0x0004)) {	/* If not stopped */
@@ -1722,6 +1734,9 @@
 		    /* There was an major error, log it. */
 		    int err_status = le32_to_cpu(lp->tx_ring[entry].misc);
 		    lp->stats.tx_errors++;
+		    if (netif_msg_tx_err(lp))
+			printk(KERN_ERR "%s: Tx error status=%04x err_status=%08x\n",
+				dev->name, status, err_status);
 		    if (err_status & 0x04000000) lp->stats.tx_aborted_errors++;
 		    if (err_status & 0x08000000) lp->stats.tx_carrier_errors++;
 		    if (err_status & 0x10000000) lp->stats.tx_window_errors++;
@@ -2087,39 +2102,33 @@
     spin_unlock_irqrestore(&lp->lock, flags);
 }

+/* This routine assumes that the lp->lock is held */
 static int mdio_read(struct net_device *dev, int phy_id, int reg_num)
 {
     struct pcnet32_private *lp = dev->priv;
     unsigned long ioaddr = dev->base_addr;
     u16 val_out;
-    int phyaddr;

     if (!lp->mii)
 	return 0;

-    phyaddr = lp->a.read_bcr(ioaddr, 33);
-
     lp->a.write_bcr(ioaddr, 33, ((phy_id & 0x1f) << 5) | (reg_num & 0x1f));
     val_out = lp->a.read_bcr(ioaddr, 34);
-    lp->a.write_bcr(ioaddr, 33, phyaddr);

     return val_out;
 }

+/* This routine assumes that the lp->lock is held */
 static void mdio_write(struct net_device *dev, int phy_id, int reg_num, int val)
 {
     struct pcnet32_private *lp = dev->priv;
     unsigned long ioaddr = dev->base_addr;
-    int phyaddr;

     if (!lp->mii)
 	return;

-    phyaddr = lp->a.read_bcr(ioaddr, 33);
-
     lp->a.write_bcr(ioaddr, 33, ((phy_id & 0x1f) << 5) | (reg_num & 0x1f));
     lp->a.write_bcr(ioaddr, 34, val);
-    lp->a.write_bcr(ioaddr, 33, phyaddr);
 }

 static int pcnet32_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
