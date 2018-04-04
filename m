Return-Path: <jglisse@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gfxr0M0jzF1TR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 07:59:27 +1000 (AEST)
Date: Wed, 4 Apr 2018 17:59:16 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 kemi.wang@intel.com, sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v9 15/24] mm: Introduce __vm_normal_page()
Message-ID: <20180404215916.GC3331@redhat.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-16-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180403193927.GD5935@redhat.com>
 <a3446d86-8a29-a9f2-a1fe-b8cc1b748132@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a3446d86-8a29-a9f2-a1fe-b8cc1b748132@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2018 at 06:26:44PM +0200, Laurent Dufour wrote:
> 
> 
> On 03/04/2018 21:39, Jerome Glisse wrote:
> > On Tue, Mar 13, 2018 at 06:59:45PM +0100, Laurent Dufour wrote:
> >> When dealing with the speculative fault path we should use the VMA's field
> >> cached value stored in the vm_fault structure.
> >>
> >> Currently vm_normal_page() is using the pointer to the VMA to fetch the
> >> vm_flags value. This patch provides a new __vm_normal_page() which is
> >> receiving the vm_flags flags value as parameter.
> >>
> >> Note: The speculative path is turned on for architecture providing support
> >> for special PTE flag. So only the first block of vm_normal_page is used
> >> during the speculative path.
> > 
> > Might be a good idea to explicitly have SPECULATIVE Kconfig option depends
> > on ARCH_PTE_SPECIAL and a comment for !HAVE_PTE_SPECIAL in the function
> > explaining that speculative page fault should never reach that point.
> 
> Unfortunately there is no ARCH_PTE_SPECIAL in the config file, it is defined in
> the per architecture header files.
> So I can't do anything in the Kconfig file

Maybe adding a new Kconfig symbol for ARCH_PTE_SPECIAL very much like
others ARCH_HAS_

> 
> However, I can check that at build time, and doing such a check in
> __vm_normal_page sounds to be a good place, like that:
> 
> @@ -869,6 +870,14 @@ struct page *__vm_normal_page(struct vm_area_struct *vma,
> unsigned long addr,
> 
>         /* !HAVE_PTE_SPECIAL case follows: */
> 
> +#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
> +       /* This part should never get called when the speculative page fault
> +        * handler is turned on. This is mainly because we can't rely on
> +        * vm_start.
> +        */
> +#error CONFIG_SPECULATIVE_PAGE_FAULT requires HAVE_PTE_SPECIAL
> +#endif
> +
>         if (unlikely(vma_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
>                 if (vma_flags & VM_MIXEDMAP) {
>                         if (!pfn_valid(pfn))
> 

I am not a fan of #if/#else/#endif in code. But that's a taste thing.
I honnestly think that adding a Kconfig for special pte is the cleanest
solution.

Cheers,
Jérôme
