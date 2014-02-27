Return-Path: <sfr@canb.auug.org.au>
Date: Thu, 27 Feb 2014 17:17:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH] powerpc: allow allyesconfig to build more
Message-Id: <20140227171719.01d7de4be01559dd02968f7c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Feb_2014_17_17_19_+1100_elp7SMB56G19+.Rn"
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Feb_2014_17_17_19_+1100_elp7SMB56G19+.Rn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes this build error:

arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org back=
wards

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/exceptions-64s.S | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

This builds allyesconfig better (we still have RELOC failures in the
link) and hopefully fixes the allmodconfig build, but I don't know if
it is semantically OK.

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exc=
eptions-64s.S
index 38d507306a11..b87859ffc8e7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1294,16 +1294,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	.globl	__end_handlers
 __end_handlers:
=20
-	/* Equivalents to the above handlers for relocation-on interrupt vectors =
*/
-	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
-	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
-
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
-	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
-	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
-
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
  * Data area reserved for FWNMI option.
@@ -1325,6 +1315,16 @@ fwnmi_data_area:
 initial_stab:
 	.space	4096
=20
+	/* Equivalents to the above handlers for relocation-on interrupt vectors =
*/
+	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
+
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf60, facility_unavailable)
+	STD_RELON_EXCEPTION_HV_OOL(0xf80, hv_facility_unavailable)
+
 #ifdef CONFIG_PPC_POWERNV
 _GLOBAL(opal_mc_secondary_handler)
 	HMT_MEDIUM_PPR_DISCARD
--=20
1.9.0

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Feb_2014_17_17_19_+1100_elp7SMB56G19+.Rn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTDthzAAoJEMDTa8Ir7ZwVBQoP/R8uHHSgcEp4vQW+1wZLbcdo
m/x4lFAfuG6teibDV8gD201eNqSdZIrDwkqBR0JmcfiY2iOOsnJySc8V0CgSG0W9
peTXUOWJ4oRG0LB/YxopmUJWLjwCGr6hMKu08OHRjW7ytg6nOLRj3IPetGjx3zMi
JR8AXXUthBrrOX0MOcY/iiMKDanMA0ZVe/gFekeXxy5KAxP1K9guSSIgRlJ7rTQp
hZBwVrDhc26PYzQ9v97ddNFH38a/1DL7SLbWK4yOJX6bxlGYJkVAUDK4fHmtS7NP
lHgUVq3v4j/r9ePJcq5JcjM5QBVvCNMpgp1ANujZEbdZoA4XOIEZ5EmgsI4emOlh
LyRo0kzUhuz9+FPtMqWXsjzEEdP+QkG/cCnfvqca6XOh8FUARhCJvDBrT5UsgakP
wW087DjSlvsKX2gz4tTF5QqsVKZPlSLLIzTtRIDUUmaAU1X0ixdVwPLdCATsW0Kx
f+ftntmTKdbF7FERa8zkra7i//h9IarLZFlC7DrfxVK7pogfSBtWi1qklz6Uxhc/
SeN5+OpyCTfGu8KPSzX74gkdAxtTtYHuyxh1egExuO+Es2IAXefGzr1GQUT2ETQp
q/ulX/tALlHu40EzHQRt3NVwC90f6Cq7JU9MM4ZWJXrdoGwm/NlDsoPmTYHiB9X2
+qRw3CoZNwkyk3m6mclp
=I3XM
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Feb_2014_17_17_19_+1100_elp7SMB56G19+.Rn--
