Return-Path: <Dai.Haruki@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5BFB9679A6
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 21:18:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k4M1wOeR003546
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 18:58:24 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4M1cOR2017209
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 20:38:24 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Gianfar SKB Recycling Support
Date: Sun, 21 May 2006 18:38:26 -0700
Message-ID: <18AEF66AFDF06F4CAAA1D419D000FD33524DED@az33exm24.fsl.freescale.net>
From: "Haruki Dai-r35557" <Dai.Haruki@freescale.com>
To: "Stephen Hemminger" <shemminger@osdl.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Stephen Hemminger [mailto:shemminger@osdl.org]=20
> Sent: Saturday, May 20, 2006 2:48 AM
> To: Haruki Dai-r35557
> Cc: netdev@vger.kernel.org; Fleming Andy-afleming; Kumar=20
> Gala; Haruki Dai-r35557
> Subject: Re: [PATCH] Gianfar SKB Recycling Support
>=20
> On Wed, 17 May 2006 15:45:14 -0700
> "Haruki Dai-r35557" <Dai.Haruki@freescale.com> wrote:
>=20
> > This patch improves the IP forwarding throughput of
> > the Freescale TSEC/eTSEC Gianfar driver. By recycling
> > the Socket buffer and Data buffer, reduce the unnecessary
> > memory allocation and de-allocation in the forwarding
> > processing chain.
> >=20
> > Signed-off-by: Dai Haruki <dai.haruki@freescale.com>
> > Signed-off-by: Andy Fleming <afleming@freescale.com>
> >=20
>=20
> In case the general impression wasn't clear from the earlier comments.
> This patch is an interesting benchmark tweak, but unlikely to ever
> make it into the mainline kernel. The kernel needs to be a general
> purpose system and deal with multiple types of hardware and resource
> control.
>=20
> But don't give up looking at performance. If you can find ways to
> speed up the overall socket buffer handling without breaking existing
> semantics; then the patches would be positively received.
>

I admit the explanation of the implementation is indeed unclear. I will
put the recycling mechanism explanation. Is it better put as the
driver's comment? Or, the separate document like, say,
Document/net/skb_recycling.txt?

Just in case, I need to confirm that the patch is rejected even though
the expalanation is added?=20

I will surely work for making this mechanism more generic to the other
interface. I want to make sure that this patch is not the purpose of
benchmark tweak. This recycling mechanism makes the Linux's position in
the packet forwarding application better compare to the other
proprietary OS/Stack in terms of the throughput performance.=20
=20
 For the gianfar user, this patch also improves interrupt response under
the situation when previous gianfar tied up with the a lot of TX hw
interrupt even under NAPI (current gianfar NAPI implementation only help
Rx side since we have separate interrupt line). I will separate the
gianfar specific improvement, and post to this list again.



- Dai
