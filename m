Return-Path: <B05799@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BD9FB7CBB
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 15:58:53 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1Q4wnKS020344
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 21:58:49 -0700 (MST)
Received: from zin33exm22.fsl.freescale.net (zin33exm22.ap.freescale.net
	[10.232.192.20])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o1Q4wpjk013547
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 22:58:52 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Gianfar driver failing on MPC8641D based board
Date: Fri, 26 Feb 2010 10:28:46 +0530
Message-ID: <9F4C7D19E8361D4C94921B95BE08B81BC93E3A@zin33exm22.fsl.freescale.net>
In-Reply-To: <20100226031452.GA11319@oksana.dev.rtsoft.ru>
References: <4B6C2488.3060403@ge.com> <4B865176.7080806@ge.com>
	<4B86A97E.6050509@ge.com>
	<20100225165141.GA9686@oksana.dev.rtsoft.ru>
	<20100225174935.GA32370@oksana.dev.rtsoft.ru>
	<7d1d9c251002251653n6473f01ex2d43933ec6aa010b@mail.gmail.com>
	<20100226031452.GA11319@oksana.dev.rtsoft.ru>
From: "Kumar Gopalpet-B05799" <B05799@freescale.com>
To: <avorontsov@ru.mvista.com>, "Paul Gortmaker" <paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Martyn Welch <martyn.welch@ge.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, davem@davemloft.net
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
>Sent: Friday, February 26, 2010 8:45 AM
>To: Paul Gortmaker
>Cc: Martyn Welch; linuxppc-dev list; netdev@vger.kernel.org;=20
>linux-kernel@vger.kernel.org; Kumar Gopalpet-B05799;=20
>davem@davemloft.net; Kumar Gala
>Subject: Re: Gianfar driver failing on MPC8641D based board
>
>On Thu, Feb 25, 2010 at 07:53:30PM -0500, Paul Gortmaker wrote:
>[...]
>> I was able to reproduce it on an 8641D and bisected it down to this:
>>=20
>> -----------
>> commit a3bc1f11e9b867a4f49505ecac486a33af248b2e
>> Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>> Date:   Tue Nov 10 14:11:10 2009 +0000
>>=20
>>     gianfar: Revive SKB recycling
>
>Thanks for the bisect. I have a guess why tx hangs in SMP=20
>case. Could anyone try the patch down below?
>
>[...]
>> ...which probably explains why you weren't seeing it on non-SMP.
>> I'd imagine it would show up on any of the e500mc boards too.
>
>Yeah.. Pity, I don't have SMP boards anymore. I'll try to get=20
>one though.
>
>
>diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c=20
>index 8bd3c9f..3ff3bd0 100644
>--- a/drivers/net/gianfar.c
>+++ b/drivers/net/gianfar.c
>@@ -2614,6 +2614,8 @@ static int gfar_poll(struct napi_struct=20
>*napi, int budget)
> 			tx_queue =3D priv->tx_queue[rx_queue->qindex];
>=20
> 			tx_cleaned +=3D gfar_clean_tx_ring(tx_queue);
>+			if (!tx_cleaned && !tx_queue->num_txbdfree)
>+				tx_cleaned +=3D 1; /* don't=20
>complete napi */
> 			rx_cleaned_per_queue =3D=20
>gfar_clean_rx_ring(rx_queue,
> 						=09
>budget_per_queue);
> 			rx_cleaned +=3D rx_cleaned_per_queue;
>

Anton,=20

There is also one more issue that I have been observing with the patch
"gianfar: Revive SKB recycling".
The issue is when I do a IPV4 forwarding test scenario with
bidirectional flows (SMP environment). I am using Spirent smart bits
(smartflow) for automation testing and I frequently observe smart flow
reporting "Rx packet counte greater than Tx packet count. Duplicate
packets might have been received".

To just get over the issue I have removed this patch and I didn't see
the issue.

To a certain extent I could get over the problem by using atomic_t for
num_txbdfree (atomic_add and atomic_dec instructions for updating the
num_txbdfree) and completely removing the spin_locks in the tx routines.

Also, I feel we might want to make some more changes to the
gfar_clean_tx_ring( ) and gfar_start_xmit() routines so that they can
operate parallely.=20

I am really sorry for not posting it a bit earlier as I am caught up
with some urgent issues.

--

Thanks
Sandeep
