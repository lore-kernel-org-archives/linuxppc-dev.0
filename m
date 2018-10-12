Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24CC6787C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:22:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CE02098A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 22:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CE02098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kot-begemot.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42X2QT0FJPzF3M7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 09:22:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kot-begemot.co.uk
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kot-begemot.co.uk
 (client-ip=5.153.251.140; helo=www.kot-begemot.co.uk;
 envelope-from=anton.ivanov@kot-begemot.co.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kot-begemot.co.uk
Received: from www.kot-begemot.co.uk (ivanoab6.miniserver.com [5.153.251.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Wx771mKBzF3Hw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 05:24:01 +1100 (AEDT)
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
 by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gB0lv-0003Z8-81; Fri, 12 Oct 2018 16:58:43 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
 by smaug.kot-begemot.co.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>)
 id 1gB0lu-0006ul-Ts; Fri, 12 Oct 2018 17:58:42 +0100
Subject: Re: [PATCH v2 2/2] mm: speed up mremap by 500x on large regions
To: Joel Fernandes <joel@joelfernandes.org>
References: <20181012013756.11285-1-joel@joelfernandes.org>
 <20181012013756.11285-2-joel@joelfernandes.org>
 <9ed82f9e-88c4-8e4f-8c45-3ef153469603@kot-begemot.co.uk>
 <20181012143728.t42uvr6etg7gp7fh@kshutemo-mobl1>
 <4dd52e22-5b51-9b30-7178-fde603a08f88@kot-begemot.co.uk>
 <97cb3fe1-7bc1-12ff-d602-56c72a5496c5@kot-begemot.co.uk>
 <20181012165012.GD223066@joelaf.mtv.corp.google.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4f969958-913e-cb9f-48fb-e3a88e1d288c@kot-begemot.co.uk>
Date: Fri, 12 Oct 2018 17:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012165012.GD223066@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 13 Oct 2018 08:58:20 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-mips@linux-mips.org, Rich Felker <dalias@libc.org>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>,
 mhocko@kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 elfring@users.sourceforge.net, Jonas Bonn <jonas@southpole.se>,
 linux-s390@vger.kernel.org, dancol@google.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Max Filippov <jcmvbkbc@gmail.com>,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>,
 "maintainer:X86 ARCHITECTURE 32-BIT AND 64-BIT" <x86@kernel.org>,
 hughd@google.com, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 kasan-dev@googlegroups.com, kvmarm@lists.cs.columbia.edu,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-snps-arc@lists.infradead.org,
 kernel-team@android.com, Sam Creasey <sammy@sammy.net>,
 linux-xtensa@linux-xtensa.org, Jeff Dike <jdike@addtoit.com>,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Julia Lawall <Julia.Lawall@lip6.fr>, linux-m68k@lists.linux-m68k.org,
 openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Ley Foon Tan <lftan@altera.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, pantin@google.com, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>, minchan@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Richard Weinberger <richard@nod.at>,
 nios2-dev@lists.rocketboards.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 10/12/18 5:50 PM, Joel Fernandes wrote:
> On Fri, Oct 12, 2018 at 05:42:24PM +0100, Anton Ivanov wrote:
>> On 10/12/18 3:48 PM, Anton Ivanov wrote:
>>> On 12/10/2018 15:37, Kirill A. Shutemov wrote:
>>>> On Fri, Oct 12, 2018 at 03:09:49PM +0100, Anton Ivanov wrote:
>>>>> On 10/12/18 2:37 AM, Joel Fernandes (Google) wrote:
>>>>>> Android needs to mremap large regions of memory during
>>>>>> memory management
>>>>>> related operations. The mremap system call can be really
>>>>>> slow if THP is
>>>>>> not enabled. The bottleneck is move_page_tables, which is copying each
>>>>>> pte at a time, and can be really slow across a large map.
>>>>>> Turning on THP
>>>>>> may not be a viable option, and is not for us. This patch
>>>>>> speeds up the
>>>>>> performance for non-THP system by copying at the PMD level
>>>>>> when possible.
>>>>>>
>>>>>> The speed up is three orders of magnitude. On a 1GB mremap, the mremap
>>>>>> completion times drops from 160-250 millesconds to 380-400
>>>>>> microseconds.
>>>>>>
>>>>>> Before:
>>>>>> Total mremap time for 1GB data: 242321014 nanoseconds.
>>>>>> Total mremap time for 1GB data: 196842467 nanoseconds.
>>>>>> Total mremap time for 1GB data: 167051162 nanoseconds.
>>>>>>
>>>>>> After:
>>>>>> Total mremap time for 1GB data: 385781 nanoseconds.
>>>>>> Total mremap time for 1GB data: 388959 nanoseconds.
>>>>>> Total mremap time for 1GB data: 402813 nanoseconds.
>>>>>>
>>>>>> Incase THP is enabled, the optimization is skipped. I also flush the
>>>>>> tlb every time we do this optimization since I couldn't find a way to
>>>>>> determine if the low-level PTEs are dirty. It is seen that the cost of
>>>>>> doing so is not much compared the improvement, on both
>>>>>> x86-64 and arm64.
>>>>>>
>>>>>> Cc: minchan@kernel.org
>>>>>> Cc: pantin@google.com
>>>>>> Cc: hughd@google.com
>>>>>> Cc: lokeshgidra@google.com
>>>>>> Cc: dancol@google.com
>>>>>> Cc: mhocko@kernel.org
>>>>>> Cc: kirill@shutemov.name
>>>>>> Cc: akpm@linux-foundation.org
>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>>> ---
>>>>>>     mm/mremap.c | 62
>>>>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>>     1 file changed, 62 insertions(+)
>>>>>>
>>>>>> diff --git a/mm/mremap.c b/mm/mremap.c
>>>>>> index 9e68a02a52b1..d82c485822ef 100644
>>>>>> --- a/mm/mremap.c
>>>>>> +++ b/mm/mremap.c
>>>>>> @@ -191,6 +191,54 @@ static void move_ptes(struct
>>>>>> vm_area_struct *vma, pmd_t *old_pmd,
>>>>>>             drop_rmap_locks(vma);
>>>>>>     }
>>>>>> +static bool move_normal_pmd(struct vm_area_struct *vma,
>>>>>> unsigned long old_addr,
>>>>>> +          unsigned long new_addr, unsigned long old_end,
>>>>>> +          pmd_t *old_pmd, pmd_t *new_pmd, bool *need_flush)
>>>>>> +{
>>>>>> +    spinlock_t *old_ptl, *new_ptl;
>>>>>> +    struct mm_struct *mm = vma->vm_mm;
>>>>>> +
>>>>>> +    if ((old_addr & ~PMD_MASK) || (new_addr & ~PMD_MASK)
>>>>>> +        || old_end - old_addr < PMD_SIZE)
>>>>>> +        return false;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * The destination pmd shouldn't be established, free_pgtables()
>>>>>> +     * should have release it.
>>>>>> +     */
>>>>>> +    if (WARN_ON(!pmd_none(*new_pmd)))
>>>>>> +        return false;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * We don't have to worry about the ordering of src and dst
>>>>>> +     * ptlocks because exclusive mmap_sem prevents deadlock.
>>>>>> +     */
>>>>>> +    old_ptl = pmd_lock(vma->vm_mm, old_pmd);
>>>>>> +    if (old_ptl) {
>>>>>> +        pmd_t pmd;
>>>>>> +
>>>>>> +        new_ptl = pmd_lockptr(mm, new_pmd);
>>>>>> +        if (new_ptl != old_ptl)
>>>>>> +            spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
>>>>>> +
>>>>>> +        /* Clear the pmd */
>>>>>> +        pmd = *old_pmd;
>>>>>> +        pmd_clear(old_pmd);
>>>>>> +
>>>>>> +        VM_BUG_ON(!pmd_none(*new_pmd));
>>>>>> +
>>>>>> +        /* Set the new pmd */
>>>>>> +        set_pmd_at(mm, new_addr, new_pmd, pmd);
>>>>> UML does not have set_pmd_at at all
>>>> Every architecture does. :)
>>> I tried to build it patching vs 4.19-rc before I made this statement and
>>> ran into that.
>>>
>>> Presently it does not.
>>>
>>> https://elixir.bootlin.com/linux/v4.19-rc7/ident/set_pmd_at - UML is not
>>> on the list.
>> Once this problem as well as the omissions in the include changes for UML in
>> patch one have been fixed it appears to be working.
>>
>> What it needs is attached.
>>
>>
>>>> But it may come not from the arch code.
>>> There is no generic definition as far as I can see. All 12 defines in
>>> 4.19 are in arch specific code. Unless i am missing something...
>>>
>>>>> If I read the code right, MIPS completely ignores the address
>>>>> argument so
>>>>> set_pmd_at there may not have the effect which this patch is trying to
>>>>> achieve.
>>>> Ignoring address is fine. Most architectures do that..
>>>> The ideas is to move page table to the new pmd slot. It's nothing to do
>>>> with the address passed to set_pmd_at().
>>> If that is it's only function, then I am going to appropriate the code
>>> out of the MIPS tree for further uml testing. It does exactly that -
>>> just move the pmd the new slot.
>>>
>>> A.
>>
>> A.
>>
>>  From ac265d96897a346b05646fce91784ed4922c7f8d Mon Sep 17 00:00:00 2001
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Date: Fri, 12 Oct 2018 17:24:10 +0100
>> Subject: [PATCH] Incremental fixes to the mmremap patch
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> ---
>>   arch/um/include/asm/pgalloc.h | 4 ++--
>>   arch/um/include/asm/pgtable.h | 3 +++
>>   arch/um/kernel/tlb.c          | 6 ++++++
>>   3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
>> index bf90b2aa2002..99eb5682792a 100644
>> --- a/arch/um/include/asm/pgalloc.h
>> +++ b/arch/um/include/asm/pgalloc.h
>> @@ -25,8 +25,8 @@
>>   extern pgd_t *pgd_alloc(struct mm_struct *);
>>   extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>>   
>> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *, unsigned long);
>> -extern pgtable_t pte_alloc_one(struct mm_struct *, unsigned long);
>> +extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
>> +extern pgtable_t pte_alloc_one(struct mm_struct *);
> If its Ok, let me handle this bit since otherwise it complicates things for
> me.
>
>>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>>   {
>> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
>> index 7485398d0737..1692da55e63a 100644
>> --- a/arch/um/include/asm/pgtable.h
>> +++ b/arch/um/include/asm/pgtable.h
>> @@ -359,4 +359,7 @@ do {						\
>>   	__flush_tlb_one((vaddr));		\
>>   } while (0)
>>   
>> +extern void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>> +		pmd_t *pmdp, pmd_t pmd);
>> +
>>   #endif
>> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
>> index 763d35bdda01..d17b74184ba0 100644
>> --- a/arch/um/kernel/tlb.c
>> +++ b/arch/um/kernel/tlb.c
>> @@ -647,3 +647,9 @@ void force_flush_all(void)
>>   		vma = vma->vm_next;
>>   	}
>>   }
>> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>> +		pmd_t *pmdp, pmd_t pmd)
>> +{
>> +	*pmdp = pmd;
>> +}
>> +
> I believe this should be included in a separate patch since it is not related
> specifically to pte_alloc argument removal. If you want, I could split it
> into a separate patch for my series with you as author.


Whichever is more convenient for you.

One thing to note - tlb flush is extremely expensive on uml.

I have lifted the definition of set_pmd_at from the mips tree and 
removed the tlb_flush_all from it for this exact reason.

If I read the original patch correctly, it does its own flush control so 
set_pmd_at does not need to do a force flush every time. It is done 
further up the chain.

Brgds,

A.


>
> thanks,
>
> - Joel
>
>
