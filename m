Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 75674B7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jul 2009 10:18:04 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF498DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2009 10:18:03 +1000 (EST)
Subject: Re: [RFC/PATCH] mm: Pass virtual address to [__]p{te,ud,md}_free_tlb()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.2.01.0907271210210.25224@localhost.localdomain>
References: <20090715074952.A36C7DDDB2@ozlabs.org>
	<20090715135620.GD7298@wotan.suse.de>
	<1248073873.13067.31.camel@pasglop>
	<alpine.LFD.2.01.0907220930320.19335@localhost.localdomain>
	<1248310415.3367.22.camel@pasglop>
	<alpine.LFD.2.01.0907271210210.25224@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 28 Jul 2009 10:17:40 +1000
Message-Id: <1248740260.30993.26.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, Linux-Arch <linux-arch@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Hugh Dickins <hugh@tiscali.co.uk>,
	linux-kernel@vger.kernel.org, ralf <ralf@linux-mips.org>,
	Linux Memory Management <linux-mm@kvack.org>,
	Paul Mundt <lethal@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-07-27 at 12:11 -0700, Linus Torvalds wrote:
> 
> On Thu, 23 Jul 2009, Benjamin Herrenschmidt wrote:
> > 
> > Hrm... my powerpc-next branch will contain stuff that depend on it, so
> > I'll probably have to pull it in though, unless I tell all my
> > sub-maintainers to also pull from that other branch first :-)
> 
> Ok, I'll just apply the patch. It does look obvious enough.

There seem to be a MIPS and SH breakage as a result but I can't see
how my patch would have broken it, ie, it looks like the bug was
already in those two archs. The error is that it complains about a
duplicate definition of __pmd_free_tlb() between those arch pgalloc.h
and pgtable-nopmd.h

For MIPS, when CONFIG_32BIT is set, asm/pgalloc.h redefines
__pmd_free_tlb despite the fact that it's already defined by
asm-generic/pgtable-nopmd.h (via via pgtable.h via linux/mm.h).

I -suspect- what happens is that the compiler, before, would ignore the
double definition (or maybe just warn) due to the definition being
strictly identical. With the new argument added, it's no longer the case
as it's called "a" in asm-generic and "addr" in mips... oops.

In any case, can Ralf and Paul check if the following patch is correct ?

>From 41928c7945d855ae0eb053eadad590ab6876847e Mon Sep 17 00:00:00 2001
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Jul 2009 10:16:48 +1000
Subject: [PATCH] mm: Remove duplicate definitions in MIPS and SH

Those definitions are already provided by asm-generic

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/mips/include/asm/pgalloc.h |   11 -----------
 arch/sh/include/asm/pgalloc.h   |    8 --------
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index f705735..3738f4b 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -104,17 +104,6 @@ do {							\
 	tlb_remove_page((tlb), pte);			\
 } while (0)
 
-#ifdef CONFIG_32BIT
-
-/*
- * allocating and freeing a pmd is trivial: the 1-entry pmd is
- * inside the pgd, so has no extra memory associated with it.
- */
-#define pmd_free(mm, x)			do { } while (0)
-#define __pmd_free_tlb(tlb, x, addr)	do { } while (0)
-
-#endif
-
 #ifdef CONFIG_64BIT
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 89a4827..63ca37b 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -79,14 +79,6 @@ do {							\
 	tlb_remove_page((tlb), (pte));			\
 } while (0)
 
-/*
- * allocating and freeing a pmd is trivial: the 1-entry pmd is
- * inside the pgd, so has no extra memory associated with it.
- */
-
-#define pmd_free(mm, x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x,addr)	do { } while (0)
-
 static inline void check_pgt_cache(void)
 {
 	quicklist_trim(QUICK_PGD, NULL, 25, 16);
-- 
1.6.1.2.14.gf26b5
