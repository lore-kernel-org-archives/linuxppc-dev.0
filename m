Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E5B6DDDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 08:52:59 +1000 (EST)
Subject: Re: [PATCH] powerpc/pci: Move pseries code into pseries platform
	specific area
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <41163AE2-5EE9-4273-B2F2-373034AE4DC4@kernel.crashing.org>
References: <1241100846-14216-1-git-send-email-galak@kernel.crashing.org>
	<1241102965.7356.7.camel@concordia>
	<41163AE2-5EE9-4273-B2F2-373034AE4DC4@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-84zEvm9FNjA/Bjt+rbmJ"
Date: Fri, 01 May 2009 08:52:58 +1000
Message-Id: <1241131978.6928.0.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-84zEvm9FNjA/Bjt+rbmJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-04-30 at 10:35 -0500, Kumar Gala wrote:
> On Apr 30, 2009, at 9:49 AM, Michael Ellerman wrote:
>=20
> > On Thu, 2009-04-30 at 09:14 -0500, Kumar Gala wrote:
> >> There doesn't appear to be any specific reason that we need to =20
> >> setup the
> >> pseries specific notifier in generic arch pci code.  Move it into =20
> >> pseries
> >> land.
> >
> > Yeah I guess. Although if some other platform ever wants to do PCI
> > hotplug it probably wants to call update_dn_pci_info() also.
>=20
> when that happens we can worry about, also the code I moved is pretty =20
> pseries specific  (seeing as the event is called PSERIES_RECONFIG_ADD)

Yeah I agree.

> >> --- a/arch/powerpc/platforms/pseries/setup.c
> >> +++ b/arch/powerpc/platforms/pseries/setup.c
> >> @@ -254,6 +255,31 @@ static void __init pseries_discover_pic(void)
> >>               " interrupt-controller\n");
> >> }
> >>
> >> +extern void * update_dn_pci_info(struct device_node *dn, void =20
> >> *data);
> >
> > Ahem :)
>=20
> Yeah, was being lazy.  I'll move it into asm/pci-bridge.h

Please do :)

cheers


--=-84zEvm9FNjA/Bjt+rbmJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkn6K8oACgkQdSjSd0sB4dKOQgCggKJcV3/Hjfevg6/8HZtymJr5
fScAnRZEeBBEy0uxTIZsMARiQrpYKiUS
=9CkW
-----END PGP SIGNATURE-----

--=-84zEvm9FNjA/Bjt+rbmJ--
