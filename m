Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C0179DDDE9
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 17:43:52 +1100 (EST)
Date: Sat, 29 Dec 2007 17:43:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 3/4] USB: add Cypress c67x00 OTG controller HCD driver
Message-Id: <20071229174346.1f4c5067.sfr@canb.auug.org.au>
In-Reply-To: <20071228235241.16003.2229.stgit@trillian.secretlab.ca>
References: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
	<20071228235241.16003.2229.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Dec_2007_17_43_46_+1100_Iq/VjGJUrZy2NAHg"
Cc: akpm@osdl.org, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linuxppc-dev@ozlabs.org, stern@rowland.harvard.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Dec_2007_17_43_46_+1100_Iq/VjGJUrZy2NAHg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grant,

Just did a superficial look over this.

On Fri, 28 Dec 2007 16:52:41 -0700 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> +++ b/drivers/usb/c67x00/c67x00-hcd.c
> +
> +#define OK(x)			len =3D (x); break

I was going to say "URK!" but it looks like it is not used, so just
remove it.

> +static int c67x00_hub_status_data(struct usb_hcd *hcd, char *buf)
> +{
> +	struct c67x00_hcd *c67x00 =3D hcd_to_c67x00_hcd(hcd);
> +	struct c67x00_sie *sie =3D c67x00->sie;
> +	u16 status;
> +	int i;
> +
> +	*buf =3D 0;
> +	status =3D c67x00_ll_husb_get_status(sie);
> +	for (i=3D0; i<C67X00_PORTS; i++)

Spacing.

> +static int c67x00_hcd_get_frame(struct usb_hcd *hcd)
> +{
> +	struct c67x00_hcd *c67x00 =3D hcd_to_c67x00_hcd(hcd);
> +	u16 temp_val;
> +	dev_dbg(c67x00_hcd_dev(c67x00), "%s\n", __FUNCTION__);

We normally put a blank line between declarations and code.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Dec_2007_17_43_46_+1100_Iq/VjGJUrZy2NAHg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHdeynTgG2atn1QN8RAshgAJ0dfXlXxeV9tMT+NUHFjydo/NdZqQCeK/ix
aUrNZdFAd6YZllYQKwRFTVg=
=JHY8
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Dec_2007_17_43_46_+1100_Iq/VjGJUrZy2NAHg--
