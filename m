Date: Wed, 19 May 2004 22:10:56 +0200
From: Colin Leroy <colin@colino.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: netconsole & sungem
Message-Id: <20040519221056.54d7f732@jack.colino.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__19_May_2004_22_10_56_+0200_.qPpE7n2W6fHYYSV"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart=_Wed__19_May_2004_22_10_56_+0200_.qPpE7n2W6fHYYSV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

I tried to make netconsole work (with the attached patch copied from e1000), but can't get anything on the cable... the destination station doesn't see anything (nor Ethereal).

Are there any traps I didn't see ? (I have netconsole as a module and it loads ok:
netconsole: local port 32768
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 192.168.0.4
netconsole: remote ethernet address 08:00:20:76:3c:57
netconsole: local IP 192.168.0.11
netconsole: network logging started
)

TIA,
--
Colin

--Multipart=_Wed__19_May_2004_22_10_56_+0200_.qPpE7n2W6fHYYSV
Content-Type: text/plain;
 name="sungem.diff"
Content-Disposition: attachment;
 filename="sungem.diff"
Content-Transfer-Encoding: 7bit

--- drivers/net/sungem.c.orig	2004-05-19 20:47:15.000000000 +0200
+++ drivers/net/sungem.c	2004-05-19 22:09:25.920632936 +0200
@@ -2441,6 +2441,22 @@
 	return 0;
 }

+#ifdef CONFIG_NET_POLL_CONTROLLER
+/*
+ * Polling 'interrupt' - used by things like netconsole to send skbs
+ * without having to re-enable interrupts. It's not called while
+ * the interrupt routine is executing.
+ */
+
+static void gem_poll(struct net_device *dev)
+{
+	struct gem *gp = dev->priv;
+	disable_irq(gp->pdev->irq);
+	gem_interrupt(gp->pdev->irq, (void *)dev, NULL);
+	enable_irq(gp->pdev->irq);
+}
+#endif
+
 static int gem_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
 {
 	struct gem *gp = dev->priv;
@@ -2810,6 +2826,9 @@
 	dev->change_mtu = gem_change_mtu;
 	dev->irq = pdev->irq;
 	dev->dma = 0;
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	dev->poll_controller = gem_poll;
+#endif

 	if (register_netdev(dev)) {
 		printk(KERN_ERR PFX "Cannot register net device, "

--Multipart=_Wed__19_May_2004_22_10_56_+0200_.qPpE7n2W6fHYYSV--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
