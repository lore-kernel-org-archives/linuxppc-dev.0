Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fWd46yH2zF14h
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 15:38:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w475TJeE136712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 May 2018 01:38:46 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2htc6bywkf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2018 01:38:45 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Mon, 7 May 2018 06:38:44 +0100
Date: Mon, 7 May 2018 15:38:38 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 03/13] powerpc/eeh: Fix use-after-release of EEH driver
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <e50359f9211fcdc342401806ab65aa092c63e7b9.1525242772.git.sbobroff@linux.ibm.com>
 <871ses9lhk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5oH/S/bF6lOfqCQb"
In-Reply-To: <871ses9lhk.fsf@concordia.ellerman.id.au>
Message-Id: <20180507053837.GE18123@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5oH/S/bF6lOfqCQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 12:56:55PM +1000, Michael Ellerman wrote:
> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>=20
> > Correct two cases where eeh_pcid_get() is used to reference the driver's
> > module but the reference is dropped before the driver pointer is used.
> >
> > In eeh_rmv_device() also refactor a little so that only two calls to
> > eeh_pcid_put() are needed, rather than three and the reference isn't
> > taken at all if it wasn't needed.
>=20
> This sounds like a crash or memory corruption bug?
>=20
> But it doesn't have Fixes or Cc: stable. Is it not a major problem for
> some reason?

Only that I've exercised that code path a fair bit during testing and
never managed to cause a problem with it. I found it by inspection.

Do you think I should mark it fixes or stable in the next version?

> cheers
>=20

--5oH/S/bF6lOfqCQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEELWWF8pdtWK5YQRohMX8w6AQl/iIFAlrv5l0ACgkQMX8w6AQl
/iKrrgf+M8Ww9WyG8KVMt1IZy/I+0AkpLTx1ZWhX4+igruhGOIel8bOj9yU7HRvV
EOM6HSdI3oJ4ILYsAZi4vs2zWmeRHP0vH0gW1jntvATmnNtRswWSQvJidRb4wunM
7H/k5oet6Ai3IVUFpmlWyDjnonP02PFdrmOGtWWTek3d6q1ZGZhYD2VzVpHK9rW/
syLYrsReftgqh5b2YM+musvZq5gX/n7KoUEseRmGYMPD6WCFW5LAlx0om7W2hZ8w
YXKsYAw2SLG9chn4Vp99i0rYSqn1mNnnU8hrxDOdJCW0iFrscjWrWStpRivZnsR+
1zfhxWB0m/vPIpa2m32KCMyZk+mvAA==
=YQ+I
-----END PGP SIGNATURE-----

--5oH/S/bF6lOfqCQb--
