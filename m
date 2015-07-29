Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 041BE1A11A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 02:02:56 +1000 (AEST)
Message-ID: <1438185761.2993.333.camel@freescale.com>
Subject: Re: [PATCH] gianfar: Fix warnings when built on 64-bit
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linuxppc-dev@lists.ozlabs.org>, <netdev@vger.kernel.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>
Date: Wed, 29 Jul 2015 11:02:41 -0500
In-Reply-To: <4498062.4y369pLSmO@wuerfel>
References: <1438147477-393-1-git-send-email-scottwood@freescale.com>
 <4498062.4y369pLSmO@wuerfel>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-29 at 10:02 +0200, Arnd Bergmann wrote:
> On Wednesday 29 July 2015 00:24:37 Scott Wood wrote:
> > +#ifdef CONFIG_PM
> >  static void lock_tx_qs(struct gfar_private *priv)
> >  {
> >     int i;
> > @@ -580,6 +581,7 @@ static void unlock_tx_qs(struct gfar_private *priv)
> >     for (i = 0; i < priv->num_tx_queues; i++)
> >             spin_unlock(&priv->tx_queue[i]->txlock);
> >  }
> > +#endif
> >  
> 
> This seems unrelated and should probably be a separate fix.

It's related in that it fixes a warning -- the 64-bit build didn't have 
CONFIG_PM -- though I should have been clearer about that in the changelog.

> > @@ -2964,8 +2967,13 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q 
> > *rx_queue, int rx_work_limit)
> >             gfar_init_rxbdp(rx_queue, bdp, bufaddr);
> >  
> >             /* Update Last Free RxBD pointer for LFC */
> > -           if (unlikely(rx_queue->rfbptr && priv->tx_actual_en))
> > -                   gfar_write(rx_queue->rfbptr, (u32)bdp);
> > +           if (unlikely(rx_queue->rfbptr && priv->tx_actual_en)) {
> > +                   u32 bdp_dma;
> > +
> > +                   bdp_dma = lower_32_bits(rx_queue->rx_bd_dma_base);
> > +                   bdp_dma += (uintptr_t)bdp - (uintptr_t)base;
> > +                   gfar_write(rx_queue->rfbptr, bdp_dma);
> > +           }
> >  
> >             /* Update to the next pointer */
> >             bdp = next_bd(bdp, base, rx_queue->rx_ring_size);
> 
> You are fixing two problems here: the warning about a size cast, and
> the fact that the driver is using the wrong pointer. I'd suggest
> explaining it in the changelog.
> 
> Note that we normally rely on void pointer arithmetic in the kernel, so
> I'd write it without the uintptr_t casts as 
> 
>       bdp_dma = lower_32_bits(rx_queue->rx_bd_dma_base + (base - bdp));

But those aren't void pointers, and rx_bd_dma_base isn't a pointer, so you'd 
get the wrong answer doing that.

-Scott
