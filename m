Return-Path: <cody@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C64C0B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 03:47:32 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 13:47:23 -0400
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5THidAY245186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 13:44:39 -0400
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5THjbMT007804
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2012 11:45:38 -0600
Message-ID: <4FEDE985.5050902@linux.vnet.ibm.com>
Date: Fri, 29 Jun 2012 10:44:37 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V1 2/9] arch/powerpc: Convert virtual address to a struct
References: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1340979457-26018-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1340979457-26018-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index 1c65a59..5ff936b 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -143,6 +143,10 @@ struct mmu_psize_def
>   	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
>   };
>
> +struct virt_addr {
> +	unsigned long addr;
> +};
> +
>   #endif /* __ASSEMBLY__ */
>
>   /*


> @@ -1153,13 +1153,13 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>   /* WARNING: This is called from hash_low_64.S, if you change this prototype,
>    *          do not forget to update the assembly call site !
>    */

I'd suggest having a similar warning next to the definition of struct 
virt_addr, as any changes to it mean we'll need to adjust hash_low_64.S

> -void flush_hash_page(unsigned long va, real_pte_t pte, int psize, int ssize,
> +void flush_hash_page(struct virt_addr va, real_pte_t pte, int psize, int ssize,
>   		     int local)
>   {
>   	unsigned long hash, index, shift, hidx, slot;
>
> -	DBG_LOW("flush_hash_page(va=%016lx)\n", va);
> -	pte_iterate_hashed_subpages(pte, psize, va, index, shift) {
> +	DBG_LOW("flush_hash_page(va=%016lx)\n", va.addr);
> +	pte_iterate_hashed_subpages(pte, psize, va.addr, index, shift) {
>   		hash = hpt_hash(va, shift, ssize);
>   		hidx = __rpte_to_hidx(pte, index);
>   		if (hidx & _PTEIDX_SECONDARY)

--
Cody
