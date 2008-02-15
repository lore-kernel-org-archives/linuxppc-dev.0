Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 454CEDDF47
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 23:49:36 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/9] fs_enet: Be an of_platform device when
	CONFIG_PPC_CPM_NEW_BINDING is set.
Date: Fri, 15 Feb 2008 13:50:15 +0100
References: <20070920220121.GF28784@loki.buserror.net>
In-Reply-To: <20070920220121.GF28784@loki.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2165880.djVGTVK3Kr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802151350.20627.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2165880.djVGTVK3Kr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Scott,

I apologize for bringing this after so much time. Hope the "better late tha=
n=20
never" motto applies.

On Friday 21 September 2007 00:01, Scott Wood wrote:
> The existing OF glue code was crufty and broken.  Rather than fix it, it
> will be removed, and the ethernet driver now talks to the device tree
> directly.
>
> The old, non-CONFIG_PPC_CPM_NEW_BINDING code can go away once CPM
> platforms are dropped from arch/ppc (which will hopefully be soon), and
> existing arch/powerpc boards that I wasn't able to test on for this
> patchset get converted (which should be even sooner).
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
[snip]
> diff --git a/drivers/net/fs_enet/fs_enet.h b/drivers/net/fs_enet/fs_enet.h
> index f8c7ee8..14ebba8 100644
> --- a/drivers/net/fs_enet/fs_enet.h
> +++ b/drivers/net/fs_enet/fs_enet.h
> @@ -24,19 +24,6 @@ struct fec_info {
>  #include <asm/cpm2.h>
>  #endif
>
> -/* This is used to operate with pins.
> -  Note that the actual port size may
> -    be different; cpm(s) handle it OK  */
> -struct bb_info {
> -	u8 mdio_dat_msk;
> -	u8 mdio_dir_msk;
> -	u8 *mdio_dir;
> -	u8 *mdio_dat;
> -	u8 mdc_msk;
> -	u8 *mdc_dat;
> -	int delay;
> -};
> -
[snip]
> diff --git a/drivers/net/fs_enet/mii-bitbang.c
> b/drivers/net/fs_enet/mii-bitbang.c index 8f766a5..2b9c44c 100644
> --- a/drivers/net/fs_enet/mii-bitbang.c
> +++ b/drivers/net/fs_enet/mii-bitbang.c
[snip]
> +struct bb_info {
> +	__be32 __iomem *dir;
> +	__be32 __iomem *dat;
> +	u32 mdio_msk;
> +	u32 mdc_msk;
> +	int delay;
> +};

We're loosing the possibility of having MDC and MDIO on different ports. Th=
is=20
is quite easy to fix for the non-CONFIG_PPC_CPM_NEW_BINDING case but I'm no=
t=20
familiar with OF bindings (yet) to fix the CONFIG_PPC_CPM_NEW_BINDING case.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2165880.djVGTVK3Kr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHtYqM8y9gWxC9vpcRAsHwAJ9Jwqm4C2K4nZ6+oAUS3U6VVL3Z8QCcCn6f
2J2XrRruFyIr9S32XXKA/x4=
=57T6
-----END PGP SIGNATURE-----

--nextPart2165880.djVGTVK3Kr--
