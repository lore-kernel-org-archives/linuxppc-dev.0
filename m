Return-Path: <sachinp@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F1C3B6F08
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Dec 2009 18:15:25 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nBE7E4vd002356
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2009 00:14:04 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBE7FG4T171892
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2009 00:15:16 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nBE7FFdP009013
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2009 00:15:16 -0700
From: Sachin Sant <sachinp@in.ibm.com>
To: benh@kernel.crashing.org
Date: Mon, 14 Dec 2009 12:45:12 +0530
Message-Id: <20091214071512.10647.1587.sendpatchset@localhost.localdomain>
Subject: [RESEND]Fix hash_utils_64.c compile errors with DEBUG enabled.
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This time without the funny characters.

Fix following build errors generated with DEBUG=1

cc1: warnings being treated as errors
arch/powerpc/mm/hash_utils_64.c: In function 'htab_dt_scan_page_sizes':
arch/powerpc/mm/hash_utils_64.c:343: error: format '%04x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
arch/powerpc/mm/hash_utils_64.c:343: error: format '%08x' expects type 'unsigned int', but argument 5 has type 'long unsigned int'
arch/powerpc/mm/hash_utils_64.c: In function 'htab_initialize':
arch/powerpc/mm/hash_utils_64.c:666: error: format '%x' expects type 'unsigned int', but argument 4 has type 'long unsigned int'
... SNIP ...

Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
---

diff -Naurp a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
--- a/arch/powerpc/mm/hash_utils_64.c	2009-12-14 11:14:01.000000000 +0530
+++ b/arch/powerpc/mm/hash_utils_64.c	2009-12-14 11:16:37.000000000 +0530
@@ -340,7 +340,7 @@ static int __init htab_dt_scan_page_size
 			else
 				def->tlbiel = 0;
 
-			DBG(" %d: shift=%02x, sllp=%04x, avpnm=%08x, "
+			DBG(" %d: shift=%02x, sllp=%04lx, avpnm=%08lx, "
 			    "tlbiel=%d, penc=%d\n",
 			    idx, shift, def->sllp, def->avpnm, def->tlbiel,
 			    def->penc);
@@ -663,7 +663,7 @@ static void __init htab_initialize(void)
 		base = (unsigned long)__va(lmb.memory.region[i].base);
 		size = lmb.memory.region[i].size;
 
-		DBG("creating mapping for region: %lx..%lx (prot: %x)\n",
+		DBG("creating mapping for region: %lx..%lx (prot: %lx)\n",
 		    base, size, prot);
 
 #ifdef CONFIG_U3_DART
@@ -1115,7 +1115,7 @@ void flush_hash_page(unsigned long va, r
 {
 	unsigned long hash, index, shift, hidx, slot;
 
-	DBG_LOW("flush_hash_page(va=%016x)\n", va);
+	DBG_LOW("flush_hash_page(va=%016lx)\n", va);
 	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
 		hash = hpt_hash(va, shift, ssize);
 		hidx = __rpte_to_hidx(pte, index);
@@ -1123,7 +1123,7 @@ void flush_hash_page(unsigned long va, r
 			hash = ~hash;
 		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
 		slot += hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %d: hash=%x, hidx=%x\n", index, slot, hidx);
+		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
 		ppc_md.hpte_invalidate(slot, va, psize, ssize, local);
 	} pte_iterate_hashed_end();
 }
