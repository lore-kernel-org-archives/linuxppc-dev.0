Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail48-fra-R.bigfish.com (mail-fra.bigfish.com [62.209.45.166])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5D7EF67B68
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 04:30:44 +1000 (EST)
Message-ID: <44D8D84C.8090501@am.sony.com>
Date: Tue, 08 Aug 2006 11:30:36 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix udbg warning
References: <17624.10198.280651.681221@cargo.ozlabs.ibm.com>
In-Reply-To: <17624.10198.280651.681221@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> I get:
>=20
> fatal: corrupt patch at line 12
> * Patch failed.
>=20
> from git-applymbox when I try to apply it.  It looks like your mailer
> turns lines that contain only whitespace into empty lines.  Please fix
> it or use a different mailer.

  -user_pref("mailnews.wraplength", 0);
  +user_pref("mailnews.wraplength", 10000);

Sorry about that, seems I made that change back in December.  I'm
wondering if you changed something on your side that now chokes on
it, or did you just get feedup with fixing my patches by hand...

Anyway, here's a new patch with some additional fixes for slb.c.
Please let me know if you have trouble with it.

-Geoff=20


Fix some warnings when udbg is enabled.

hash_utils_64.c:169: warning: implicit declaration of function =E2=80=98u=
dbg_printf=E2=80=99
hash_utils_64.c:251: warning: format =E2=80=98%04x=E2=80=99 expects type =
=E2=80=98unsigned int=E2=80=99
slb.c:191: warning: format =E2=80=98%04x=E2=80=99 expects type =E2=80=98u=
nsigned int=E2=80=99

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/mm/hash_utils_64.c |    7 ++++---
 arch/powerpc/mm/slb.c           |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

Index: cell--common--4/arch/powerpc/mm/hash_utils_64.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--common--4.orig/arch/powerpc/mm/hash_utils_64.c
+++ cell--common--4/arch/powerpc/mm/hash_utils_64.c
@@ -51,6 +51,7 @@
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
 #include <asm/sections.h>
+#include <asm/udbg.h>
=20
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -247,7 +248,7 @@
 			else
 				def->tlbiel =3D 0;
=20
-			DBG(" %d: shift=3D%02x, sllp=3D%04x, avpnm=3D%08x, "
+			DBG(" %d: shift=3D%02x, sllp=3D%04lx, avpnm=3D%08lx, "
 			    "tlbiel=3D%d, penc=3D%d\n",
 			    idx, shift, def->sllp, def->avpnm, def->tlbiel,
 			    def->penc);
@@ -773,7 +774,7 @@
 {
 	unsigned long hash, index, shift, hidx, slot;
=20
-	DBG_LOW("flush_hash_page(va=3D%016x)\n", va);
+	DBG_LOW("flush_hash_page(va=3D%016lx)\n", va);
 	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
 		hash =3D hpt_hash(va, shift);
 		hidx =3D __rpte_to_hidx(pte, index);
@@ -781,7 +782,7 @@
 			hash =3D ~hash;
 		slot =3D (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot +=3D hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %d: hash=3D%x, hidx=3D%x\n", index, slot, hidx);
+		DBG_LOW(" sub %ld: hash=3D%lx, hidx=3D%lx\n", index, slot, hidx);
 		ppc_md.hpte_invalidate(slot, va, psize, local);
 	} pte_iterate_hashed_end();
 }
Index: cell--common--4/arch/powerpc/mm/slb.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cell--common--4.orig/arch/powerpc/mm/slb.c
+++ cell--common--4/arch/powerpc/mm/slb.c
@@ -22,6 +22,7 @@
 #include <asm/paca.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
+#include <asm/udbg.h>
=20
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -187,12 +188,12 @@
 		patch_slb_encoding(slb_miss_kernel_load_io,
 				   SLB_VSID_KERNEL | io_llp);
=20
-		DBG("SLB: linear  LLP =3D %04x\n", linear_llp);
-		DBG("SLB: io      LLP =3D %04x\n", io_llp);
+		DBG("SLB: linear  LLP =3D %04lx\n", linear_llp);
+		DBG("SLB: io      LLP =3D %04lx\n", io_llp);
 #ifdef CONFIG_HUGETLB_PAGE
 		patch_slb_encoding(slb_miss_user_load_huge,
 				   SLB_VSID_USER | huge_llp);
-		DBG("SLB: huge    LLP =3D %04x\n", huge_llp);
+		DBG("SLB: huge    LLP =3D %04lx\n", huge_llp);
 #endif
 	}
=20

=20
