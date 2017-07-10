Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5VZx6G03zDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:10:33 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A39D1w113256
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Jul 2017 23:10:31 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjuj0v0up-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 23:10:31 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 10 Jul 2017 13:10:29 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A3AQlk19333288
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:10:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A3AGPG006298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 13:10:18 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC v5 32/38] powerpc: capture the violated protection key on
 fault
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-33-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Date: Mon, 10 Jul 2017 08:40:19 +0530
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-33-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5fa43f48-d3b3-89f2-0bbd-58be3e07f4b8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2017 02:52 AM, Ram Pai wrote:
> Capture the protection key that got violated in paca.
> This value will be used by used to inform the signal
> handler.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/paca.h   |    1 +
>  arch/powerpc/kernel/asm-offsets.c |    1 +
>  arch/powerpc/mm/fault.c           |    3 +++
>  3 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index c8bd1fc..0c06188 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -94,6 +94,7 @@ struct paca_struct {
>  	u64 dscr_default;		/* per-CPU default DSCR */
>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>  	u64 paca_amr;			/* value of amr at exception */
> +	u16 paca_pkey;                  /* exception causing pkey */
>  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  
>  #ifdef CONFIG_PPC_STD_MMU_64
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 17f5d8a..7dff862 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -244,6 +244,7 @@ int main(void)
>  
>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>  	OFFSET(PACA_AMR, paca_struct, paca_amr);
> +	OFFSET(PACA_PKEY, paca_struct, paca_pkey);
>  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>  
>  	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a6710f5..c8674a7 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -265,6 +265,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (error_code & DSISR_KEYFAULT) {
>  		code = SEGV_PKUERR;
>  		get_paca()->paca_amr = read_amr();
> +		get_paca()->paca_pkey = get_pte_pkey(current->mm, address);
>  		goto bad_area_nosemaphore;
>  	}
>  #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
> @@ -290,6 +291,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +

Stray empty line addition here.

>  	/*
>  	 * We want to do this outside mmap_sem, because reading code around nip
>  	 * can result in fault, which will cause a deadlock when called with
> @@ -453,6 +455,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>  			is_exec, 0)) {
>  		get_paca()->paca_amr = read_amr();
> +		get_paca()->paca_pkey = vma_pkey(vma);

Why not get_pte_pkey() here as well ? IIUC both these function would
give us the same pkey, then why is the difference when we process a
page fault for real protection key violation in HW compared to cross
checking of VMA protection key in SW for regular page faults.
