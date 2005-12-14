Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D45768802
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 02:13:24 +1100 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <D5163F2D-A7C9-47E2-BE8D-E291B6C98A40@kernel.crashing.org>
References: <1134569118.3875.9.camel@localhost>
	<66D10776-B8F2-48E4-9B96-CA37323B5799@kernel.crashing.org>
	<1134571773.3875.12.camel@localhost>
	<D5163F2D-A7C9-47E2-BE8D-E291B6C98A40@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2saK4Crrnm6WCVvYHuPv"
Date: Wed, 14 Dec 2005 16:13:11 +0100
Message-Id: <1134573191.3875.18.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2saK4Crrnm6WCVvYHuPv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-12-14 at 09:07 -0600, Kumar Gala wrote:

> It is, we just need to ensure that the user page we are copying from =20
> is in memory.

So in the interrupt handler we need to ensure this and then call
__copy_from_user_inatomic instead?

> But, now that I go back and look at your log message, its odd. I =20
> didn't expect ProgramExceptions to be executed with the MSR[EE] =3D 0. =20
> Now, I'm wondering why that is.

Hm. I can tell you what I did: Something like=20
  mtspr 940, r3

in userland :)
Not sure if it was 940, might have been one of the other registers
reserved for performance monitoring.

johannes

--=-2saK4Crrnm6WCVvYHuPv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ6A2haVg1VMiehFYAQKh+g//dFw+75BRxIT2BAshFz7AfPUZjdDtWBJ5
9ZSiQpqiTxmawXwXVxq1FdEwSlfTx46HfqOGG05eYbt7bzRPQxER5X7gjszJ7lT/
L/3ziML287rep7CEiFcoBQqQCyjjvAEjH+Nigk20EWGO8lCLwzn1IiF623pyZkSj
YJscwupaFtikIAxAeO7ALt4Pp6V3kXIgNim66thJzOnIkgYROnUQN3rdWO0el9iW
hZfD8mFzmacbAwTnNq6n646qvyzIicgwGKZrZ+FvMgvO4Ry+bUs8gdgD2Z1MEd5w
NfFsHP50fTfPJR2C/YE6YN2Ofu0Qzne7PR59VXfzfBUrODmFp3FJMBl+xjrmP4Ac
a1ICTfnoiCfz4d157yKRWg+x8EDklZ7xk8tSXr4ZmIrbEf6JO0sKmdDdOMrCx+u8
qjj/yKY3KeamCwOztJcOCZ0/QP7cMGHHMBJApwTenz/8d0DxHJdVRNMIHDKKFMnp
3G3pWfCIb1oBY+/8crvVH3jZ2ZLeolLN1D0BJSgAtLCVTUuT229uGTi/Hdz/BAF/
amyhFoevwrfXZpto9rSfw2SsfXa8Sqmyo7CyF2ipsg8hIxTuzaCJ48pCdX51jEsA
aEE5OblQbJqUDjcFi6SiZwYpNjULYf6xxISHdBdxkpvYHMX/6C+U78kG+dvUqNk7
fZ2I+CATa4I=
=eQK8
-----END PGP SIGNATURE-----

--=-2saK4Crrnm6WCVvYHuPv--
