Message-Id: <5.1.0.14.2.20021119234016.021989c8@pop.prodigy.net>
Date: Tue, 19 Nov 2002 23:50:43 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: Suspicious sequence of code in ibm_ocp_enet.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I found a strange sequence of code in ppc405_enet_open (devel_2_4 & devel_2_5).

init_rings is called _AFTER_ enabling MAL tx and rx channels:

static int
ppc405_enet_open(struct net_device *dev)
{

        ... some code skipped ...

         /* enable all MAL transmit and receive channels */
         enable_mal_chan(fep);

         /* set transmit and receive enable */
         out_be32(&emacp->em0mr0, EMAC_M0_TXE | EMAC_M0_RXE);

         init_rings(dev);

        netif_start_queue(dev);
         printk(KERN_NOTICE "%s: IBM EMAC: open completed\n\n", dev->name);

         return 0;
}

I suspect that this can cause some trouble during opening the device if a
packet arrives just after enabling rx channel but before init_rings is
executed. Frankly, I'm pretty sure that this causes infrequent crashes on
our custom 405GP board.

I'd move call to init_rings(dev) just before enable_mal_chan(fep);

Any ideas, suggestions ?

Thanks,


  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
