Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrH1N44WHzDqZg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 21:42:48 +1000 (AEST)
Received: by mail-pf0-x231.google.com with SMTP id n1so29560800pfn.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 04:42:48 -0700 (PDT)
Subject: Re: [PATCH V2 29/68] powerpc/mm: Move hugetlb and THP related pmd
 accessors to pgtable.h
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5718A328.10309@gmail.com> <1461232790.26743.0.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718BCA8.704@gmail.com>
Date: Thu, 21 Apr 2016 21:42:32 +1000
MIME-Version: 1.0
In-Reply-To: <1461232790.26743.0.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21/04/16 19:59, Michael Ellerman wrote:
> On Thu, 2016-04-21 at 19:53 +1000, Balbir Singh wrote:
>> On 09/04/16 16:13, Aneesh Kumar K.V wrote:
>>> +static inline int pgd_huge(pgd_t pgd)
>>> +{
>>> +	/*
>>> +	 * leaf pte for huge page
>>> +	 */
>>> +	return !!(pgd_val(pgd) & _PAGE_PTE);
>>> +}
>>> +#define pgd_huge pgd_huge
>>> +
>>
>> ??
> 
> #ifndef pgd_huge
> #define pgd_huge(x)	0
> #endif
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/hugetlb.h#n185
> 

Aaah.. makes sense

Cheers
Balbir Singh.
