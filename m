Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539s2TvdzF36n
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:37:04 +1000 (AEST)
Message-Id: <13dbe36c823b005bfb4a93d82e9ac370ccaa5745.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 05/17] powerpc/mm: add pte helpers to query and change
 pte flags
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:37:01 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to avoid using generic _PAGE_XXX flags in powerpc
core functions, define helpers for all needed flags:
- pte_mkuser() and pte_mkprivileged() to set/unset and/or
unset/set _PAGE_USER and/or _PAGE_PRIVILEGED
- pte_hashpte() to check if _PAGE_HASHPTE is set.
- pte_mknoncoherent() to make a page non coherent
- pte_ci() check if cache is inhibited (already existing on book3s/64)
- pte_exprotect() to protect against execution
- pte_exec() and pte_mkexec() to query and set page execution
- pte_mkpte() to set _PAGE_PTE flag.

On book3s/32 there is no exec protection, so pte_mkexec() and
pte_exprotect() are nops and pte_exec() returns always true.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 33 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 30 +++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  5 +++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  5 +++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 28 +++++++++++++++++++++++
 5 files changed, 101 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index b6d3b25d255c..daebb4cde626 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -301,6 +301,9 @@ static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY);
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_hashpte(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_HASHPTE); }
+static inline bool pte_ci(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_NO_CACHE); }
+static inline bool pte_exec(pte_t pte)		{ return true; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 static inline int pte_present(pte_t pte)
@@ -354,6 +357,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -364,6 +372,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
@@ -389,6 +407,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_USER);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_USER);
+}
+
+static inline pte_t pte_mknoncoherent(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_COHERENT);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 13a688fc8cd0..b8a88c6d34ff 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -519,6 +519,11 @@ static inline int pte_special(pte_t pte)
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SPECIAL));
 }
 
+static inline bool pte_exec(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_EXEC));
+}
+
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -646,6 +651,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -656,6 +666,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PTE);
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	/*
@@ -689,6 +709,16 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+}
+
 /*
  * This is potentially called with a pmd as the argument, in which case it's not
  * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 3ee4ae5d28c3..3be2109719ed 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -164,6 +164,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(ptev);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 60d3bdd13ba1..6b50aa864e12 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -114,6 +114,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c746e9e784cd..49417b8b49e9 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -19,6 +19,9 @@ static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_hashpte(pte_t pte)	{ return false; }
+static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
+static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -77,6 +80,11 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -87,6 +95,11 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
@@ -97,6 +110,21 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_HUGE);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+}
+
+static inline pte_t pte_mknoncoherent(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_COHERENT);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-- 
2.13.3
