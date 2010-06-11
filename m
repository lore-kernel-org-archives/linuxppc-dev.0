Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 0DDBD1007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 18:45:27 +1000 (EST)
Received: by fxm5 with SMTP id 5so517046fxm.15
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 01:45:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100303181858.GA458@oksana.dev.rtsoft.ru>
References: <20100303181858.GA458@oksana.dev.rtsoft.ru>
Date: Fri, 11 Jun 2010 10:45:24 +0200
Message-ID: <AANLkTiljLE2pgD5dK6Wa9WrYMCn8oNX_7OtEySrmttsU@mail.gmail.com>
Subject: Re: [PATCH] gianfar: Fix TX ring processing on SMP machines
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, netdev@vger.kernel.org,
	Martyn Welch <martyn.welch@ge.com>, linuxppc-dev@ozlabs.org,
	Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 3, 2010 at 8:18 PM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Starting with commit a3bc1f11e9b867a4f49505 ("gianfar: Revive SKB
> recycling") gianfar driver sooner or later stops transmitting any
> packets on SMP machines.
>
> start_xmit() prepares new skb for transmitting, generally it does
> three things:
>
> 1. sets up all BDs (marks them ready to send), except the first one.
> 2. stores skb into tx_queue->tx_skbuff so that clean_tx_ring()
> =A0 would cleanup it later.
> 3. sets up the first BD, i.e. marks it ready.
>
> Here is what clean_tx_ring() does:
>
> 1. reads skbs from tx_queue->tx_skbuff
> 2. checks if the *last* BD is ready. If it's still ready [to send]
> =A0 then it it isn't transmitted, so clean_tx_ring() returns.
> =A0 Otherwise it actually cleanups BDs. All is OK.
>
> Now, if there is just one BD, code flow:
>
> - start_xmit(): stores skb into tx_skbuff. Note that the first BD
> =A0(which is also the last one) isn't marked as ready, yet.
> - clean_tx_ring(): sees that skb is not null, *and* its lstatus
> =A0says that it is NOT ready (like if BD was sent), so it cleans
> =A0it up (bad!)
> - start_xmit(): marks BD as ready [to send], but it's too late.
>
> We can fix this simply by reordering lstatus/tx_skbuff writes.
>
> Reported-by: Martyn Welch <martyn.welch@ge.com>
> Bisected-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Tested-by: Martyn Welch <martyn.welch@ge.com>
> Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>
> Cc: Stable <stable@vger.kernel.org> [2.6.33]
> ---
> =A0drivers/net/gianfar.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index 8bd3c9f..cccb409 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -2021,7 +2021,6 @@ static int gfar_start_xmit(struct sk_buff *skb, str=
uct net_device *dev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* setup the TxBD length and buffer pointer for the first =
BD */
> - =A0 =A0 =A0 tx_queue->tx_skbuff[tx_queue->skb_curtx] =3D skb;
> =A0 =A0 =A0 =A0txbdp_start->bufPtr =3D dma_map_single(&priv->ofdev->dev, =
skb->data,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0skb_headlen(skb), DMA_TO_D=
EVICE);
>
> @@ -2053,6 +2052,10 @@ static int gfar_start_xmit(struct sk_buff *skb, st=
ruct net_device *dev)
>
> =A0 =A0 =A0 =A0txbdp_start->lstatus =3D lstatus;
>
> + =A0 =A0 =A0 eieio(); /* force lstatus write before tx_skbuff */
> +
> + =A0 =A0 =A0 tx_queue->tx_skbuff[tx_queue->skb_curtx] =3D skb;
> +
> =A0 =A0 =A0 =A0/* Update the current skb pointer to the next entry we wil=
l use
> =A0 =A0 =A0 =A0 * (wrapping if necessary) */
> =A0 =A0 =A0 =A0tx_queue->skb_curtx =3D (tx_queue->skb_curtx + 1) &

This patch also makes gianfar work stable on mpc8313 with 2.6.33/RT_PREEMPT=
.
WIthout it, I see exactly the same problems as reported by Anton on SMP.

/Esben
--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha@doredevelopment.dk
WWW: http://www.doredevelopment.dk
