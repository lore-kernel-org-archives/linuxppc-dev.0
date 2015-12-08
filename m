Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE6891A0F25
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 13:45:05 +1100 (AEDT)
Date: Tue, 8 Dec 2015 13:35:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/9] KVM: PPC: Use RCU for arch.spapr_tce_tables
Message-ID: <20151208023555.GJ20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-5-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="lYetfuAxy9ic4HK3"
In-Reply-To: <1442314179-9706-5-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--lYetfuAxy9ic4HK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:34PM +1000, Alexey Kardashevskiy wrote:
> At the moment spapr_tce_tables is not protected against races. This makes
> use of RCU-variants of list helpers. As some bits are executed in real
> mode, this makes use of just introduced list_for_each_entry_rcu_notrace().
>=20
> This converts release_spapr_tce_table() to a RCU scheduled handler.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Looks correct on my limited knowledge of RCU

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lYetfuAxy9ic4HK3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZkILAAoJEGw4ysog2bOSdDwQAJaVViLHnUu1TS63+Yi7G+l1
Enir8Lltq94k/Bm/+j8xq03nu3R8jxeQByEnoS3mPHS/CMK8TkqTVwlw8UR7ebd2
eSlY2Wb22rFCIgernYj6trKQZqykPRDXc0qfuEuIeDk524ibfRynWsLRC6sJ/JlO
HHqMmchkphFwZ4NGYhSYBevQ42D9hagS+jrgbgGwuASHa+nzrJn1QReysmJqj3hO
lUqzXDipFTtwXko2/WyPSALyVTWQ6/dSlhVmFnESh35+9pJ35wNWP0TX48JiNt0K
8EQBFpLev/svoOQuGAAjUR2VU56g4WeH+8odkDrPZEhg7eIqq/8iE7hTO52dx3dP
R6pg+6Xg/dgdIz9YHvb91ZBCl8ARuj5xwRCjol4t8TzL3kozpfhtlV44l7+lEHww
00baIPSCGiBJaIBVPacJopyEoV31rO+ZIQOsqCmegJLhK4jj0inkbLdIwDYaNkl+
O3GS16ShJuUNQzBjjPyI5zoRTed85zNoH6mrKo/N1uGTBZO7EJb6/+8Vyt2ObEBq
LTn45BliWFLUeRpjzywmmaCnY7CXCUpeYkzV/H4tLCXTIIdR57BhhNv6YOGCWV91
OZ5CeE5Ai3bG13UWBZA0u4pqHvDdWRCGUjZg2JGf/z22VACyg4qsiXHAgbVClEI3
YRnO0THZmXtaAZnn/SJf
=hSyI
-----END PGP SIGNATURE-----

--lYetfuAxy9ic4HK3--
