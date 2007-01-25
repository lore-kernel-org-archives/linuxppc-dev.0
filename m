Return-Path: <MGalassi@c-cor.com>
Received: from ns1.c-cor.com (ns1.c-cor.com [12.17.0.130])
	by ozlabs.org (Postfix) with ESMTP id ABD7FDE036
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 07:36:20 +1100 (EST)
Received: from scpmail1.NTSCD.C-COR.com (scpo1.c-cor.com [192.168.128.18])
	by ns1.c-cor.com (8.12.10/8.12.10) with ESMTP id l0PKajLc024400
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 15:36:45 -0500 (EST)
Received: from penguin.ncube.com (localhost [127.0.0.1])
	by penguin.ncube.com (8.13.8/8.13.8) with ESMTP id l0PKa4Uw038035
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 12:36:04 -0800 (PST)
	(envelope-from nerd@penguin.ncube.com)
Message-Id: <200701252036.l0PKa4Uw038035@penguin.ncube.com>
To: linuxppc-embedded@ozlabs.org
From: Michael Galassi <mgalassi@c-cor.com>
Subject: Xilinx temac multicast support
Date: Thu, 25 Jan 2007 12:36:04 -0800
Sender: mgalassi@c-cor.com
Reply-To: Michael Galassi <mgalassi@c-cor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A quick perusal of the Xilinx provided linux 2.6 TEMAC driver indicates
that they've (Xilinx/MontaVista) yet to get around to providing
multicast support.  Since this was going to be a deal-breaker for our
application I added that support.  This seems to work well enough though
the hardware only has support for joining 4 multicast groups without
going to promiscious mode so performance may not be optimal if your
application calls for joining dozens of groups.

This patch should apply cleanly to the TEMAC driver as produced by the
current EDK/ISI with the most current IP updates installed.  The general
structure was borrowed from the GEMAC driver.  Any comments would be
greatly appreciated.

We're (C-Cor) new to the open source world so this is my first submitted
Linux patch, be gentle with me and the next ones will be better.

-michael

diff -Naur xilinx_temac.orig/adapter.c xilinx_temac/adapter.c
--- xilinx_temac.orig/adapter.c	2007-01-25 09:41:00.000000000 -0800
+++ xilinx_temac/adapter.c	2007-01-25 12:09:14.000000000 -0800
@@ -2007,6 +2007,104 @@
 #endif
 }
 
+static void xtenet_set_multicast_list(struct net_device *dev)
+{
+    struct net_local *lp = netdev_priv(dev);
+    struct dev_mc_list *mc;
+    u32 Options;
+    int i;
+
+    /*
+     * XTemac_Start, XTemac_Stop and XTemac_SetOptions are supposed to
+     * be protected by a semaphore.  This Linux adapter doesn't have
+     * it as bad as the VxWorks adapter because the sequence of
+     * requests to us is much more sequential.  However, we do have
+     * one area in which this is a problem.
+     *
+     * xtenet_set_multicast_list() is called while the link is up and
+     * interrupts are enabled, so at any point in time we could get
+     * an error that causes our reset() to be called.  reset() calls
+     * the aforementioned functions, and we need to call them from
+     * here as well.
+     *
+     * The solution is to make sure that we don't get interrupts or
+     * timers popping while we are in this function.
+     */
+    disable_irq(dev->irq);
+    local_bh_disable();
+
+    /*
+     * The dev's set_multicast_list function is only called when
+     * the device is up.  So, without checking, we know we need to
+     * Stop and Start the XTemac because it has already been
+     * started.  XTemac_Stop() will return an error if it is already
+     * stopped, but in this case we don't care so cast it to void
+     * to make it explicit
+     */
+    (void)XTemac_Stop(&lp->Emac);
+
+    Options = XTemac_GetOptions(&lp->Emac);
+
+    if (dev->flags & IFF_PROMISC) {
+	Options |= XTE_PROMISC_OPTION;
+	Options &= ~(XTE_MULTICAST_OPTION|XTE_MULTICAST_CAM_OPTION);
+    } else if ((dev->flags & IFF_ALLMULTI) ||
+	       ((dev->flags & IFF_MULTICAST) &&
+		(dev->mc_count > XTE_MULTI_CAM_ENTRIES))) {
+	/*
+	 * unfortunately the temac only supports 4 entries so if we
+	 * want to subscribe to more than 4 multicast groups we need
+	 * to fake it by going promiscious.
+	 */
+	/* may as well clear cam list */
+	for (i = 0; i < XTE_MULTI_CAM_ENTRIES; ++i) {
+	    XTemac_MulticastClear(&lp->Emac, i);
+	}
+	/* and set promiscuous mode */
+	Options |=
+	    (XTE_MULTICAST_OPTION|XTE_PROMISC_OPTION|XTE_MULTICAST_CAM_OPTION);
+    } else if (dev->flags & IFF_MULTICAST) {
+	for (i = 0; i < XTE_MULTI_CAM_ENTRIES; ++i) {
+	    XTemac_MulticastClear(&lp->Emac, i);
+	}
+	for (i = 0, mc = dev->mc_list; mc; ++i, mc = mc->next) {
+#ifdef NERDHAX
+	    /* watch mac addrs getting added */
+	    printk(KERN_DEBUG "%s add mc %x:%x:%x:%x:%x:%x\n", dev->name,
+		   mc->dmi_addr[0], mc->dmi_addr[1], mc->dmi_addr[2],
+		   mc->dmi_addr[3], mc->dmi_addr[4], mc->dmi_addr[5]);
+#endif /*NERDHAX*/
+	    XTemac_MulticastAdd(&lp->Emac, mc->dmi_addr, i);
+	}
+	Options |= (XTE_MULTICAST_OPTION|XTE_MULTICAST_CAM_OPTION);
+    } else {
+	Options &=
+	    ~(XTE_PROMISC_OPTION|XTE_MULTICAST_OPTION|XTE_MULTICAST_CAM_OPTION);
+    }
+#ifdef NERDHAX
+    printk(KERN_DEBUG "%s: Options %x flags %x mc_count %d\n",
+	   dev->name, Options, dev->flags, dev->mc_count);
+#endif /*NERDHAX*/
+    /*
+     * The following function will return an error if the EMAC is already
+     * started.  We know it isn't started so we can safely ignore the
+     * return value.  We cast it to void to make that explicit.
+     */
+    (void)XTemac_SetOptions(&lp->Emac, Options);
+
+    /*
+     * XTemac_Start returns an error when: it is already started, the send
+     * and receive handlers are not set, or a scatter-gather DMA list is
+     * missing.  None of these can happen at this point, so we cast the
+     * return to void to make that explicit.
+     */
+    (void)XTemac_Start(&lp->Emac);
+
+    /* All done, get those interrupts and timers going again. */
+    local_bh_enable();
+    enable_irq(dev->irq);
+}
+
 static int
 xenet_ethtool_get_settings (struct net_device *dev, struct ethtool_cmd* ecmd)
 {
@@ -2789,7 +2887,7 @@
     ndev->irq = r_irq->start;
 
 
-    /* Initialize the private data used by XEmac_LookupConfig().
+    /* Initialize the private data used by XTEmac_LookupConfig().
      * The private data are zeroed out by alloc_etherdev() already.
      */
     lp = netdev_priv(ndev);
@@ -2829,7 +2927,24 @@
     }
 
     /* Set the MAC address */
+#ifdef CONFIG_SQ
+    switch (pdev->id) {
+    case 0:
+	memcpy(ndev->dev_addr, ((bd_t *)&__res)->bi_enetaddr, 6);
+	break;
+    case 1:
+	memcpy(ndev->dev_addr, ((bd_t *)&__res)->bi_enet1addr, 6);
+	break;
+    case 2:
+	memcpy(ndev->dev_addr, ((bd_t *)&__res)->bi_enet2addr, 6);
+	break;
+    case 3:
+	memcpy(ndev->dev_addr, ((bd_t *)&__res)->bi_enet3addr, 6);
+	break;
+    }
+#else /*CONFIG_SQ*/
     memcpy(ndev->dev_addr, ((bd_t *) &__res)->bi_enetaddr, 6);
+#endif /*CONFIG_SQ*/
     if (XTemac_SetMacAddress(&lp->Emac, ndev->dev_addr) != XST_SUCCESS) {
         /* should not fail right after an initialize */
         printk(KERN_ERR "XTemac: could not set MAC address.\n");
@@ -2911,7 +3026,7 @@
     ndev->stop          = xenet_close;
     ndev->change_mtu    = xenet_change_mtu;
     ndev->get_stats     = xenet_get_stats;
-    ndev->flags         &= ~IFF_MULTICAST;
+    ndev->set_multicast_list = xtenet_set_multicast_list;
 
     /* TX DRE and SGDMA need to go together for this to work right */
     if ((XTemac_mIsTxDre(&lp->Emac) == TRUE) && (XTemac_mIsSgDma(&lp->Emac) == TRUE)) {
diff -Naur xilinx_temac.orig/xtemac.h xilinx_temac/xtemac.h
--- xilinx_temac.orig/xtemac.h	2007-01-25 09:41:00.000000000 -0800
+++ xilinx_temac/xtemac.h	2007-01-23 09:56:11.000000000 -0800
@@ -537,6 +537,10 @@
 /**< VLAN Rx & Tx frame support.
  *   This option defaults to disabled (cleared) */ 
 
+#define XTE_MULTICAST_OPTION             0x00000008
+/**< Multicast address reception
+ *   This option defaults to disabled (cleared) */
+
 #define XTE_FLOW_CONTROL_OPTION          0x00000010
 /**< Enable recognition of flow control frames on Rx
  *   This option defaults to enabled (set) */
