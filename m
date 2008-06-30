Return-Path: <emunson@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36B55DE2B6
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 01:56:55 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5UFuqwf020033
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 11:56:52 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5UFuaKu120606
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 09:56:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5UFuW8L011414
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 09:56:32 -0600
Date: Mon, 30 Jun 2008 08:56:30 -0700
From: Eric B Munson <ebmunson@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V2] Keep 3 high personality bytes across exec
Message-ID: <20080630155630.GA8445@us.ibm.com>
References: <20080628000813.GA19960@us.ibm.com>
	<18536.38684.384039.662264@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <18536.38684.384039.662264@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jun 2008, Paul Mackerras wrote:

> Eric B Munson writes:
>=20
> > --- a/include/asm-powerpc/elf.h
> > +++ b/include/asm-powerpc/elf.h
> > @@ -257,7 +257,8 @@ do {								\
> >  	else							\
> >  		clear_thread_flag(TIF_ABI_PENDING);		\
> >  	if (personality(current->personality) !=3D PER_LINUX32)	\
> > -		set_personality(PER_LINUX);			\
> > +		set_personality(PER_LINUX |			\
> > +			(current->personality & PER_INHERIT));	\
>=20
> Couldn't we use ~PER_MASK here instead of PER_INHERIT?  That would
> mean we wouldn't have to modify include/linux/personality.h, and we
> wouldn't have to keep updating PER_INHERIT as more flags get added.
>=20
> (Nice patch description, BTW.  Thanks.)
>=20
> Paul.
>=20

Yeah, ~PER_MASK will work fine.  I used PER_INHERIT first because I
was not sure if there were values that should not be carried forward.
I will have an updated patch out shortly.

Eric

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIaQIusnv9E83jkzoRAjBzAJ9bQ+qYRJSc7v+Xnd0p2KLekE8oWQCgsDHz
UNvamXxuUJ461lmmtsQMZh4=
=yDrU
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
