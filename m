Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1438A1A0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 19:27:42 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 2 Jun 2014 14:57:37 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DBFBA1258048
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jun 2014 14:56:51 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s529RmeK7864746
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:57:48 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s529RZCx014754
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:57:35 +0530
Received: from [9.124.94.161] ([9.124.94.161])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s529RYOj014726
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jun 2014 14:57:35 +0530
Message-ID: <538C4386.4010207@linux.vnet.ibm.com>
Date: Mon, 02 Jun 2014 14:57:34 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: fix regression of per-CPU DSCR setting
References: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
 <ebb9e3af49b234c98cbfa6b34ba04dfa70c7d7f3.1400652868.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <ebb9e3af49b234c98cbfa6b34ba04dfa70c7d7f3.1400652868.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 21 May 2014 12:02 PM, Sam Bobroff wrote:
> Since commit "efcac65 powerpc: Per process DSCR + some fixes (try#4)"
> it is no longer possible to set the DSCR on a per-CPU basis.
> 
> The old behaviour was to minipulate the DSCR SPR directly but this is no
> longer sufficient: the value is quickly overwritten by context switching.
> 
> This patch stores the per-CPU DSCR value in a kernel variable rather than
> directly in the SPR and it is used whenever a process has not set the DSCR
> itself. The sysfs interface (/sys/devices/system/cpu/cpuN/dscr) is unchanged.
> 
> Writes to the old global default (/sys/devices/system/cpu/dscr_default)
> now set all of the per-CPU values and reads return the last written value.
> 
> The new per-CPU default is added to the paca_struct and is used everywhere
> outside of sysfs.c instead of the old global default.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  arch/powerpc/include/asm/paca.h         |    3 +++
>  arch/powerpc/kernel/asm-offsets.c       |    1 +
>  arch/powerpc/kernel/entry_64.S          |    9 +--------
>  arch/powerpc/kernel/sysfs.c             |   32 ++++++++++++++++++-------------
>  arch/powerpc/kernel/tm.S                |   16 ++++------------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |    3 +--
>  6 files changed, 29 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 8e956a0..bb0bd25 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -92,7 +92,10 @@ struct paca_struct {
>  	struct slb_shadow *slb_shadow_ptr;
>  	struct dtl_entry *dispatch_log;
>  	struct dtl_entry *dispatch_log_end;
> +#endif /* CONFIG_PPC_STD_MMU_64 */
> +	u64 dscr_default;		/* per-CPU default DSCR */
>  
> +#ifdef CONFIG_PPC_STD_MMU_64
>  	/*
>  	 * Now, starting in cacheline 2, the exception save areas
>  	 */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index dba8140..cba2697 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -247,6 +247,7 @@ int main(void)
>  #endif
>  	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
>  	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
> +	DEFINE(PACA_DSCR, offsetof(struct paca_struct, dscr_default));
>  	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
>  	DEFINE(PACA_STARTTIME_USER, offsetof(struct paca_struct, starttime_user));
>  	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 9fde8a1..911d453 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -387,12 +387,6 @@ _GLOBAL(ret_from_kernel_thread)
>  	li	r3,0
>  	b	syscall_exit
>  
> -	.section	".toc","aw"
> -DSCR_DEFAULT:
> -	.tc dscr_default[TC],dscr_default
> -
> -	.section	".text"
> -
>  /*
>   * This routine switches between two different tasks.  The process
>   * state of one is saved on its kernel stack.  Then the state
> @@ -577,11 +571,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
>  #ifdef CONFIG_PPC64
>  BEGIN_FTR_SECTION
>  	lwz	r6,THREAD_DSCR_INHERIT(r4)
> -	ld	r7,DSCR_DEFAULT@toc(2)
>  	ld	r0,THREAD_DSCR(r4)
>  	cmpwi	r6,0
>  	bne	1f
> -	ld	r0,0(r7)
> +	ld	r0,PACA_DSCR(r13)
>  1:
>  BEGIN_FTR_SECTION_NESTED(70)
>  	mfspr	r8, SPRN_FSCR
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index e2a1d6f..67fd2fd 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -484,7 +484,6 @@ SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
>  SYSFS_PMCSETUP(mmcra, SPRN_MMCRA);
>  SYSFS_SPRSETUP(purr, SPRN_PURR);
>  SYSFS_SPRSETUP(spurr, SPRN_SPURR);
> -SYSFS_SPRSETUP(dscr, SPRN_DSCR);
>  SYSFS_SPRSETUP(pir, SPRN_PIR);
>  
>  /*
> @@ -494,12 +493,27 @@ SYSFS_SPRSETUP(pir, SPRN_PIR);
>  */
>  static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
>  static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
> -static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
>  static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>  
> -unsigned long dscr_default = 0;
> -EXPORT_SYMBOL(dscr_default);
> +static unsigned long dscr_default;
> +
> +static void read_dscr(void *val)
> +{
> +	*(unsigned long *)val = get_paca()->dscr_default;
> +}
> +
> +static void write_dscr(void *val)
> +{
> +	get_paca()->dscr_default = *(unsigned long *)val;
> +	if (!current->thread.dscr_inherit) {
> +		current->thread.dscr = *(unsigned long *)val;
> +		mtspr(SPRN_DSCR, *(unsigned long *)val);
> +	}
> +}
> +
> +SYSFS_SPRSETUP_SHOW_STORE(dscr);
> +static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
>  
>  static void add_write_permission_dev_attr(struct device_attribute *attr)
>  {
> @@ -512,14 +526,6 @@ static ssize_t show_dscr_default(struct device *dev,
>  	return sprintf(buf, "%lx\n", dscr_default);
>  }
>  
> -static void update_dscr(void *dummy)
> -{
> -	if (!current->thread.dscr_inherit) {
> -		current->thread.dscr = dscr_default;
> -		mtspr(SPRN_DSCR, dscr_default);
> -	}
> -}
> -
>  static ssize_t __used store_dscr_default(struct device *dev,
>  		struct device_attribute *attr, const char *buf,
>  		size_t count)
> @@ -532,7 +538,7 @@ static ssize_t __used store_dscr_default(struct device *dev,
>  		return -EINVAL;
>  	dscr_default = val;
>  
> -	on_each_cpu(update_dscr, NULL, 1);
> +	on_each_cpu(write_dscr, &val, 1);
>  
>  	return count;
>  }

Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index ee061c3..2a324f4 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -78,12 +78,6 @@ _GLOBAL(tm_abort)
>  	TABORT(R3)
>  	blr
>  
> -	.section	".toc","aw"
> -DSCR_DEFAULT:
> -	.tc dscr_default[TC],dscr_default
> -
> -	.section	".text"
> -
>  /* void tm_reclaim(struct thread_struct *thread,
>   *                 unsigned long orig_msr,
>   *		   uint8_t cause)
> @@ -298,9 +292,8 @@ dont_backup_fp:
>  	mtlr	r0
>  	ld	r2, STK_GOT(r1)
>  
> -	/* Load system default DSCR */
> -	ld	r4, DSCR_DEFAULT@toc(r2)
> -	ld	r0, 0(r4)
> +	/* Load CPU's default DSCR */
> +	ld	r0, PACA_DSCR(r13)
>  	mtspr	SPRN_DSCR, r0
>  
>  	blr
> @@ -479,9 +472,8 @@ restore_gprs:
>  	mtlr	r0
>  	ld	r2, STK_GOT(r1)
>  
> -	/* Load system default DSCR */
> -	ld	r4, DSCR_DEFAULT@toc(r2)
> -	ld	r0, 0(r4)
> +	/* Load CPU's default DSCR */
> +	ld	r0, PACA_DSCR(r13)
>  	mtspr	SPRN_DSCR, r0
>  
>  	blr
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 9f0ad71..12f4ce5 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -286,8 +286,7 @@ kvm_start_guest:
>  	beq	kvm_no_guest
>  
>  	/* Set HSTATE_DSCR(r13) to something sensible */
> -	LOAD_REG_ADDR(r6, dscr_default)
> -	ld	r6, 0(r6)
> +	ld	r6, PACA_DSCR(r13)
>  	std	r6, HSTATE_DSCR(r13)
>  
>  	bl	kvmppc_hv_entry
> 
