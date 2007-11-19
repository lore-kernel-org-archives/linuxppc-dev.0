Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711181749p1d2744b1md8ea92fdca60d6d6@mail.gmail.com>
Date: Sun, 18 Nov 2007 20:49:58 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Fix buglets in mpc5200 FEC code that are corrupting
	memory.
In-Reply-To: <fa686aa40711090557u1b6cb29ex388b82efcbad7c18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
References: <9e4733910711082131v70c4b7bm2b00445b7e62c33f@mail.gmail.com>
	<20071109091245.GA3148@nd47.coderock.org>
	<fa686aa40711090557u1b6cb29ex388b82efcbad7c18@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>, Jeff Garzik <jgarzik@pobox.com>,
	Domen Puncer <domen.puncer@telargo.com>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/9/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/9/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> > On 09/11/07 00:31 -0500, Jon Smirl wrote:
> > > This is the reason I couldn't get user space started or connect to my
> > > nfs server. Patch is against current linus git.
> > >
> > > mpc5200 fec driver is corrupting memory. This patch fixes two bugs
> > > where the wrong skb buffer was being referenced.
> > >
> > > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> >
> > Acked-by: Domen Puncer <domen.puncer@telargo.com>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Jeff, can you please pick this up for .24?

This is didn't make it into rc3. Without this patch this driver is broken.

>
> Thanks,
> g.
>
> >
> > I can't test it at the moment, but the patch is obviously correct,
> > mapped buffer should be the _same_ as submitted.
> >
> > >
> > > ---
> > >
> > >  drivers/net/fec_mpc52xx.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > >
> > > diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> > > index a8a0ee2..ddfcc0b 100644
> > > --- a/drivers/net/fec_mpc52xx.c
> > > +++ b/drivers/net/fec_mpc52xx.c
> > > @@ -422,7 +422,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int
> > > irq, void *dev_id)
> > >
> > >               rskb =3D bcom_retrieve_buffer(priv->rx_dmatsk, &status,
> > >                               (struct bcom_bd **)&bd);
> > > -             dma_unmap_single(&dev->dev, bd->skb_pa, skb->len, DMA_F=
ROM_DEVICE);
> > > +             dma_unmap_single(&dev->dev, bd->skb_pa, rskb->len, DMA_=
FROM_DEVICE);
> > >
> > >               /* Test for errors in received frame */
> > >               if (status & BCOM_FEC_RX_BD_ERRORS) {
> > > @@ -467,7 +467,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int
> > > irq, void *dev_id)
> > >                       bcom_prepare_next_buffer(priv->rx_dmatsk);
> > >
> > >               bd->status =3D FEC_RX_BUFFER_SIZE;
> > > -             bd->skb_pa =3D dma_map_single(&dev->dev, rskb->data,
> > > +             bd->skb_pa =3D dma_map_single(&dev->dev, skb->data,
> > >                               FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
> > >
> > >               bcom_submit_next_buffer(priv->rx_dmatsk, skb);
> > >
> > >
> > > --
> > > Jon Smirl
> > > jonsmirl@gmail.com
> >
> > --
> > Domen Puncer | Research & Development
> > .......................................................................=
......................
> > Telargo d.o.o. | Zagreb=9Aka cesta 20 | 2000 Maribor | Slovenia
> > .......................................................................=
......................
> > www.telargo.com
> >
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


--=20
Jon Smirl
jonsmirl@gmail.com
