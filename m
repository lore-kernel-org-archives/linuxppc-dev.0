Return-Path: <michael@ellerman.id.au>
Date: Mon, 15 Apr 2013 16:36:58 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 4/4] powerpc: Try to insert the hptes repeatedly
 in kernel_map_linear_page()
Message-ID: <20130415063658.GF21147@concordia>
References: <1365733021-28912-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1365733021-28912-5-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365733021-28912-5-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 12, 2013 at 10:17:00AM +0800, Li Zhong wrote:
> This patch tries to fix following issue when CONFIG_DEBUG_PAGEALLOC
> is enabled:

Please include a better changelog.

This patch does fix (I hope?) the following oops, caused by xxx. Reproducible
by doing yyy.

cheers

> 
> [  543.075675] ------------[ cut here ]------------
> [  543.075701] kernel BUG at arch/powerpc/mm/hash_utils_64.c:1239!
> [  543.075714] Oops: Exception in kernel mode, sig: 5 [#1]
> [  543.075722] PREEMPT SMP NR_CPUS=16 DEBUG_PAGEALLOC NUMA pSeries
> [  543.075741] Modules linked in: binfmt_misc ehea
> [  543.075759] NIP: c000000000036eb0 LR: c000000000036ea4 CTR: c00000000005a594
> [  543.075771] REGS: c0000000a90832c0 TRAP: 0700   Not tainted  (3.8.0-next-20130222)
> [  543.075781] MSR: 8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 22224482  XER: 00000000
> [  543.075816] SOFTE: 0
> [  543.075823] CFAR: c00000000004c200
> [  543.075830] TASK = c0000000e506b750[23934] 'cc1' THREAD: c0000000a9080000 CPU: 1
> GPR00: 0000000000000001 c0000000a9083540 c000000000c600a8 ffffffffffffffff
> GPR04: 0000000000000050 fffffffffffffffa c0000000a90834e0 00000000004ff594
> GPR08: 0000000000000001 0000000000000000 000000009592d4d8 c000000000c86854
> GPR12: 0000000000000002 c000000006ead300 0000000000a51000 0000000000000001
> GPR16: f000000003354380 ffffffffffffffff ffffffffffffff80 0000000000000000
> GPR20: 0000000000000001 c000000000c600a8 0000000000000001 0000000000000001
> GPR24: 0000000003354380 c000000000000000 0000000000000000 c000000000b65950
> GPR28: 0000002000000000 00000000000cd50e 0000000000bf50d9 c000000000c7c230
> [  543.076005] NIP [c000000000036eb0] .kernel_map_pages+0x1e0/0x3f8
> [  543.076016] LR [c000000000036ea4] .kernel_map_pages+0x1d4/0x3f8
> [  543.076025] Call Trace:
> [  543.076033] [c0000000a9083540] [c000000000036ea4] .kernel_map_pages+0x1d4/0x3f8 (unreliable)
> [  543.076053] [c0000000a9083640] [c000000000167638] .get_page_from_freelist+0x6cc/0x8dc
> [  543.076067] [c0000000a9083800] [c000000000167a48] .__alloc_pages_nodemask+0x200/0x96c
> [  543.076082] [c0000000a90839c0] [c0000000001ade44] .alloc_pages_vma+0x160/0x1e4
> [  543.076098] [c0000000a9083a80] [c00000000018ce04] .handle_pte_fault+0x1b0/0x7e8
> [  543.076113] [c0000000a9083b50] [c00000000018d5a8] .handle_mm_fault+0x16c/0x1a0
> [  543.076129] [c0000000a9083c00] [c0000000007bf1dc] .do_page_fault+0x4d0/0x7a4
> [  543.076144] [c0000000a9083e30] [c0000000000090e8] handle_page_fault+0x10/0x30
> [  543.076155] Instruction dump:
> [  543.076163] 7c630038 78631d88 e80a0000 f8410028 7c0903a6 e91f01de e96a0010 e84a0008
> [  543.076192] 4e800421 e8410028 7c7107b4 7a200fe0 <0b000000> 7f63db78 48785781 60000000
> [  543.076224] ---[ end trace bd5807e8d6ae186b ]---
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_utils_64.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index a7f54f0..4b449a0 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1272,7 +1272,7 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
>  	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
>  	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
>  	unsigned long mode = htab_convert_pte_flags(PAGE_KERNEL);
> -	int ret;
> +	long ret;
>  
>  	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
>  	hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
> @@ -1280,9 +1280,11 @@ static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
>  	/* Don't create HPTE entries for bad address */
>  	if (!vsid)
>  		return;
> -	ret = ppc_md.hpte_insert(hpteg, vpn, __pa(vaddr),
> -				 mode, 0,
> -				 mmu_linear_psize, mmu_kernel_ssize);
> +
> +	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr),
> +				    mode, mmu_linear_psize,
> +				    mmu_kernel_ssize);
> +
>  	BUG_ON (ret < 0);
>  	spin_lock(&linear_map_hash_lock);
>  	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
> -- 
> 1.7.9.5
> 
