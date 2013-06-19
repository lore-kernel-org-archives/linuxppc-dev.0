Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BD2612C0344
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 13:17:27 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id bi5so4674998pad.18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 20:17:24 -0700 (PDT)
Message-ID: <51C122BC.8060107@ozlabs.ru>
Date: Wed, 19 Jun 2013 13:17:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-4-git-send-email-aik@ozlabs.ru>
 <1371357560.21896.120.camel@pasglop>
In-Reply-To: <1371357560.21896.120.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2013 02:39 PM, Benjamin Herrenschmidt wrote:
>>  static pte_t kvmppc_lookup_pte(pgd_t *pgdir, unsigned long hva, bool writing,
>> -			unsigned long *pte_sizep)
>> +			unsigned long *pte_sizep, bool do_get_page)
>>  {
>>  	pte_t *ptep;
>>  	unsigned int shift = 0;
>> @@ -135,6 +136,14 @@ static pte_t kvmppc_lookup_pte(pgd_t *pgdir, unsigned long hva, bool writing,
>>  	if (!pte_present(*ptep))
>>  		return __pte(0);
>>  
>> +	/*
>> +	 * Put huge pages handling to the virtual mode.
>> +	 * The only exception is for TCE list pages which we
>> +	 * do need to call get_page() for.
>> +	 */
>> +	if ((*pte_sizep > PAGE_SIZE) && do_get_page)
>> +		return __pte(0);
>> +
>>  	/* wait until _PAGE_BUSY is clear then set it atomically */
>>  	__asm__ __volatile__ (
>>  		"1:	ldarx	%0,0,%3\n"
>> @@ -148,6 +157,18 @@ static pte_t kvmppc_lookup_pte(pgd_t *pgdir, unsigned long hva, bool writing,
>>  		: "cc");
>>  
>>  	ret = pte;
>> +	if (do_get_page && pte_present(pte) && (!writing || pte_write(pte))) {
>> +		struct page *pg = NULL;
>> +		pg = realmode_pfn_to_page(pte_pfn(pte));
>> +		if (realmode_get_page(pg)) {
>> +			ret = __pte(0);
>> +		} else {
>> +			pte = pte_mkyoung(pte);
>> +			if (writing)
>> +				pte = pte_mkdirty(pte);
>> +		}
>> +	}
>> +	*ptep = pte;	/* clears _PAGE_BUSY */
>>  
>>  	return ret;
>>  }
> 
> So now you are adding the clearing of _PAGE_BUSY that was missing for
> your first patch, except that this is not enough since that means that
> in the "emulated" case (ie, !do_get_page) you will in essence return
> and then use a PTE that is not locked without any synchronization to
> ensure that the underlying page doesn't go away... then you'll
> dereference that page.
> 
> So either make everything use speculative get_page, or make the emulated
> case use the MMU notifier to drop the operation in case of collision.
> 
> The former looks easier.
> 
> Also, any specific reason why you do:
> 
>   - Lock the PTE
>   - get_page()
>   - Unlock the PTE
> 
> Instead of
> 
>   - Read the PTE
>   - get_page_unless_zero
>   - re-check PTE
> 
> Like get_user_pages_fast() does ?
> 
> The former will be two atomic ops, the latter only one (faster), but
> maybe you have a good reason why that can't work...



If we want to set "dirty" and "young" bits for pte then I do not know how
to avoid _PAGE_BUSY.



-- 
Alexey
