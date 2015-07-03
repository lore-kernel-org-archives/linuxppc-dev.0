Return-Path: <wenweitaowenwei@gmail.com>
Received: from mail-wi0-x233.google.com (mail-wi0-x233.google.com
 [IPv6:2a00:1450:400c:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E89CB1A04C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 18:47:46 +1000 (AEST)
Received: by wiar9 with SMTP id r9so124317002wia.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2015 01:47:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435873760.10531.11.camel@freescale.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
 <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
 <1435873760.10531.11.camel@freescale.com>
Date: Fri, 3 Jul 2015 16:47:42 +0800
Message-ID: <CAD=trs9bjbeG=NF0UjFBTvL23rF8rry5myhKi_a-rFL4u=7EuQ@mail.gmail.com>
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

Thank you for your comments.

Kernel already has that function: is_vm_hugetlb_page() , but the
original code didn't use it,
in order to keep the coding style of the original code, I didn't use it either.

For the sentence like: "vma->vm_flags & VM_HUGETLB" , hiding it behind
'is_vm_hugetlb_page()' is ok,
but the sentence like: "vma->vm_flags &
(VM_LOCKED|VM_HUGETLB|VM_PFNMAP)" appears in the patch 2/6,
is it better to hide the bit combinations behind the
is_vm_hugetlb_page() ?  In my patch I just replaced it with
"vma->vm_flags & (VM_LOCKED|VM_PFNMAP) ||  (vma->vm_flags &
(VM_HUGETLB|VM_MERGEABLE)) == VM_HUGETLB".

I am a newbie to Linux kernel, do you have any good suggestions on
this situation?

Thank you
Wenwei

2015-07-03 5:49 GMT+08:00 Scott Wood <scottwood@freescale.com>:
> On Wed, 2015-06-10 at 14:27 +0800, Wenwei Tao wrote:
>> Hugetlb VMAs are not mergeable, that means a VMA couldn't have VM_HUGETLB
>> and
>> VM_MERGEABLE been set in the same time. So we use VM_HUGETLB to indicate new
>> mergeable VMAs. Because of that a VMA which has VM_HUGETLB been set is a
>> hugetlb
>> VMA only if it doesn't have VM_MERGEABLE been set in the same time.
>
> Eww.
>
> If you must overload such bit combinations, please hide it behind a
> vm_is_hugetlb() function.
>
> -Scott
>
