Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id B802A2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 15:44:53 +1100 (EST)
Date: Tue, 26 Mar 2013 15:44:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: fix annotation of fake_numa_create_new_node()
Message-Id: <20130326154444.9879423ed8e5f8aeba6511e4@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__26_Mar_2013_15_44_44_+1100_gTsvRY5AQYHEGEOK"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__26_Mar_2013_15_44_44_+1100_gTsvRY5AQYHEGEOK
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This function has always been marked as __cpuinit, but is only called
from functions marked as __init and references an __initdata variable.
So change its annotation to __init.

Fixes this build warning:

WARNING: arch/powerpc/mm/built-in.o(.cpuinit.text+0x86): Section mismatch i=
n reference from the function .fake_numa_create_new_node() to the variable =
.init.data:cmdline
The function __cpuinit .fake_numa_create_new_node() references
a variable __initdata cmdline.
If cmdline is only used by .fake_numa_create_new_node then
annotate cmdline with a matching annotation.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index bba87ca..715cab7 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -79,7 +79,7 @@ static void __init setup_node_to_cpumask_map(void)
 	dbg("Node to cpumask map for %d nodes\n", nr_node_ids);
 }
=20
-static int __cpuinit fake_numa_create_new_node(unsigned long end_pfn,
+static int __init fake_numa_create_new_node(unsigned long end_pfn,
 						unsigned int *nid)
 {
 	unsigned long long mem;
--=20
1.8.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Tue__26_Mar_2013_15_44_44_+1100_gTsvRY5AQYHEGEOK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJRUSe8AAoJEECxmPOUX5FEjAYQAJ7ILRK9bMykrLygM8KBlB7Z
n9WQOywONPWTay3pRIcZ4TfVPa4CLdLTre5YHKrLVw16+HPAM72HlVaRatrX9Ea+
8DXrWRStTHsfdzP6JOg7jv/9Z1fNtd0SRWzagzGVuT2byoDnK+WmwgLzanuxxxzv
KeyjGcKfMLlcNSL+/HHYoLTe/h3VEVNcHnrCIykO6zR9DnoYVkur7zNOcLaxbPIM
3Ti0p7+IoT2D/bQbn1CybWy5W0eQKefEspCUrny9XoEMoDEKqEgK1S/f0fCsjmrV
BEHYw5yCyiYhOxp6lU//mBCzCQmwoXz3ir+G1O+vBVilxexbh2i3BQHsM0d2ADNl
+dSnwUGk1bNASOYAwVF/9hg2RY8rrqbn4fHUlpORe3Y/LeIcnpS8i/dLIK6HDkN+
XEFXY5cOlwmxUYQbecbu6yR8DHgZ5Kd8hAsMjS3TXP92plgAHJSfYE/TwuKgmGTK
t0JLLAVElPelVxPNTsXE/bwnjjWmJAwTqmQP6oniG5TKV/JxcanSDwPTDKhiYkIF
WnQ7e92UJL2ak4NstipVvqhomm3n5WM4Oy13EN1IgH65PZnqcCWEnHzoLJb4P5Wi
6NHp04Xnn7VcbOgOphK3zzVLFxmAR8AA31LHGXEZS1RSRLvzor28e3g1RQVRlVVL
Ys/ieAA1epg4cONXgvuj
=997B
-----END PGP SIGNATURE-----

--Signature=_Tue__26_Mar_2013_15_44_44_+1100_gTsvRY5AQYHEGEOK--
