Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE6CFDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 17:37:37 +1000 (EST)
Subject: Re: [PATCH] power-management elements for 603e/fsl (version 2)
From: Johannes Berg <johannes@sipsolutions.net>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
In-Reply-To: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
References: <Pine.LNX.4.60.0705192013010.10162@poirot.grange>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-m7ZGA84LCbS347jECL8M"
Date: Mon, 21 May 2007 17:54:56 +0200
Message-Id: <1179762897.9122.17.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-m7ZGA84LCbS347jECL8M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-05-19 at 21:22 +0200, Guennadi Liakhovetski wrote:

> +int fsl_suspend(suspend_state_t state)
> +{
> +	struct pci_dev *bridge;
> +	unsigned long flags;
> +	u16 pmcr1;
> +
> +	bridge =3D pci_find_slot(0, 0);
> +	if (!bridge)
> +		return -ENODEV;
> +
> +	pci_read_config_word(bridge, 0x70, &pmcr1);
> +	local_irq_save(flags);
> +	/* Apparently, MacOS uses NAP mode for Grackle ??? */

That comment seems out of place :)

> +	pmcr1 &=3D ~(MPC10X_DOZE | MPC10X_NAP);
> +	pmcr1 |=3D MPC10X_PM | MPC10X_SLEEP | MPC10X_LP_REF_EN;
> +	pci_write_config_word(bridge, 0x70, pmcr1);
> +	local_irq_restore(flags);
> +
> +	/* Make sure the decrementer won't interrupt us */
> +	asm volatile("mtdec %0" : : "r" (0x7fffffff));
> +	/* Make sure any pending DEC interrupt occurring while we did
> +	 * the above didn't re-enable the DEC */
> +	mb();
> +	asm volatile("mtdec %0" : : "r" (0x7fffffff)); /* 8 seconds */

Are you sure that's 8 seconds? Seems too fast.

Also, the whole irq handling thing in resume/suspend seems bogus. Both
resume and suspend are called with interrupts off, so the
local_irq_{save,restore} calls do nothing. You probably need to use
arch_suspend_{enable,disable}_irqs and do the decrementer magic there
(after all that's why we introduced these.)

Then again, see the other mail I'm about to send in response to a patch
from Scott Wood using these hooks.

johannes

--=-m7ZGA84LCbS347jECL8M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGUcDQ/ETPhpq3jKURAt41AKCF60grmtvA6SiTm0C7A6rpKwp4TACfdHHj
7MuI+UgIr1yaQAmBYCc+CiE=
=Ks2Q
-----END PGP SIGNATURE-----

--=-m7ZGA84LCbS347jECL8M--
