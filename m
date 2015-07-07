Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 380CE1A1152
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 05:47:55 +1000 (AEST)
Message-ID: <1436298461.2658.39.camel@freescale.com>
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
Date: Tue, 7 Jul 2015 14:47:41 -0500
In-Reply-To: <CAD=trs-c0qrajh1GN3H97FNR-xhVg86MPM8AsWQLR61+2myxFw@mail.gmail.com>
References: <1433917639-31699-1-git-send-email-wenweitaowenwei@gmail.com>
 <1433917639-31699-7-git-send-email-wenweitaowenwei@gmail.com>
 <1435873760.10531.11.camel@freescale.com>
 <CAD=trs9bjbeG=NF0UjFBTvL23rF8rry5myhKi_a-rFL4u=7EuQ@mail.gmail.com>
 <1436218475.2658.14.camel@freescale.com>
 <CAD=trs-c0qrajh1GN3H97FNR-xhVg86MPM8AsWQLR61+2myxFw@mail.gmail.com>
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

On Tue, 2015-07-07 at 16:05 +0800, wenwei tao wrote:
> Hi Scott
> 
> I understand what you said.
> 
> I will use the function 'is_vm_hugetlb_page()' to hide the bit
> combinations according to your comments in the next version of patch
> set.
> 
> But for the situation like below, there isn't an obvious structure
> 'vma', using 'is_vm_hugetlb_page()' maybe costly or even not possible.
> void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>                 unsigned long end, unsigned long vmflag)
> {
>     ...
> 
>     if (end == TLB_FLUSH_ALL || tlb_flushall_shift == -1
>                     || vmflag & VM_HUGETLB) {
>         local_flush_tlb();
>         goto flush_all;
>     }
> ...
> }

Add a function that operates on the flags directly, then.

-Scott
