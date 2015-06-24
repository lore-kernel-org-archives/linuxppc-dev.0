Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49B4F1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:09:41 +1000 (AEST)
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F223D140319
 for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2015 15:09:38 +1000 (AEST)
Received: by pactm7 with SMTP id tm7so21391209pac.2
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2015 22:09:36 -0700 (PDT)
Message-ID: <1435122485.28543.34.camel@axtens.net>
Subject: Re: [PATCH] powerpc: Set the correct kernel taint on machine check
 errors.
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Wed, 24 Jun 2015 15:08:05 +1000
In-Reply-To: <1435122019.3620.6.camel@ellerman.id.au>
References: <1434338719-8416-1-git-send-email-dja@axtens.net>
 <1435122019.3620.6.camel@ellerman.id.au>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-x48SKaz11FLKsMU0GgOO"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-x48SKaz11FLKsMU0GgOO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2015-06-24 at 15:00 +1000, Michael Ellerman wrote:
> On Mon, 2015-06-15 at 13:25 +1000, Daniel Axtens wrote:
> > This means the 'M' flag will work properly when the kernel prints a bac=
ktrace.
> >=20
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> > ---
> >  arch/powerpc/kernel/traps.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index 6530f1b..37de90f 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -297,6 +297,8 @@ long machine_check_early(struct pt_regs *regs)
> > =20
> >  	__this_cpu_inc(irq_stat.mce_exceptions);
> > =20
> > +	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
>=20
> I'm not sure about the lockdep bit.
>=20
> I guess it's safer to just declare it fubar.
>=20
I'm also not sure; I was matching x86 behaviour.

> Does this fix a bug, or just nice to have?
>=20
If you consider having the taint bits set incorrectly to be a bug, then
it fixes a bug. Otherwise, it's just nice debug info to have: when we
get a traceback with M set that isn't obviously related to a MCE we are
forewarned.

> cheers
>=20
>=20

--=20
Regards,
Daniel

--=-x48SKaz11FLKsMU0GgOO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVijtGAAoJEPC3R3P2I92F4RQQAIJB02MawjSJa6a0NB8BvQuX
wRQBDLxbLrAiOuNmyPqUnv9STmhpuINSALcLSaTC6Bgw7Pfc6N0/6RvHkshZUMeP
Zc/eEr3Q9X2E5P4dSCvNIxK7ktalnhkQp5EAhPSY3Up/U9xIvNsJc0FPvEvvkGRm
fMpsJscKyubN/n6HrUwkpStByhneMjrZiJ38XHKYkQYpWxdEc2CHXErCFC1tfIEY
+SWZdVRKkOJjMyrbGVQ1O6ACR5QvK5G4YTjCozEC4au9PlIAwMKSqaY6IX6Q1k58
AdZZMCO2im0YpvWr70Jig8/+07dEiL3R6UgEfyoVZxohiQuvltNUkix9L0EMbKIP
IMsDaABK6k5tvVRa4duYycQD3PN/Du5plOmY1amJDLTNn6XJkdlVamVXVNWgE+nS
dMv3O9WscbUFxi0e+lMGlHY3BBXjS5hvsVB5qtDPxmYiw4ZSMHs8hurDzym0j371
jZGHAVKPYQsF30a/lbC/D/HyBqHAZ6mhn/zK+zxOwp7iwfuHsWgk/Va8aS8skU7O
5l3WIjpZLwqHZ5khbNQq5MlMgYx5CTpci4NlH77RgyRwajdY3ctJxHzf5gdS30On
Q9Oc78kbJcCksdXQx5Ha1RaTawqqNmilF3qVV0f5JsDRiHIpZbVDqf0x5YmVl1rB
uETxOWR5DVSYrra0BFFD
=YfWV
-----END PGP SIGNATURE-----

--=-x48SKaz11FLKsMU0GgOO--
