Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8vZ0B1LzDrLM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:46:34 +1000 (AEST)
Received: by mail-pa0-x22c.google.com with SMTP id zm5so121223491pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 05:46:33 -0700 (PDT)
Subject: Re: [PATCH 03/10] mm/hugetlb: Protect follow_huge_(pud|pgd) functions
 from race
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1460007464-26726-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1460007464-26726-4-git-send-email-khandual@linux.vnet.ibm.com>
 <570627C9.5030105@gmail.com> <570B3897.6040804@linux.vnet.ibm.com>
Cc: hughd@google.com, dave.hansen@intel.com, aneesh.kumar@linux.vnet.ibm.com,
 kirill@shutemov.name, n-horiguchi@ah.jp.nec.com,
 mgorman@techsingularity.net, akpm@linux-foundation.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <570B9C93.5050507@gmail.com>
Date: Mon, 11 Apr 2016 22:46:11 +1000
MIME-Version: 1.0
In-Reply-To: <570B3897.6040804@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/04/16 15:39, Anshuman Khandual wrote:
> On 04/07/2016 02:56 PM, Balbir Singh wrote:
>>
>> On 07/04/16 15:37, Anshuman Khandual wrote:
>>>> follow_huge_(pmd|pud|pgd) functions are used to walk the page table and
>>>> fetch the page struct during 'follow_page_mask' call. There are possible
>>>> race conditions faced by these functions which arise out of simultaneous
>>>> calls of move_pages() and freeing of huge pages. This was fixed partly
>>>> by the previous commit e66f17ff7177 ("mm/hugetlb: take page table lock
>>>> in follow_huge_pmd()") for only PMD based huge pages.
>>>>
>>>> After implementing similar logic, functions like follow_huge_(pud|pgd)
>>>> are now safe from above mentioned race conditions and also can support
>>>> FOLL_GET. Generic version of the function 'follow_huge_addr' has been
>>>> left as it is and its upto the architecture to decide on it.
>>>>
>>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>>> ---
>>>>  include/linux/mm.h | 33 +++++++++++++++++++++++++++
>>>>  mm/hugetlb.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++++--------
>>>>  2 files changed, 91 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index ffcff53..734182a 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1751,6 +1751,19 @@ static inline void pgtable_page_dtor(struct page *page)
>>>>  		NULL: pte_offset_kernel(pmd, address))
>>>>  
>>>>  #if USE_SPLIT_PMD_PTLOCKS
>> Do we still use USE_SPLIT_PMD_PTLOCKS? I think its good enough. with pgd's
>> we are likely to use the same locks and the split nature may not be really
>> split.
>>
> 
> Sorry Balbir, did not get what you asked. Can you please elaborate on
> this ?
> 

What I meant is that do we need SPLIT_PUD_PTLOCKS for example? I don't think we do

Balbir
