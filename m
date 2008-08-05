Return-Path: <michael@ellerman.id.au>
Subject: Re: to schedule() or not to schedule() ?
From: Michael Ellerman <michael@ellerman.id.au>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <4898A96B.40502@hypersurf.com>
References: <4895F9EB.8050508@hypersurf.com> <48989DFE.7080506@nortel.com>
	<4898A96B.40502@hypersurf.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HolnNUbUTfvgVvTTOeJs"
Date: Wed, 06 Aug 2008 09:00:56 +1000
Message-Id: <1217977256.7593.2.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HolnNUbUTfvgVvTTOeJs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-08-05 at 12:26 -0700, Kevin Diggs wrote:
> Chris Friesen wrote:
> > Kevin Diggs wrote:

> >>     I have the following near the top of my cpufreq driver target=20
> >> routine:
> >>
> >> while(test_and_set_bit(cf750gxmCfgChangeBit,&cf750gxvStateBits)) {
> >>         /*
> >>          * Someone mucking with our cfg? (I hope it is ok to call
> >>          * schedule() here! - truth is I have no idea what I am doing
> >>          * ... my reasoning is I want to yeild the cpu so whoever is
> >>          * mucking around can finish)
> >>          */
> >>         schedule();
> >> }
> >>
> >> This is to prevent bad things from happening if someone is trying to=20
> >> change a parameter for the driver via sysfs while the target routine=20
> >> is running. Fortunately, because I had a bug where this bit was not=20
> >> getting cleared on one of the paths through the target routine ... I=20
> >> now know it is not safe to call schedule (it got stuck in there -=20
> >> knocked out my adb keyboard! - (I think target is called from a timer=20
> >> that the governor sets up ... interrupt context?)).
> >=20
> >=20
> > Is the issue that someone may be in the middle of a multi-stage=20
> > procedure, and you've woken up partway through?
> >=20
> > If so, what about simply rescheduling the timer for some short time in=20
> > the future and aborting the current call?

> Chris,
>=20
> 	Thanks for taking the time to reply. The parameter in question modifies=20
> the frequency table. It is used several times in the target routine.=20
> I've addressed the issue by making a local copy of the frequency table=20
> upon entry to the target routine and use that while there. I don't care=20
> who wins the race.

How are you copying the table? Is it an atomic copy? Otherwise you could
just end up copying the table while it's being updated, and you get a
copy of the partially updated table.

Don't you just need a spinlock?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HolnNUbUTfvgVvTTOeJs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBImNuodSjSd0sB4dIRAg1qAJ91sV2vNv06gNo9Hs7VBHgMXmhtkQCfYKbf
Waf4s+Ci7zLaMdzLtQzss3Q=
=O7rA
-----END PGP SIGNATURE-----

--=-HolnNUbUTfvgVvTTOeJs--
