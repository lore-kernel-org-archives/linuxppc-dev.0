Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A239FB6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Dec 2009 11:30:10 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp02.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBH0ROpm024028
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2009 11:27:24 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBH0U9Ln1302544
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2009 11:30:09 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBH0U8vh018860
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2009 11:30:09 +1100
Date: Thu, 17 Dec 2009 11:29:56 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Fix stupid bug in subpge protection handling
Message-ID: <20091217002956.GQ9463@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>,
	". Jan-Bernd Themann" <THEMANN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit d28513bc7f675d28b479db666d572e078ecf182d ("Fix bug in pagetable
cache cleanup with CONFIG_PPC_SUBPAGE_PROT"), itself a fix for
breakage caused by an earlier clean up patch of mine, contains a
stupid bug.  I changed the parameters of the subpage_protection()
function, but failed to update one of the callers.

This patch fixes it, and replaces a void * with a typed pointer so
that the compiler will warn on such an error in future.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- working-2.6.orig/arch/powerpc/mm/hash_utils_64.c	2009-12-16 11:43:51.357324268 +1100
+++ working-2.6/arch/powerpc/mm/hash_utils_64.c	2009-12-16 11:44:35.473351990 +1100
@@ -879,7 +879,7 @@ static inline int subpage_protection(str
  */
 int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
 {
-	void *pgdir;
+	pgd_t *pgdir;
 	unsigned long vsid;
 	struct mm_struct *mm;
 	pte_t *ptep;
@@ -1025,7 +1025,7 @@ int hash_page(unsigned long ea, unsigned
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
 	{
-		int spp = subpage_protection(pgdir, ea);
+		int spp = subpage_protection(mm, ea);
 		if (access & spp)
 			rc = -2;
 		else


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
