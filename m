Message-Id: <5.1.0.14.2.20021120212220.00aebfa0@pop.prodigy.net>
Date: Wed, 20 Nov 2002 21:47:34 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: [PATCH] correct initialization sequence in ppc405_enet_open
Cc: David Gibson <david@gibson.dropbear.id.au>,
	Armin Kuster <akuster@dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

This patch fixes problem in drivers/net/ibm_ocp/ibm_ocp_enet.c.
Ring buffers initialization (init_rings) is called _after_ enabling MAL rx
channel.
If a packet arrives just after MAL was enabled but before init_rings
initialized buffers, you can see random crashes during EMAC open or receive
descriptor error interrupt.

This bug affects all systems that use drivers/net/ibm_ocp/ibm_ocp_enet.c
(405GP based, 440GP based, etc).
This patch is against current devel_2_4, but I think should apply without
any problems to devel_2_5 also.

Thanks.

===== drivers/net/ibm_ocp/ibm_ocp_enet.c 1.55 vs edited =====
--- 1.55/drivers/net/ibm_ocp/ibm_ocp_enet.c     Thu Aug 22 11:29:32 2002
+++ edited/drivers/net/ibm_ocp/ibm_ocp_enet.c   Wed Nov 20 21:34:30 2002
@@ -375,13 +375,15 @@
                 request_irq(BL_MAL_RXEOB,ppc405_eth_rxeob,0,"OCP EMAC RX
EOB",dev);
         }

-       /* enable all MAL transmit and receive channels */
+       /* init buffer descriptors rings */
+       init_rings(dev);

+       /* enable all MAL transmit and receive channels */
         enable_mal_chan(fep);

         /* set transmit and receive enable */
         out_be32(&emacp->em0mr0, EMAC_M0_TXE | EMAC_M0_RXE);
-       init_rings(dev);
+
         netif_start_queue(dev);
         printk(KERN_NOTICE "%s: IBM EMAC: open completed\n\n", dev->name);



  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
