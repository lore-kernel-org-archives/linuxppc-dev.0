Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71D3F1A06DF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 13:29:27 +1000 (AEST)
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B2FAE140293
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2015 13:29:25 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so45570390pac.2
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 20:29:24 -0700 (PDT)
Message-ID: <1433993307.31423.35.camel@axtens.net>
Subject: Re: [PATCH V8 02/10] powerpc, perf: Restore privillege level filter
 support for BHRB
From: Daniel Axtens <dja@axtens.net>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Date: Thu, 11 Jun 2015 13:28:27 +1000
In-Reply-To: <557828CB.9080806@linux.vnet.ibm.com>
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1433907837.3096.11.camel@axtens.net> <557828CB.9080806@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-MVoVjj189XMa3Tj5Ek5j"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-MVoVjj189XMa3Tj5Ek5j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> >> =20
> >> -	if (!(ppmu->flags & PPMU_ARCH_207S)) {
> >> +	if (!(ppmu->flags & PPMU_ARCH_207S) || cpuhw->bhrb_users)
>=20
> > You're using cpuhw->bhrb_users as a bool here, where it's an int. Could
> > you make the test more specific so that it's clear exactly what you're
> > expecting bhrb_users to contain?
>=20
> Using cpuhw->bhrb_users as a bool just verifies whether it contains
> zero or non-zero value in it. The test seems to be doing that as
> expected. But yes, we can move it as a nested conditional block as
> well if that is better.
>=20

What I meant was, should this read (cpuhw->bhrb_users !=3D 0)? Because
bhrb_users in check_excludes() is a signed int, I also wanted to make
sure it shouldn't be a test for bhrb_users > 0 instead. (Also, if
bhrb_users is always positive, should it be an unsigned int?)

I don't think a nested conditional would be better.=20



> >> -	if (check_excludes(ctrs, cflags, n, 1))
> >> +	cpuhw =3D &get_cpu_var(cpu_hw_events);
> > Should this be using a this_cpu_ptr rather than a get_cpu_var? (as with
> > the power_pmu_commit_txn case?)
> >> +	if (check_excludes(ctrs, cflags, n, 1, cpuhw->bhrb_users)) {
> >> +		put_cpu_var(cpu_hw_events);
> > Likewise with this?
> >>  		return -EINVAL;
> >> +	}
> >> =20
> >> -	cpuhw =3D &get_cpu_var(cpu_hw_events);
>=20
> This patch just moves the existing code couple of lines above without
> changing it in any manner.
>=20
I see that, but I still think you should take this opportunity to
improve it.

Regards,
Daniel

--=-MVoVjj189XMa3Tj5Ek5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVeQBbAAoJEPC3R3P2I92FpjgQAMDbT6Ylm+Sgniy3GQFnW4qk
eBofUKMLaBNXCcfMxfGYtY5RFAzBYr6u/E0gMjkvQzG56/2zGYSeqTN+fiDkbWgW
xH7q1lI2r7evQn0Z5uZ7hM2F0eggXR9OrUchSMLLQhTXFLxojbn5jjFGBvuNJmjU
+T3YAEHkgfTo98Ch+XDvibkZhX8bXMYh92qWYB97c9zoL+BN3AqEjMQFwuNVsc7X
XWm3oSUZkPyfkYyCiWB8/FjAeJESdaV8wSecXTkGh3IpBEM4Kwu+J3NnBudwlWkc
CCfGS8ESSEGcZGlbMJ2lhbcX7yQn/zGOABYy6IffJc4E+clJEGmFd1ueC8AB15b2
0//KxGE9B2wenvwTsmkNZGvxuKw+CY337e0FMxV1Jy8UEG64PHh483uS0osEEBjQ
jT5ZpzMQj3zhX15N16wLCbo5Wv6DQdQabdXo6KLmpk1fbz571Ry0aEbg2ei0Oe0S
7dchRQhTJ345sEXjBg+PtVZsJxmNb7ZWPuRo5VZDaOtd31HCaj+AtR98owKxFR3I
TTr4sc9ZtlOh4+pSf7lD9/JxEnEyfLw2vtIx1FfvTgj1QVCEMBi6wLRlPo2lLKN3
6nDWiWIVr/VBS020eEsI3nWtHZd9b0ZoRLE951GITBhKW5l9MYQY/Z/gFiPqn9ea
0fPcXWWz9cEIoA1ElMx+
=CizQ
-----END PGP SIGNATURE-----

--=-MVoVjj189XMa3Tj5Ek5j--
