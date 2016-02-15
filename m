Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D14F61A0D15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 16:21:28 +1100 (AEDT)
Date: Mon, 15 Feb 2016 15:08:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 4/7] KVM: PPC: Account TCE-containing pages in
 locked_vm
Message-ID: <20160215040853.GV2732@voom.fritz.box>
References: <1455501309-47200-1-git-send-email-aik@ozlabs.ru>
 <1455501309-47200-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="DMefDzZywwCHZelG"
In-Reply-To: <1455501309-47200-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--DMefDzZywwCHZelG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 15, 2016 at 12:55:06PM +1100, Alexey Kardashevskiy wrote:
> At the moment pages used for TCE tables (in addition to pages addressed
> by TCEs) are not counted in locked_vm counter so a malicious userspace
> tool can call ioctl(KVM_CREATE_SPAPR_TCE) as many times as
> RLIMIT_NOFILE and lock a lot of memory.
>=20
> This adds counting for pages used for TCE tables.
>=20
> This counts the number of pages required for a table plus pages for
> the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.
>=20
> This changes release_spapr_tce_table() to store @npages on stack to
> avoid calling kvmppc_stt_npages() in the loop (tiny optimization,
> probably).
>=20
> This does not change the amount of used memory.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Alas, this may cause failures with older libvirts in certain
configurations which may not have estimated enough locked memory.
Newer libvirts should be taking this amount into account (even though
it wasn't actually accounted as locked vm until now).  Has to be done,
though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DMefDzZywwCHZelG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWwU9VAAoJEGw4ysog2bOSnZEQAL2cYMQKt//6UTryc3NdZcfj
YD/6WHnGbK9yhssb/62lfZS8Edt1MeVd/o1u4Be6kchVx4d80pByn1MB0O3/tVbI
tjdypMZS5CcnxNmG2/voEgHuCk6ArVpei6AZ+kQVryHVnsaCm7sO+rJkolnKb3Ab
D+Klns8+IQDxKEiCub4TmXMMmrOx5mxIJVytBhgPwkU15QbXHjlYIMbWg8On1nxL
PIbqa0aGndb1MSYVoUcaqTiaE9ucojlWuGjMiYAGpoJRmHNDU/bC++QF2Byu7viD
8o7/TVFOkbAnV0CXmy6JhO2IcFTGDIeDEH45dY7ORgWX1wULClJzTCCMFSBYWv+d
ZBgSVeVP0QASEXp6rtu+jSBHL+qmQiMqTdCoIYioKPPpZ0LXthJQUuZlSB20gWxF
J9daKn5gTSu4wVN04k7n7F7qepLXsNG2mNKCJlL7R9kuiFvMRaC9lg/6gguR1FeM
crqLC8LOxB+Q9VtCO5qgQkn1mbO5Z+PMuRPZCaP8jokdv2Eu3xqhnT3LQxwT8lky
krySvDgTWu9DGL5TeSBZcnc3sJ3/5vV1uFWBno3l7r33v2jHsFREXLr85ztx1hUv
YcDzmbNlAqzwsg7cyASMTPAy9ompC25CGtU/geVzj0kyB0kvaVXKcQFPOMDMKYpE
YlrnFeAhVEpoeCdD+nHg
=C8+U
-----END PGP SIGNATURE-----

--DMefDzZywwCHZelG--
