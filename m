Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E6E2C2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:42:22 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 19:42:21 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 722A22CE8053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:42:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0L9N8Cg56492106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:23:08 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0L9gIQV028079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 20:42:18 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
In-Reply-To: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Tue, 21 Jan 2014 15:12:14 +0530
Message-ID: <8761pdk6x5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu Ping Fan <kernelfans@gmail.com> writes:

> To make sure that on host, the pages marked with _PAGE_NUMA result in a fault
> when guest access them, we should force the checking when guest uses hypercall
> to setup hpte.
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

When we mark pte with _PAGE_NUMA we already call mmu_notifier_invalidate_range_start and
mmu_notifier_invalidate_range_end, which will mark existing guest hpte
entry as HPTE_V_ABSENT. Now we need to do that when we are inserting new
guest hpte entries. This patch does that. 

> ---
> v2:
>   It should be the reply to "[PATCH 2/4] powernv: kvm: make _PAGE_NUMA take effect"
>   And I imporve the changelog according to Aneesh's suggestion.
> ---
>  arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 9c51544..af8602d 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -232,7 +232,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
>  		/* Look up the Linux PTE for the backing page */
>  		pte_size = psize;
>  		pte = lookup_linux_pte(pgdir, hva, writing, &pte_size);
> -		if (pte_present(pte)) {
> +		if (pte_present(pte) && !pte_numa(pte)) {
>  			if (writing && !pte_write(pte))
>  				/* make the actual HPTE be read-only */
>  				ptel = hpte_make_readonly(ptel);
> -- 
> 1.8.1.4
