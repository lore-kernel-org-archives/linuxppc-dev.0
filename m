Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 62DB42C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2012 17:03:47 +1100 (EST)
Date: Thu, 15 Nov 2012 17:03:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: manual merge of the powerpc tree with the signal tree
Message-Id: <20121115170336.acc55b1d7f4eb656518a8f98@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__15_Nov_2012_17_03_36_+1100_jBon2HdkiaH/BFob"
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 Li Zhong <zhong@linux.vnet.ibm.com>, Al Viro <viro@ZenIV.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__15_Nov_2012_17_03_36_+1100_jBon2HdkiaH/BFob
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the powerpc tree got a conflict in
arch/powerpc/kernel/entry_64.S between commits 40792104b255 ("powerpc:
don't mess with r2 in copy_thread() and friends") and 53b50f9483cc
("powerpc: take dereferencing to ret_from_kernel_thread()") from the
signal tree and commit 12660b170253 ("powerpc: Fix
MAX_STACK_TRACE_ENTRIES too low warning !") from the powerpc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/kernel/entry_64.S
index e9a906c,ad76666..0000000
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@@ -373,7 -373,9 +373,9 @@@ _GLOBAL(ret_from_fork
  _GLOBAL(ret_from_kernel_thread)
  	bl	.schedule_tail
  	REST_NVGPRS(r1)
 -	REST_GPR(2,r1)
 +	ld	r14, 0(r14)
+ 	li	r3,0
+ 	std	r3,0(r1)
  	mtlr	r14
  	mr	r3,r15
  	blrl

--Signature=_Thu__15_Nov_2012_17_03_36_+1100_jBon2HdkiaH/BFob
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQpIW4AAoJEECxmPOUX5FEtPYP/jpkfS5XNJdEN3zr/GJcNC7O
o69Dq6pi2uqIaX+ptNYZC2pP/KNEfovZTZH5uhw5jxvQKOGMb8z4wk3iy4NZFwak
drmPSRcBc2r03UbUGgpJCHRfO+MMLMAkmidr15vn8KZMb7lz4ppaU7CdokeYaYrJ
DkOFbIq0HjOu++hHK9K5x/lMY/VTis41Z6Adcwmm6J3QlLmdSWX5s+RwNv4JfXda
+QmTr65099xhfmDwAp9BmjtP4EhAOWwwNrJkEdLKY+koLKVIl4+Dka5+S2ptjFgR
XqfnANSpbAGo9txrSLx+FzpLKKL1ZIqXlenIAukJe7nLjfFHerCgBeHnxadEDc6b
8nNDTtABwobls0uV3o4coxzNU2/JCdEpdD4f+LGKAnlR6B2gXQZgL7hdBFWU+ILd
7aNx5/nZV+24bH8avSLq1FOptPfL9AULP7bHvtCY1F3rUJWa/MskmhAgd8S/qUFe
8f8wGoqBJdTDmgUqjIPgou72L6CRF7h4CIc4nzc9D6O+AL2iTfWu0LcJeSpCVx3W
GTfnJhxATvV4TdPn/ohrR5P5NL7LpE53UAQP26VNGYdvaeqHa/uF3ZsC9mVmc+VO
FMMtLznkRdpcpe7LB19iVV6vN4JEMC6h3yOQz9zm6vmxfEhpw0XgS49ysrtInoEZ
G6NDUeLBEaqBD6xDoW9u
=umAV
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Nov_2012_17_03_36_+1100_jBon2HdkiaH/BFob--
