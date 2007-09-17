Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 638DBDDECC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 08:43:29 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l8HMhOx0001703
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 15:43:24 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l8HMhNOe004825
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 17:43:23 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Mon, 17 Sep 2007 15:43:22 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701555C08@az33exm24.fsl.freescale.net>
In-Reply-To: <16939.1190068482@redhat.com>
References: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
	<16939.1190068482@redhat.com>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: <dhowells@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <kumar.gala@freescale.com>,
	paulus@samba.org, bzolnier@gmail.com, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,


I've seen you patch earlier, but I'm not trying to solve the BSG related
problem/warnings. That's why I put a reference to an already existing
commit addressing the BSG/bsg.h warnings. I'm trying to address a
slightly different problem in the PowerPC code only.


Cheers,
Emil.


> -----Original Message-----
> From: dhowells@redhat.com [mailto:dhowells@redhat.com]=20
> Sent: Monday, September 17, 2007 5:35 PM
> To: Medve Emilian-EMMEDVE1
> Cc: dhowells@redhat.com; paulus@samba.org; Gala Kumar-B11780;=20
> linuxppc-dev@ozlabs.org; bzolnier@gmail.com; linux-ide@vger.kernel.org
> Subject: Re: [PATCH] [POWERPC] Fix build errors when BLOCK=3Dn
>=20
>=20
> Try the attached.
>=20
> David
> ---
> [PATCH] VFS: Make BSG declarations dependent on CONFIG_BLOCK
>=20
> From: David Howells <dhowells@redhat.com>
>=20
> Make BSG function declarations dependent on CONFIG_BLOCK as=20
> they are not
> compilable if the block layer is compiled out.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>=20
>  include/linux/bsg.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/bsg.h b/include/linux/bsg.h
> index 60e377b..28f5d44 100644
> --- a/include/linux/bsg.h
> +++ b/include/linux/bsg.h
> @@ -52,6 +52,7 @@ struct sg_io_v4 {
>  };
> =20
>  #ifdef __KERNEL__
> +#ifdef CONFIG_BLOCK
> =20
>  #if defined(CONFIG_BLK_DEV_BSG)
>  struct bsg_class_device {
> @@ -73,6 +74,7 @@ static inline void=20
> bsg_unregister_queue(struct request_queue *rq)
>  }
>  #endif
> =20
> +#endif /* CONFIG_BLOCK */
>  #endif /* __KERNEL__ */
> =20
>  #endif
