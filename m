Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C0B9DDF23
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 21:05:23 +1100 (EST)
Subject: Re: [RFC PATCH] power-management elements for 603e/fsl
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
References: <Pine.LNX.4.60.0703182216130.4143@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kYeXxT5J1q6A3F+d9dUU"
Date: Wed, 21 Mar 2007 21:59:35 +0100
Message-Id: <1174510775.3944.64.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kYeXxT5J1q6A3F+d9dUU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-03-18 at 22:40 +0100, Guennadi Liakhovetski wrote:

> +static int ls_pm_valid(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +	case PM_SUSPEND_MEM:
> +		return 1;

Better just implement only one of them. Having two that do exactly the
same thing is confusing. Since you don't turn off the CPU feel free to
call it standby, but it doesn't really matter to me, there doesn't seem
to be a good set of rules to apply as to which name to use.

I just posted a patchset that exports a pm_valid_only_mem function in
pm.h, you should use that as the .valid callback if you decided to call
your sleep state 'mem'.

> +/*
> + * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
> + */

> +//	.pm_disk_mode	=3D PM_DISK_FIRMWARE,

Both the comment and .pm_disk_mode are bogus, I just removed all such
comments from all other users. It's just wrong, the pm_disk_mode is
something that most likely ACPI will only ever use (though I could
probably implement it for PMU as well)
=20
> +# contains only the suspend handler for time
> +obj-$(CONFIG_PM)		+=3D timer.o
> +

That seems to have slipped into this patch :)

johannes

--=-kYeXxT5J1q6A3F+d9dUU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAZy3/ETPhpq3jKURAtqHAJ9tq2oMqHnLgf9ZaZOwq0HFTw1JdQCgmu1W
v0dr1+Jxm1v+wLDxMMFSNP8=
=a7cr
-----END PGP SIGNATURE-----

--=-kYeXxT5J1q6A3F+d9dUU--
