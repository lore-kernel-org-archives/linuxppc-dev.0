Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfHvd6xpkzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 15:48:13 +1000 (AEST)
Date: Tue, 5 Apr 2016 14:09:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, Alexander Graf <agraf@suse.de>,
 linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] spapr: Don't set the TM ibm,pa-features bit in PR KVM mode
Message-ID: <20160405040941.GT16485@voom.fritz.box>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <20160405021201.GA2663@yogo.paulus.ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
In-Reply-To: <20160405021201.GA2663@yogo.paulus.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 05, 2016 at 12:12:01PM +1000, Paul Mackerras wrote:
> On Mon, Apr 04, 2016 at 09:09:28PM +1000, Anton Blanchard wrote:
> > We don't support transactional memory in PR KVM, so don't tell
> > the OS that we do.
>=20
> This assumes PR KVM won't ever support TM, which is hopefully not
> true.  If PR KVM does get TM support in future, then QEMU will have no
> clear way to know whether it needs to clear the pa-features bit or
> not.  I think we need to define some way for the KVM implementation to
> tell qemu which of these kinds of CPU features it supports.

Yeah, I think we need some sort of capability flag for this.  We also
need to isolate this KVM capability testing better into the KVM code,
so we won't break things on TCG.

Speaking of which... I don't imagine we implement TM instructions in
TCG either, so we should probably make sure TM isn't advertised there
either.

> However, we could defer implementing that mechanism until PR KVM does
> get support for TM, I guess.  In that case this patch could go in now,
> though it seems slightly icky to be using the pvinfo stuff to
> distinguish PR from HV.

It is icky, but it's the best idiom we have for distinguishing PR
KVM.  We try to only do it as a fallback when we can't determine
availability of the specific feature based on a capability, though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXAzqFAAoJEGw4ysog2bOSls4P/3mnzu0EAvR8viNN74p7HM1S
8J0U1flwRhdKzHUkpRFOJZNzpZkjGXnRq1W/pslsSkYAvuByqwOoKUJTT2QZwJTN
J2LZNDa7hMKFfbOf6qOz6UR/INWHo+ZJAnGlQZdQTz4sf9bAiqAUdsgyelxF1VnO
jkD9dQMl1/o7cfKszoiJPMZ1ETfaAQ4QJlNcaEH3RqGrbl966hH2vMyQ5+Lii/wc
KDd2KPVMt+C7jBbTKYOA2hEG4Ystf7jw4CHrl96Vsv4LELThQL89edsNmV0xo+f8
0x4ktswUX3cmjEFa3wa6vYCEuoe0rnHJoVvQMmDKaPpIXS7nvxIdGOzERoAuNswP
ALJwJx2mfk+hrvZ69Ev4yOoJVaZ3Ts/QgoQ7sp4JaSOhwGmTkx4sVfqAU4IhXREr
AySWNHS/Lk33TeUwgf/yNkMUrJQ3S/vs30sjuUosRK1Y7l7q/GAOKhnaA7LItHKr
uxDD8fXm3PVO7hZLvg7c4I+Gel5Pq9k58d9Bq8QhdBHkZ40swFySnpBGh3CtVC3e
jnnui+/bRSJebdSEDkLm5MAFhUqbPbIhQhYtcfYqVhaySO5rfhd5Hz4wafy79jie
Wyw09cpYgtB6JQLyoobfyTVSlFTZbeOaySpYzQJdQxKchkzkpbkm3Jv30wgriwZS
BL3B2QoDAQNxcQ/wzJwW
=0d0X
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
