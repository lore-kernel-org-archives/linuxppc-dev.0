Subject: [PATCH] MPC85XX TSEC driver: adapter identify
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="=-BMh/0OM6TAbidsDNF5rz"
Message-Id: <1088507077.4836.42.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Tue, 29 Jun 2004 13:04:37 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-BMh/0OM6TAbidsDNF5rz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This adds support for the "-p" option to ethtool with the Marvell
and Intel PHYs:

 -p     initiates adapter-specific action intended to enable an operator
        to  easily  identify  the  adapter  by  sight.   typically  this
        involves  blinking  one  or  more  LEDs on the specific ethernet
        port.

It's mostly borrowed from the e1000 driver, and I would perfectly
understand if it doesn't make it in right away :)

Again, it's hand-edited, I'll send the full files on request.

--
Stefan Nickl
Kontron Modular Computers


--=-BMh/0OM6TAbidsDNF5rz
Content-Disposition: attachment; filename=gfar_gianfar_ethtool_c_identify.patch
Content-Type: text/x-patch; name=gfar_gianfar_ethtool_c_identify.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar_ethtool.c	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar_ethtool.c	2004-06-29 11:57:43.000000000 +0200
@@ -245,6 +245,52 @@
 	memcpy(buf, stat_gstrings, GFAR_STATS_LEN * ETH_GSTRING_LEN);
 }

+/* toggle LED 4 times per second = 2 "blinks" per second */
+#define GFAR_ID_INTERVAL       (HZ/4)
+
+/* bit defines for priv->led_status */
+#define GFAR_LED_ON            0
+
+static void gfar_led_blink_callback(unsigned long data)
+{
+	struct net_device *dev = (struct net_device *) data;
+	struct gfar_private *priv = (struct gfar_private *) dev->priv;
+
+	if(test_and_change_bit(GFAR_LED_ON, &priv->led_status))
+		phy_run_commands(dev, priv->phyinfo->off_leds);
+	else
+		phy_run_commands(dev, priv->phyinfo->on_leds);
+
+	mod_timer(&priv->blink_timer, jiffies + GFAR_ID_INTERVAL);
+}
+
+/* Blink LEDs to enable an operator to easily identify the adapter by sight */
+static int gfar_phys_id(struct net_device *dev, u32 data)
+{
+	struct gfar_private *priv = (struct gfar_private *) dev->priv;
+
+	if(!data || data > (uint32_t)(MAX_SCHEDULE_TIMEOUT / HZ))
+		data = (uint32_t)(MAX_SCHEDULE_TIMEOUT / HZ);
+
+	if(!priv->blink_timer.function) {
+		init_timer(&priv->blink_timer);
+		priv->blink_timer.function = gfar_led_blink_callback;
+		priv->blink_timer.data = (unsigned long) dev;
+	}
+
+	mod_timer(&priv->blink_timer, jiffies);
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	schedule_timeout(data * HZ);
+	del_timer_sync(&priv->blink_timer);
+
+	clear_bit(GFAR_LED_ON, &priv->led_status);
+	phy_run_commands(dev, priv->phyinfo->setup_leds);
+
+	return 0;
+}
+
 /* Convert microseconds to ethernet clock ticks, which changes
  * depending on what speed the controller is running at */
 static unsigned int gfar_usecs2ticks(struct gfar_private *priv, unsigned int usecs)
@@ -479,6 +525,7 @@
 	.get_ringparam = gfar_gringparam,
 	.set_ringparam = gfar_sringparam,
 	.get_strings = gfar_gstrings,
+	.phys_id = gfar_phys_id,
 	.get_stats_count = gfar_stats_count,
 	.get_ethtool_stats = gfar_fill_stats,
 };

--=-BMh/0OM6TAbidsDNF5rz
Content-Disposition: attachment; filename=gfar_gianfar_h_identify.patch
Content-Type: text/x-patch; name=gfar_gianfar_h_identify.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar.h	2004-06-14 08:44:05.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar.h	2004-06-29 10:15:21.000000000 +0200
@@ -512,6 +512,8 @@
 	int olddplx;
 	int speed;	/* Indicates negotiated speed */
 	int oldspeed;
+	struct timer_list blink_timer;
+	unsigned long led_status;

 	/* Info structure initialized by board setup code */
 	struct ocp_gfar_data *einfo;


--=-BMh/0OM6TAbidsDNF5rz
Content-Disposition: attachment; filename=gfar_gianfar_phy_c_identify.patch
Content-Type: text/x-patch; name=gfar_gianfar_phy_c_identify.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar_phy.c	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar_phy.c	2004-06-29 11:59:54.000000000 +0200
@@ -271,6 +294,23 @@
 		{MIIM_88E1011_IMASK, MIIM_88E1011_IMASK_CLEAR, NULL},
 		{miim_end,}
 	},
+	(const struct phy_cmd[]) {	/* setup_leds */
+                /* set all LEDs into normal mode */
+		{MIIM_88E1011_PHY_LEDMAN, 0x0000, NULL},
+#ifdef CONFIG_GFAR_EBC_XDUAL
+		/* LED combined mode 01 + TX LED becomes Activity/Link */
+		{MIIM_88E1011_PHY_LED, MIIM_88E1011_PHYLED_COMB01 | 0x01, NULL},
+#endif
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* on_leds */
+		{MIIM_88E1011_PHY_LEDMAN, 0x0fff, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* off_leds */
+		{MIIM_88E1011_PHY_LEDMAN, 0x0aaa, NULL},
+		{miim_end,}
+	},
 };

 /* Cicada 8204 */
@@ -404,11 +444,70 @@
 	},
 };

+	(const struct phy_cmd[]) {	/* setup_leds */
+		{MIIM_LXT971_LED, 0x0422, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* on_leds */
+		{MIIM_LXT971_LED, 0x8882, NULL},
+		{miim_end,}
+	},
+	(const struct phy_cmd[]) {	/* off_leds */
+		{MIIM_LXT971_LED, 0x9992, NULL},
+		{miim_end,}
+	},
+};
+
+
@@ -458,6 +560,9 @@
 	struct gfar_private *priv = (struct gfar_private *) dev->priv;
 	volatile struct gfar *phyregs = priv->phyregs;

+	if(!cmd)
+		return;
+
 	/* Reset the management interface */
 	gfar_write(&phyregs->miimcfg, MIIMCFG_RESET);


--=-BMh/0OM6TAbidsDNF5rz
Content-Disposition: attachment; filename=gfar_gianfar_phy_h_identify.patch
Content-Type: text/x-patch; name=gfar_gianfar_phy_h_identify.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar_phy.h	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar_phy.h	2004-06-29 10:10:38.000000000 +0200
@@ -94,6 +94,12 @@
 #define MIIM_88E1011_IMASK_INIT		0x6400
 #define MIIM_88E1011_IMASK_CLEAR	0x0000

+#define MIIM_88E1011_PHY_LEDMAN         0x19
+
+
 /* DM9161 Control register values */
 #define MIIM_DM9161_CR_STOP	0x0400
 #define MIIM_DM9161_CR_RSTAN	0x1200
@@ -127,6 +133,22 @@
 #define MIIM_DM9161_10BTCSR	0x12
 #define MIIM_DM9161_10BTCSR_INIT	0x7800

 /* LXT971 PHY Status Register #2 */
 #define MIIM_LXT971_SR2         0x11
 #define MIIM_LXT971_SR2_SPEED   0x4000
 #define MIIM_LXT971_SR2_DUPLEX  0x0200

 /* LXT971 PHY Interrupt Enable Register */
 #define MIIM_LXT971_IER         0x12
 #define MIIM_LXT971_IER_INIT    0x00f2
 #define MIIM_LXT971_IER_CLEAR   0x0000

 /* LXT971 PHY Interrupt Status Register */
 #define MIIM_LXT971_ISR         0x13
+
+/* LXT971 PHY LED Configuration Register */
+#define MIIM_LXT971_LED         0x14
+#define MIIM_LXT971_LED         0x14

 #define MIIM_READ_COMMAND       0x00000001

@@ -184,6 +206,10 @@
     /* Called when bringing down the controller.  Usually stops
      * the interrupts from being generated */
     const struct phy_cmd *shutdown;
+
+    const struct phy_cmd *setup_leds;
+    const struct phy_cmd *on_leds;
+    const struct phy_cmd *off_leds;
 };

 struct phy_info *get_phy_info(struct net_device *dev);

--=-BMh/0OM6TAbidsDNF5rz
Content-Disposition: attachment; filename=gfar_gianfar_c_identify.patch
Content-Type: text/x-patch; name=gfar_gianfar_c_identify.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linuxppc-2.4/drivers/net/gianfar.c	2004-05-18 14:29:35.000000000 +0200
+++ linuxppc-2.4_85xx/drivers/net/gianfar.c	2004-06-29 10:17:21.000000000 +0200
@@ -387,6 +387,7 @@

 	/* Run the commands which configure the PHY */
 	phy_run_commands(dev, curphy->config);
+	phy_run_commands(dev, curphy->setup_leds);

 	return 0;
 }


--=-BMh/0OM6TAbidsDNF5rz--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
