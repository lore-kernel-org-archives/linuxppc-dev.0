Return-Path: <marny@rambler.ru>
Received: from ns.tz.ru (ns.tz.ru [194.149.234.1])
	by ozlabs.org (Postfix) with ESMTP id 793B467DCC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 22:34:19 +1000 (EST)
Received: from localhost (localhost.tz.ru [127.0.0.1])
	by ns.tz.ru (Postfix) with ESMTP id 5EF49173B3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 16:03:45 +0400 (MSD)
Received: from ns.tz.ru ([127.0.0.1])
	by localhost (ns.tz.ru [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21139-08 for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 16:03:22 +0400 (MSD)
Received: from marnat.intranet.tz.ru (marnat.intranet.tz.ru [90.0.0.18])
	by ns.tz.ru (Postfix) with ESMTP id D249D173AC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 16:03:22 +0400 (MSD)
From: Igor Marnat <marny@rambler.ru>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 28 Jul 2005 16:03:22 +0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507281603.22332.marny@rambler.ru>
Subject: eth1 on linux 2.4.25 from ELDK 3.1.1 becomes slowly when is pinged
	by great packets
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list!
I tried to work with kernel 2.4.25 from ELDK 3.1.1 from Denx. My board is 
PPChameleon EVB (PPC 405 EP). First, the kernel even didn't compile as is for 
this architecture, I've forced to made changes (see the patch below) to be 
able to build the kernel for this board. Now I'm experiencing the following 
problem: I've inited both interfaces (eth0 and eth1). When I ping eth1 with 
small packet (less that 2k), it works fine. When I ping eth1 with the packets 
of size greater that 2k, time of responce becomes about n * 1000 
milliseconds. I.e., ping writes me: 

3008 bytes from 90.0.0.139: icmp_seq=1 ttl=64 time=3001 ms
3008 bytes from 90.0.0.139: icmp_seq=2 ttl=64 time=3002 ms
...
3008 bytes from 90.0.0.139: icmp_seq=6 ttl=64 time=3003 ms
3008 bytes from 90.0.0.139: icmp_seq=7 ttl=64 time=3003 ms


Sometimes it is 2000 ms, sometimes it is 1000 ms, but it's always like this. 
After it was one time pinged by the great packets, it'll responce in such a 
fashion allways, even when is pinged by the smapll packets. Once crashed, it 
is crashed till it is reinited. To make it work normally once again, I do:
#ifconfig eth1 down
#ifconfig eth1 up

and it helps, i.e. after reinitialization eth1 work normally. Eth0 works fine 
anyway with pings of any sizes. What is the status of PPChameleon in ELDK 
3.1.1? Is it supported in general? Any ideas or suggestions? I've searched 
the archives and tried the patches of Matt Porter (of Mar 3, about jumbo 
packets size), but it didn't help. 

Regards,
Igor Marnat


diff -uprN -X dontdiff linux-2.4.25/arch/ppc/platforms/ibm405ep.c 
linux-2.4.25-07-mar-2005/arch/ppc/platforms/ibm405ep.c
--- linux-2.4.25/arch/ppc/platforms/ibm405ep.c  2003-11-11 19:33:37.000000000 
+0300
+++ linux-2.4.25-07-mar-2005/arch/ppc/platforms/ibm405ep.c      2005-07-28 
14:25:21.000000000 +0400
@@ -31,6 +31,7 @@ static struct ocp_func_emac_data ibm405e
        .mal_tx1_chan   = 0,            /* MAL tx channel 1 number */
        .mal_tx2_chan   = 1,            /* MAL tx channel 2 number */
        .wol_irq        = BL_MAC_WOL,   /* WOL interrupt number */
+       .jumbo          = 0,
        .mdio_idx       = -1,           /* No shared MDIO */
 };

@@ -43,6 +44,7 @@ static struct ocp_func_emac_data ibm405e
        .mal_tx1_chan   = 2,            /* MAL tx channel 1 number */
        .mal_tx2_chan   = 3,            /* MAL tx channel 2 number */
        .wol_irq        = BL_MAC_WOL,   /* WOL interrupt number */
+       .jumbo          = 0,
        .mdio_idx       = -1,           /* No shared MDIO */
 };

diff -uprN -X dontdiff linux-2.4.25/drivers/mtd/nand/ppchameleonevb.c 
linux-2.4.25-07-mar-2005/drivers/mtd/nand/ppchameleonevb.c
--- linux-2.4.25/drivers/mtd/nand/ppchameleonevb.c      2004-05-29 
19:46:27.000000000 +0400
+++ linux-2.4.25-07-mar-2005/drivers/mtd/nand/ppchameleonevb.c  2005-07-28 
14:35:06.000000000 +0400
@@ -58,12 +58,30 @@ __setup("ppchameleonevb_fio_pbase=",ppch
 /*
  * Define static partitions for flash device
  */
+/*
 static struct mtd_partition partition_info[] = {
        { name: "PPChameleonEVB Nand Flash",
                  offset: 0,
                  size: 32*1024*1024 }
 };
 #define NUM_PARTITIONS 1
+*/
+/*
+ * Define static partitions for flash device
+ */
+static struct mtd_partition partition_info[] = {
+       { name: "PPChameleonEVB NAND flash main part",
+                 offset: 0,
+                 size: 24*1024*1024 },
+       { name: "PPChameleonEVB Nand Flash etc part",
+                 offset: 24*1024*1024,
+                 size: 4*1024*1024 },
+       { name: "PPChameleonEVB Nand Flash var part",
+                 offset: (24 + 4)*1024*1024,
+                 size: 4*1024*1024 }
+
+};
+#define NUM_PARTITIONS 3
 #endif


diff -uprN -X dontdiff linux-2.4.25/drivers/net/ibm_emac/ibm_ocp_enet.c 
linux-2.4.25-07-mar-2005/drivers/net/ibm_emac/ibm_ocp_enet.c
--- linux-2.4.25/drivers/net/ibm_emac/ibm_ocp_enet.c    2005-01-17 
18:39:43.000000000 +0300
+++ linux-2.4.25-07-mar-2005/drivers/net/ibm_emac/ibm_ocp_enet.c        
2005-07-28 15:30:12.000000000 +0400
@@ -1042,7 +1042,7 @@ emac_adjust_to_link(struct ocp_enet_priv
        /* set speed (default is 10Mb) */
     switch(speed) {
        case SPEED_1000:
-               mode_reg |= EMAC_M1_JUMBO_ENABLE | EMAC_M1_RFS_16K;
+               mode_reg |= EMAC_M1_JUMBO_ENABLE /*| EMAC_M1_RFS_16K */;
                if (fep->rgmii_dev) {
                        struct ibm_ocp_rgmii *rgmii = 
RGMII_PRIV(fep->rgmii_dev);

@@ -1264,7 +1264,7 @@ emac_init_rings(struct net_device *dev)
        int loop;

        ep->tx_desc = (struct mal_descriptor *) ((char *) 
ep->mal->tx_virt_addr +
-                                     (ep->mal_tx_chan * MAL_DT_ALIGN));
+                                     (ep->mal_tx1_chan * MAL_DT_ALIGN));
        ep->rx_desc = (struct mal_descriptor *) ((char *) 
ep->mal->rx_virt_addr +
                                      (ep->mal_rx_chan * MAL_DT_ALIGN));

@@ -1281,7 +1281,9 @@ emac_init_rings(struct net_device *dev)

        /* Format the receive descriptor ring. */
        ep->rx_slot = 0;
-       ep->rx_buffer_size = ENET_DEF_BUF_SIZE;
+       //ep->rx_buffer_size = ENET_DEF_BUF_SIZE;
+       ep->rx_buffer_size =
+               dev->mtu + ENET_HEADER_SIZE + ENET_FCS_SIZE;
        emac_rx_fill(dev, 0);
        if (ep->rx_slot != 0) {
                printk(KERN_ERR
@@ -1752,11 +1754,12 @@ static int emac_init_device(struct ocp_d

        /* Fill out MAL informations and register commac */
        ep->mal = mal;
-       ep->mal_tx_chan = emacdata->mal_tx_chan;
+       ep->mal_tx1_chan = emacdata->mal_tx1_chan;
+       ep->mal_tx2_chan = emacdata->mal_tx2_chan;
        ep->mal_rx_chan = emacdata->mal_rx_chan;
        ep->commac.ops = &emac_commac_ops;
        ep->commac.dev = ndev;
-       ep->commac.tx_chan_mask = MAL_CHAN_MASK(ep->mal_tx_chan);
+       ep->commac.tx_chan_mask = MAL_CHAN_MASK(ep->mal_tx1_chan) | 
MAL_CHAN_MASK(ep->mal_tx2_chan);
        ep->commac.rx_chan_mask = MAL_CHAN_MASK(ep->mal_rx_chan);
        rc = mal_register_commac(ep->mal, &ep->commac);
        if (rc != 0)
diff -uprN -X dontdiff linux-2.4.25/drivers/net/ibm_emac/ibm_ocp_enet.h 
linux-2.4.25-07-mar-2005/drivers/net/ibm_emac/ibm_ocp_enet.h
--- linux-2.4.25/drivers/net/ibm_emac/ibm_ocp_enet.h    2005-01-17 
18:39:43.000000000 +0300
+++ linux-2.4.25-07-mar-2005/drivers/net/ibm_emac/ibm_ocp_enet.h        
2005-07-28 13:59:14.000000000 +0400
@@ -158,7 +158,7 @@ struct ocp_enet_private {
        int zmii_input;

        struct ibm_ocp_mal *mal;
-       int mal_tx_chan, mal_rx_chan;
+       int mal_tx1_chan, mal_tx2_chan, mal_rx_chan;
        struct mal_commac commac;

     struct ocp_device *tah_dev;
diff -uprN -X dontdiff linux-2.4.25/include/asm-ppc/ibm4xx.h 
linux-2.4.25-07-mar-2005/include/asm-ppc/ibm4xx.h
--- linux-2.4.25/include/asm-ppc/ibm4xx.h       2005-01-17 18:39:44.000000000 
+0300
+++ linux-2.4.25-07-mar-2005/include/asm-ppc/ibm4xx.h   2005-07-28 
13:31:13.000000000 +0400
@@ -25,7 +25,7 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-extern bd_t  __res;
+extern unsigned char __res[];
 #endif

 /* Device Control Registers */
diff -uprN -X dontdiff linux-2.4.25/include/asm-ppc/ocp_ids.h 
linux-2.4.25-07-mar-2005/include/asm-ppc/ocp_ids.h
--- linux-2.4.25/include/asm-ppc/ocp_ids.h      2005-01-17 18:39:44.000000000 
+0300
+++ linux-2.4.25-07-mar-2005/include/asm-ppc/ocp_ids.h  2005-07-28 
13:46:40.000000000 +0400
@@ -112,7 +112,8 @@
                int     zmii_mux;       /* ZMII input of this EMAC */
                int     mal_idx;        /* MAL device index */
                int     mal_rx_chan;    /* MAL rx channel number */
-               int     mal_tx_chan;    /* MAL tx channel 1 number */
+               int     mal_tx1_chan;   /* MAL tx channel 1 number */
+               int     mal_tx2_chan;   /* MAL tx channel 2 number */
                int     wol_irq;        /* WOL interrupt */
                int     mdio_idx;       /* EMAC idx of MDIO master or -1 */
                int     tah_idx;        /* TAH device index or -1 */
