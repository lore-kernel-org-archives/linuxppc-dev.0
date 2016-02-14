Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECCD51A0314
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 07:40:04 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id f6so2847173ywa.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2016 12:40:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160211161650.1F12C1A2400@localhost.localdomain>
References: <20160211161650.1F12C1A2400@localhost.localdomain>
Date: Sun, 14 Feb 2016 23:40:01 +0300
Message-ID: <CAOJe8K0VJM8VEEN2i+ufV0YjSrRYHO+o7k3Tiv=va9LnH02R7w@mail.gmail.com>
Subject: Re: [PATCH v5] powerpc32: provide VIRT_CPU_ACCOUNTING
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/11/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
> PPC32 doesn't have the PACA structure, so we use the task_info
> structure to store the accounting data.
>
> In order to reuse on PPC32 the PPC64 functions, all u64 data has
> been replaced by 'unsigned long' so that it is u32 on PPC32 and
> u64 on PPC64
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Doesn't build for me with the patch applied

To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `get_cpu_idle_time':
(.text+0x1261c4): undefined reference to `__umoddi3'
drivers/built-in.o: In function `get_cpu_idle_time':
(.text+0x1261e0): undefined reference to `__udivdi3'
Makefile:936: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1


> ---
> Changes in v3: unlike previous version of the patch that was inspired
> from IA64 architecture, this new version tries to reuse as much as
> possible the PPC64 implementation.
>
> PPC32 doesn't have PACA and past discusion on v2 version has shown
> that it is not worth implementing a PACA in PPC32 architecture
> (see below benh opinion)
>
> benh: PACA is actually a data structure and you really really don't want it
> on ppc32 :-) Having a register point to current works, having a register
> point to per-cpu data instead works too (ie, change what we do today),
> but don't introduce a PACA *please* :-)
>
> Changes in v4: ACCOUNT_CPU_USER_ENTRY/EXIT() needed updates in other
> places than entry_32.S and entry_64.S (reported by kbuild-robot)
> Related defines in asm-offset.c need to be conditional to
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE (reported by kbuild-robot)
>
> Changes in v5: Using PPC_LL et PPC_STL instead of defining new macros
> AC_LD and AC_STD
>
>  arch/powerpc/Kconfig                     |  1 +
>  arch/powerpc/include/asm/cputime.h       |  4 ++++
>  arch/powerpc/include/asm/exception-64s.h |  2 +-
>  arch/powerpc/include/asm/ppc_asm.h       | 24 ++++++++++----------
>  arch/powerpc/include/asm/reg.h           |  1 +
>  arch/powerpc/include/asm/thread_info.h   | 11 +++++++++
>  arch/powerpc/kernel/asm-offsets.c        |  7 ++++++
>  arch/powerpc/kernel/entry_32.S           | 17 ++++++++++++++
>  arch/powerpc/kernel/entry_64.S           |  6 ++---
>  arch/powerpc/kernel/exceptions-64e.S     |  4 ++--
>  arch/powerpc/kernel/time.c               | 38
> ++++++++++++++++++++++++++------
>  arch/powerpc/platforms/Kconfig.cputype   |  1 -
>  12 files changed, 90 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3a557be..57ce4ff 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -159,6 +159,7 @@ config PPC
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
> +	select HAVE_VIRT_CPU_ACCOUNTING
>
>  config GENERIC_CSUM
>  	def_bool CPU_LITTLE_ENDIAN
> diff --git a/arch/powerpc/include/asm/cputime.h
> b/arch/powerpc/include/asm/cputime.h
> index e245255..c4c33be 100644
> --- a/arch/powerpc/include/asm/cputime.h
> +++ b/arch/powerpc/include/asm/cputime.h
> @@ -230,7 +230,11 @@ static inline cputime_t clock_t_to_cputime(const
> unsigned long clk)
>
>  #define cputime64_to_clock_t(ct)	cputime_to_clock_t((cputime_t)(ct))
>
> +#ifdef CONFIG_PPC64
>  static inline void arch_vtime_task_switch(struct task_struct *tsk) { }
> +#else
> +void arch_vtime_task_switch(struct task_struct *tsk);
> +#endif
>
>  #endif /* __KERNEL__ */
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
> diff --git a/arch/powerpc/include/asm/exception-64s.h
> b/arch/powerpc/include/asm/exception-64s.h
> index 93ae809..8bc38d1 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -287,7 +287,7 @@ do_kvm_##n:								\
>  	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
>  	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
>  	beq	4f;			/* if from kernel mode		*/ \
> -	ACCOUNT_CPU_USER_ENTRY(r9, r10);				   \
> +	ACCOUNT_CPU_USER_ENTRY(r13, r9, r10);				   \
>  	SAVE_PPR(area, r9, r10);					   \
>  4:	EXCEPTION_PROLOG_COMMON_2(area)					   \
>  	EXCEPTION_PROLOG_COMMON_3(n)					   \
> diff --git a/arch/powerpc/include/asm/ppc_asm.h
> b/arch/powerpc/include/asm/ppc_asm.h
> index 499d9f8..07d1bfc 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -24,27 +24,27 @@
>   */
>
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> -#define ACCOUNT_CPU_USER_ENTRY(ra, rb)
> -#define ACCOUNT_CPU_USER_EXIT(ra, rb)
> +#define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)
> +#define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)
>  #define ACCOUNT_STOLEN_TIME
>  #else
> -#define ACCOUNT_CPU_USER_ENTRY(ra, rb)					\
> +#define ACCOUNT_CPU_USER_ENTRY(ptr, ra, rb)				\
>  	MFTB(ra);			/* get timebase */		\
> -	ld	rb,PACA_STARTTIME_USER(r13);				\
> -	std	ra,PACA_STARTTIME(r13);					\
> +	PPC_LL	rb, PACA_STARTTIME_USER(ptr);				\
> +	PPC_STL	ra, PACA_STARTTIME(ptr);				\
>  	subf	rb,rb,ra;		/* subtract start value */	\
> -	ld	ra,PACA_USER_TIME(r13);					\
> +	PPC_LL	ra, PACA_USER_TIME(ptr);				\
>  	add	ra,ra,rb;		/* add on to user time */	\
> -	std	ra,PACA_USER_TIME(r13);					\
> +	PPC_STL	ra, PACA_USER_TIME(ptr);				\
>
> -#define ACCOUNT_CPU_USER_EXIT(ra, rb)					\
> +#define ACCOUNT_CPU_USER_EXIT(ptr, ra, rb)				\
>  	MFTB(ra);			/* get timebase */		\
> -	ld	rb,PACA_STARTTIME(r13);					\
> -	std	ra,PACA_STARTTIME_USER(r13);				\
> +	PPC_LL	rb, PACA_STARTTIME(ptr);				\
> +	PPC_STL	ra, PACA_STARTTIME_USER(ptr);				\
>  	subf	rb,rb,ra;		/* subtract start value */	\
> -	ld	ra,PACA_SYSTEM_TIME(r13);				\
> +	PPC_LL	ra, PACA_SYSTEM_TIME(ptr);				\
>  	add	ra,ra,rb;		/* add on to system time */	\
> -	std	ra,PACA_SYSTEM_TIME(r13)
> +	PPC_STL	ra, PACA_SYSTEM_TIME(ptr)
>
>  #ifdef CONFIG_PPC_SPLPAR
>  #define ACCOUNT_STOLEN_TIME						\
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index c4cb2ff..ff6b591 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1275,6 +1275,7 @@ static inline unsigned long mfvtb (void)
>  			asm volatile("mfspr %0, %1" : "=r" (rval) : \
>  				"i" (SPRN_TBRU)); rval;})
>  #endif
> +#define mftb()		mftbl()
>  #endif /* !__powerpc64__ */
>
>  #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
> diff --git a/arch/powerpc/include/asm/thread_info.h
> b/arch/powerpc/include/asm/thread_info.h
> index 7efee4a..4f19e96 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -44,6 +44,17 @@ struct thread_info {
>  						   <0 => BUG */
>  	unsigned long	local_flags;		/* private flags for thread */
>
> +#if defined(CONFIG_VIRT_CPU_ACCOUNTING_NATIVE) && defined(CONFIG_PPC32)
> +	/* Stuff for accurate time accounting */
> +	unsigned long user_time;	/* accumulated usermode TB ticks */
> +	unsigned long system_time;	/* accumulated system TB ticks */
> +	unsigned long user_time_scaled;	/* accumulated usermode SPURR ticks */
> +	unsigned long starttime;	/* TB value snapshot */
> +	unsigned long starttime_user;	/* TB value on exit to usermode */
> +	unsigned long startspurr;	/* SPURR value snapshot */
> +	unsigned long utime_sspurr;	/* ->user_time when ->startspurr set */
> +#endif
> +
>  	/* low level flags - has atomic operations done on it */
>  	unsigned long	flags ____cacheline_aligned_in_smp;
>  };
> diff --git a/arch/powerpc/kernel/asm-offsets.c
> b/arch/powerpc/kernel/asm-offsets.c
> index 07cebc3..b04b957 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -256,6 +256,13 @@ int main(void)
>  	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
>  	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct, nap_state_lost));
>  	DEFINE(PACA_SPRG_VDSO, offsetof(struct paca_struct, sprg_vdso));
> +#else /* CONFIG_PPC64 */
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	DEFINE(PACA_STARTTIME, offsetof(struct thread_info, starttime));
> +	DEFINE(PACA_STARTTIME_USER, offsetof(struct thread_info, starttime_user));
> +	DEFINE(PACA_USER_TIME, offsetof(struct thread_info, user_time));
> +	DEFINE(PACA_SYSTEM_TIME, offsetof(struct thread_info, system_time));
> +#endif
>  #endif /* CONFIG_PPC64 */
>
>  	/* RTAS */
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 2405631..9899032 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -175,6 +175,12 @@ transfer_to_handler:
>  	addi	r12,r12,-1
>  	stw	r12,4(r11)
>  #endif
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	CURRENT_THREAD_INFO(r9, r1)
> +	tophys(r9, r9)
> +	ACCOUNT_CPU_USER_ENTRY(r9, r11, r12)
> +#endif
> +
>  	b	3f
>
>  2:	/* if from kernel, check interrupted DOZE/NAP mode and
> @@ -398,6 +404,13 @@ BEGIN_FTR_SECTION
>  	lwarx	r7,0,r1
>  END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
>  	stwcx.	r0,0,r1			/* to clear the reservation */
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	andi.	r4,r8,MSR_PR
> +	beq	3f
> +	CURRENT_THREAD_INFO(r4, r1)
> +	ACCOUNT_CPU_USER_EXIT(r4, r5, r7)
> +3:
> +#endif
>  	lwz	r4,_LINK(r1)
>  	lwz	r5,_CCR(r1)
>  	mtlr	r4
> @@ -769,6 +782,10 @@ restore_user:
>  	andis.	r10,r0,DBCR0_IDM@h
>  	bnel-	load_dbcr0
>  #endif
> +#ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
> +	CURRENT_THREAD_INFO(r9, r1)
> +	ACCOUNT_CPU_USER_EXIT(r9, r10, r11)
> +#endif
>
>  	b	restore
>
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 0d525ce..d9bf82b 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -70,7 +70,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
>  	std	r0,GPR0(r1)
>  	std	r10,GPR1(r1)
>  	beq	2f			/* if from kernel mode */
> -	ACCOUNT_CPU_USER_ENTRY(r10, r11)
> +	ACCOUNT_CPU_USER_ENTRY(r13, r10, r11)
>  2:	std	r2,GPR2(r1)
>  	std	r3,GPR3(r1)
>  	mfcr	r2
> @@ -222,7 +222,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
>  	ld	r4,_LINK(r1)
>
>  	beq-	1f
> -	ACCOUNT_CPU_USER_EXIT(r11, r12)
> +	ACCOUNT_CPU_USER_EXIT(r13, r11, r12)
>
>  BEGIN_FTR_SECTION
>  	HMT_MEDIUM_LOW
> @@ -822,7 +822,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  BEGIN_FTR_SECTION
>  	mtspr	SPRN_PPR,r2	/* Restore PPR */
>  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> -	ACCOUNT_CPU_USER_EXIT(r2, r4)
> +	ACCOUNT_CPU_USER_EXIT(r13, r2, r4)
>  	REST_GPR(13, r1)
>  1:
>  	mtspr	SPRN_SRR1,r3
> diff --git a/arch/powerpc/kernel/exceptions-64e.S
> b/arch/powerpc/kernel/exceptions-64e.S
> index 488e631..a9bc548 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -386,7 +386,7 @@ exc_##n##_common:							    \
>  	std	r10,_NIP(r1);		/* save SRR0 to stackframe */	    \
>  	std	r11,_MSR(r1);		/* save SRR1 to stackframe */	    \
>  	beq	2f;			/* if from kernel mode */	    \
> -	ACCOUNT_CPU_USER_ENTRY(r10,r11);/* accounting (uses cr0+eq) */	    \
> +	ACCOUNT_CPU_USER_ENTRY(r13,r10,r11);/* accounting (uses cr0+eq) */ \
>  2:	ld	r3,excf+EX_R10(r13);	/* get back r10 */		    \
>  	ld	r4,excf+EX_R11(r13);	/* get back r11 */		    \
>  	mfspr	r5,scratch;		/* get back r13 */		    \
> @@ -1059,7 +1059,7 @@ fast_exception_return:
>  	andi.	r6,r10,MSR_PR
>  	REST_2GPRS(6, r1)
>  	beq	1f
> -	ACCOUNT_CPU_USER_EXIT(r10, r11)
> +	ACCOUNT_CPU_USER_EXIT(r13, r10, r11)
>  	ld	r0,GPR13(r1)
>
>  1:	stdcx.	r0,0,r1		/* to clear the reservation */
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 81b0900..6307b09 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -165,7 +165,13 @@ DEFINE_PER_CPU(unsigned long,
> cputime_scaled_last_delta);
>
>  cputime_t cputime_one_jiffy;
>
> +#ifdef CONFIG_PPC_SPLPAR
>  void (*dtl_consumer)(struct dtl_entry *, u64);
> +#endif
> +
> +#ifdef CONFIG_PPC32
> +#define get_paca()	task_thread_info(tsk)
> +#endif
>
>  static void calc_cputime_factors(void)
>  {
> @@ -185,7 +191,7 @@ static void calc_cputime_factors(void)
>   * Read the SPURR on systems that have it, otherwise the PURR,
>   * or if that doesn't exist return the timebase value passed in.
>   */
> -static u64 read_spurr(u64 tb)
> +static unsigned long read_spurr(unsigned long tb)
>  {
>  	if (cpu_has_feature(CPU_FTR_SPURR))
>  		return mfspr(SPRN_SPURR);
> @@ -294,11 +300,12 @@ static inline u64 calculate_stolen_time(u64 stop_tb)
>   * Account time for a transition between system, hard irq
>   * or soft irq state.
>   */
> -static u64 vtime_delta(struct task_struct *tsk,
> -			u64 *sys_scaled, u64 *stolen)
> +static unsigned long vtime_delta(struct task_struct *tsk,
> +				 unsigned long *sys_scaled,
> +				 unsigned long *stolen)
>  {
> -	u64 now, nowscaled, deltascaled;
> -	u64 udelta, delta, user_scaled;
> +	unsigned long now, nowscaled, deltascaled;
> +	unsigned long udelta, delta, user_scaled;
>
>  	WARN_ON_ONCE(!irqs_disabled());
>
> @@ -343,7 +350,7 @@ static u64 vtime_delta(struct task_struct *tsk,
>
>  void vtime_account_system(struct task_struct *tsk)
>  {
> -	u64 delta, sys_scaled, stolen;
> +	unsigned long delta, sys_scaled, stolen;
>
>  	delta = vtime_delta(tsk, &sys_scaled, &stolen);
>  	account_system_time(tsk, 0, delta, sys_scaled);
> @@ -354,7 +361,7 @@ EXPORT_SYMBOL_GPL(vtime_account_system);
>
>  void vtime_account_idle(struct task_struct *tsk)
>  {
> -	u64 delta, sys_scaled, stolen;
> +	unsigned long delta, sys_scaled, stolen;
>
>  	delta = vtime_delta(tsk, &sys_scaled, &stolen);
>  	account_idle_time(delta + stolen);
> @@ -381,6 +388,23 @@ void vtime_account_user(struct task_struct *tsk)
>  	account_user_time(tsk, utime, utimescaled);
>  }
>
> +#ifdef CONFIG_PPC32
> +/*
> + * Called from the context switch with interrupts disabled, to charge all
> + * accumulated times to the current process, and to prepare accounting on
> + * the next process.
> + */
> +void arch_vtime_task_switch(struct task_struct *prev)
> +{
> +	struct thread_info *pi = task_thread_info(prev);
> +	struct thread_info *ni = task_thread_info(current);
> +
> +	ni->starttime = pi->starttime;
> +	ni->system_time = 0;
> +	ni->user_time = 0;
> +}
> +#endif /* CONFIG_PPC32 */
> +
>  #else /* ! CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
>  #define calc_cputime_factors()
>  #endif
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype
> index 142dff5..54b8043 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -1,7 +1,6 @@
>  config PPC64
>  	bool "64-bit kernel"
>  	default n
> -	select HAVE_VIRT_CPU_ACCOUNTING
>  	select ZLIB_DEFLATE
>  	help
>  	  This option selects whether a 32-bit or a 64-bit kernel
> --
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
