Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4269fR16grzF3SN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 18:32:15 +1000 (AEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <8736uneylc.fsf@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1f4d6cc9-5d18-b171-02b0-d715629d594f@c-s.fr>
Date: Thu, 6 Sep 2018 21:36:53 +0000
MIME-Version: 1.0
In-Reply-To: <8736uneylc.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/06/2018 09:58 AM, Aneesh Kumar K.V wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>> common parts of code.
>> Using those directly in common parts of code have proven to lead to
>> mistakes or misbehaviour, because their use is not always as trivial
>> as one could think.
>>
>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>> that a page is a kernel page, because some targets are using
>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>> This has to (bad) consequences:
>>
>>   - All targets must define every bit, even the unsupported ones,
>>     leading to a lot of useless #define _PAGE_XXX 0
>>   - If someone forgets to take into account all possible _PAGE_XXX bits
>>     for the case, we can get unexpected behaviour on some targets.
>>
>> This becomes even more complex when we come to using _PAGE_RW.
>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>> if writable or not, because:
>>
>>   - Some targets have _PAGE_RO instead, which has to be unset to tell
>>     a page is writable
>>   - Some targets have _PAGE_R and _PAGE_W, in which case
>>     _PAGE_RW = _PAGE_R | _PAGE_W
>>   - Even knowing whether a page is readable is not always trivial because:
>>     - Some targets requires to check that _PAGE_R is set to ensure page
>>     is readable
>>     - Some targets requires to check that _PAGE_NA is not set
>>     - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>
>> Etc ....
>>
>> In order to work around all those issues and minimise the risks of errors,
>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
>> are then defined in target specific parts of the kernel code.
> 
> The series is really good. It also helps in code readability. Few things
> i am not sure there is a way to reduce the overhead
> 
> -		access = _PAGE_EXEC;
> +		access = pte_val(pte_mkexec(__pte(0)));
> 
> Considering we have multiple big endian to little endian coversion there
> for book3s 64.

Thanks for the review.

For the above, I propose the following:

diff --git a/arch/powerpc/mm/hash_utils_64.c 
b/arch/powerpc/mm/hash_utils_64.c
index f23a89d8e4ce..904ac9c84ea5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct 
*mm, unsigned long ea)
  #endif

  void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  unsigned long access, unsigned long trap)
+		  bool is_exec, unsigned long trap)
  {
  	int hugepage_shift;
  	unsigned long vsid;
@@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned 
long ea,
  	pte_t *ptep;
  	unsigned long flags;
  	int rc, ssize, update_flags = 0;
+	unsigned long access = is_exec ? _PAGE_EXEC : 0;

  	BUG_ON(REGION_ID(ea) != USER_REGION_ID);

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c611..4122f26a2f44 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -507,7 +507,8 @@ void update_mmu_cache(struct vm_area_struct *vma, 
unsigned long address,
  	 * We don't need to worry about _PAGE_PRESENT here because we are
  	 * called with either mm->page_table_lock held or ptl lock held
  	 */
-	unsigned long access, trap;
+	unsigned long trap;
+	bool is_exec;

  	if (radix_enabled()) {
  		prefetch((void *)address);
@@ -529,10 +530,10 @@ void update_mmu_cache(struct vm_area_struct *vma, 
unsigned long address,
  	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
  	switch (trap) {
  	case 0x300:
-		access = 0UL;
+		is_exec = false;
  		break;
  	case 0x400:
-		access = _PAGE_EXEC;
+		is_exec = true;
  		break;
  	default:
  		return;
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index e5d779eed181..dd7f9b951d25 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -82,7 +82,7 @@ static inline void _tlbivax_bcast(unsigned long 
address, unsigned int pid,
  #else /* CONFIG_PPC_MMU_NOHASH */

  extern void hash_preload(struct mm_struct *mm, unsigned long ea,
-			 unsigned long access, unsigned long trap);
+			 bool is_exec, unsigned long trap);


  extern void _tlbie(unsigned long address);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f983ffa24aa0..506e5c3e96da 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -263,7 +263,7 @@ static void __init __mapin_ram_chunk(unsigned long 
offset, unsigned long top)
  		map_kernel_page(v, p, f);
  #ifdef CONFIG_PPC_STD_MMU_32
  		if (ktext)
-			hash_preload(&init_mm, v, 0, 0x300);
+			hash_preload(&init_mm, v, false, 0x300);
  #endif
  		v += PAGE_SIZE;
  		p += PAGE_SIZE;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index bea6c544e38f..38a793bfca37 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -163,7 +163,7 @@ void __init setbat(int index, unsigned long virt, 
phys_addr_t phys,
   * Preload a translation in the hash table
   */
  void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  unsigned long access, unsigned long trap)
+		  bool is_exec, unsigned long trap)
  {
  	pmd_t *pmd;



> 
> Other thing is __ioremap_at where we do
> 
> +       pte_t pte = __pte(flags);
>   
>          /* Make sure we have the base flags */
> -       if ((flags & _PAGE_PRESENT) == 0)
> +       if (!pte_present(pte))

This one is using pte_raw(), so shouldn't be a problem.

Since the function is doing almost nothing of on the flags, maybe
we could just replace the above by pte_present(__pte(flags)) and
leave the rest as is.

> 
> -               err = map_kernel_page(v+i, p+i, flags);
> +               err = map_kernel_page(v + i, p + i, pte_val(pte));

Maybe another alternative would be to pass a pte_t to map_kernel_page(), 
then we have to find an optimised way to insert the RPN into it before
calling set_pte_at() instead of using pfn_pte() ?


If we are so concerned by the multiple conversions, should we modify all 
the pte_mkxxxx() to use pte_raw() and __pte_raw() instead of pte_val() 
and __pte() ?

> 
> 
> But otherwise for the series.
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 

Thanks
Christophe
