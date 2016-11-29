Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSRtV3v0dzDw6h
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 13:13:54 +1100 (AEDT)
Message-ID: <1480385626.11342.53.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/mm: Fix lazy icache flush on pre-POWER5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 29 Nov 2016 13:13:46 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit CPUs with no-execute support and non-snooping icache, such as
970 or POWER4, we have a software mechanism to ensure coherency of the
cache (using exec faults when needed).

This was broken due to a logic inversion when that code was rewritten
from assembly to C.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 91f1da99792a1d133df94c4753510305353064a1
Fixes: 89ff725051d177556b23d80f2a30f880a657a6c1
Fixes: a43c0eb8364c022725df586e91dd753633374d66
--
diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 42c702b..6fa450c 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -55,7 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	rflags = htab_convert_pte_flags(new_pte);
 
-	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
+	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 3bbbea0..1a68cb1 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -87,7 +87,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	subpg_pte = new_pte & ~subpg_prot;
 	rflags = htab_convert_pte_flags(subpg_pte);
 
-	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
+	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE)) {
 
 		/*
@@ -258,7 +258,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 
 	rflags = htab_convert_pte_flags(new_pte);
 
-	if (!cpu_has_feature(CPU_FTR_NOEXECUTE) &&
+	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
 		rflags = hash_page_do_lazy_icache(rflags, __pte(old_pte), trap);
 
