Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B8A867AC5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 20:05:38 +1000 (EST)
Subject: Re: PowerMac: force only suspend-to-disk to be valid
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1146562296.3858.9.camel@localhost>
References: <1146562296.3858.9.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-w7yre0see/suGEfB0DUi"
Date: Thu, 25 May 2006 12:05:27 +0200
Message-Id: <1148551527.11759.10.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-w7yre0see/suGEfB0DUi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-02 at 11:31 +0200, Johannes Berg wrote:
> This patch adds the .valid callback to pm_ops on PowerMac so that only th=
e
> suspend to disk state can be entered. Note that just returning 0 would
> suffice since the upper layers don't pass PM_SUSPEND_DISK down, but I thi=
nk
> they ought to be passing it down since they do really need support (or
> am I mistaken again?) so we handle it there regardless.

No one ever seemed to care about this patch, can we queue it up for
2.6.18? I suppose it's too late now for 2.6.17 even if it fixes the
long-standing but that on ppc, /sys/power/state kills the machine.

[quoted patch for reference]

> --- wireless-dev.orig/arch/powerpc/platforms/powermac/setup.c	2006-05-02 =
10:57:32.101509438 +0200
> +++ wireless-dev/arch/powerpc/platforms/powermac/setup.c	2006-05-02 10:58=
:44.491509438 +0200
> @@ -463,11 +463,23 @@ static int pmac_pm_finish(suspend_state_
>  	return 0;
>  }
> =20
> +static int pmac_pm_valid(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_DISK:
> +		return 1;
> +	/* can't do any other states via generic mechanism yet */
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static struct pm_ops pmac_pm_ops =3D {
>  	.pm_disk_mode	=3D PM_DISK_SHUTDOWN,
>  	.prepare	=3D pmac_pm_prepare,
>  	.enter		=3D pmac_pm_enter,
>  	.finish		=3D pmac_pm_finish,
> +	.valid		=3D pmac_pm_valid,
>  };
> =20
>  #endif /* CONFIG_SOFTWARE_SUSPEND */


--=-w7yre0see/suGEfB0DUi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHWBZaVg1VMiehFYAQLeIRAAkyMD8uC8iWiSYn6ao1+LavXHPvGzOWRg
0kNkInZCnn5VnvH1p0dwSNuLkbF5Pucf4IXSciOYkidjI3pX9lI7iMi3PoFjGxma
dg07Qk6W5c1iNTPjmMWFFiAoN5j+MHEnh+J/Q4xDvh5zKkq+W/SM7sGz0hN1ctJu
eaztWRIPswcxi5Ksivqx5+o0A7vDmRKMnjyPjpkdtc3wA2YX7VoOvw6xUg5s6pJm
y2/Fr9Kl/Zjr1ICNsTOJkKhQmwDb3UjUpUXpH9UtXJE8pgKddDKXhchWJ9Bi0foQ
F6A78RsXqLXxxElwQeswSu+vzhYiQcySvtqALh4FqqFiLXIO7SEIAwh8G009Zzzv
wYzLO/RkjWGQxA5f7Cgw9wERREKY/Q/0roBpJDMh4x3SnY2LRYfzpAsEbh/ouaUE
jlgAipadmWPEyJp5tYlr7ZqlmwRnhdpfyl/3tv4RFUtB354o2YuBfEaoMvxrYN5j
9SqLkQe5r6Zi0gXiaTin7ejl/wPeAiu69QrL/V0nAyuxkFYbJCk8Z5lGpTITF/EH
OOgykDBrnJylKBrIPFncxIPflMw7QALaWfMbzKxzcYN2A56p/0g1W5kQdQjcLVXs
KdQNgmZgJ47hICi7+7DKDjxPeeKKjo+gcwMde+LCxaHrlMw1tkxIgantiA1ULC03
GWXaqlDYP3o=
=B8Hh
-----END PGP SIGNATURE-----

--=-w7yre0see/suGEfB0DUi--
