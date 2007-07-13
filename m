Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DDDDDDF0A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 20:13:04 +1000 (EST)
Subject: Re: [PATCH 2/4] Implement arch disable/enable irq hooks.
From: Johannes Berg <johannes@sipsolutions.net>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070712191257.GA31381@ld0162-tx32.am.freescale.net>
References: <20070712191257.GA31381@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8pr4LHBhvlTbiKhcPw7w"
Date: Fri, 13 Jul 2007 12:10:00 +0200
Message-Id: <1184321400.30334.4.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8pr4LHBhvlTbiKhcPw7w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-12 at 14:12 -0500, Scott Wood wrote:
> These hooks ensure that a decrementer interrupt is not pending when
> suspending; otherwise, problems may occur.  For example, with deep sleep
> on the 831x, a pending decrementer will cause a system freeze because the
> SoC thinks the decrementer interrupt would have woken the system, but the
> core must have interrupts disabled due to the setup required for deep
> sleep.

> +/* Overrides the weak version in kernel/power/main.c */
> +void arch_suspend_disable_irqs(void)
> +{
> +	if (ppc_md.suspend_disable_irqs)
> +		ppc_md.suspend_disable_irqs();
> +	else
> +		generic_suspend_disable_irqs();
> +}

Looks good to me, thanks for the update with ppc_md.

johannes

--=-8pr4LHBhvlTbiKhcPw7w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGl093/ETPhpq3jKURAldWAJ9MvYX3r56PjZSkmAOBEN9bidqGZACfaNqy
vQQ37u3THjEnN+OQPL5PAWQ=
=zutm
-----END PGP SIGNATURE-----

--=-8pr4LHBhvlTbiKhcPw7w--
