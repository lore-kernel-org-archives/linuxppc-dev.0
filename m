Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ynYFV5NCVzDrny
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 21:15:42 +1100 (AEDT)
Date: Thu, 30 Nov 2017 16:11:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: a3b2cb30 broken panic reporting for qemu guests
Message-ID: <20171130051126.GE3023@umbus.fritz.box>
References: <20171129040652.GF3023@umbus.fritz.box>
 <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vN1VrOpIkjMGbM/7"
In-Reply-To: <20171129142343.1e371cbb@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vN1VrOpIkjMGbM/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 02:23:43PM +1000, Nicholas Piggin wrote:
> On Wed, 29 Nov 2017 15:06:52 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > a3b2cb30 "powerpc: Do not call ppc_md.panic in fadump panic notifier"
> > purports to fix a problem when the kernel panics with fadump not
> > registered, but it breaks something else instead.  I _think_ it was
> > working on the incorrect assumption that ppc_md.panic was (or should
> > be) only used with fadump, but I'm not really sure.
> >=20
> > Panic works with kdump enabled, and (I think) with fadump enabled).
> > However, with neither of these enabled, we always go to the generic
> > panic logic.
>=20
> Yeah thanks, I can't remember what assumption I was working on tbh.
> =20
> > That's incorrect for PAPR guests - they should call ibm,os-term via
> > RTAS.  Under qemu this leads to a "GUEST_PANICKED" event notification
> > which higher-level management pays attention to.  Since a3b2cb30 we
> > now reboot instead of reporting that.
> >=20
> > I believe it will also break panic for PS3 machines, but since that
> > platform basically no longer exists, we probably don't care.
>=20
> I (hope) it should just go down to the normal panic path and not do
> much worse than it already does -- although it won't print out that
> message.
>=20
> > I'm not entirely sure how to fix this.  I _think_ what we want is to
> > call ppc_md.panic from a late panic notifier, the way this patch does
> > for fadump_panic_event() if fadump is registered.
>=20
> The problem I had there is that some of the printk and console stuff
> wasn't getting flushed out, so I was getting a blank screen. This was
> probably in conjunction with panicing from NMI context that we're now
> starting to introduce.
>=20
> So it's a bit annoying. There's other ugliness we have for being unable
> to control panic code well enough from arch code
> (arch/powerpc/platforms/powernv/opal.c)
>=20
> I guess a really minimal fix is to put an #ifdef powerpc down the bottom
> there (/me *cries*).

Um.. right.  I'm not really sure from that how to go forward from
here.  We want to fix this for RHEL7.5, which doesn't give us a lot of
time.

Adding the #ifdef at the bottom of the generic panic code is gross,
but there's already a bunch of that, so maybe adequate until a better
solution can be found?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vN1VrOpIkjMGbM/7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofkv4ACgkQbDjKyiDZ
s5JDDw//fdILwP4FPd/xeqsrEJwc3O0MN6bZH2j535fnS6PUPRMT7KK2RqTl0VNO
04oHKPfl6UFVhinnkQaiWYgPttHzbtTFIFTmZUCq5iGLQZ9WoGvjZbU5vFoLMf+z
Kus4ffs0TL7VsQCVzgxJq4L6vOCLwQrp98mJfn+/XDfu0cuNCCoxzQ8mD2FrOp+K
/ikPRLQeJFAcyua03auPI5YU1kPwnbKmNsJVmfXAk70KF4mCA+M1RGTR4lmX2PLF
C+0G2aOR51WEf0EKAin9z9cLVd1zLJWUamwTZ0cG989n9T9xtd0AlDKMcK1LaHyY
yXb+lg89h6Ht1qYQiQvLzgWyjkFxrsmF/grtBgaIleAGmrGBK3P68MDA5sipAfoT
xN2ZMoQ6C5vQJaIkoydGF4qmgdR/e2soSm74blf4nJ/8lT37Q4hiTQw5rg3rtiWb
mTRu/+j3lNFt45OAVyNf8seLCq29jHdplvHuOKAYHbxzjOBqNXTrAV0tTg/6wXYS
LtThu5gPFb3W8l+3tlC+wIyaSpxS+UVfBUd+8a5C42LizrZDvAK+cB4Wp+VjUTab
2ftQLkg6kQ5w5Ia5ERwwomnVuxmcYeV7CPGNvPQI0hgvmHwL6Svvxzwy5uirUz3g
+Cb5XpRTD3zG2Os6kqnqZC7ItxqEIkK4L/iRR9MUIeuZvPvCFvY=
=uPmi
-----END PGP SIGNATURE-----

--vN1VrOpIkjMGbM/7--
