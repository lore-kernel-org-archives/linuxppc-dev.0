Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E5CBDB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 00:24:22 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8FBCDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 00:24:22 +1000 (EST)
Subject: Re: [PATCH] Do not inline putprops function
From: Michael Ellerman <michael@ellerman.id.au>
To: mohan@in.ibm.com
In-Reply-To: <20090805164938.GA2970@in.ibm.com>
References: <1245241595.4269.15.camel@concordia>
	<20090617130413.GB2774@localhost.localdomain>
	<20090617133435.GB4059@in.ibm.com>
	<20090617140514.GB31383@hmsreliant.think-freely.org>
	<20090617142652.GC4059@in.ibm.com>
	<20090617144007.GC31383@hmsreliant.think-freely.org>
	<20090623125534.GA8664@in.ibm.com>
	<20090623135604.GC1157@hmsreliant.think-freely.org>
	<1245803263.9237.3.camel@concordia> <20090803054919.GA19594@in.ibm.com>
	<20090805164938.GA2970@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-2VJu83n7jjuqsVREaLR4"
Date: Fri, 07 Aug 2009 00:24:20 +1000
Message-Id: <1249568660.20200.23.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Neil Horman <nhorman@redhat.com>,
	Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org,
	miltonm@bga.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-2VJu83n7jjuqsVREaLR4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-08-05 at 22:19 +0530, M. Mohan Kumar wrote:
> Hi,
>=20
> When I align the dtstruct variable to 8 bytes, I am able to invoke kdump.
>=20
> When the line
> 	static unsigned dtstruct[TREEWORDS], *dt;
> changed to=20
> 	static unsigned dtstruct[TREEWORDS] __attribute__ ((aligned (8))), *dt;
>=20
> kexec-tool works.

Hmm, odd.

Can you check how it's aligned without your change? ie. in the original
binary, is it 4 byte aligned?

When you make the change, is the only thing that changes in the binary
the alignedness of dtstruct, or does it cause other things to move
around?

I don't think an unaligned dt blob should have any effect on the kernel,
ie. it should copy it in fine, but I'd have to look at the code.

cheers

--=-2VJu83n7jjuqsVREaLR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp655QACgkQdSjSd0sB4dJuXwCfVJK7BSEqe7YKDSjxu+ZWyJLV
qBUAn3xYesv3ml8hG97w2HG0HssSops2
=xnLC
-----END PGP SIGNATURE-----

--=-2VJu83n7jjuqsVREaLR4--
