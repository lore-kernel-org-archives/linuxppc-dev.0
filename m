Return-Path: <nizhan.chen@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76CA12C0088
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 11:36:01 +1100 (EST)
Received: by mail-pa0-f51.google.com with SMTP id kq12so1193771pab.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 17:35:59 -0700 (PDT)
Message-ID: <50761466.9010902@gmail.com>
Date: Thu, 11 Oct 2012 08:35:50 +0800
From: Ni zhan Chen <nizhan.chen@gmail.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH 8/10] memory-hotplug : remove page table of x86_64
 architecture
References: <506E43E0.70507@jp.fujitsu.com> <506E4799.30407@jp.fujitsu.com>
 <m2d30tvatv.fsf@firstfloor.org> <50726354.60803@cn.fujitsu.com>
In-Reply-To: <50726354.60803@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
 Andi Kleen <andi@firstfloor.org>, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/08/2012 01:23 PM, Wen Congyang wrote:
> At 10/08/2012 12:37 PM, Andi Kleen Wrote:
>> Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com> writes:
>>> +			}
>>> +
>>> +			/*
>>> +			 * We use 2M page, but we need to remove part of them,
>>> +			 * so split 2M page to 4K page.
>>> +			 */
>>> +			pte = alloc_low_page(&pte_phys);
>> What happens when the allocation fails?
>>
>> alloc_low_page seems to be buggy there too, it would __pa a NULL
>> pointer.
> Yes, it will cause kernek panicked in __pa() if CONFI_DEBUG_VIRTUAL is set.
> Otherwise, it will return a NULL pointer. I will update this patch to deal
> with NULL pointer.
>
>>> +		if (pud_large(*pud)) {
>>> +			if ((addr & ~PUD_MASK) == 0 && next <= end) {
>>> +				set_pud(pud, __pud(0));
>>> +				pages++;
>>> +				continue;
>>> +			}
>>> +
>>> +			/*
>>> +			 * We use 1G page, but we need to remove part of them,
>>> +			 * so split 1G page to 2M page.
>>> +			 */
>>> +			pmd = alloc_low_page(&pmd_phys);
>> Same here
>>
>>> +			__split_large_page((pte_t *)pud, addr, (pte_t *)pmd);
>>> +
>>> +			spin_lock(&init_mm.page_table_lock);
>>> +			pud_populate(&init_mm, pud, __va(pmd_phys));
>>> +			spin_unlock(&init_mm.page_table_lock);
>>> +		}
>>> +
>>> +		pmd = map_low_page(pmd_offset(pud, 0));
>>> +		phys_pmd_remove(pmd, addr, end);
>>> +		unmap_low_page(pmd);
>>> +		__flush_tlb_all();
>>> +	}
>>> +	__flush_tlb_all();

Hi Congyang,

I see you call __flush_tlb_all() every pud entry(all pmd, pte related to 
it changed) modified, then how to determine the flush frequency? why not 
every pmd entry?

Regards,
Chen

>> This doesn't flush the other CPUs doesn't it?
> How to flush the other CPU's tlb? use on_each_cpu() to run __flush_tlb_all()
> on each online cpu?
>
> Thanks
> Wen Congyang
>
>> -Andi
>>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
