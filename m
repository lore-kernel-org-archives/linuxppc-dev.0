Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78D552C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 22:45:17 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Dec 2013 21:45:16 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B6B583578069
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 21:58:32 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB5AwKJI11993526
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 21:58:20 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB5AwVfp013219
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Dec 2013 21:58:32 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3] powerpc: mm: optimize for the correctly placed page
In-Reply-To: <1386140348-7854-4-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386140348-7854-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386140348-7854-4-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Thu, 05 Dec 2013 16:28:27 +0530
Message-ID: <877gbjva24.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu Ping Fan <kernelfans@gmail.com> writes:

> The period check of _PAGE_NUMA can probably trigger the check on
> the correctly placed page. For this case, we can just insert hpte and
> do fast exception return.

I still don't understand why we need to handle numa faults in hash
page ? Are you trying to optimize the code path ? If so can you explain
the benefits ? Some numbers showing it is helping  ?


>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 9bf1195..735678c 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -965,6 +965,10 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>  	const struct cpumask *tmp;
>  	int rc, user_region = 0, local = 0;
>  	int psize, ssize;
> +	pte_t old, new;
> +	struct vm_area_struct *vma;
> +	int page_nid, target_nid;
> +	struct page *test_page;
>
>  	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
>  		ea, access, trap);
> @@ -1033,12 +1037,40 @@ int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
>
>  	/* Get PTE and page size from page tables */
>  	ptep = find_linux_pte_or_hugepte(pgdir, ea, &hugeshift);
> -	if (ptep == NULL || !pte_present(*ptep) || pte_numa(*ptep)) {
> +	if (ptep == NULL || !pte_present(*ptep)) {
>  		DBG_LOW(" no PTE !\n");
>  		rc = 1;
>  		goto bail;
>  	}
>
> +	old = pte_val(*ptep);
> +	if (pte_numa(old)) {
> +		/* If fail to lock, let do_page_fault() to handle it */
> +		if (down_read_trylock(&mm->mmap_sem)) {

hmm is that something we want to do in hash_page ?

> +			vma = find_vma(mm, ea);
> +			up_read(&mm->mmap_sem);
> +			test_page = pte_page(old);
> +			page_nid = page_to_nid(test_page);
> +			target_nid = numa_migrate_prep(test_page, vma, ea,
> +						page_nid);
> +			if (target_nid < 0) {
> +				new = pte_mknonnuma(old);
> +				/* If ptep is modified under us,
> +				 * just retry the access
> +				 */
> +				if (unlikely(cmpxchg(ptep, old, new) != old)) {
> +					put_page(test_page);
> +					return 0;
> +				}
> +				put_page(test_page);
> +			}
> +		} else {
> +				put_page(test_page);
> +				rc = 1;
> +				goto bail;
> +		}
> +	}
> +
>  	/* Add _PAGE_PRESENT to the required access perm */
>  	access |= _PAGE_PRESENT;
>

-aneesh
