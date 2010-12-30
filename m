Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C57F8B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 12:34:03 +1100 (EST)
Message-ID: <4D1BDFC1.3030101@goop.org>
Date: Thu, 30 Dec 2010 12:26:25 +1100
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Hugh Dickins <hughd@google.com>
Subject: Re: PowerPC BUG: using smp_processor_id() in preemptible code
References: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
In-Reply-To: <alpine.LSU.2.00.1012291413360.22939@sister.anvils>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
	Nick Piggin <npiggin@kernel.dk>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/30/2010 09:54 AM, Hugh Dickins wrote:
> With recent 2.6.37-rc, with CONFIG_PREEMPT=y CONFIG_DEBUG_PREEMPT=y
> on the PowerPC G5, I get spammed by BUG warnings each time I swapoff:
>
> BUG: using smp_processor_id() in preemptible [00000000] code: swapoff/3974
> caller is .hpte_need_flush+0x4c/0x2e8
> Call Trace:
> [c0000001b4a3f830] [c00000000000f3cc] .show_stack+0x6c/0x16c (unreliable)
> [c0000001b4a3f8e0] [c00000000023eda0] .debug_smp_processor_id+0xe4/0x11c
> [c0000001b4a3f970] [c00000000002f2f4] .hpte_need_flush+0x4c/0x2e8
> [c0000001b4a3fa30] [c0000000000e7ef8] .vunmap_pud_range+0x148/0x200
> [c0000001b4a3fb10] [c0000000000e8058] .vunmap_page_range+0xa8/0xd4
> [c0000001b4a3fbb0] [c0000000000e80a4] .free_unmap_vmap_area+0x20/0x38
> [c0000001b4a3fc40] [c0000000000e8138] .remove_vm_area+0x7c/0xb4
> [c0000001b4a3fcd0] [c0000000000e8308] .__vunmap+0x50/0x104
> [c0000001b4a3fd60] [c0000000000ef3fc] .SyS_swapoff+0x59c/0x6a8
> [c0000001b4a3fe30] [c0000000000075a8] syscall_exit+0x0/0x40
>
> I notice hpte_need_flush() itself acknowledges
>  * Must be called from within some kind of spinlock/non-preempt region...
>
> Though I didn't actually bisect, I believe this is since Jeremy's
> 64141da587241301ce8638cc945f8b67853156ec "vmalloc: eagerly clear ptes
> on vunmap", which moves a call to vunmap_page_range() from one place
> (which happened to be inside a spinlock) to another (where it's not).

Yes.  I was  bit worried by the interaction between vb->lock and the pte
locks, and thought it safer to keep it outside.  Though I suppose kernel
mappings don't have pte locks, so that's a non-issue.

> I guess my warnings would be easily silenced by moving that call to
> vunmap_page_range() down just inside the spinlock below it; but I'm
> dubious that that's the right fix - it looked as if there are other
> paths through vmalloc.c where vunmap_page_range() has been getting
> called without preemption disabled, long before Jeremy's change,
> just paths that I never happen to go down in my limited testing.
>
> For the moment I'm using the obvious patch below to keep it quiet;
> but I doubt that this is the right patch either.  I'm hoping that
> ye who understand the importance of hpte_need_flush() will be best
> able to judge what to do.  Or might there be other architectures
> expecting to be unpreemptible there?

Since kernel mappings don't have a formal pte lock to rely on for
synchronization, each subsystem defines its own ad-hoc one.  In this
case that's probably vb->lock anyway, so the fix is to move
vunmap_page_range() back into its protection.

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -37,11 +37,13 @@ static void vunmap_pte_range(pmd_t *pmd,
>  {
>  	pte_t *pte;
>  
> +	preempt_disable(); /* Stop __vunmap() triggering smp_processor_id() in preemptible from hpte_need_flush() */
>  	pte = pte_offset_kernel(pmd, addr);
>  	do {
>  		pte_t ptent = ptep_get_and_clear(&init_mm, addr, pte);
>  		WARN_ON(!pte_none(ptent) && !pte_present(ptent));
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
> +	preempt_enable();
>  }
>  
>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end)

That looks OK, but it interferes with my plans to use
apply_to_page_range(_batch) to replace all this code.

    J
