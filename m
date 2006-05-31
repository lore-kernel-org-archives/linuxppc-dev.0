Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D48EE67B17
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 19:23:39 +1000 (EST)
Subject: [RFT] snd-aoa has headphone and line-out detection now
From: Johannes Berg <johannes@sipsolutions.net>
To: debian-powerpc <debian-powerpc@lists.debian.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-m3PaPWgEumFsrtgI5rim"
Date: Wed, 31 May 2006 11:23:16 +0200
Message-Id: <1149067396.8877.19.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-m3PaPWgEumFsrtgI5rim
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,

I committed the code necessary in snd-aoa to support headphone and
line-out detection, but I need help with one thing:

When you plug in an optical connector into the combo thingie, is a
regular interrupt generated? Since nothing will actually be printed out,
I suggest the following method to find out:

1) start alsamixer
2) enable all outputs
3) plug in optical connector into the headphone/line-out plug
4) observe if anything changes
5) remove optical connector again
6) disable all outputs
7) plug in optical connector again
8) reply to this mail telling me what happens in alsamixer when doing it

If nothing happens then I suppose no interrupt is generated, otherwise,
there must be. But I'll need to change the code a bit in any case.

The headphone detection is intentionally not doing much, for one it
reports the current state in the mixer element 'Headphone Detected', and
you get the choice of switching to headphone on detect, which also turns
off all the others, and enables speakers when removing. Also, the
initial status is based on it.

If you want more options, run a userspace daemon that listens to changes
on 'Headphone Detected' and changes stuff appropriately. Keep in mind
that it must disable the automatic handling then. And no, I haven't
written one :)

johannes

PS: For those who care, here are some technical details:
(1) I decided not to make the fabric handle *all* the interrupts
     because that gets messy quickly with the allowed transfer items.
     Also, it is hard to handle because sometimes some inputs are
     mutually exclusive, while outputs controlled by amps are not, etc.
(2) I will need to change the code so that the fabric handles all the
     outputs, that is move the S/PDIF control to the fabric and have
     the codec have a call for enabling/disabling it... Yes, this is
     going into the direction of having the fabric control all of it,
     but see (1). Maybe that code will enable having the fabric control
     it all, I dunno.


--=-m3PaPWgEumFsrtgI5rim
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARH1ggqVg1VMiehFYAQKf8w//ZDCGAn5w+AG4OCQTLs7ULErzdIZU6Uet
5PSQtVUsXlJOhEZvgPHFkStWfQPckrNNBu97vZgj8RLbEsodks7G9VySBQ4wdGC4
NYnNdNlw3+sV0SMGpLCXzKOE4old9Gedp/YtlDVe9mDL51pg4v8APO0F45Ycng7k
M7UW9pfgPAhIyXXD0dz6fpxww+KOr6ShkUsIxPDvJQYDskxXGihQlqNhH0fcLyeE
8ixSII5TGgcrmrYzFDP8TuWohDzDP8XPVVXEUvoK8pWVHftvExSA2vbkCngij13i
6W+MGvvux15/ZC7uBTLt/snbeh5gPCWdDtn6jut1SAwArkp9CTgRtqtBDM0e4stW
QlWS8FyIN1XFbeDOdF1ftToL7K6fEj4KZ22CSj298v4+YKF+3z179UzYVFu/ZfQm
BGSB6wDuusSMpSPz0mVE9mcTzUAZZXyqq+v79FNXODDn6JiSqc143OCaLMXdo9As
1WPe1tCzhoMuwBCE1HeAL9wnpElJpC/2GcbpLlNIUZMzywnzPTzMFmUO0sOVvFO5
z/Hs7+YpRzcGmVuN9iRpigvzj939ChIv0/ur93lq4d/ziw9QtXfShZ8dgl+nOBlR
c2R/+ksjueUZ9fxYZk3uexoUz9mixa/9OLyDfnsRW6u1uieyyWvh+XpWeZ4K7CjX
S6VjGt3yKkg=
=+Edu
-----END PGP SIGNATURE-----

--=-m3PaPWgEumFsrtgI5rim--
