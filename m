Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 684581A048E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 02:06:24 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 20:36:21 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 37B181258023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 20:36:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9F6Np958065046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 20:36:24 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9F69tQ016043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 20:36:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 LEROY Christophe <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, scottwood@freescale.com
Subject: Re: powerpc32: missing accessors to pgprot_t objects
In-Reply-To: <20141209101841.7D9241400D2@ozlabs.org>
References: <20141209101841.7D9241400D2@ozlabs.org>
Date: Tue, 09 Dec 2014 20:36:08 +0530
Message-ID: <87bnncq2vz.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> On Mon, 2014-08-12 at 14:16:29 UTC, LEROY Christophe wrote:
>> Compilation with #define STRICT_MM_TYPECHECKS in arch/powerpc/include/as=
m/page.h
>> fails due to missing use of pgprot_val() when using pgprot_t objects.
>
> Hmm, looks like 64 bit doesn't build either.
>
> Aneesh I think you added this, mind fixing it up?
>
> In file included from ../arch/powerpc/include/asm/thread_info.h:34:0,
>                  from ../include/linux/thread_info.h:54,
>                  from ../include/asm-generic/preempt.h:4,
>                  from arch/powerpc/include/generated/asm/preempt.h:1,
>                  from ../include/linux/preempt.h:18,
>                  from ../include/linux/spinlock.h:50,
>                  from ../include/linux/mmzone.h:7,
>                  from ../include/linux/gfp.h:5,
>                  from ../include/linux/mm.h:9,
>                  from ../arch/powerpc/mm/tlb_hash64.c:25:
> ../arch/powerpc/mm/tlb_hash64.c: In function =E2=80=98__flush_hash_table_=
range=E2=80=99:
> ../arch/powerpc/include/asm/page.h:286:24: error: request for member =E2=
=80=98pte=E2=80=99 in something not a structure or union
>  #define pte_val(x) ((x).pte)
>                         ^=20=20=20=20
> ../arch/powerpc/mm/tlb_hash64.c:219:37: note: in expansion of macro =E2=
=80=98pte_val=E2=80=99
>     trace_hugepage_invalidate(start, pte_val(pte));
>                                      ^=20=20=20=20
> make[2]: *** [arch/powerpc/mm/tlb_hash64.o] Error 1
>

Will send a proper patch after compile testing with other configs. The
kvm hunk is really ugly, will try to rework.=20

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/includ=
e/asm/kvm_book3s_64.h
index 0aa8179..cd0ff37 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -291,11 +291,11 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_=
t *ptep, int writing,
 	pte_t old_pte, new_pte =3D __pte(0);
=20
 	while (1) {
-		old_pte =3D pte_val(*ptep);
+		old_pte =3D *ptep;
 		/*
 		 * wait until _PAGE_BUSY is clear then set it atomically
 		 */
-		if (unlikely(old_pte & _PAGE_BUSY)) {
+		if (unlikely(pte_val(old_pte) & _PAGE_BUSY)) {
 			cpu_relax();
 			continue;
 		}
@@ -306,16 +306,18 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_=
t *ptep, int writing,
 			return __pte(0);
 #endif
 		/* If pte is not present return None */
-		if (unlikely(!(old_pte & _PAGE_PRESENT)))
+		if (unlikely(!(pte_val(old_pte) & _PAGE_PRESENT)))
 			return __pte(0);
=20
 		new_pte =3D pte_mkyoung(old_pte);
 		if (writing && pte_write(old_pte))
 			new_pte =3D pte_mkdirty(new_pte);
=20
-		if (old_pte =3D=3D __cmpxchg_u64((unsigned long *)ptep, old_pte,
-					     new_pte))
+		if (pte_val(old_pte) =3D=3D __cmpxchg_u64((unsigned long *)ptep,
+						      pte_val(old_pte),
+						      pte_val(new_pte))) {
 			break;
+		}
 	}
 	return new_pte;
 }
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/pag=
e.h
index 26fe1ae..cc62ab9 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -278,7 +278,7 @@ extern long long virt_phys_offset;
=20
 #ifndef __ASSEMBLY__
=20
-#undef STRICT_MM_TYPECHECKS
+#define STRICT_MM_TYPECHECKS 1
=20
 #ifdef STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking. */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/=
pgtable.h
index 316f9a5..3e29088 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -77,8 +77,8 @@ static inline void pmdp_set_numa(struct mm_struct *mm, un=
signed long addr,
  * which was inherited from x86. For the purposes of powerpc pte_basic_t a=
nd
  * pmd_t are equivalent
  */
-#define pteval_t pte_basic_t
-#define pmdval_t pmd_t
+typedef unsigned long pteval_t;
+typedef unsigned long pmdval_t;
 static inline pteval_t ptenuma_flags(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NUMA_MASK;
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index c8d709a..5162936 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -714,7 +714,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long add=
r,
 	assert_spin_locked(&mm->page_table_lock);
 	WARN_ON(!pmd_trans_huge(pmd));
 #endif
-	trace_hugepage_set_pmd(addr, pmd);
+	trace_hugepage_set_pmd(addr, pmd_val(pmd));
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
=20
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index d2a94b8..c522969 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -216,7 +216,7 @@ void __flush_hash_table_range(struct mm_struct *mm, uns=
igned long start,
 			continue;
 		pte =3D pte_val(*ptep);
 		if (hugepage_shift)
-			trace_hugepage_invalidate(start, pte_val(pte));
+			trace_hugepage_invalidate(start, pte);
 		if (!(pte & _PAGE_HASHPTE))
 			continue;
 		if (unlikely(hugepage_shift && pmd_trans_huge(*(pmd_t *)pte)))
