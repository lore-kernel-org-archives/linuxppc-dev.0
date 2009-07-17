Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81E9CB708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 10:36:14 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 71FE3DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 10:36:14 +1000 (EST)
Subject: Re: [PATCH] Hold reference to device_node during EEH event handling
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Mason <mmlnx@us.ibm.com>
In-Reply-To: <4A5F5675.6040104@us.ibm.com>
References: <4A5E4D68.6070909@us.ibm.com>
	<1247708506.9851.8.camel@concordia>  <4A5F5675.6040104@us.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-sxjL+fttO2lckVm4fdFc"
Date: Fri, 17 Jul 2009 10:36:13 +1000
Message-Id: <1247790973.16836.11.camel@concordia>
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


--=-sxjL+fttO2lckVm4fdFc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-16 at 09:33 -0700, Mike Mason wrote:
> Michael Ellerman wrote:
> > On Wed, 2009-07-15 at 14:43 -0700, Mike Mason wrote:
> >> This patch increments the device_node reference counter when an EEH
> >> error occurs and decrements the counter when the event has been
> >> handled.  This is to prevent the device_node from being released until
> >> eeh_event_handler() has had a chance to deal with the event.  We've
> >> seen cases where the device_node is released too soon when an EEH
> >> event occurs during a dlpar remove, causing the event handler to
> >> attempt to access bad memory locations.
> >>
> >> Please review and let me know of any concerns.
> >=20
> > Taking a reference sounds sane, but ...
> >=20
> >> Signed-off-by: Mike Mason <mmlnx@us.ibm.com>=20
> >>
> >> --- a/arch/powerpc/platforms/pseries/eeh_event.c	2008-10-09 15:13:53.0=
00000000 -0700
> >> +++ b/arch/powerpc/platforms/pseries/eeh_event.c	2009-07-14 14:14:00.0=
00000000 -0700
> >> @@ -75,6 +75,14 @@ static int eeh_event_handler(void * dumm
> >>  	if (event =3D=3D NULL)
> >>  		return 0;
> >> =20
> >> +	/* EEH holds a reference to the device_node, so if it
> >> +	 * equals 1 it's no longer valid and the event should
> >> +	 * be ignored */
> >> +	if (atomic_read(&event->dn->kref.refcount) =3D=3D 1) {
> >> +		of_node_put(event->dn);
> >> +		return 0;
> >> +	}
> >=20
> > That's really gross :)
>=20
> Agreed.  I'll look for another way to determine if device is gone and
> the event should be ignored.  Suggestions are welcome :-)

Benh and I had a quick chat about it, and were wondering whether what
you really should be doing is taking a reference to the pci device
(perhaps as well as the device node).

@@ -140,7 +149,7 @@ int eeh_send_failure_event (struct devic
        if (dev)
                pci_dev_get(dev);
=20
-       event->dn =3D dn;
+       event->dn =3D of_node_get(dn);
        event->dev =3D dev;

pci devs are refcounted too, see pci_dev_get(), so taking a reference
there would be the "right" thing to do - otherwise there's no guarantee
it still exists later, unless there's some other trick in the EEH code.

Taking a reference would presumably block a concurrent hotunplug until
you'd processed the EEH event and dropped your reference. That might be
OK, or you could add a hotplug notifier to the EEH code and drop the
reference there and mark the event as handled or something.

All of that with the caveat that I don't really know the EEH or hotplug
code :D

cheers




--=-sxjL+fttO2lckVm4fdFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpfx30ACgkQdSjSd0sB4dI/jACghIaiIGQcSxo5niyNJrlXeUwz
Ns8AoLjTFoSBQZ8LtW48Al/ULzEQvgNe
=uyyC
-----END PGP SIGNATURE-----

--=-sxjL+fttO2lckVm4fdFc--
