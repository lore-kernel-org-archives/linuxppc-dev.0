Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3E0CCB70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 10:27:45 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 24AECDDDE2
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 10:27:45 +1000 (EST)
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
To: Neil Horman <nhorman@redhat.com>
In-Reply-To: <20090623135604.GC1157@hmsreliant.think-freely.org>
References: <20090617113456.GC31595@in.ibm.com>
	<20090617114551.GA5672@verge.net.au>
	<20090617115917.GD31595@in.ibm.com>
	<1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ggNhO6RKgPj9FrJxG8iU"
Date: Wed, 24 Jun 2009 10:27:43 +1000
Message-Id: <1245803263.9237.3.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, miltonm@bga.com,
	Simon Horman <horms@verge.net.au>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-ggNhO6RKgPj9FrJxG8iU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-06-23 at 09:56 -0400, Neil Horman wrote:
> On Tue, Jun 23, 2009 at 06:25:34PM +0530, M. Mohan Kumar wrote:
> > On Wed, Jun 17, 2009 at 10:40:07AM -0400, Neil Horman wrote:
> > =20
> > > > send objdump of fs2dt.o with and without this assignment.
> > > >=20
> > > That would be a fine thing to do, and I'd be happy to compare them.  =
My though
> > > regarding the comparison of the device tree on a good and bad run was=
 meant to
> > > expidite what change in the assembly we'd be looking for.  If its the=
 kdump
> > > kernel boot thats hanging, Its likely hanging on something in the dev=
ice tree,
> > > as thats whats being manipulated by this code.  So I figure that unde=
rstanding
> > > whats changed there will point us toward what change in the assembly =
might be
> > > responsible for the hang.  The assmebly's going to be signficantly di=
fferent
> > > (lots of optimization might be lost from no longer inlining a functio=
n), so
> > > anything that helps us narrow down whats changed will be good
> >=20
> > I am attaching the objdumps of fs2dt with and without dt_len.
> >=20
> Well it definately looks like removing that variable had some code change=
s.
> It'll take some time to match it up to source, but Most interesting I thi=
nk is
> the variance in putprops around address f34.  Looks like its doing some s=
tring
> maniuplation in a reversed order, using a huge offset.  Might be worthwhi=
le to
> check to see if theres any string overruns in this code.

Yeah I still suspect it's just a bug in the code that's being exposed
now.

Mohan, can you try running it under valgrind?

cheers

--=-ggNhO6RKgPj9FrJxG8iU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpBcv8ACgkQdSjSd0sB4dIrYgCeOc0NKJAe0vj8YBryzOSF47S1
6o0AoIwG689eO7S+Neae/5wgpE8f1Ydn
=xAmA
-----END PGP SIGNATURE-----

--=-ggNhO6RKgPj9FrJxG8iU--
