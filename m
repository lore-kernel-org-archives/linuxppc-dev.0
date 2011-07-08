Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E273D1007D1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jul 2011 01:13:48 +1000 (EST)
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: "Chen, Tiejun" <Tiejun.Chen@windriver.com>, "benh@kernel.crashing.org"
	<benh@kernel.crashing.org>, "linuxppc-dev@ozlabs.org"
	<linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH 1/2] booke/kprobe: make program exception to use one
	dedicated	exception stack
Date: Fri, 8 Jul 2011 15:13:42 +0000
Message-ID: <82C960D7DF4A1F47B94FC1C67A29BEE38459F1@ALA-MBA.corp.ad.wrs.com>
References: <1310119524-19672-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1310119524-19672-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+tiejun.chen=3Dwindriver.com@lists.o
zlabs.org] On Behalf Of Tiejun Chen
> Sent: Friday, July 08, 2011 6:05 PM
> To: benh@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: [PATCH 1/2] booke/kprobe: make program exception to=20
> use one dedicated exception stack
>=20
> When kprobe these operations such as store-and-update-word for SP(r1),
>=20
> stwu r1, -A(r1)
>=20
> The program exception is triggered, and PPC always allocate=20
> an exception frame as shown as the follows:
>=20
> old r1 ----------
>          ...
>          nip
>          gpr[2] ~ gpr[31]
>          gpr[1] <--------- old r1 is stored.
>          gpr[0]
>        -------- <--------- pr_regs @offset 16 bytes
>        padding
>        STACK_FRAME_REGS_MARKER
>        LR
>        back chain
> new r1 ----------
> Then emulate_step() will emulate this instruction, 'stwu'.=20
> Actually its equivalent to:
> 1> Update pr_regs->gpr[1] =3D mem[old r1 + (-A)]
> 2> stw [old r1], mem[old r1 + (-A)]
>=20
> Please notice the stack based on new r1 may be covered with mem[old r1
> +(-A)] when addr[old r1 + (-A)] < addr[old r1 + sizeof(an=20
> exception frame0].
> So the above 2# operation will overwirte something to break=20
> this exception frame then unexpected kernel problem will be issued.
>=20
> So looks we have to implement independed interrupt stack for=20
> PPC program exception when CONFIG_BOOKE is enabled. Here we=20
> can use EXC_LEVEL_EXCEPTION_PROLOG to replace original=20
> NORMAL_EXCEPTION_PROLOG for program exception if=20
> CONFIG_BOOKE. Then its always safe for kprobe with independed=20
> exc stack from one pre-allocated and dedicated thread_info.
> Actually this is just waht we did for critical/machine check=20
> exceptions on PPC.

Update:

You can understand this problem completely from our previous email thread, =
 about '[BUG?] 3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu' lead=
 to system crash/freeze'.=20

>=20
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/irq.h   |    3 +++
>  arch/powerpc/include/asm/reg.h   |    4 ++++
>  arch/powerpc/kernel/head_booke.h |   12 +++++++++++-
>  arch/powerpc/kernel/irq.c        |   11 +++++++++++
>  arch/powerpc/kernel/setup_32.c   |    4 ++++
>  5 files changed, 33 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/irq.h=20
> b/arch/powerpc/include/asm/irq.h index 1bff591..6d12169 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -313,6 +313,9 @@ struct pt_regs;
>  extern struct thread_info *critirq_ctx[NR_CPUS];  extern=20
> struct thread_info *dbgirq_ctx[NR_CPUS];  extern struct=20
> thread_info *mcheckirq_ctx[NR_CPUS];
> +#if defined(CONFIG_KPROBES) && defined(CONFIG_BOOKE) extern struct=20
> +thread_info *pgirq_ctx[NR_CPUS]; #endif
>  extern void exc_lvl_ctx_init(void);
>  #else
>  #define exc_lvl_ctx_init()
> diff --git a/arch/powerpc/include/asm/reg.h=20
> b/arch/powerpc/include/asm/reg.h index c5cae0d..34d6178 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -885,6 +885,10 @@
>  #endif
>  #define SPRN_SPRG_RVCPU		SPRN_SPRG1
>  #define SPRN_SPRG_WVCPU		SPRN_SPRG1
> +#ifdef	CONFIG_KPROBES
> +#define	SPRN_SPRG_RSCRATCH_PG	SPRN_SPRG0
> +#define	SPRN_SPRG_WSCRATCH_PG	SPRN_SPRG0
> +#endif
>  #endif
> =20
>  #ifdef CONFIG_8xx
> diff --git a/arch/powerpc/kernel/head_booke.h=20
> b/arch/powerpc/kernel/head_booke.h
> index a0bf158..cf6cb1e 100644
> --- a/arch/powerpc/kernel/head_booke.h
> +++ b/arch/powerpc/kernel/head_booke.h
> @@ -79,6 +79,10 @@
>  /* only on e500mc/e200 */
>  #define DBG_STACK_BASE		dbgirq_ctx
> =20
> +#if defined(CONFIG_KPROBES)
> +#define PG_STACK_BASE		pgirq_ctx
> +#endif
> +
>  #define EXC_LVL_FRAME_OVERHEAD	(THREAD_SIZE -=20
> INT_FRAME_SIZE - EXC_LVL_SIZE)
> =20
>  #ifdef CONFIG_SMP
> @@ -158,6 +162,12 @@
>  		EXC_LEVEL_EXCEPTION_PROLOG(DBG, SPRN_DSRR0,=20
> SPRN_DSRR1)  #define MCHECK_EXCEPTION_PROLOG \
>  		EXC_LEVEL_EXCEPTION_PROLOG(MC, SPRN_MCSRR0, SPRN_MCSRR1)
> +#if defined(CONFIG_KPROBES)
> +#define	PROGRAM_EXCEPTION_PROLOG \
> +		EXC_LEVEL_EXCEPTION_PROLOG(PG, SPRN_SRR0,=20
> SPRN_SRR1) #else
> +#define	PROGRAM_EXCEPTION_PROLOG	NORMAL_EXCEPTION_PROLOG
> +#endif
> =20
>  /*
>   * Exception vectors.
> @@ -370,7 +380,7 @@ label:
> =20
>  #define PROGRAM_EXCEPTION				=09
> 	      \
>  	START_EXCEPTION(Program)			=09
> 	      \
> -	NORMAL_EXCEPTION_PROLOG;			=09
> 	      \
> +	PROGRAM_EXCEPTION_PROLOG;			=09
> 	      \
>  	mfspr	r4,SPRN_ESR;		/* Grab the ESR and=20
> save it */	      \
>  	stw	r4,_ESR(r11);				=09
> 	      \
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;		=09
> 	      \
> diff --git a/arch/powerpc/kernel/irq.c=20
> b/arch/powerpc/kernel/irq.c index 5b428e3..ff5b8dd 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -397,6 +397,10 @@ struct thread_info  =20
> *critirq_ctx[NR_CPUS] __read_mostly;
>  struct thread_info    *dbgirq_ctx[NR_CPUS] __read_mostly;
>  struct thread_info *mcheckirq_ctx[NR_CPUS] __read_mostly;
> =20
> +#if defined(CONFIG_KPROBES) && defined(CONFIG_BOOKE)
> +struct thread_info    *pgirq_ctx[NR_CPUS] __read_mostly;
> +#endif
> +
>  void exc_lvl_ctx_init(void)
>  {
>  	struct thread_info *tp;
> @@ -423,6 +427,13 @@ void exc_lvl_ctx_init(void)
>  		tp =3D mcheckirq_ctx[cpu_nr];
>  		tp->cpu =3D cpu_nr;
>  		tp->preempt_count =3D HARDIRQ_OFFSET;
> +
> +#if defined(CONFIG_KPROBES)
> +		memset((void *)pgirq_ctx[i], 0, THREAD_SIZE);
> +		tp =3D pgirq_ctx[i];
> +		tp->cpu =3D i;
> +		tp->preempt_count =3D 0;
> +#endif
>  #endif
>  	}
>  }
> diff --git a/arch/powerpc/kernel/setup_32.c=20
> b/arch/powerpc/kernel/setup_32.c index 620d792..f0c62ae 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -272,6 +272,10 @@ static void __init exc_lvl_early_init(void)
>  			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
>  		mcheckirq_ctx[hw_cpu] =3D (struct thread_info *)
>  			__va(memblock_alloc(THREAD_SIZE, THREAD_SIZE));
> +#ifdef CONFIG_KPROBES
> +		pgirq_ctx[i] =3D (struct thread_info *)
			    ^
			Next version I should replace 'i' with 'hw_cpu' like the above usage :)

Tiejun

> +			__va(memblock_alloc(THREAD_SIZE,=20
> THREAD_SIZE)); #endif
>  #endif
>  	}
>  }
> --
> 1.5.6=
