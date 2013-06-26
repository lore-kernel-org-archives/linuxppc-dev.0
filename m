Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.pcug.org.au [203.10.76.10])
 by ozlabs.org (Postfix) with ESMTP id 9042E2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 16:56:50 +1000 (EST)
Date: Wed, 26 Jun 2013 16:56:42 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: linux-next: manual merge of the akpm tree with the powerpc tree
Message-Id: <20130626165642.8740ecb6d5d5882b06f173c8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Wed__26_Jun_2013_16_56_42_+1000_9ZYzORaX4_xzG.ZF"
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__26_Jun_2013_16_56_42_+1000_9ZYzORaX4_xzG.ZF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
arch/powerpc/kernel/ptrace.c between commit b0b0aa9c7faf
("powerpc/hw_brk: Fix setting of length for exact mode breakpoints") from
the powerpc tree and commit "ptrace/powerpc: revert "hw_breakpoints: Fix
racy access to ptrace breakpoints"" from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/powerpc/kernel/ptrace.c
index 64f7bd5,6645e57..0000000
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@@ -1449,10 -1437,7 +1437,9 @@@ static long ppc_set_hwdebug(struct task
  	 */
  	if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE) {
  		len =3D bp_info->addr2 - bp_info->addr;
 -	} else if (bp_info->addr_mode !=3D PPC_BREAKPOINT_MODE_EXACT) {
 +	} else if (bp_info->addr_mode =3D=3D PPC_BREAKPOINT_MODE_EXACT)
 +		len =3D 1;
 +	else {
- 		ptrace_put_breakpoints(child);
  		return -EINVAL;
  	}
  	bp =3D thread->ptrace_bps[0];

--Signature=_Wed__26_Jun_2013_16_56_42_+1000_9ZYzORaX4_xzG.ZF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRypCuAAoJEECxmPOUX5FEMFsP/iLMpsI83VEBPCVdZdKFq4ms
mxTBOl7XT27o/pj+0b3Z+htLcBqjzDfeMfrvyURf2Rs/e0Ha0xUX88fUolzrFHK6
7prwBftW35ee3eWTkv3rwprbGc0PPsqz8NZJAx5sUnGfjNNY6RTcpPohSy7i2T5x
O7D7qYIVTRL9hsCvgHPiZrnbkjY6PLkzgEakgbt0QiDBYKmIQ9aFuFzimhIkTS4Q
87BO/fc3sefuYT/4N59xP9lkS7eTVR0C6sSZDsUaImIhwY4QSeaouwAihTba7u9x
UMSh2M2UkvN003Cj71UtaHrhsPW+K7QbFnW2TVD1X4OKe2gF9ncefYgfgYvZIUL1
r/r6Edav3rnP+lyAMIHmvhSP4aes37Dfmeq5cIlVxLPTNxuQW3Mx5m6qSh0YT3wc
UJf/peocUSIrsVJLtrYNAm3iv9Vy0N2CMaREgSX0YAzoM9u+KwHA8vft2PGH8wL9
YLlm72AGg5W/glOGEd1WNg4zA0JQRr5ITPEYsgdb1jBNkh36BVmYxHohUF56ZoxN
IJ+c7KQlmgdjkVxZ7hnGW/EWfZbv25yG6zpw3mFWPmSosP/q9PdjJ6YGKxGcr4WD
KlW/RvXhoL/W1IJUyKbZtfzF7vPqOHmyfzm7pZcWDw4tcldpMMehX64zVL1guRiM
eN1c1fAK2tjRP16l0kDj
=JNfM
-----END PGP SIGNATURE-----

--Signature=_Wed__26_Jun_2013_16_56_42_+1000_9ZYzORaX4_xzG.ZF--
