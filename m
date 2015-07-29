Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2330E1A0DA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 07:10:10 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Claudiu Manoil <claudiu.manoil@freescale.com>
Subject: Re: [PATCH] gianfar: Fix warnings when built on 64-bit
Date: Wed, 29 Jul 2015 23:04:46 +0200
Message-ID: <2331012.mZ9bDLS4JC@wuerfel>
In-Reply-To: <1438185761.2993.333.camel@freescale.com>
References: <1438147477-393-1-git-send-email-scottwood@freescale.com>
 <4498062.4y369pLSmO@wuerfel> <1438185761.2993.333.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 29 July 2015 11:02:41 Scott Wood wrote:
> On Wed, 2015-07-29 at 10:02 +0200, Arnd Bergmann wrote:
> > On Wednesday 29 July 2015 00:24:37 Scott Wood wrote:
> > > +#ifdef CONFIG_PM
> > >  static void lock_tx_qs(struct gfar_private *priv)
> > >  {
> > >     int i;
> > > @@ -580,6 +581,7 @@ static void unlock_tx_qs(struct gfar_private *priv)
> > >     for (i = 0; i < priv->num_tx_queues; i++)
> > >             spin_unlock(&priv->tx_queue[i]->txlock);
> > >  }
> > > +#endif
> > >  
> > 
> > This seems unrelated and should probably be a separate fix.
> 
> It's related in that it fixes a warning -- the 64-bit build didn't have 
> CONFIG_PM -- though I should have been clearer about that in the changelog.

Yes, that's what I meant: you can easily have a 32-bit build without
CONFIG_PM of course, and that would have the same problem.

> > 
> > You are fixing two problems here: the warning about a size cast, and
> > the fact that the driver is using the wrong pointer. I'd suggest
> > explaining it in the changelog.
> > 
> > Note that we normally rely on void pointer arithmetic in the kernel, so
> > I'd write it without the uintptr_t casts as 
> > 
> >       bdp_dma = lower_32_bits(rx_queue->rx_bd_dma_base + (base - bdp));
> 
> But those aren't void pointers, and rx_bd_dma_base isn't a pointer, so you'd 
> get the wrong answer doing that.

Ah, right.

	Arnd
