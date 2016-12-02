Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVJDh72LgzDvt3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 13:36:03 +1100 (AEDT)
Date: Fri, 2 Dec 2016 02:35:52 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <agraf@suse.de>
Message-ID: <20161202023552.GJ2697@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Subject: [PATCH 1/2] powerpc: Remove Mac-on-Linux hooks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The symbols exported for use by MOL aren't getting CRCs and I was
about to fix that.  But MOL is dead upstream, and the latest work on
it was to make it use KVM instead of its own kernel module.  So remove
them instead.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/kernel/head_32.S | 7 +------
 arch/powerpc/mm/hash_low_32.S | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 9d963547d243..87998430cd9b 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -735,11 +735,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 	EXCEPTION(0x2c00, Trap_2c, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2d00, Trap_2d, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2e00, Trap_2e, unknown_exception, EXC_XFER_EE)
-	EXCEPTION(0x2f00, MOLTrampoline, unknown_exception, EXC_XFER_EE_LITE)
-
-	.globl mol_trampoline
-	.set mol_trampoline, i0x2f00
-	EXPORT_SYMBOL(mol_trampoline)
+	EXCEPTION(0x2f00, Trap_2f, unknown_exception, EXC_XFER_EE)
=20
 	. =3D 0x3000
=20
@@ -1289,7 +1285,6 @@ intercept_table:
 	.long 0, 0, 0, 0, 0, 0, 0, 0
 	.long 0, 0, 0, 0, 0, 0, 0, 0
 	.long 0, 0, 0, 0, 0, 0, 0, 0
-EXPORT_SYMBOL(intercept_table)
=20
 /* Room for two PTE pointers, usually the kernel and current user pointers
  * to their respective root page table.
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index 09cc50c8dace..cddf14f60bf3 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -34,7 +34,6 @@
 	.globl mmu_hash_lock
 mmu_hash_lock:
 	.space	4
-EXPORT_SYMBOL(mmu_hash_lock)
 #endif /* CONFIG_SMP */
=20
 /*


--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWEDeCOe/yOyVhhEJAQpj3A//Zngs0cFHBy+keid/vbhJ+/n/DJJ3XPVk
xdJhVjReuN7dT5/iSnqWaJqFJiJGfxaELOvN1oZQatiu+9mVBjyuEWbky1skMQgd
ad4utbIifSLoD8M0XEIBQPhxb8U0ZVTvkdu/yvDCJCnKrmp786QNWLyW31a+SaHH
DQs2mGuGdO68nr9kSS+t4ebE16FHwx0pfiwrlzcRxN9hF/3/C+rqkppIzUTUbKmz
wF5hRDEqKCRqoYydU8lWV8AEPsp3y3ChySx/feoBczWWCSmKp4AaMz/Lt2CqbjT3
HWKOFIpCFFxojvVSKeqL4sc8gThA98WxtZFpk5oOkog64HEvtDYTPOxWKKqfsiEk
l35OeZzJc6UWcbx3F+4mzxGMlulRRAPQI4FsKwBE3WKR8PVFZ2ScxQkXGXqIuLGG
aZUFsdYAnqfohU5L3Kd91cHvNnbEOskFAOspjRr1j0XvmL/I2C6nzre1383X29Ue
FlSyXblceERNpI1rcYvw2xPB1fizSlgI92nuAn3OCWk+quVa2b2NhcN8HmDvU2NO
8f/AJVXrL0uNVf3Uq4zWacFylKCofm1Jpep0HXlgitTFCrZAAd4PeUoOKHWUerGE
SF2PxIh5Ha2FQ0iF/762rZ/uDhki0sKxKnRH9peZbX2WML86yKzXYmSiT+GJXiWh
VGorOnKaj2g=
=gIrs
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
