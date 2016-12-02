Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVJHj0tnDzDvt6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 13:38:41 +1100 (AEDT)
Date: Fri, 2 Dec 2016 02:38:38 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linuxppc-dev@lists.ozlabs.org
Cc: Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20161202023837.GK2697@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
In-Reply-To: <20161202023552.GJ2697@decadent.org.uk>
Subject: [PATCH 2/2] powerpc: Fix missing CRCs, add yet more asm-prototypes.h
 declarations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add declarations for:
- __mfdcr, __mtdcr (if CONFIG_PPC_DCR_NATIVE=3Dy; through <asm/dcr.h>)
- switch_mmu_context (if CONFIG_PPC_BOOK3S_64=3Dn; through <asm/mmu_context=
=2Eh>)

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I checked all the symbols potentially exported from assembly under
arch/powerpc, and these seem to be the only ones not yet declared
through asm-prototypes.h (aside from those supporting Mac-on-Linux
which are removed by the previous patch).

Ben.

 arch/powerpc/include/asm/asm-prototypes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/inclu=
de/asm/asm-prototypes.h
index e0baba1535e6..ba0225ff38f8 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -18,6 +18,8 @@
 #include <asm/checksum.h>
 #include <asm/uaccess.h>
 #include <asm/epapr_hcalls.h>
+#include <asm/dcr.h>
+#include <asm/mmu_context.h>
=20
 #include <uapi/asm/ucontext.h>
=20

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWEDeree/yOyVhhEJAQpzJA/+N6GxyJql+bvdC6E4pW0tSADiPuH8Lo2J
9r8HWqptdObvD2XmsczZVxD4Y6v/3mvuUz4wgb+Xl0pdXveVxzmVZ6adt7U1FWjM
XlNvZBNZavF+09uabGxJb2OULCldN/xqwBmmlzebWa5s/pfofBCF/GCKIJrLGpru
7QEbaX2cDLSV5T9sZ/BVZHpct/Tk2owZP4F8C9+s7tmpJ618rLjuK1Pq4QmGp1PF
AE9rr9X1xdF9lLq4nyux+YI18OkMeV17WoiFHB7fDJBiLvz6Mp3tgdMBPoAsiVaF
SSbOgbEVPtxIHAexAYMCwEXgv/GJp2N0sSKZnsSim0acqOIe3JcawbLCQmqJCozL
SzIsHzw8Zu2C6xA52xvqNaC4/7eO9ihBL3XCvI7d1bprlIPhhk8TYEc+hsPxAdSe
pgAfHJk6eeuRh+LsMCBooDr6fI9/Duqs4s4AFIuEio5xHYT0hz4EnJlF+He7B06i
y3cGPvUeZshowP9NEQxI2qHMPYIWah+uUYupm0woFB3SXgUePEDCRg8PnCQSuytz
o7uipf0DMFAD8PWeCjPDv3y9VWZctSnms2YjtLlDiJID79G9wgy1M8Flzri0n2X3
SDHFjamlo22zSJj9S2mRObnL08g33h8FlqjoCaY+jhoRssD/NCAmvjr0G3IrEuV/
lG6bc1+hYxY=
=IWwC
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
