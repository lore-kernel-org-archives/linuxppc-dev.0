Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA61C1A2B10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 20:11:33 +1100 (AEDT)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 23 Mar 2015 09:11:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7B39317D8063
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 09:11:54 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2N9BRix11665712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 09:11:27 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2N9BMHN011313
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 03:11:27 -0600
Message-ID: <550FD8B6.305@linux.vnet.ibm.com>
Date: Mon, 23 Mar 2015 10:11:18 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] mm: Introducing arch_remap hook
References: <cover.1426866405.git.ldufour@linux.vnet.ibm.com>
 <503499aae380db1c4673f146bcba6ad095021257.1426866405.git.ldufour@linux.vnet.ibm.com>
 <20150323085209.GA28965@gmail.com>
In-Reply-To: <20150323085209.GA28965@gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>,
 Jeff Dike <jdike@addtoit.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, criu@openvz.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 user-mode-linux-user@lists.sourceforge.net,
 Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 cov@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23/03/2015 09:52, Ingo Molnar wrote:
> 
> * Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> Some architecture would like to be triggered when a memory area is moved
>> through the mremap system call.
>>
>> This patch is introducing a new arch_remap mm hook which is placed in the
>> path of mremap, and is called before the old area is unmapped (and the
>> arch_unmap hook is called).
>>
>> To no break the build, this patch adds the empty hook definition to the
>> architectures that were not using the generic hook's definition.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/s390/include/asm/mmu_context.h      | 6 ++++++
>>  arch/um/include/asm/mmu_context.h        | 5 +++++
>>  arch/unicore32/include/asm/mmu_context.h | 6 ++++++
>>  arch/x86/include/asm/mmu_context.h       | 6 ++++++
>>  include/asm-generic/mm_hooks.h           | 6 ++++++
>>  mm/mremap.c                              | 9 +++++++--
>>  6 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
>> index 8fb3802f8fad..ddd861a490ba 100644
>> --- a/arch/s390/include/asm/mmu_context.h
>> +++ b/arch/s390/include/asm/mmu_context.h
>> @@ -131,4 +131,10 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>>  {
>>  }
>>  
>> +static inline void arch_remap(struct mm_struct *mm,
>> +			      unsigned long old_start, unsigned long old_end,
>> +			      unsigned long new_start, unsigned long new_end)
>> +{
>> +}
>> +
>>  #endif /* __S390_MMU_CONTEXT_H */
>> diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
>> index 941527e507f7..f499b017c1f9 100644
>> --- a/arch/um/include/asm/mmu_context.h
>> +++ b/arch/um/include/asm/mmu_context.h
>> @@ -27,6 +27,11 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>>  				     struct vm_area_struct *vma)
>>  {
>>  }
>> +static inline void arch_remap(struct mm_struct *mm,
>> +			      unsigned long old_start, unsigned long old_end,
>> +			      unsigned long new_start, unsigned long new_end)
>> +{
>> +}
>>  /*
>>   * end asm-generic/mm_hooks.h functions
>>   */
>> diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
>> index 1cb5220afaf9..39a0a553172e 100644
>> --- a/arch/unicore32/include/asm/mmu_context.h
>> +++ b/arch/unicore32/include/asm/mmu_context.h
>> @@ -97,4 +97,10 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
>>  {
>>  }
>>  
>> +static inline void arch_remap(struct mm_struct *mm,
>> +			      unsigned long old_start, unsigned long old_end,
>> +			      unsigned long new_start, unsigned long new_end)
>> +{
>> +}
>> +
>>  #endif
>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
>> index 883f6b933fa4..75cb71f4be1e 100644
>> --- a/arch/x86/include/asm/mmu_context.h
>> +++ b/arch/x86/include/asm/mmu_context.h
>> @@ -172,4 +172,10 @@ static inline void arch_unmap(struct mm_struct *mm, struct vm_area_struct *vma,
>>  		mpx_notify_unmap(mm, vma, start, end);
>>  }
>>  
>> +static inline void arch_remap(struct mm_struct *mm,
>> +			      unsigned long old_start, unsigned long old_end,
>> +			      unsigned long new_start, unsigned long new_end)
>> +{
>> +}
>> +
>>  #endif /* _ASM_X86_MMU_CONTEXT_H */
> 
> So instead of spreading these empty prototypes around mmu_context.h 
> files, why not add something like this to the PPC definition:
> 
>  #define __HAVE_ARCH_REMAP
> 
> and define the empty prototype for everyone else? It's a bit like how 
> the __HAVE_ARCH_PTEP_* namespace works.
> 
> That should shrink this patch considerably.

My idea was to mimic the MMU hook's definition. This new hook is in the
continuity of what have been done for arch_dup_mmap, arch_exit_mmap,
arch_unmap and arch_bprm_mm_init.

Do you think that there is a need to make this one in another way ?

Thanks,
Laurent.
