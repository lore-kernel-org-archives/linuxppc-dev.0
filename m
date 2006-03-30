Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C32C67A3F
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 00:04:37 +1100 (EST)
Subject: Re: [PATCH] PowerMac11,2 i2c-bus@0 duplicate dev-tree workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143692765.16706.10.camel@localhost.localdomain>
References: <1143631816.9481.5.camel@localhost>
	<1143692765.16706.10.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Qer2Y7GqKp5J3Aezx1GI"
Date: Thu, 30 Mar 2006 15:04:26 +0200
Message-Id: <1143723866.20571.13.camel@localhost>
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


--=-Qer2Y7GqKp5J3Aezx1GI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-03-30 at 15:26 +1100, Benjamin Herrenschmidt wrote:

> Hrm... you set allnextpp to NULL ... won't that prevent any further node
> from being enqueued in the global node list ?

No, it only prevents all *child* nodes, since the function recurses so
once you go out allnextpp is valid again. I'm not setting *allnextpp :)

> In fact, I think the workaround should be in prom_init.c when
> flattening... easier to skip a node there, and that's also where you are
> reasonably sure of getting the nodes in the right order, not when
> unflattening.=20

Ok. I'll look at that code then.

> Also, you don't even need to test for PowerMac11,2 .. .prom_init.c
> already has a machine type, so just test that it's a mac and has this
> node duplicated, and if yes, remove the dup. In fact, you could probably
> even run a bit of forth with "interpret" to do so before the tree is
> even walked though :)

Heh. Well, if you tell me what you prefer I'll try to do it. Meanwhile
I'll use this patch so the sound stuff etc. doesn't get too confusing
(it keeps telling me about two onyx codecs found...)

johannes

--=-Qer2Y7GqKp5J3Aezx1GI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCvXWaVg1VMiehFYAQKhUg//a97JR2szMwIlaiiKMphkNeW2jzdOmnqI
E2C/1LCV6/MgCBR3GNVyJKzOZda+EIgMSkFlTBeL6XyfstAU5GgBHfxkahlw0JKo
j/mx/r/MuzwJoANhB1M3VOuZVZ2NSXogqIxB+K1jqaHsb3Fx0vrsYuwxQ0SC1FZ/
zDgytzt67flabjV4x2Ep7pAcF+MFZVWulCv/kTrNiZ3t7ZAbCUgtDZSJCgcvzE20
aU1rrBVftD1mTGgvLp2NHbgqSDsIJI9NNnieAWY65C+srtcaOxg7YUbwOhLvn/Kx
P/Sdhf4ilNlXioyo0TGlr+zQicLFgievCCfmNILH2u+MPPWPF822hLyG/ZF+3ndU
cU9WFM+dMyC1vpW0Ofez8rrocrnJQ/9px9nE4iA/S1G1TXg/f6KphmfYihUyYr1I
QYlGuVZKsMjyBh7GHrD5dKg2nvcxZXp9yBL+p70xiF3JAJSSHmJsrLyHSnUCJbtm
Bt8TeVNpMu1rN8Pvv8RL2iVIQSOExM60DBDPUZyItGlUIrJM/X22nMryp367Allp
s0NUuz7HCHI/0NwKaeRGwY+ZD3WmrNn8iFMXL7zZ5pGe4EIB4uBdBCvSF4TnC1JG
JxN9N1p7h7Cq9nO6YLzZw90JVWyCmcJfo3khrbRSdLaNf5ZquGgpetuapfYCUEKE
MO8eudPFtJ0=
=XOc5
-----END PGP SIGNATURE-----

--=-Qer2Y7GqKp5J3Aezx1GI--
