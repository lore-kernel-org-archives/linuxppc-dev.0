Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D09F0DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 22:52:45 +1100 (EST)
In-Reply-To: <2a27d3730903270350m52fcb837ge78c0b87cc3887d5@mail.gmail.com>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2a27d3730903270350m52fcb837ge78c0b87cc3887d5@mail.gmail.com>
To: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] ucc_geth: Move freeing of TX packets to NAPI context.
Message-ID: <OF073D5C49.F0D791DE-ONC1257586.0040163D-C1257586.00413F47@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 27 Mar 2009 12:52:41 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, pku.leo@gmail.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pku.leo@gmail.com wrote on 27/03/2009 11:50:09:
> 
> On Thu, Mar 26, 2009 at 8:54 PM, Joakim Tjernlund
> <Joakim.Tjernlund@transmode.se> wrote:
> > Also set NAPI weight to 64 as this is a common value.
> > This will make the system alot more responsive while
> > ping flooding the ucc_geth ethernet interaface.
> >
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > ---
> >        /* Errors and other events */
> >        if (ucce & UCCE_OTHER) {
> >                if (ucce & UCC_GETH_UCCE_BSY)
> > @@ -3733,7 +3725,7 @@ static int ucc_geth_probe(struct of_device* 
ofdev, const struct of_device_id *ma
> >        dev->netdev_ops = &ucc_geth_netdev_ops;
> >        dev->watchdog_timeo = TX_TIMEOUT;
> >        INIT_WORK(&ugeth->timeout_work, ucc_geth_timeout_work);
> > -       netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, 
UCC_GETH_DEV_WEIGHT);
> > +       netif_napi_add(dev, &ugeth->napi, ucc_geth_poll, 64);
> 
> It doesn't make sense to have larger napi budget than the size of RX
> BD ring.  You can't have more BDs than RX_BD_RING_LEN in backlog for
> napi_poll to process.  Increase the RX_BD_RING_LEN if you want to
> increase UCC_GETH_DEV_WEIGHT.  However please also provide the
> performance comparison for this kind of change.  Thanks

Bring it up with David Miller. After my initial attempt to just increase
weight somewhat, he requested that I hardcoded it to 64. Just read the 
whole thread.
If I don't increase weight somewhat, ping -f -l 3 almost halts the board. 
Logging
in takes forever. These are my "performance numbers".

weight theory:
Before the drivers gets to the end of a full BD ring, new pkgs arrives so 
that
even if the DB ring is only 16, the driver wants to process 17 or more 
pkgs.
