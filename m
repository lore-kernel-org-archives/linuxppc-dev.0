Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSZYp00tGzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 09:15:09 +1100 (AEDT)
Date: Wed, 22 Feb 2017 09:15:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Rashmica Gupta
 <rashmicy@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: linux-next: manual merge of the tip tree with the powerpc tree
Message-ID: <20170222091508.49ade97f@canb.auug.org.au>
In-Reply-To: <20170217124843.7ea6e3d8@canb.auug.org.au>
References: <20170217124843.7ea6e3d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On Fri, 17 Feb 2017 12:48:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Today's linux-next merge of the tip tree got a conflict in:
> 
>   arch/powerpc/kernel/asm-offsets.c
> 
> between commit:
> 
>   454656155110 ("powerpc/asm: Use OFFSET macro in asm-offsets.c")
> 
> from the powerpc tree and commit:
> 
>   8c8b73c4811f ("sched/cputime, powerpc: Prepare accounting structure for cputime flush on tick")
> 
> from the tip tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/powerpc/kernel/asm-offsets.c
> index d918338b54b0,9e8e771f8acb..000000000000
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@@ -208,48 -213,58 +208,48 @@@ int main(void
>   #endif /* CONFIG_PPC_BOOK3E */
>   
>   #ifdef CONFIG_PPC_STD_MMU_64
>  -	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
>  -	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
>  -	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
>  +	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
>  +	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
>  +	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
>   #ifdef CONFIG_PPC_MM_SLICES
>  -	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
>  +	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
>   #else
>  -	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, mm_ctx_sllp));
>  +	OFFSET(PACACONTEXTSLLP, paca_struct, mm_ctx_sllp);
>   #endif /* CONFIG_PPC_MM_SLICES */
>  -	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
>  -	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
>  -	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
>  -	DEFINE(PACALPPACAPTR, offsetof(struct paca_struct, lppaca_ptr));
>  -	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
>  -	DEFINE(SLBSHADOW_STACKVSID,
>  -	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
>  -	DEFINE(SLBSHADOW_STACKESID,
>  -	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid));
>  -	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
>  -	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, pmcregs_in_use));
>  -	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
>  -	DEFINE(LPPACA_YIELDCOUNT, offsetof(struct lppaca, yield_count));
>  -	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
>  +	OFFSET(PACA_EXGEN, paca_struct, exgen);
>  +	OFFSET(PACA_EXMC, paca_struct, exmc);
>  +	OFFSET(PACA_EXSLB, paca_struct, exslb);
>  +	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
>  +	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
>  +	OFFSET(SLBSHADOW_STACKVSID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid);
>  +	OFFSET(SLBSHADOW_STACKESID, slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid);
>  +	OFFSET(SLBSHADOW_SAVEAREA, slb_shadow, save_area);
>  +	OFFSET(LPPACA_PMCINUSE, lppaca, pmcregs_in_use);
>  +	OFFSET(LPPACA_DTLIDX, lppaca, dtl_idx);
>  +	OFFSET(LPPACA_YIELDCOUNT, lppaca, yield_count);
>  +	OFFSET(PACA_DTL_RIDX, paca_struct, dtl_ridx);
>   #endif /* CONFIG_PPC_STD_MMU_64 */
>  -	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
>  +	OFFSET(PACAEMERGSP, paca_struct, emergency_sp);
>   #ifdef CONFIG_PPC_BOOK3S_64
>  -	DEFINE(PACAMCEMERGSP, offsetof(struct paca_struct, mc_emergency_sp));
>  -	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
>  -#endif
>  -	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
>  -	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
>  -	DEFINE(PACA_DSCR_DEFAULT, offsetof(struct paca_struct, dscr_default));
>  -	DEFINE(ACCOUNT_STARTTIME,
>  -	       offsetof(struct paca_struct, accounting.starttime));
>  -	DEFINE(ACCOUNT_STARTTIME_USER,
>  -	       offsetof(struct paca_struct, accounting.starttime_user));
>  -	DEFINE(ACCOUNT_USER_TIME,
>  -	       offsetof(struct paca_struct, accounting.utime));
>  -	DEFINE(ACCOUNT_SYSTEM_TIME,
>  -	       offsetof(struct paca_struct, accounting.stime));
>  -	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
>  -	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct, nap_state_lost));
>  -	DEFINE(PACA_SPRG_VDSO, offsetof(struct paca_struct, sprg_vdso));
>  +	OFFSET(PACAMCEMERGSP, paca_struct, mc_emergency_sp);
>  +	OFFSET(PACA_IN_MCE, paca_struct, in_mce);
>  +#endif
>  +	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
>  +	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
>  +	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
>  +	OFFSET(ACCOUNT_STARTTIME, paca_struct, accounting.starttime);
>  +	OFFSET(ACCOUNT_STARTTIME_USER, paca_struct, accounting.starttime_user);
> - 	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.user_time);
> - 	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.system_time);
> ++	OFFSET(ACCOUNT_USER_TIME, paca_struct, accounting.utime);
> ++	OFFSET(ACCOUNT_SYSTEM_TIME, paca_struct, accounting.stime);
>  +	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
>  +	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
>  +	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
>   #else /* CONFIG_PPC64 */
>   #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  -	DEFINE(ACCOUNT_STARTTIME,
>  -	       offsetof(struct thread_info, accounting.starttime));
>  -	DEFINE(ACCOUNT_STARTTIME_USER,
>  -	       offsetof(struct thread_info, accounting.starttime_user));
>  -	DEFINE(ACCOUNT_USER_TIME,
>  -	       offsetof(struct thread_info, accounting.utime));
>  -	DEFINE(ACCOUNT_SYSTEM_TIME,
>  -	       offsetof(struct thread_info, accounting.stime));
>  +	OFFSET(ACCOUNT_STARTTIME, thread_info, accounting.starttime);
>  +	OFFSET(ACCOUNT_STARTTIME_USER, thread_info, accounting.starttime_user);
> - 	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.user_time);
> - 	OFFSET(ACCOUNT_SYSTEM_TIME, thread_info, accounting.system_time);
> ++	OFFSET(ACCOUNT_USER_TIME, thread_info, accounting.utime);
> ++	OFFSET(ACCOUNT_SYSTEM_TIME, thread_info, accounting.stime);
>   #endif
>   #endif /* CONFIG_PPC64 */
>   

This is now a conflict between the powerpc tree and Linus' tree.

-- 
Cheers,
Stephen Rothwell
