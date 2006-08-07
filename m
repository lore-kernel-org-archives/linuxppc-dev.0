Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 26BCA679E1
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Aug 2006 11:18:31 +1000 (EST)
Message-ID: <44D68EAE.5010308@am.sony.com>
Date: Sun, 06 Aug 2006 17:51:58 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: fix udbg warning
References: <44D655BF.3080803@am.sony.com>
In-Reply-To: <44D655BF.3080803@am.sony.com>
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

Here's an updated version that fixes a few more warnings.

-Geoff


Fix an implicit declaration warning in hash_utils_64.c
when udbg is enabled.

hash_utils_64.c: In function =E2=80=98htab_bolt_mapping=E2=80=99:
hash_utils_64.c:169: warning: implicit declaration of function =E2=80=98u=
dbg_printf=E2=80=99
hash_utils_64.c:251: warning: format =E2=80=98%04x=E2=80=99 expects type =
=E2=80=98unsigned int=E2=80=99


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

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

 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -247,7 +248,7 @@ static int __init htab_dt_scan_page_size
 			else
 				def->tlbiel =3D 0;

-			DBG(" %d: shift=3D%02x, sllp=3D%04x, avpnm=3D%08x, "
+			DBG(" %d: shift=3D%02x, sllp=3D%04lx, avpnm=3D%08lx, "
 			    "tlbiel=3D%d, penc=3D%d\n",
 			    idx, shift, def->sllp, def->avpnm, def->tlbiel,
 			    def->penc);
@@ -773,7 +774,7 @@ void flush_hash_page(unsigned long va, r
 {
 	unsigned long hash, index, shift, hidx, slot;

-	DBG_LOW("flush_hash_page(va=3D%016x)\n", va);
+	DBG_LOW("flush_hash_page(va=3D%016lx)\n", va);
 	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
 		hash =3D hpt_hash(va, shift);
 		hidx =3D __rpte_to_hidx(pte, index);
@@ -781,7 +782,7 @@ void flush_hash_page(unsigned long va, r
 			hash =3D ~hash;
 		slot =3D (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot +=3D hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %d: hash=3D%x, hidx=3D%x\n", index, slot, hidx);
+		DBG_LOW(" sub %ld: hash=3D%lx, hidx=3D%lx\n", index, slot, hidx);
 		ppc_md.hpte_invalidate(slot, va, psize, local);
 	} pte_iterate_hashed_end();
 }
