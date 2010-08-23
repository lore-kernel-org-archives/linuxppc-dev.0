Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc: remove fpscr use from [kvm_]cvt_{fd,df}
In-reply-to: <m2hbinzlon.fsf@igel.home>
References: <m2hbinzlon.fsf@igel.home>
Date: Mon, 23 Aug 2010 10:23:45 +1000
Message-ID: <27922.1282523025@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Neither lfs nor stfs touch the fpscr, so remove the restore/save of it
> around them.

Do some 32 bit processors need this? 

In 32 bit before the merge, we use to have code that did:

  #if defined(CONFIG_4xx) || defined(CONFIG_E500)
   #define cvt_fd without save/restore fpscr
  #else
   #define cvt_fd with save/restore fpscr
  #end if

Kumar; does this ring any bells?

(The addition of this predates even bitkeeper)

Mikey
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  arch/powerpc/include/asm/kvm_fpu.h       |    4 +-
>  arch/powerpc/include/asm/system.h        |    4 +-
>  arch/powerpc/kernel/align.c              |    4 +-
>  arch/powerpc/kernel/fpu.S                |   10 -------
>  arch/powerpc/kvm/book3s_paired_singles.c |   44 +++++++++++++---------------
-
>  arch/powerpc/kvm/fpu.S                   |    8 -----
>  6 files changed, 26 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_fpu.h b/arch/powerpc/include/asm/kv
m_fpu.h
> index c3d4f05..92daae1 100644
> --- a/arch/powerpc/include/asm/kvm_fpu.h
> +++ b/arch/powerpc/include/asm/kvm_fpu.h
> @@ -82,7 +82,7 @@ FPD_THREE_IN(fmadd)
>  FPD_THREE_IN(fnmsub)
>  FPD_THREE_IN(fnmadd)
>  
> -extern void kvm_cvt_fd(u32 *from, u64 *to, u64 *fpscr);
> -extern void kvm_cvt_df(u64 *from, u32 *to, u64 *fpscr);
> +extern void kvm_cvt_fd(u32 *from, u64 *to);
> +extern void kvm_cvt_df(u64 *from, u32 *to);
>  
>  #endif
> diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/sys
tem.h
> index 6c294ac..0b3fe78 100644
> --- a/arch/powerpc/include/asm/system.h
> +++ b/arch/powerpc/include/asm/system.h
> @@ -154,8 +154,8 @@ extern void enable_kernel_spe(void);
>  extern void giveup_spe(struct task_struct *);
>  extern void load_up_spe(struct task_struct *);
>  extern int fix_alignment(struct pt_regs *);
> -extern void cvt_fd(float *from, double *to, struct thread_struct *thread);
> -extern void cvt_df(double *from, float *to, struct thread_struct *thread);
> +extern void cvt_fd(float *from, double *to);
> +extern void cvt_df(double *from, float *to);
>  
>  #ifndef CONFIG_SMP
>  extern void discard_lazy_cpu_state(void);
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index b876e98..8184ee9 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -889,7 +889,7 @@ int fix_alignment(struct pt_regs *regs)
>  #ifdef CONFIG_PPC_FPU
>  			preempt_disable();
>  			enable_kernel_fp();
> -			cvt_df(&data.dd, (float *)&data.v[4], &current->thread)
;
> +			cvt_df(&data.dd, (float *)&data.v[4]);
>  			preempt_enable();
>  #else
>  			return 0;
> @@ -933,7 +933,7 @@ int fix_alignment(struct pt_regs *regs)
>  #ifdef CONFIG_PPC_FPU
>  		preempt_disable();
>  		enable_kernel_fp();
> -		cvt_fd((float *)&data.v[4], &data.dd, &current->thread);
> +		cvt_fd((float *)&data.v[4], &data.dd);
>  		preempt_enable();
>  #else
>  		return 0;
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index fc8f5b1..e86c040 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -163,24 +163,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  /*
>   * These are used in the alignment trap handler when emulating
>   * single-precision loads and stores.
> - * We restore and save the fpscr so the task gets the same result
> - * and exceptions as if the cpu had performed the load or store.
>   */
>  
>  _GLOBAL(cvt_fd)
> -	lfd	0,THREAD_FPSCR(r5)	/* load up fpscr value */
> -	MTFSF_L(0)
>  	lfs	0,0(r3)
>  	stfd	0,0(r4)
> -	mffs	0
> -	stfd	0,THREAD_FPSCR(r5)	/* save new fpscr value */
>  	blr
>  
>  _GLOBAL(cvt_df)
> -	lfd	0,THREAD_FPSCR(r5)	/* load up fpscr value */
> -	MTFSF_L(0)
>  	lfd	0,0(r3)
>  	stfs	0,0(r4)
> -	mffs	0
> -	stfd	0,THREAD_FPSCR(r5)	/* save new fpscr value */
>  	blr
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book
3s_paired_singles.c
> index 474f2e2..35a701f 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -159,7 +159,7 @@
>  
>  static inline void kvmppc_sync_qpr(struct kvm_vcpu *vcpu, int rt)
>  {
> -	kvm_cvt_df(&vcpu->arch.fpr[rt], &vcpu->arch.qpr[rt], &vcpu->arch.fpscr)
;
> +	kvm_cvt_df(&vcpu->arch.fpr[rt], &vcpu->arch.qpr[rt]);
>  }
>  
>  static void kvmppc_inject_pf(struct kvm_vcpu *vcpu, ulong eaddr, bool is_sto
re)
> @@ -204,7 +204,7 @@ static int kvmppc_emulate_fpr_load(struct kvm_run *run, s
truct kvm_vcpu *vcpu,
>  	/* put in registers */
>  	switch (ls_type) {
>  	case FPU_LS_SINGLE:
> -		kvm_cvt_fd((u32*)tmp, &vcpu->arch.fpr[rs], &vcpu->arch.fpscr);
> +		kvm_cvt_fd((u32*)tmp, &vcpu->arch.fpr[rs]);
>  		vcpu->arch.qpr[rs] = *((u32*)tmp);
>  		break;
>  	case FPU_LS_DOUBLE:
> @@ -230,7 +230,7 @@ static int kvmppc_emulate_fpr_store(struct kvm_run *run, 
struct kvm_vcpu *vcpu,
>  
>  	switch (ls_type) {
>  	case FPU_LS_SINGLE:
> -		kvm_cvt_df(&vcpu->arch.fpr[rs], (u32*)tmp, &vcpu->arch.fpscr);
> +		kvm_cvt_df(&vcpu->arch.fpr[rs], (u32*)tmp);
>  		val = *((u32*)tmp);
>  		len = sizeof(u32);
>  		break;
> @@ -296,7 +296,7 @@ static int kvmppc_emulate_psq_load(struct kvm_run *run, s
truct kvm_vcpu *vcpu,
>  	emulated = EMULATE_DONE;
>  
>  	/* put in registers */
> -	kvm_cvt_fd(&tmp[0], &vcpu->arch.fpr[rs], &vcpu->arch.fpscr);
> +	kvm_cvt_fd(&tmp[0], &vcpu->arch.fpr[rs]);
>  	vcpu->arch.qpr[rs] = tmp[1];
>  
>  	dprintk(KERN_INFO "KVM: PSQ_LD [0x%x, 0x%x] at 0x%lx (%d)\n", tmp[0],
> @@ -314,7 +314,7 @@ static int kvmppc_emulate_psq_store(struct kvm_run *run, 
struct kvm_vcpu *vcpu,
>  	u32 tmp[2];
>  	int len = w ? sizeof(u32) : sizeof(u64);
>  
> -	kvm_cvt_df(&vcpu->arch.fpr[rs], &tmp[0], &vcpu->arch.fpscr);
> +	kvm_cvt_df(&vcpu->arch.fpr[rs], &tmp[0]);
>  	tmp[1] = vcpu->arch.qpr[rs];
>  
>  	r = kvmppc_st(vcpu, &addr, len, tmp, true);
> @@ -516,9 +516,9 @@ static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool
 rc,
>  	WARN_ON(rc);
>  
>  	/* PS0 */
> -	kvm_cvt_df(&fpr[reg_in1], &ps0_in1, &vcpu->arch.fpscr);
> -	kvm_cvt_df(&fpr[reg_in2], &ps0_in2, &vcpu->arch.fpscr);
> -	kvm_cvt_df(&fpr[reg_in3], &ps0_in3, &vcpu->arch.fpscr);
> +	kvm_cvt_df(&fpr[reg_in1], &ps0_in1);
> +	kvm_cvt_df(&fpr[reg_in2], &ps0_in2);
> +	kvm_cvt_df(&fpr[reg_in3], &ps0_in3);
>  
>  	if (scalar & SCALAR_LOW)
>  		ps0_in2 = qpr[reg_in2];
> @@ -529,7 +529,7 @@ static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool
 rc,
>  			  ps0_in1, ps0_in2, ps0_in3, ps0_out);
>  
>  	if (!(scalar & SCALAR_NO_PS0))
> -		kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
> +		kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
>  
>  	/* PS1 */
>  	ps1_in1 = qpr[reg_in1];
> @@ -566,12 +566,12 @@ static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool
 rc,
>  	WARN_ON(rc);
>  
>  	/* PS0 */
> -	kvm_cvt_df(&fpr[reg_in1], &ps0_in1, &vcpu->arch.fpscr);
> +	kvm_cvt_df(&fpr[reg_in1], &ps0_in1);
>  
>  	if (scalar & SCALAR_LOW)
>  		ps0_in2 = qpr[reg_in2];
>  	else
> -		kvm_cvt_df(&fpr[reg_in2], &ps0_in2, &vcpu->arch.fpscr);
> +		kvm_cvt_df(&fpr[reg_in2], &ps0_in2);
>  
>  	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in1, &ps0_in2);
>  
> @@ -579,7 +579,7 @@ static int kvmppc_ps_two_in(struct kvm_vcpu *vcpu, bool r
c,
>  		dprintk(KERN_INFO "PS2 ps0 -> f(0x%x, 0x%x) = 0x%x\n",
>  				  ps0_in1, ps0_in2, ps0_out);
>  
> -		kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
> +		kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
>  	}
>  
>  	/* PS1 */
> @@ -615,13 +615,13 @@ static int kvmppc_ps_one_in(struct kvm_vcpu *vcpu, bool
 rc,
>  	WARN_ON(rc);
>  
>  	/* PS0 */
> -	kvm_cvt_df(&fpr[reg_in], &ps0_in, &vcpu->arch.fpscr);
> +	kvm_cvt_df(&fpr[reg_in], &ps0_in);
>  	func(&vcpu->arch.fpscr, &ps0_out, &ps0_in);
>  
>  	dprintk(KERN_INFO "PS1 ps0 -> f(0x%x) = 0x%x\n",
>  			  ps0_in, ps0_out);
>  
> -	kvm_cvt_fd(&ps0_out, &fpr[reg_out], &vcpu->arch.fpscr);
> +	kvm_cvt_fd(&ps0_out, &fpr[reg_out]);
>  
>  	/* PS1 */
>  	ps1_in = qpr[reg_in];
> @@ -671,7 +671,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, str
uct kvm_vcpu *vcpu)
>  #ifdef DEBUG
>  	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
>  		u32 f;
> -		kvm_cvt_df(&vcpu->arch.fpr[i], &f, &vcpu->arch.fpscr);
> +		kvm_cvt_df(&vcpu->arch.fpr[i], &f);
>  		dprintk(KERN_INFO "FPR[%d] = 0x%x / 0x%llx    QPR[%d] = 0x%x\n"
,
>  			i, f, vcpu->arch.fpr[i], i, vcpu->arch.qpr[i]);
>  	}
> @@ -796,8 +796,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, str
uct kvm_vcpu *vcpu)
>  			vcpu->arch.fpr[ax_rd] = vcpu->arch.fpr[ax_ra];
>  			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
>  			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
> -				   &vcpu->arch.qpr[ax_rd],
> -				   &vcpu->arch.fpscr);
> +				   &vcpu->arch.qpr[ax_rd]);
>  			break;
>  		case OP_4X_PS_MERGE01:
>  			WARN_ON(rcomp);
> @@ -808,19 +807,16 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, s
truct kvm_vcpu *vcpu)
>  			WARN_ON(rcomp);
>  			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
>  			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
> -				   &vcpu->arch.fpr[ax_rd],
> -				   &vcpu->arch.fpscr);
> +				   &vcpu->arch.fpr[ax_rd]);
>  			/* vcpu->arch.qpr[ax_rd] = vcpu->arch.fpr[ax_rb]; */
>  			kvm_cvt_df(&vcpu->arch.fpr[ax_rb],
> -				   &vcpu->arch.qpr[ax_rd],
> -				   &vcpu->arch.fpscr);
> +				   &vcpu->arch.qpr[ax_rd]);
>  			break;
>  		case OP_4X_PS_MERGE11:
>  			WARN_ON(rcomp);
>  			/* vcpu->arch.fpr[ax_rd] = vcpu->arch.qpr[ax_ra]; */
>  			kvm_cvt_fd(&vcpu->arch.qpr[ax_ra],
> -				   &vcpu->arch.fpr[ax_rd],
> -				   &vcpu->arch.fpscr);
> +				   &vcpu->arch.fpr[ax_rd]);
>  			vcpu->arch.qpr[ax_rd] = vcpu->arch.qpr[ax_rb];
>  			break;
>  		}
> @@ -1255,7 +1251,7 @@ int kvmppc_emulate_paired_single(struct kvm_run *run, s
truct kvm_vcpu *vcpu)
>  #ifdef DEBUG
>  	for (i = 0; i < ARRAY_SIZE(vcpu->arch.fpr); i++) {
>  		u32 f;
> -		kvm_cvt_df(&vcpu->arch.fpr[i], &f, &vcpu->arch.fpscr);
> +		kvm_cvt_df(&vcpu->arch.fpr[i], &f);
>  		dprintk(KERN_INFO "FPR[%d] = 0x%x\n", i, f);
>  	}
>  #endif
> diff --git a/arch/powerpc/kvm/fpu.S b/arch/powerpc/kvm/fpu.S
> index cb34bbe..bf68d59 100644
> --- a/arch/powerpc/kvm/fpu.S
> +++ b/arch/powerpc/kvm/fpu.S
> @@ -273,19 +273,11 @@ FPD_THREE_IN(fnmsub)
>  FPD_THREE_IN(fnmadd)
>  
>  _GLOBAL(kvm_cvt_fd)
> -	lfd	0,0(r5)			/* load up fpscr value */
> -	MTFSF_L(0)
>  	lfs	0,0(r3)
>  	stfd	0,0(r4)
> -	mffs	0
> -	stfd	0,0(r5)			/* save new fpscr value */
>  	blr
>  
>  _GLOBAL(kvm_cvt_df)
> -	lfd	0,0(r5)			/* load up fpscr value */
> -	MTFSF_L(0)
>  	lfd	0,0(r3)
>  	stfs	0,0(r4)
> -	mffs	0
> -	stfd	0,0(r5)			/* save new fpscr value */
>  	blr
> -- 
> 1.7.2.2
> 
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
