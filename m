Return-Path: <jdaniel@adventnetworks.com>
Received: from advcorp-exc01.advent.com (rrcs-24-153-228-72.sw.biz.rr.com
	[24.153.228.72]) by ozlabs.org (Postfix) with ESMTP id 8FC4C67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jan 2005 05:38:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Date: Wed, 19 Jan 2005 12:30:44 -0600
Message-ID: <D10E8F42CD2F1C4B93F482091D0E13320C1C66@advcorp-exc01.advent.com>
From: "Johns Daniel" <jdaniel@adventnetworks.com>
To: "linuxppc" <linuxppc-embedded@ozlabs.org>
Subject: RE: Kernel boot hangs by parallel flood pings
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have had better luck with the following fcc_enet.c patch (against the =
ELDK 2.4.4 kernel):

~~~~~~~~~~~~~
1.) In static void mii_display_status(struct net_device *dev):
=20
 	if (!fep->link && !fep->old_link) {
 		/* Link is still down - don't print anything */
 		return;
 	}
=20
	printk("%s: status: ", dev->name);
=20
 	if (!fep->link) {
+        netif_carrier_off(dev);
		printk("link down");
 	} else {
+        netif_carrier_on(dev);
		printk("link up");
=20
 		switch(s & PHY_STAT_SPMASK) {
~~~~~~~~~~~~~

2.) In fcc_enet_open(struct net_device *dev):

 		mii_do_cmd(dev, fep->phy->startup);
 #ifdef	CONFIG_PM826
 		/* Read the autonegotiation results */
 		mii_do_cmd(dev, fep->phy->ack_int);
 		mii_do_cmd(dev, phy_cmd_relink);
 #endif	/* CONFIG_PM826 */
+        if (fep->link) {
+            netif_carrier_on(dev);
+        } else {
+            netif_carrier_off(dev);
+        }
 		netif_start_queue(dev);
 		return 0;		/* Success */
 	}
 	return -ENODEV;		/* No PHY we understand */
 #else
 	fep->link =3D 1;
~~~~~~~~~~~~~

This communicates the link status to the kernel TCP/IP stack. Obviously, =
this assumes that MDIO is working!

-- Johns Daniel, Advent Networks, Inc.

-----Original Message-----
From:	linuxppc-embedded-bounces@ozlabs.org on behalf of Ho Lee
Sent:	Wed 1/12/2005 6:14 PM
To:	'linuxppc'
Cc:	'Steffen Rumler'
Subject:	RE: Kernel boot hangs by parallel flood pings



-----Original Message-----
From:	linuxppc-embedded-bounces@ozlabs.org on behalf of Ho Lee
Sent:	Wed 1/12/2005 6:14 PM
To:	'linuxppc'
Cc:	'Steffen Rumler'
Subject:	RE: Kernel boot hangs by parallel flood pings

I met the same problem in CPM driver, and there could be many=20
solutions. I think the right place to fix is the fec driver.=20
The fec driver registers interrupt handler during the=20
initialization not when the device is opened, so it may
receive packets even the device is not up and running (also=20
before the network subsystem is initialized) My fix was to=20
ignore the received packets if the driver is not opened.=20

--- linux-2.4.26.orig/arch/ppc/8xx_io/fec.c
+++ linux-2.4.26/arch/ppc/8xx_io/fec.c=20
@@ -587,6 +587,9 @@
                goto rx_processing_done;
        }
=20
+       if (!netif_running(dev))
+           goto rx_processing_done;
+
        /* Process the incoming frame.
         */
        fep->stats.rx_packets++;


Regards,
Ho

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Rune =
Torgersen
Sent: Wednesday, January 12, 2005 7:32 AM
To: Steffen Rumler; linuxppc
Subject: RE: Kernel boot hangs by parallel flood pings

--- Kernel.old/net/ipv4/ip_output.c     Thu Jun  5 09:00:39 2003
+++ Kernel/net/ipv4/ip_output.c Thu Jun  5 09:00:28 2003
@@ -1087,11 +1087,11 @@

 void __init ip_init(void)
 {
-       dev_add_pack(&ip_packet_type);
-
        ip_rt_init();
        inet_initpeers();

+       dev_add_pack(&ip_packet_type);
+
 #ifdef CONFIG_IP_MULTICAST
        proc_net_create("igmp", 0, ip_mc_procinfo);
 #endif
>>


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
