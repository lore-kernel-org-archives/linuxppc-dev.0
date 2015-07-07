Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-wg0-x229.google.com (mail-wg0-x229.google.com
 [IPv6:2a00:1450:400c:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F8DC1A1055
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 18:05:43 +1000 (AEST)
Received: by wgbgr6 with SMTP id gr6so6426290wgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2015 01:05:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436218475.2658.14.camel@freescale.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
 <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
 <1435873760.10531.11.camel@freescale.com>
 <CAD=trs9bjbeG=NF0UjFBTvL23rF8rry5myhKi_a-rFL4u=7EuQ@mail.gmail.com>
 <1436218475.2658.14.camel@freescale.com>
Date: Tue, 7 Jul 2015 16:05:39 +0800
Message-ID: <CAD=trs-c0qrajh1GN3H97FNR-xhVg86MPM8AsWQLR61+2myxFw@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] powerpc/kvm: change the condition of identifying
 hugetlb vm
From: wenwei tao <wenweitaowenwei@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Cc: Izik Eidus <izik.eidus@ravellosystems.com>, aarcange@redhat.com,
 chrisw@sous-sol.org,
 Hugh Dickins <hughd@google.com>, tglx@linutronix.de, mingo@redhat.com,
 hpa@zytor.com,
 x86@kernel.org, viro@zeniv.linux.org.uk, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott

I understand what you said.

I will use the function 'is_vm_hugetlb_page()' to hide the bit
combinations according to your comments in the next version of patch
set.

But for the situation like below, there isn't an obvious structure
'vma', using 'is_vm_hugetlb_page()' maybe costly or even not possible.
void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
                unsigned long end, unsigned long vmflag)
{
    ...

    if (end == TLB_FLUSH_ALL || tlb_flushall_shift == -1
                    || vmflag & VM_HUGETLB) {
        local_flush_tlb();
        goto flush_all;
    }
...
}


Thank you
Wenwei

2015-07-07 5:34 GMT+08:00 Scott Wood <scottwood@freescale.com>:
> On Fri, 2015-07-03 at 16:47 +0800, wenwei tao wrote:
>> Hi Scott
>>
>> Thank you for your comments.
>>
>> Kernel already has that function: is_vm_hugetlb_page() , but the
>> original code didn't use it,
>> in order to keep the coding style of the original code, I didn't use it
>> either.
>>
>> For the sentence like: "vma->vm_flags & VM_HUGETLB" , hiding it behind
>> 'is_vm_hugetlb_page()' is ok,
>> but the sentence like: "vma->vm_flags &
>> (VM_LOCKED|VM_HUGETLB|VM_PFNMAP)" appears in the patch 2/6,
>> is it better to hide the bit combinations behind the
>> is_vm_hugetlb_page() ?  In my patch I just replaced it with
>> "vma->vm_flags & (VM_LOCKED|VM_PFNMAP) ||  (vma->vm_flags &
>> (VM_HUGETLB|VM_MERGEABLE)) == VM_HUGETLB".
>
> If you're going to do non-obvious things with the flags, it should be done in
> one place rather than throughout the code.  Why would you do the above and
> not "vma->vm_flags & (VM_LOCKED | VM_PFNMAP) || is_vm_hugetlb_page(vma)"?
>
> -Scott
>
