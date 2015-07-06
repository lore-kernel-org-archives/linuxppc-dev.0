Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E1D91A0D8A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 07:34:51 +1000 (AEST)
Message-ID: <1436218475.2658.14.camel@freescale.com>
Subject: Re: [RFC PATCH 6/6] powerpc/kvm: change the condition of
 identifying hugetlb vm
From: Scott Wood <scottwood@freescale.com>
To: wenwei tao <wenweitaowenwei@gmail.com>
CC: Izik Eidus <izik.eidus@ravellosystems.com>, <aarcange@redhat.com>,
 <chrisw@sous-sol.org>, Hugh Dickins <hughd@google.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
 <viro@zeniv.linux.org.uk>, <linux-mm@kvack.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm@vger.kernel.org>,
 <kvm-ppc@vger.kernel.org>
Date: Mon, 6 Jul 2015 16:34:35 -0500
In-Reply-To: <CAD=trs9bjbeG=NF0UjFBTvL23rF8rry5myhKi_a-rFL4u=7EuQ@mail.gmail.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
 <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
 <1435873760.10531.11.camel@freescale.com>
 <CAD=trs9bjbeG=NF0UjFBTvL23rF8rry5myhKi_a-rFL4u=7EuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-03 at 16:47 +0800, wenwei tao wrote:
> Hi Scott
> 
> Thank you for your comments.
> 
> Kernel already has that function: is_vm_hugetlb_page() , but the
> original code didn't use it,
> in order to keep the coding style of the original code, I didn't use it 
> either.
>
> For the sentence like: "vma->vm_flags & VM_HUGETLB" , hiding it behind
> 'is_vm_hugetlb_page()' is ok,
> but the sentence like: "vma->vm_flags &
> (VM_LOCKED|VM_HUGETLB|VM_PFNMAP)" appears in the patch 2/6,
> is it better to hide the bit combinations behind the
> is_vm_hugetlb_page() ?  In my patch I just replaced it with
> "vma->vm_flags & (VM_LOCKED|VM_PFNMAP) ||  (vma->vm_flags &
> (VM_HUGETLB|VM_MERGEABLE)) == VM_HUGETLB".

If you're going to do non-obvious things with the flags, it should be done in 
one place rather than throughout the code.  Why would you do the above and 
not "vma->vm_flags & (VM_LOCKED | VM_PFNMAP) || is_vm_hugetlb_page(vma)"?

-Scott
