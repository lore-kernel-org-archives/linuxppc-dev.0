Date: Wed, 20 Nov 2002 10:32:08 -0500
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Suspicious sequence of code in ibm_ocp_enet.c
Message-ID: <20021120153208.GU27929@zax.zax>
References: <5.1.0.14.2.20021119234016.021989c8@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20021119234016.021989c8@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 19, 2002 at 11:50:43PM -0800, Eugene Surovegin wrote:
>
> Hi!
>
> I found a strange sequence of code in ppc405_enet_open (devel_2_4 &
> devel_2_5).
>
> init_rings is called _AFTER_ enabling MAL tx and rx channels:
>
> static int
> ppc405_enet_open(struct net_device *dev)
> {
>
>        ... some code skipped ...
>
>         /* enable all MAL transmit and receive channels */
>         enable_mal_chan(fep);
>
>         /* set transmit and receive enable */
>         out_be32(&emacp->em0mr0, EMAC_M0_TXE | EMAC_M0_RXE);
>
>         init_rings(dev);
>
>        netif_start_queue(dev);
>         printk(KERN_NOTICE "%s: IBM EMAC: open completed\n\n", dev->name);
>
>         return 0;
> }
>
> I suspect that this can cause some trouble during opening the device if a
> packet arrives just after enabling rx channel but before init_rings is
> executed. Frankly, I'm pretty sure that this causes infrequent crashes on
> our custom 405GP board.
>
> I'd move call to init_rings(dev) just before enable_mal_chan(fep);
>
> Any ideas, suggestions ?

It certainly looks dodgy.  Try changing it and see what happens.  Then
send a patch :-)

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
