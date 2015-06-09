Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 622E91A02D6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 14:56:59 +1000 (AEST)
Date: Tue, 9 Jun 2015 14:22:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v12 09/34] vfio: powerpc/spapr: Move locked_vm
 accounting to helpers
Message-ID: <20150609042212.GE11000@voom.redhat.com>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
 <1433486126-23551-10-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
In-Reply-To: <1433486126-23551-10-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 04:35:01PM +1000, Alexey Kardashevskiy wrote:
> There moves locked pages accounting to helpers.
> Later they will be reused for Dynamic DMA windows (DDW).
>=20
> This reworks debug messages to show the current value and the limit.
>=20
> This stores the locked pages number in the container so when unlocking
> the iommu table pointer won't be needed. This does not have an effect
> now but it will with the multiple tables per container as then we will
> allow attaching/detaching groups on fly and we may end up having
> a container with no group attached but with the counter incremented.
>=20
> While we are here, update the comment explaining why RLIMIT_MEMLOCK
> might be required to be bigger than the guest RAM. This also prints
> pid of the current process in pr_warn/pr_debug.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> [aw: for the vfio related changes]
> Acked-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> Changes:
> v12:
> * added WARN_ON_ONCE() to decrement_locked_vm() for the sake of
> documentation

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVdmn0AAoJEGw4ysog2bOSRV0QAObnpOLGL5MY3VqDAlEaH43I
O8P3262HmefTVf5DPP5aZgBMhuMYvrXQ7Ezb4OuZQ4rXqOFDKHc5hHkRP3CJY6JO
JOxSWOX6kcH0REC64YO+Qm7QsTyJgz5JhrhlmPfSnqhd1pVLbwOgSIAyvFVAShDV
XFUgEME15ePhbWG5BIth60gc2fWqkryMAiNy7GnoZUIGIs7Lq9yThZOvw4vicCdk
ekAwLKwDpjwNApSnIh9TIsBy37E1hsFuAhFE5oz4ajoJqPsVD2gzl/7X+2/mRHNp
alReEb0tG/xF8jy0BiOHW+hwaqah/213H35NMCzyCojkkBKQl+5bOJy/h8c4uhfY
kIM0W0aMoZHhr6VoXTcf8TiZcl4y1IVTtd2XRoMY1J7TreRkMtPBIZtJcPy8QnQU
W580mmk82QHZ7qFzzaMDrYahPyvTKLqezize54S8ZluCEaBULbgGiXR5l9i1+4Ow
Izhc6CDJO7a1gZfM/CuhovtGZMKthgZqE8bri4246Yj/8zqyhCorBlaPPtaUyFwY
O7bGzTbpg7D61zCZFaWeu8YEzh1/8MTq8pvD8Kj5/nwt4voyCzA2tvG9Srwaju+X
MIndZEoprI4j0v23E5k2qHvMSg7EBOsmY4O5ljtqFtE5WWCVCspgreQL0z/Wb9ZB
ccAi3qzw8d8CvXCS0OJ9
=nyie
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
