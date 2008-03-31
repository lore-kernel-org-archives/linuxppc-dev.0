Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3C91CDDECA
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 19:18:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Mon, 31 Mar 2008 11:08:58 +0200
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803281854.28595.laurentp@cse-semaphore.com>
	<47ED33FC.3020107@freescale.com>
In-Reply-To: <47ED33FC.3020107@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4442112.1e5vfN3VoT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311109.02422.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4442112.1e5vfN3VoT
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 28 March 2008 19:07, Scott Wood wrote:
> Laurent Pinchart wrote:
> > On Friday 28 March 2008 18:11, Scott Wood wrote:
> >> Laurent Pinchart wrote:
> >>> Locating the end of the muram isn't as straightforward as it
> >>> could be. As the current code already uses the beginning of the
> >>> muram to store the BDs and data buffers, should I really bother
> >>> locating the end or can I store the SMC parameter ram at the
> >>> beginning as well ?
> >> Maybe, but the end would be safer.  What's the problem with finding
> >> the end?
> >=20
> > That requires manual parsing of all the cells in the reg property.
> > The device-tree API doesn't provide a way to get the length of a
> > property,
>=20
> Sure it does.  Do a getprop with an insufficiently large buffer, and it
> tells you how much you really need. :-)

Ok thanks.

> > so I'll have to use a big enough pre-allocated buffer. I'm also not
> > sure if resources are guaranteed to be sorted in increasing order.
>=20
> Ah, good point.
>=20
> > This doesn't make finding the end of the muram really difficult. I
> > was just wondering if the increased code complexity was worth it,
> > especially seeing how the cpm_serial code in the boot wrapper seem
> > quite unstable.
>=20
> Unstable in what way?

I was refering to the virtual-reg (non-)issue I mentionned below.

> > I'm not familiar with the boot wrapper code so I'm sometimes not very
> >  confident in my assumptions, but isn't the handling of the
> > virtual-reg property in cpm_console_init broken ?
>=20
> Not as far as I can see.
>=20
> > If I'm not mistaken, getprop will return the address and size of the
> > first resource and not the addresses of the first two resources.
>=20
> No, it'll get as much of the virtual-reg property as will fit in the=20
> buffer.  There's no size in virtual-reg.

Ah right. Sorry about the misunderstanding.

> > What is virtual-reg used for ? To report the virtual address without
> > requiring a device tree walk ? Does it provide any information that
> > dt_xlate_reg can't find ?
>=20
> Yes, it tells you the virtual address when it's not an identity mapping.=
=20
>   It's not currently used on CPM platforms, but might be used down the=20
> road with a QE device on 85xx.

Will the virtual-reg property on the muram node list the addresses of all=20
muram chunks or the address of the first chunk only ?

> >> Even the end of the first reg resource would be OK.
> >=20
> > If I use the end of the first resource, can I assume it spans 0x0000
> > - 0x8000 to set the default tx BD address in Kconfig ?
>=20
> No, especially seeing as it doesn't on any existing boards. :-)

I still need a default value :-) It obviously won't work for all boards.

> You could set the default to just before 0x2000 with board-specific=20
> exceptions, though.

We're getting a bit lost. I'll try to summarize the discussion.

=2D The muram node has a reg property that lists the offsets and sizes of a=
ll=20
muram chunks, and an optional virtual-reg property that lists the virtual=20
address of all chunks/the first chunk only.

=2D From the above information I can locate a section of muram at the end o=
f the=20
first chunk (easy) or at the end of the muram (not really difficult, just a=
=20
bit more complex, especially if chunks are not sorted by their start=20
address).

=2D Kconfig needs a default address for the tx BD. This depends on the=20
allocation strategy (end of first chunk vs. end of last chunk). Is there so=
me=20
consistent default across QE devices ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4442112.1e5vfN3VoT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8Kou8y9gWxC9vpcRAmMpAJ9Dd22Yeij1f1QuYtMpRk9ziu9KDACgyFMP
8G1e4Z5hnyDBrS9XW0FIdro=
=yceM
-----END PGP SIGNATURE-----

--nextPart4442112.1e5vfN3VoT--
