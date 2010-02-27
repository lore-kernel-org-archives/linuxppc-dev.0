Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C485CB7D5D
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 16:35:58 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1R5ZZD8009061
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 22:35:46 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o1R5g7RE007588
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 23:42:08 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar driver failing on MPC8641D based board
Date: Sat, 27 Feb 2010 11:05:32 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BC93EC3@zin33exm22.fsl.freescale.net>
In-Reply-To: <20100226213825.GA32363@oksana.dev.rtsoft.ru>
References: <20100225174935.GA32370@oksana.dev.rtsoft.ru>
	<7d1d9c251002251653n6473f01ex2d43933ec6aa010b@mail.gmail.com>
	<20100226031452.GA11319@oksana.dev.rtsoft.ru>
	<4B87B937.6010204@ge.com>
	<20100226143532.GA31622@oksana.dev.rtsoft.ru>
	<4B87E01E.4070704@windriver.com> <4B87E662.3080106@ge.com>
	<4B87E9EF.3010604@ge.com>
	<20100226161058.GA22954@oksana.dev.rtsoft.ru>
	<4B87F67E.5070601@windriver.com>
	<20100226213825.GA32363@oksana.dev.rtsoft.ru>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: <avorontsov@ru.mvista.com>, "Paul Gortmaker" <paul.gortmaker@windriver.com>
Cc: Martyn Welch <martyn.welch@ge.com>, netdev@vger.kernel.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

>-----Original Message-----
>From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
>Sent: Saturday, February 27, 2010 3:08 AM
>To: Paul Gortmaker
>Cc: Martyn Welch; netdev@vger.kernel.org;=20
>linux-kernel@vger.kernel.org; linuxppc-dev list; Kumar=20
>Gopalpet-B05799; davem@davemloft.net
>Subject: Re: Gianfar driver failing on MPC8641D based board
>
>On Fri, Feb 26, 2010 at 11:27:42AM -0500, Paul Gortmaker wrote:
>> On 10-02-26 11:10 AM, Anton Vorontsov wrote:
>> > On Fri, Feb 26, 2010 at 03:34:07PM +0000, Martyn Welch wrote:
>> > [...]
>> >> Out of 10 boot attempts, 7 failed.
>> >=20
>> > OK, I see why. With ip=3Don (dhcp boot) it's much harder to trigger =

>> > it. With static ip config can I see the same.
>>=20
>> I'd kind of expected to see us stuck in gianfar on that=20
>lock, but the=20
>> SysRQ-T doesn't show us hung up anywhere in gianfar itself.
>> [This was on a base 2.6.33, with just a small sysrq fix patch]
>
>> [df841a30] [c0009fc4] __switch_to+0x8c/0xf8                 =20
>                  =20
>> [df841a50] [c0350160] schedule+0x354/0x92c                  =20
>                  =20
>> [df841ae0] [c0331394] rpc_wait_bit_killable+0x2c/0x54       =20
>                  =20
>> [df841af0] [c0350eb0] __wait_on_bit+0x9c/0x108              =20
>                  =20
>> [df841b10] [c0350fc0] out_of_line_wait_on_bit+0xa4/0xb4     =20
>                  =20
>> [df841b40] [c0331cf0] __rpc_execute+0x16c/0x398             =20
>                  =20
>> [df841b90] [c0329abc] rpc_run_task+0x48/0x9c                =20
>                  =20
>> [df841ba0] [c0329c40] rpc_call_sync+0x54/0x88               =20
>                  =20
>> [df841bd0] [c015e780] nfs_proc_lookup+0x94/0xe8             =20
>                  =20
>> [df841c20] [c014eb60] nfs_lookup+0x12c/0x230                =20
>                  =20
>> [df841d50] [c00b9680] do_lookup+0x118/0x288                 =20
>                  =20
>> [df841d80] [c00bb904] link_path_walk+0x194/0x1118           =20
>                  =20
>> [df841df0] [c00bcb08] path_walk+0x8c/0x168                  =20
>                  =20
>> [df841e20] [c00bcd6c] do_path_lookup+0x74/0x7c              =20
>                  =20
>> [df841e40] [c00be148] do_filp_open+0x5d4/0xba4              =20
>                  =20
>> [df841f10] [c00abe94] do_sys_open+0xac/0x190                =20
>                  =20
>
>Yeah, I don't think this is gianfar-related. It must be=20
>something else triggered by the fact that gianfar no longer=20
>sends stuff.
>
>OK, I think I found what's happening in gianfar.
>
>Some background...
>
>start_xmit() prepares new skb for transmitting, generally it=20
>does three things:
>
>1. sets up all BDs (marks them ready to send), except the first one.
>2. stores skb into tx_queue->tx_skbuff so that clean_tx_ring()
>   would cleanup it later.
>3. sets up the first BD, i.e. marks it ready.
>
>Here is what clean_tx_ring() does:
>
>1. reads skbs from tx_queue->tx_skbuff
>2. Checks if the *last* BD is ready. If it's still ready [to send]
>   then it it isn't transmitted, so clean_tx_ring() returns.
>   Otherwise it actually cleanups BDs. All is OK.
>
>Now, if there is just one BD, code flow:
>
>- start_xmit(): stores skb into tx_skbuff. Note that the first BD
>  (which is also the last one) isn't marked as ready, yet.
>- clean_tx_ring(): sees that skb is not null, *and* its lstatus
>  says that it is NOT ready (like if BD was sent), so it cleans
>  it up (bad!)
>- start_xmit(): marks BD as ready [to send], but it's too late.
>
>We can fix this simply by reordering lstatus/tx_skbuff writes.
>
>It works flawlessly on my p2020, please try it.

Anton,

Understood, and thanks for the explanation. Am I correct in saying that
this is
due to the out-of-order execution capability on powerpc ?

I have one more question, why don't we use use atomic_t for num_txbdfree
and
completely  do away with spin_locks in gfar_clean_tx_ring() and
gfar_start_xmit().
In an non-SMP, scenario I would feel there is absolutely no requirement
of spin_locks
and in case of SMP atomic operation would be much more safer on powerpc
rather than spin_locks.

What is your suggestion ?


--

Thanks
Sandeep

>
>Thanks!
>
>
>diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=20
>index 8bd3c9f..cccb409 100644
>--- a/drivers/net/gianfar.c
>+++ b/drivers/net/gianfar.c
>@@ -2021,7 +2021,6 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
> 	}
>=20
> 	/* setup the TxBD length and buffer pointer for the first BD */
>-	tx_queue->tx_skbuff[tx_queue->skb_curtx] =3D skb;
> 	txbdp_start->bufPtr =3D dma_map_single(&priv->ofdev->dev,=20
>skb->data,
> 			skb_headlen(skb), DMA_TO_DEVICE);
>=20
>@@ -2053,6 +2052,10 @@ static int gfar_start_xmit(struct=20
>sk_buff *skb, struct net_device *dev)
>=20
> 	txbdp_start->lstatus =3D lstatus;
>=20
>+	eieio(); /* force lstatus write before tx_skbuff */
>+
>+	tx_queue->tx_skbuff[tx_queue->skb_curtx] =3D skb;
>+
> 	/* Update the current skb pointer to the next entry we will use
> 	 * (wrapping if necessary) */
> 	tx_queue->skb_curtx =3D (tx_queue->skb_curtx + 1) &
>
>
