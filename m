Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 970412C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 02:22:16 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Jan 2014 20:52:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B37EBE004A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 20:55:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0KFM7Gn56885272
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 20:52:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0KFM71o005313
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 20:52:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/4] powernv: kvm: make _PAGE_NUMA take effect
In-Reply-To: <1386751674-14136-3-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1386751674-14136-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1386751674-14136-3-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Mon, 20 Jan 2014 20:52:07 +0530
Message-ID: <87fvoi7k68.fsf@linux.vnet.ibm.com>
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

> To make _PAGE_NUMA take effect, we should force the checking when
> guest uses hypercall to setup hpte.
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
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

How did we end up doing h_enter on a pte entry with pte_numa bit set ?

-aneesh
