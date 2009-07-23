Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 47177B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 11:21:44 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0FD4DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 11:21:43 +1000 (EST)
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Mason <mmlnx@us.ibm.com>
In-Reply-To: <4A67A3A2.4050508@us.ibm.com>
References: <4A5E4D68.6070909@us.ibm.com>
	<1247708506.9851.8.camel@concordia> <4A5F5675.6040104@us.ibm.com>
	<1247790973.16836.11.camel@concordia>  <4A67A3A2.4050508@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-TqUv7DC9d1TUKFSFpgG9"
Date: Thu, 23 Jul 2009 11:21:42 +1000
Message-Id: <1248312102.6543.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-TqUv7DC9d1TUKFSFpgG9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-07-22 at 16:41 -0700, Mike Mason wrote:
> Michael Ellerman wrote:
> > On Thu, 2009-07-16 at 09:33 -0700, Mike Mason wrote:
> >> Michael Ellerman wrote:
> >>> On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
> >>>> This patch increments the device_node reference counter when an EEH
> >>>> error occurs and decrements the counter when the event has been
> >>>> handled.  This is to prevent the device_node from being released unt=
il
> >>>> eeh_event_handler() has had a chance to deal with the event.  We've
> >>>> seen cases where the device_node is released too soon when an EEH
> >>>> event occurs during a dlpar remove, causing the event handler to
> >>>> attempt to access bad memory locations.
> >>>>
> >>>> Please review and let me know of any concerns.
> >>> Taking a reference sounds sane, but ...
> >>>
> >>>> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>=20
> >>>>
> >>>> --- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53=
.000000000 -0700
> >>>> +++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00=
.000000000 -0700
> >>>> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
> >>>>  	if (event =3D=3D NULL)
> >>>>  		return 0;
> >>>> =20
> >>>> +	/* EEH holds a reference to the device_node, so if it
> >>>> +	 * equals 1 it's no longer valid and the event should
> >>>> +	 * be ignored */
> >>>> +	if (atomic_read(&event->dn->kref.refcount) =3D=3D 1) {
> >>>> +		of_node_put(event->dn);
> >>>> +		return 0;
> >>>> +	}
> >>> That's really gross :)
> >> Agreed.  I'll look for another way to determine if device is gone and
> >> the event should be ignored.  Suggestions are welcome :-)
>=20
> Actually, it turns out the atomic_read() isn't necessary.  I just need
> to take the reference to the device_node when the EEH error is
> detected and let EEH try to handle the error.  EEH detects the fact
> that the device is no longer valid, aborts the recovery attempt, then
> gives the device_node reference back.  Works as expected.

How does it detect that the device is no longer valid?

> I'll resubmit the patch without the atomic_read().
>=20
> >=20
> > Benh and I had a quick chat about it, and were wondering whether what
> > you really should be doing is taking a reference to the pci device
> > (perhaps as well as the device node).
>=20
> EEH already does that 3 lines before the of_node_get (see below).

Ah right, while you're touching the code, mind changing it to the
simpler and more obvious:

>         event->dev =3D pci_dev_get(dev);

cheers


--=-TqUv7DC9d1TUKFSFpgG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpnuyMACgkQdSjSd0sB4dJReQCgvlsRk0D4fTmRG8Yay9cplmXr
/hQAoMR2IUoTPVsd7DKTNe1iOCRJaJau
=PZ2P
-----END PGP SIGNATURE-----

--=-TqUv7DC9d1TUKFSFpgG9--
