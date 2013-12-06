Return-Path: <Hong.Pham@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com", Issuer "Thawte SGC CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 269E22C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 03:15:12 +1100 (EST)
Message-ID: <52A1F804.5000205@windriver.com>
Date: Fri, 6 Dec 2013 11:15:00 -0500
From: "Hong H. Pham" <hong.pham@windriver.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, linux-rt-users
 <linux-rt-users@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
References: <1386258894-21851-1-git-send-email-hong.pham@windriver.com>
 <874n6muuw4.fsf@linux.vnet.ibm.com>
In-Reply-To: <874n6muuw4.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linux-stable <stable@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On 12/06/2013 05:38 AM, Aneesh Kumar K.V wrote:

> can you also specifiy the config details here. ie, 4K page size functions
> are broken ?

My PPC64 config has SMP and 4K page size enabled.  I re-tested with 64K page size,
and the problem is not present.

I have added a note that this problem affects only PPC32 and PPC64 SMP kernels.
On PPC64, the problem is limited to 4K page size.

> make it closer to what it was before,
>
> pgtable_page_dtor(table);
> pgtable_free_tlb(tlb, page_address(table), 0);
>
> This is what we had before
>
> -static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
> -                                 unsigned long address)
> -{
> -       tlb_flush_pgtable(tlb, address);
> -       pgtable_page_dtor(ptepage);
> -       pgtable_free_tlb(tlb, page_address(ptepage), 0);
> -}
>
>
> -aneesh
>

Done.

Thanks,
Hong
