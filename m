Return-Path: <emunson@mgebm.net>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28531B6F75
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 07:27:40 +1000 (EST)
Received: by qyk29 with SMTP id 29so3044889qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Apr 2011 14:27:37 -0700 (PDT)
Date: Wed, 6 Apr 2011 17:27:33 -0400
From: Eric B Munson <emunson@mgebm.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Message-ID: <20110406212733.GB2596@mgebm.net>
References: <1301059689-4556-1-git-send-email-emunson@mgebm.net>
	<1301378637.2402.671.camel@pasglop>
	<20110329142519.GA3527@mgebm.net>
	<1301433165.2402.689.camel@pasglop>
	<20110330183656.GA2564@mgebm.net>
	<1301551476.2407.61.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
In-Reply-To: <1301551476.2407.61.camel@pasglop>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Mar 2011, Benjamin Herrenschmidt wrote:

> On Wed, 2011-03-30 at 14:36 -0400, Eric B Munson wrote:
> > On Wed, 30 Mar 2011, Benjamin Herrenschmidt wrote:
> >=20
> > > On Tue, 2011-03-29 at 10:25 -0400, Eric B Munson wrote:
> > > > Here I made the assumption that the hardware would never remove mor=
e events in
> > > > a speculative roll back than it had added.  This is not a situation=
 I
> > > > encoutered in my limited testing, so I didn't think underflow was p=
ossible.  I
> > > > will send out a V2 using the signed 32 bit delta and remeber to CC =
stable
> > > > this time.=20
> > >=20
> > > I'm not thinking about underflow but rollover... or that isn't possib=
le
> > > with those counters ? IE. They don't wrap back to 0 after hitting
> > > ffffffff ?
> > >=20
> >=20
> > They do roll over to 0 after ffffffff, but I thought that case was alre=
ady
> > covered by the perf_event_interrupt.  Are you concerned that we will re=
set a
> > counter and speculative roll back will underflow that counter?
>=20
> No, but take this part of the patch:
>=20
> > --- a/arch/powerpc/kernel/perf_event.c
> > +++ b/arch/powerpc/kernel/perf_event.c
> > @@ -416,6 +416,15 @@ static void power_pmu_read(struct perf_event *even=
t)
> >  		prev =3D local64_read(&event->hw.prev_count);
> >  		barrier();
> >  		val =3D read_pmc(event->hw.idx);
> > +		/*
> > +		 * POWER7 can roll back counter values, if the new value is
> > +		 * smaller than the previous value it will cause the delta
> > +		 * and the counter to have bogus values.  If this is the
> > +		 * case skip updating anything until the counter grows again.
> > +		 * This can lead to a small lack of precision in the counters.
> > +		 */
> > +		if (val < prev)
> > +			return;
> >  	} while (local64_cmpxchg(&event->hw.prev_count, prev, val) !=3D prev);
>=20
> Doesn't that mean that power_pmu_read() can only ever increase the value =
of
> the perf_event and so will essentially -stop- once the counter rolls over=
 ?
>=20
> Similar comments every where you do this type of comparison.
>=20
> Cheers,
> Ben.

Sorry for the nag, but am I missing something about the way the register and
the previous values are reset in the overflow interrupt handler?

Thanks,
Eric

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNnNrFAAoJEH65iIruGRnNDSgIANiVEWRw2KhUErflFUPV0Gs4
w8+7Bz1xPAdiPprxe7DbYn9GxEyvJ23kCmnCxetFrixX1+o0SPT0iyVip4GRfWHw
oLDXuRCuqrOjctugNIfJM+CFAxlOtzooKjedXjlRsTCW+BMv7CvjahQR0+ecpunh
0462K+CUTJh42ZBbJaRiomiWWMveRvInXpKYVarHaOO6OfqYl7p21UvFomTUyu8Z
NTk0X38TG4KEfpghr3aIHKwYFCBE53bRE54A3LnQijq0P1CxHWEQgpRulHwRZZwz
r4uPrs23gBuMeh5I/lToWGRv1G+QW4TVh5wqGkHR85XussvYA4Bpm29WpR8cX5Y=
=X0/4
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
