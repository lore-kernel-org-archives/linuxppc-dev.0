Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 90F0D67A67
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2005 10:00:43 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 7 Mar 2005 15:54:01 -0700
To: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Message-ID: <20050307225401.GA31041@xyzzy>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
Subject: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 07, 2005 at 12:57:39PM +0000, Nicolas DET wrote:
> Hello James,
> > - why do you need to use SA_SHIRQ in the ethernet driver?
> 
> Because the IRQ we use for ethernet is shared with others devices.

I've included an untested patch below that adds support for passing
IRQ flags via platform device.

For the pegasos 2, you'll need the second patch which applies after
the one I previously sent for chrp_setup.c.

Sven + Nicolas, please let me know if this compiles/works for you.

Thanks,
-Dale


------------------------- Begin IRQ_flags Patch --------------------------
mv643xx: support passing ethernet IRQ flags via platform device

This patch adds a field to struct mv643xx_eth_platform_data for
passing the IRQ flags value that is passed to request_irq.

Default value is (SA_INTERRUPT | SA_SAMPLE_RANDOM).

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.5-enet/drivers/net/mv643xx_eth.h
===================================================================
--- linux-2.5-enet.orig/drivers/net/mv643xx_eth.h
+++ linux-2.5-enet/drivers/net/mv643xx_eth.h
@@ -328,6 +328,7 @@
 	u32 port_config_extend;		/* User port config extend value*/
 	u32 port_sdma_config;		/* User port SDMA config value	*/
 	u32 port_serial_control;	/* User port serial control value */
+	u32 irq_flags;			/* Flags for request_irq	*/
 	u32 port_tx_queue_command;	/* Port active Tx queues summary*/
 	u32 port_rx_queue_command;	/* Port active Rx queues summary*/
 
Index: linux-2.5-enet/include/linux/mv643xx.h
===================================================================
--- linux-2.5-enet.orig/include/linux/mv643xx.h
+++ linux-2.5-enet/include/linux/mv643xx.h
@@ -1302,6 +1302,7 @@
 	u32		port_config_extend;
 	u32		port_sdma_config;
 	u32		port_serial_control;
+	u32		irq_flags;
 	u32		tx_queue_size;
 	u32		rx_queue_size;
 	u32		tx_sram_addr;
Index: linux-2.5-enet/drivers/net/mv643xx_eth.c
===================================================================
--- linux-2.5-enet.orig/drivers/net/mv643xx_eth.c
+++ linux-2.5-enet/drivers/net/mv643xx_eth.c
@@ -667,8 +667,8 @@
 
 	spin_lock_irq(&mp->lock);
 
-	err = request_irq(dev->irq, mv643xx_eth_int_handler,
-			SA_INTERRUPT | SA_SAMPLE_RANDOM, dev->name, dev);
+	err = request_irq(dev->irq, mv643xx_eth_int_handler, mp->irq_flags,
+			  dev->name, dev);
 
 	if (err) {
 		printk(KERN_ERR "Can not assign IRQ number to MV643XX_eth%d\n",
@@ -1427,6 +1427,7 @@
 	mp->port_config_extend = MV643XX_ETH_PORT_CONFIG_EXTEND_DEFAULT_VALUE;
 	mp->port_sdma_config = MV643XX_ETH_PORT_SDMA_CONFIG_DEFAULT_VALUE;
 	mp->port_serial_control = MV643XX_ETH_PORT_SERIAL_CONTROL_DEFAULT_VALUE;
+	mp->irq_flags = SA_INTERRUPT | SA_SAMPLE_RANDOM;
 	mp->rx_ring_size = MV643XX_ETH_PORT_DEFAULT_RECEIVE_QUEUE_SIZE;
 	mp->tx_ring_size = MV643XX_ETH_PORT_DEFAULT_TRANSMIT_QUEUE_SIZE;
 
@@ -1450,6 +1451,9 @@
 		if (pd->port_serial_control || pd->force_port_serial_control)
 			mp->port_serial_control = pd->port_serial_control;
 
+		if (pd->irq_flags)
+			mp->irq_flags = pd->irq_flags;
+
 		if (pd->rx_queue_size)
 			mp->rx_ring_size = pd->rx_queue_size;
 
------------------------- End IRQ_flags Patch --------------------------

------------------------- Begin chrp_setup Patch --------------------------
Index: linux-2.5-enet/arch/ppc/platforms/chrp_setup.c
===================================================================
--- linux-2.5-enet.orig/arch/ppc/platforms/chrp_setup.c
+++ linux-2.5-enet/arch/ppc/platforms/chrp_setup.c
@@ -246,7 +246,9 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth0_pd;
+static struct mv643xx_eth_platform_data eth0_pd = {
+	.irq_flags	= SA_SHIRQ | SA_SAMPLE_RANDOM;
+};
 
 static struct platform_device eth0_device = {
 	.name		= MV643XX_ETH_NAME,
@@ -267,7 +269,9 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth1_pd;
+static struct mv643xx_eth_platform_data eth1_pd = {
+	.irq_flags	= SA_SHIRQ | SA_SAMPLE_RANDOM;
+};
 
 static struct platform_device eth1_device = {
 	.name		= MV643XX_ETH_NAME,
------------------------- End chrp_setup Patch --------------------------
