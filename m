Date: Wed, 14 Feb 2001 03:24:14 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pmac netdevice driver probing bugs
Message-ID: <20010214032414.A25165@suse.de>
References: <20010206121414.A7877@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <20010206121414.A7877@suse.de>; from olh@suse.de on Tue, Feb 06, 2001 at 12:14:15PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 06, Olaf Hering wrote:

>
> Hi,
>
> the current device probing code for mace,bmac and gmac returns always 0
> and the module can be loaded even if the required hardware is not
> present.
>
> cherry:~ # modprobe pcnet32
> /lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: init_module: No
> such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> /lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: insmod
> /lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o failed
> /lib/modules/2.4.1-olaf/kernel/drivers/net/pcnet32.o: insmod pcnet32
> failed
> cherry:~ #  modprobe bmac
> cherry:~ # lsmod
> Module                  Size  Used by
> bmac                   12512   0  (unused)
> nfsd                   75888   4  (autoclean)
> autofs4                11920   4  (autoclean)
> ipv6                  151488  -1  (autoclean)
> gmac                   15248   1  (autoclean)
>
>
>
> Can we change that behaviour?
> de4x5 and pcnet32 return -EIO as example and the module is not loaded.

The attached patches fix that problem.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-pre3_bmac_safe_modload.dif"

--- linuxppc_2_4/drivers/net/bmac.c	Sat Jan 13 04:36:20 2001
+++ linux-2.4.2-pre3.ppc/drivers/net/bmac.c	Sat Feb 10 23:31:16 2001
@@ -147,7 +147,7 @@
 	+ sizeof(struct sk_buff_head))

 static unsigned char bitrev(unsigned char b);
-static void bmac_probe1(struct device_node *bmac, int is_bmac_plus);
+static int bmac_probe1(struct device_node *bmac, int is_bmac_plus);
 static int bmac_open(struct net_device *dev);
 static int bmac_close(struct net_device *dev);
 static int bmac_transmit_packet(struct sk_buff *skb, struct net_device *dev);
@@ -1257,12 +1257,13 @@
 static int __init bmac_probe(void)
 {
 	struct device_node *bmac;
+	int bmac_error = -ENODEV;

 	for (bmac = find_devices("bmac"); bmac != 0; bmac = bmac->next)
-		bmac_probe1(bmac, 0);
+		bmac_error = bmac_probe1(bmac, 0);
 	for (bmac = find_compatible_devices("network", "bmac+"); bmac != 0;
 	     bmac = bmac->next)
-		bmac_probe1(bmac, 1);
+		bmac_error = bmac_probe1(bmac, 1);

 	if (bmac_devs != 0) {
 		proc_net_create ("bmac", 0, bmac_proc_info);
@@ -1270,20 +1271,21 @@
 		pmu_register_sleep_notifier(&bmac_sleep_notifier);
 #endif
 	}
-	return 0;
+	return bmac_error;
 }

-static void __init bmac_probe1(struct device_node *bmac, int is_bmac_plus)
+static int __init bmac_probe1(struct device_node *bmac, int is_bmac_plus)
 {
 	int j, rev, ret;
 	struct bmac_data *bp;
 	unsigned char *addr;
 	struct net_device *dev;
+	int bmac_error = -EIO;

 	if (bmac->n_addrs != 3 || bmac->n_intrs != 3) {
 		printk(KERN_ERR "can't use BMAC %s: need 3 addrs and 3 intrs\n",
 		       bmac->full_name);
-		return;
+		return bmac_error;
 	}
 	addr = get_property(bmac, "mac-address", NULL);
 	if (addr == NULL) {
@@ -1291,7 +1293,7 @@
 		if (addr == NULL) {
 			printk(KERN_ERR "Can't get mac-address for BMAC %s\n",
 			       bmac->full_name);
-			return;
+			return bmac_error;
 		}
 	}

@@ -1299,7 +1301,7 @@
 	if (!dev) {
 		printk(KERN_ERR "init_etherdev failed, out of memory for BMAC %s\n",
 		       bmac->full_name);
-		return;
+		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);

@@ -1374,7 +1376,7 @@

 	bp->next_bmac = bmac_devs;
 	bmac_devs = dev;
-	return;
+	return 0;

 err_out_irq1:
 	free_irq(bmac->intrs[1].line, dev);
@@ -1389,6 +1391,7 @@
 err_out:
 	unregister_netdev(dev);
 	kfree(dev);
+	return bmac_error;
 }

 static int bmac_open(struct net_device *dev)

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.1_mace_safe_module.dif"

--- linux/drivers/net/mace.c.bk	Sat Dec 30 20:23:14 2000
+++ linux/drivers/net/mace.c	Wed Feb 14 03:13:02 2001
@@ -67,7 +67,7 @@

 static int bitrev(int);
 static int mace_probe(void);
-static void mace_probe1(struct device_node *mace);
+static int mace_probe1(struct device_node *mace);
 static int mace_open(struct net_device *dev);
 static int mace_close(struct net_device *dev);
 static int mace_xmit_start(struct sk_buff *skb, struct net_device *dev);
@@ -103,13 +103,14 @@
 static int __init mace_probe(void)
 {
 	struct device_node *mace;
+	int mace_error = -ENODEV;

 	for (mace = find_devices("mace"); mace != NULL; mace = mace->next)
-		mace_probe1(mace);
-	return 0;
+		mace_error = mace_probe1(mace);
+	return mace_error;
 }

-static void __init mace_probe1(struct device_node *mace)
+static int __init mace_probe1(struct device_node *mace)
 {
 	int j, rev;
 	struct net_device *dev;
@@ -119,7 +120,7 @@
 	if (mace->n_addrs != 3 || mace->n_intrs != 3) {
 		printk(KERN_ERR "can't use MACE %s: need 3 addrs and 3 irqs\n",
 		       mace->full_name);
-		return;
+		return -EIO;
 	}

 	addr = get_property(mace, "mac-address", NULL);
@@ -128,13 +129,13 @@
 		if (addr == NULL) {
 			printk(KERN_ERR "Can't get mac-address for MACE %s\n",
 			       mace->full_name);
-			return;
+			return -EIO;
 		}
 	}

 	dev = init_etherdev(0, PRIV_BYTES);
 	if (!dev)
-		return;
+		return -EIO;
 	SET_MODULE_OWNER(dev);

 	mp = dev->priv;
@@ -192,6 +193,7 @@

 	mp->next_mace = mace_devs;
 	mace_devs = dev;
+	return 0;
 }

 static void dbdma_reset(volatile struct dbdma_regs *dma)

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.1_gmac_safe_module.dif"

--- linux/drivers/net/gmac.c.bk	Sun Dec 31 03:16:13 2000
+++ linux/drivers/net/gmac.c	Wed Feb 14 02:54:25 2001
@@ -81,7 +81,7 @@
 static void gmac_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static struct net_device_stats *gmac_stats(struct net_device *dev);
 static int gmac_probe(void);
-static void gmac_probe1(struct device_node *gmac);
+static int gmac_probe1(struct device_node *gmac);

 #ifdef CONFIG_PMAC_PBOOK
 int gmac_sleep_notify(struct pmu_sleep_notifier *self, int when);
@@ -1299,6 +1299,7 @@
 gmac_probe(void)
 {
 	struct device_node *gmac;
+	int gmac_error = -ENODEV;

 	/* We bump use count during probe since get_free_page can sleep
 	 * which can be a race condition if module is unloaded at this
@@ -1312,15 +1313,15 @@
 	 */
 	for (gmac = find_compatible_devices("network", "gmac"); gmac != 0;
 	     gmac = gmac->next)
-		gmac_probe1(gmac);
+		gmac_error = gmac_probe1(gmac);


 	MOD_DEC_USE_COUNT;

-	return 0;
+	return gmac_error;
 }

-static void
+static int
 gmac_probe1(struct device_node *gmac)
 {
 	struct gmac *gm;
@@ -1332,26 +1333,26 @@
 	if (gmac->n_addrs < 1 || gmac->n_intrs < 1) {
 		printk(KERN_ERR "can't use GMAC %s: %d addrs and %d intrs\n",
 		       gmac->full_name, gmac->n_addrs, gmac->n_intrs);
-		return;
+		return -EIO;
 	}

 	addr = get_property(gmac, "local-mac-address", NULL);
 	if (addr == NULL) {
 		printk(KERN_ERR "Can't get mac-address for GMAC %s\n",
 		       gmac->full_name);
-		return;
+		return -EIO;
 	}

 	tx_descpage = get_free_page(GFP_KERNEL);
 	if (tx_descpage == 0) {
 		printk(KERN_ERR "GMAC: can't get a page for tx descriptors\n");
-		return;
+		return -EIO;
 	}
 	rx_descpage = get_free_page(GFP_KERNEL);
 	if (rx_descpage == 0) {
 		printk(KERN_ERR "GMAC: can't get a page for rx descriptors\n");
 		free_page(tx_descpage);
-		return;
+		return -EIO;
 	}

 	dev = init_etherdev(NULL, sizeof(struct gmac));
@@ -1360,7 +1361,7 @@
 		printk(KERN_ERR "GMAC: init_etherdev failed, out of memory\n");
 		free_page(tx_descpage);
 		free_page(rx_descpage);
-		return;
+		return -ENOMEM;
 	}
 	SET_MODULE_OWNER(dev);

@@ -1410,6 +1411,7 @@
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&gmac_sleep_notifier);
 #endif
+	return 0;
 }

 MODULE_AUTHOR("Paul Mackerras/Ben Herrenschmidt");

--a8Wt8u1KmwUX3Y2C--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
