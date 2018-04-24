Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vsww3Hf2zF24N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:56:00 +1000 (AEST)
Received: by mail-oi0-x244.google.com with SMTP id f63-v6so18687628oic.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 11:56:00 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180325090648.1029-1-malat@debian.org>
References: <20180316110224.12260-2-malat@debian.org>
 <20180325090648.1029-1-malat@debian.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 24 Apr 2018 20:55:37 +0200
Message-ID: <CA+7wUswB9TWRV=hrxAuJbf3YSxgEw0SLwh7ysrGSRNMBrmOBAw@mail.gmail.com>
Subject: Re: [PATCH v2] xmon: Use __printf markup to silence compiler
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No comment so far... Did I miss anything ?

On Sun, Mar 25, 2018 at 11:06 AM, Mathieu Malaterre <malat@debian.org> wrot=
e:
> Update the other prototype declarations in asm/xmon.h.
>
> Silence warnings (triggered at W=3D1) by adding relevant __printf attribu=
te.
> Move #define at bottom of the file to prevent conflict with gcc attribute=
.
>
> Solve the original warning:
>
>   arch/powerpc/xmon/nonstdio.c:178:2: error: function might be possible c=
andidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Werror=3Dsugge=
st-attribute=3Dformat]
>
> In turn this uncovered the following (partial list) warnings (treated as
> errors with W=3D1):
>
>   arch/powerpc/xmon/xmon.c:2866:17: error: format =E2=80=98%x=E2=80=99 ex=
pects argument of type =E2=80=98unsigned int=E2=80=99, but argument 2 has t=
ype =E2=80=98unsigned char *=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:1607:31: error: format =E2=80=98%lx=E2=80=99 e=
xpects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 4=
 has type =E2=80=98struct pt_regs *=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:1611:9: error: too many arguments for format [=
-Werror=3Dformat-extra-args]
>   arch/powerpc/xmon/xmon.c:1623:26: error: format =E2=80=98%lx=E2=80=99 e=
xpects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 2=
 has type =E2=80=98struct task_struct *=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:630:36: error: format =E2=80=98%lx=E2=80=99 ex=
pects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 2 =
has type =E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:1392:15: error: format =E2=80=98%x=E2=80=99 ex=
pects argument of type =E2=80=98unsigned int=E2=80=99, but argument 2 has t=
ype =E2=80=98long int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:2570:16: error: format =E2=80=98%lx=E2=80=99 e=
xpects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 3=
 has type =E2=80=98u64 {aka long long unsigned int}=E2=80=99 [-Werror=3Dfor=
mat=3D]
>   arch/powerpc/xmon/xmon.c:1629:25: error: format =E2=80=98%ld=E2=80=99 e=
xpects argument of type =E2=80=98long int=E2=80=99, but argument 2 has type=
 =E2=80=98pid_t {aka int}=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:1168:18: error: format =E2=80=98%x=E2=80=99 ex=
pects argument of type =E2=80=98unsigned int=E2=80=99, but argument 2 has t=
ype =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:3016:24: error: format =E2=80=98%lx=E2=80=99 e=
xpects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 2=
 has type =E2=80=98pgd_t * {aka struct <anonymous> *}=E2=80=99 [-Werror=3Df=
ormat=3D]
>   arch/powerpc/xmon/xmon.c:2339:9: error: format =E2=80=98%lx=E2=80=99 ex=
pects argument of type =E2=80=98long unsigned int=E2=80=99, but argument 5 =
has type =E2=80=98u64 {aka long long unsigned int}=E2=80=99 [-Werror=3Dform=
at=3D]
>   arch/powerpc/xmon/xmon.c:2339:9: error: format =E2=80=98%llx=E2=80=99 e=
xpects argument of type =E2=80=98long long unsigned int=E2=80=99, but argum=
ent 5 has type =E2=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:3827:10: error: format =E2=80=98%p=E2=80=99 ex=
pects argument of type =E2=80=98void *=E2=80=99, but argument 4 has type =
=E2=80=98long long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:3896:50: error: format =E2=80=98%d=E2=80=99 ex=
pects argument of type =E2=80=98int=E2=80=99, but argument 2 has type =E2=
=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/spu-dis.c:137:18: error: format =E2=80=98%d=E2=80=99 =
expects argument of type =E2=80=98int=E2=80=99, but argument 2 has type =E2=
=80=98long unsigned int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:3827:10: error: format =E2=80=98%d=E2=80=99 ex=
pects argument of type =E2=80=98int=E2=80=99, but argument 4 has type =E2=
=80=98u64 {aka long long unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:1665:17: error: format =E2=80=98%ld=E2=80=99 e=
xpects argument of type =E2=80=98long int=E2=80=99, but argument 2 has type=
 =E2=80=98int=E2=80=99 [-Werror=3Dformat=3D]
>   arch/powerpc/xmon/xmon.c:2339:9: error: '#' flag used with =E2=80=98%p=
=E2=80=99 gnu_printf format [-Werror=3Dformat=3D]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: resubmit patch series a single patch
>
>  arch/powerpc/include/asm/xmon.h |   2 +-
>  arch/powerpc/xmon/nonstdio.h    |   8 +--
>  arch/powerpc/xmon/spu-dis.c     |  18 +++---
>  arch/powerpc/xmon/xmon.c        | 133 ++++++++++++++++++++--------------=
------
>  4 files changed, 82 insertions(+), 79 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/xmon.h b/arch/powerpc/include/asm/x=
mon.h
> index eb42a0c6e1d9..30ff69bd8f43 100644
> --- a/arch/powerpc/include/asm/xmon.h
> +++ b/arch/powerpc/include/asm/xmon.h
> @@ -29,7 +29,7 @@ static inline void xmon_register_spus(struct list_head =
*list) { };
>  extern int cpus_are_in_xmon(void);
>  #endif
>
> -extern void xmon_printf(const char *format, ...);
> +extern __printf(1, 2) void xmon_printf(const char *format, ...);
>
>  #endif /* __KERNEL __ */
>  #endif /* __ASM_POWERPC_XMON_H */
> diff --git a/arch/powerpc/xmon/nonstdio.h b/arch/powerpc/xmon/nonstdio.h
> index 2202ec61972c..e8deac6c84e2 100644
> --- a/arch/powerpc/xmon/nonstdio.h
> +++ b/arch/powerpc/xmon/nonstdio.h
> @@ -1,13 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #define EOF    (-1)
>
> -#define printf xmon_printf
> -#define putchar        xmon_putchar
> -
>  extern void xmon_set_pagination_lpp(unsigned long lpp);
>  extern void xmon_start_pagination(void);
>  extern void xmon_end_pagination(void);
>  extern int xmon_putchar(int c);
>  extern void xmon_puts(const char *);
>  extern char *xmon_gets(char *, int);
> -extern void xmon_printf(const char *, ...);
> +extern __printf(1, 2) void xmon_printf(const char *fmt, ...);
> +
> +#define printf xmon_printf
> +#define putchar        xmon_putchar
> diff --git a/arch/powerpc/xmon/spu-dis.c b/arch/powerpc/xmon/spu-dis.c
> index e5f89837c82e..4cbc7da88524 100644
> --- a/arch/powerpc/xmon/spu-dis.c
> +++ b/arch/powerpc/xmon/spu-dis.c
> @@ -102,7 +102,7 @@ print_insn_spu (unsigned long insn, unsigned long mem=
addr)
>
>    if (index =3D=3D 0)
>      {
> -      printf(".long 0x%x", insn);
> +      printf(".long 0x%lx", insn);
>      }
>    else
>      {
> @@ -134,27 +134,27 @@ print_insn_spu (unsigned long insn, unsigned long m=
emaddr)
>           switch (arg)
>             {
>             case A_T:
> -             printf("$%d",
> +             printf("$%lu",
>                                      DECODE_INSN_RT (insn));
>               break;
>             case A_A:
> -             printf("$%d",
> +             printf("$%lu",
>                                      DECODE_INSN_RA (insn));
>               break;
>             case A_B:
> -             printf("$%d",
> +             printf("$%lu",
>                                      DECODE_INSN_RB (insn));
>               break;
>             case A_C:
> -             printf("$%d",
> +             printf("$%lu",
>                                      DECODE_INSN_RC (insn));
>               break;
>             case A_S:
> -             printf("$sp%d",
> +             printf("$sp%lu",
>                                      DECODE_INSN_RA (insn));
>               break;
>             case A_H:
> -             printf("$ch%d",
> +             printf("$ch%lu",
>                                      DECODE_INSN_RA (insn));
>               break;
>             case A_P:
> @@ -162,11 +162,11 @@ print_insn_spu (unsigned long insn, unsigned long m=
emaddr)
>               printf("(");
>               break;
>             case A_U7A:
> -             printf("%d",
> +             printf("%lu",
>                                      173 - DECODE_INSN_U8 (insn));
>               break;
>             case A_U7B:
> -             printf("%d",
> +             printf("%lu",
>                                      155 - DECODE_INSN_U8 (insn));
>               break;
>             case A_S3:
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index ee113a6e008c..edd7ea85272f 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -627,7 +627,7 @@ static int xmon_core(struct pt_regs *regs, int fromip=
i)
>                 excprint(regs);
>                 bp =3D at_breakpoint(regs->nip);
>                 if (bp) {
> -                       printf("Stopped at breakpoint %lx (", BP_NUM(bp))=
;
> +                       printf("Stopped at breakpoint %tx (", BP_NUM(bp))=
;
>                         xmon_print_symbol(regs->nip, " ", ")\n");
>                 }
>                 if (unrecoverable_excp(regs))
> @@ -1165,7 +1165,7 @@ static int cpu_cmd(void)
>         }
>         /* try to switch to cpu specified */
>         if (!cpumask_test_cpu(cpu, &cpus_in_xmon)) {
> -               printf("cpu 0x%x isn't in xmon\n", cpu);
> +               printf("cpu 0x%lx isn't in xmon\n", cpu);
>                 return 0;
>         }
>         xmon_taken =3D 0;
> @@ -1179,7 +1179,7 @@ static int cpu_cmd(void)
>                         /* take control back */
>                         mb();
>                         xmon_owner =3D smp_processor_id();
> -                       printf("cpu 0x%x didn't take control\n", cpu);
> +                       printf("cpu 0x%lx didn't take control\n", cpu);
>                         return 0;
>                 }
>                 barrier();
> @@ -1362,7 +1362,7 @@ bpt_cmds(void)
>                         }
>                 }
>
> -               printf("Cleared breakpoint %lx (", BP_NUM(bp));
> +               printf("Cleared breakpoint %tx (", BP_NUM(bp));
>                 xmon_print_symbol(bp->address, " ", ")\n");
>                 bp->enabled =3D 0;
>                 break;
> @@ -1389,7 +1389,7 @@ bpt_cmds(void)
>                         for (bp =3D bpts; bp < &bpts[NBPTS]; ++bp) {
>                                 if (!bp->enabled)
>                                         continue;
> -                               printf("%2x %s   ", BP_NUM(bp),
> +                               printf("%tx %s   ", BP_NUM(bp),
>                                     (bp->enabled & BP_CIABR) ? "inst": "t=
rap");
>                                 xmon_print_symbol(bp->address, "  ", "\n"=
);
>                         }
> @@ -1604,11 +1604,11 @@ static void excprint(struct pt_regs *fp)
>  #endif /* CONFIG_SMP */
>
>         trap =3D TRAP(fp);
> -       printf("Vector: %lx %s at [%lx]\n", fp->trap, getvecname(trap), f=
p);
> +       printf("Vector: %lx %s at [%p]\n", fp->trap, getvecname(trap), fp=
);
>         printf("    pc: ");
>         xmon_print_symbol(fp->nip, ": ", "\n");
>
> -       printf("    lr: ", fp->link);
> +       printf("    lr: ");
>         xmon_print_symbol(fp->link, ": ", "\n");
>
>         printf("    sp: %lx\n", fp->gpr[1]);
> @@ -1620,13 +1620,13 @@ static void excprint(struct pt_regs *fp)
>                         printf(" dsisr: %lx\n", fp->dsisr);
>         }
>
> -       printf("  current =3D 0x%lx\n", current);
> +       printf("  current =3D 0x%p\n", current);
>  #ifdef CONFIG_PPC64
> -       printf("  paca    =3D 0x%lx\t softe: %d\t irq_happened: 0x%02x\n"=
,
> +       printf("  paca    =3D 0x%p\t softe: %d\t irq_happened: 0x%02x\n",
>                local_paca, local_paca->irq_soft_mask, local_paca->irq_hap=
pened);
>  #endif
>         if (current) {
> -               printf("    pid   =3D %ld, comm =3D %s\n",
> +               printf("    pid   =3D %d, comm =3D %s\n",
>                        current->pid, current->comm);
>         }
>
> @@ -1662,16 +1662,16 @@ static void prregs(struct pt_regs *fp)
>  #ifdef CONFIG_PPC64
>         if (FULL_REGS(fp)) {
>                 for (n =3D 0; n < 16; ++n)
> -                       printf("R%.2ld =3D "REG"   R%.2ld =3D "REG"\n",
> +                       printf("R%.2d =3D "REG"   R%.2d =3D "REG"\n",
>                                n, fp->gpr[n], n+16, fp->gpr[n+16]);
>         } else {
>                 for (n =3D 0; n < 7; ++n)
> -                       printf("R%.2ld =3D "REG"   R%.2ld =3D "REG"\n",
> +                       printf("R%.2d =3D "REG"   R%.2d =3D "REG"\n",
>                                n, fp->gpr[n], n+7, fp->gpr[n+7]);
>         }
>  #else
>         for (n =3D 0; n < 32; ++n) {
> -               printf("R%.2d =3D %.8x%s", n, fp->gpr[n],
> +               printf("R%.2d =3D %.8lx%s", n, fp->gpr[n],
>                        (n & 3) =3D=3D 3? "\n": "   ");
>                 if (n =3D=3D 12 && !FULL_REGS(fp)) {
>                         printf("\n");
> @@ -1775,9 +1775,9 @@ static void dump_206_sprs(void)
>
>         /* Actually some of these pre-date 2.06, but whatevs */
>
> -       printf("srr0   =3D %.16lx  srr1  =3D %.16lx dsisr  =3D %.8x\n",
> +       printf("srr0   =3D %.16lx  srr1  =3D %.16lx dsisr  =3D %.8lx\n",
>                 mfspr(SPRN_SRR0), mfspr(SPRN_SRR1), mfspr(SPRN_DSISR));
> -       printf("dscr   =3D %.16lx  ppr   =3D %.16lx pir    =3D %.8x\n",
> +       printf("dscr   =3D %.16lx  ppr   =3D %.16lx pir    =3D %.8lx\n",
>                 mfspr(SPRN_DSCR), mfspr(SPRN_PPR), mfspr(SPRN_PIR));
>         printf("amr    =3D %.16lx  uamor =3D %.16lx\n",
>                 mfspr(SPRN_AMR), mfspr(SPRN_UAMOR));
> @@ -1785,11 +1785,11 @@ static void dump_206_sprs(void)
>         if (!(mfmsr() & MSR_HV))
>                 return;
>
> -       printf("sdr1   =3D %.16lx  hdar  =3D %.16lx hdsisr =3D %.8x\n",
> +       printf("sdr1   =3D %.16lx  hdar  =3D %.16lx hdsisr =3D %.8lx\n",
>                 mfspr(SPRN_SDR1), mfspr(SPRN_HDAR), mfspr(SPRN_HDSISR));
>         printf("hsrr0  =3D %.16lx hsrr1  =3D %.16lx hdec   =3D %.16lx\n",
>                 mfspr(SPRN_HSRR0), mfspr(SPRN_HSRR1), mfspr(SPRN_HDEC));
> -       printf("lpcr   =3D %.16lx  pcr   =3D %.16lx lpidr  =3D %.8x\n",
> +       printf("lpcr   =3D %.16lx  pcr   =3D %.16lx lpidr  =3D %.8lx\n",
>                 mfspr(SPRN_LPCR), mfspr(SPRN_PCR), mfspr(SPRN_LPID));
>         printf("hsprg0 =3D %.16lx hsprg1 =3D %.16lx amor   =3D %.16lx\n",
>                 mfspr(SPRN_HSPRG0), mfspr(SPRN_HSPRG1), mfspr(SPRN_AMOR))=
;
> @@ -1806,10 +1806,10 @@ static void dump_207_sprs(void)
>         if (!cpu_has_feature(CPU_FTR_ARCH_207S))
>                 return;
>
> -       printf("dpdes  =3D %.16lx  tir   =3D %.16lx cir    =3D %.8x\n",
> +       printf("dpdes  =3D %.16lx  tir   =3D %.16lx cir    =3D %.8lx\n",
>                 mfspr(SPRN_DPDES), mfspr(SPRN_TIR), mfspr(SPRN_CIR));
>
> -       printf("fscr   =3D %.16lx  tar   =3D %.16lx pspb   =3D %.8x\n",
> +       printf("fscr   =3D %.16lx  tar   =3D %.16lx pspb   =3D %.8lx\n",
>                 mfspr(SPRN_FSCR), mfspr(SPRN_TAR), mfspr(SPRN_PSPB));
>
>         msr =3D mfmsr();
> @@ -1822,12 +1822,12 @@ static void dump_207_sprs(void)
>
>         printf("mmcr0  =3D %.16lx  mmcr1 =3D %.16lx mmcr2  =3D %.16lx\n",
>                 mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1), mfspr(SPRN_MMCR2));
> -       printf("pmc1   =3D %.8x pmc2 =3D %.8x  pmc3 =3D %.8x  pmc4   =3D =
%.8x\n",
> +       printf("pmc1   =3D %.8lx pmc2 =3D %.8lx  pmc3 =3D %.8lx  pmc4   =
=3D %.8lx\n",
>                 mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
>                 mfspr(SPRN_PMC3), mfspr(SPRN_PMC4));
> -       printf("mmcra  =3D %.16lx   siar =3D %.16lx pmc5   =3D %.8x\n",
> +       printf("mmcra  =3D %.16lx   siar =3D %.16lx pmc5   =3D %.8lx\n",
>                 mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR), mfspr(SPRN_PMC5));
> -       printf("sdar   =3D %.16lx   sier =3D %.16lx pmc6   =3D %.8x\n",
> +       printf("sdar   =3D %.16lx   sier =3D %.16lx pmc6   =3D %.8lx\n",
>                 mfspr(SPRN_SDAR), mfspr(SPRN_SIER), mfspr(SPRN_PMC6));
>         printf("ebbhr  =3D %.16lx  ebbrr =3D %.16lx bescr  =3D %.16lx\n",
>                 mfspr(SPRN_EBBHR), mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
> @@ -2337,22 +2337,25 @@ static void dump_one_paca(int cpu)
>
>  #define DUMP(paca, name, format) \
>         printf(" %-*s =3D %#-*"format"\t(0x%lx)\n", 20, #name, 18, paca->=
name, \
> -               offsetof(struct paca_struct, name));
> +               offsetof(struct paca_struct, name))
> +#define DUMPPTR(paca, name, format) \
> +       printf(" %-*s =3D %-*"format"\t(0x%lx)\n", 20, #name, 18, paca->n=
ame, \
> +               offsetof(struct paca_struct, name))
>
>         DUMP(p, lock_token, "x");
>         DUMP(p, paca_index, "x");
> -       DUMP(p, kernel_toc, "lx");
> -       DUMP(p, kernelbase, "lx");
> -       DUMP(p, kernel_msr, "lx");
> -       DUMP(p, emergency_sp, "px");
> +       DUMP(p, kernel_toc, "llx");
> +       DUMP(p, kernelbase, "llx");
> +       DUMP(p, kernel_msr, "llx");
> +       DUMPPTR(p, emergency_sp, "p");
>  #ifdef CONFIG_PPC_BOOK3S_64
> -       DUMP(p, nmi_emergency_sp, "px");
> -       DUMP(p, mc_emergency_sp, "px");
> +       DUMPPTR(p, nmi_emergency_sp, "p");
> +       DUMPPTR(p, mc_emergency_sp, "p");
>         DUMP(p, in_nmi, "x");
>         DUMP(p, in_mce, "x");
>         DUMP(p, hmi_event_available, "x");
>  #endif
> -       DUMP(p, data_offset, "lx");
> +       DUMP(p, data_offset, "llx");
>         DUMP(p, hw_cpu_id, "x");
>         DUMP(p, cpu_start, "x");
>         DUMP(p, kexec_state, "x");
> @@ -2367,16 +2370,16 @@ static void dump_one_paca(int cpu)
>                 vsid =3D be64_to_cpu(p->slb_shadow_ptr->save_area[i].vsid=
);
>
>                 if (esid || vsid) {
> -                       printf(" slb_shadow[%d]:       =3D 0x%016lx 0x%01=
6lx\n",
> +                       printf(" slb_shadow[%d]:       =3D 0x%016llx 0x%0=
16llx\n",
>                                 i, esid, vsid);
>                 }
>         }
>         DUMP(p, vmalloc_sllp, "x");
>         DUMP(p, slb_cache_ptr, "x");
>         for (i =3D 0; i < SLB_CACHE_ENTRIES; i++)
> -               printf(" slb_cache[%d]:        =3D 0x%016lx\n", i, p->slb=
_cache[i]);
> +               printf(" slb_cache[%d]:        =3D 0x%016x\n", i, p->slb_=
cache[i]);
>
> -       DUMP(p, rfi_flush_fallback_area, "px");
> +       DUMPPTR(p, rfi_flush_fallback_area, "p");
>  #endif
>         DUMP(p, dscr_default, "llx");
>  #ifdef CONFIG_PPC_BOOK3E
> @@ -2387,11 +2390,11 @@ static void dump_one_paca(int cpu)
>         DUMP(p, crit_kstack, "px");
>         DUMP(p, dbg_kstack, "px");
>  #endif
> -       DUMP(p, __current, "px");
> -       DUMP(p, kstack, "lx");
> -       printf(" kstack_base          =3D 0x%016lx\n", p->kstack & ~(THRE=
AD_SIZE - 1));
> -       DUMP(p, stab_rr, "lx");
> -       DUMP(p, saved_r1, "lx");
> +       DUMPPTR(p, __current, "p");
> +       DUMP(p, kstack, "llx");
> +       printf(" kstack_base          =3D 0x%016llx\n", p->kstack & ~(THR=
EAD_SIZE - 1));
> +       DUMP(p, stab_rr, "llx");
> +       DUMP(p, saved_r1, "llx");
>         DUMP(p, trap_save, "x");
>         DUMP(p, irq_soft_mask, "x");
>         DUMP(p, irq_happened, "x");
> @@ -2405,20 +2408,20 @@ static void dump_one_paca(int cpu)
>  #endif
>
>  #ifdef CONFIG_PPC_POWERNV
> -       DUMP(p, core_idle_state_ptr, "px");
> +       DUMPPTR(p, core_idle_state_ptr, "p");
>         DUMP(p, thread_idle_state, "x");
>         DUMP(p, thread_mask, "x");
>         DUMP(p, subcore_sibling_mask, "x");
>  #endif
>
> -       DUMP(p, accounting.utime, "llx");
> -       DUMP(p, accounting.stime, "llx");
> -       DUMP(p, accounting.utime_scaled, "llx");
> -       DUMP(p, accounting.starttime, "llx");
> -       DUMP(p, accounting.starttime_user, "llx");
> -       DUMP(p, accounting.startspurr, "llx");
> -       DUMP(p, accounting.utime_sspurr, "llx");
> -       DUMP(p, accounting.steal_time, "llx");
> +       DUMP(p, accounting.utime, "lx");
> +       DUMP(p, accounting.stime, "lx");
> +       DUMP(p, accounting.utime_scaled, "lx");
> +       DUMP(p, accounting.starttime, "lx");
> +       DUMP(p, accounting.starttime_user, "lx");
> +       DUMP(p, accounting.startspurr, "lx");
> +       DUMP(p, accounting.utime_sspurr, "lx");
> +       DUMP(p, accounting.steal_time, "lx");
>  #undef DUMP
>
>         catch_memory_errors =3D 0;
> @@ -2564,7 +2567,7 @@ static void dump_by_size(unsigned long addr, long c=
ount, int size)
>                         default: val =3D 0;
>                         }
>
> -                       printf("%0*lx", size * 2, val);
> +                       printf("%0*llx", size * 2, val);
>                 }
>                 printf("\n");
>         }
> @@ -2728,7 +2731,7 @@ generic_inst_dump(unsigned long adr, long count, in=
t praddr,
>                 dotted =3D 0;
>                 last_inst =3D inst;
>                 if (praddr)
> -                       printf(REG"  %.8x", adr, inst);
> +                       printf(REG"  %.8lx", adr, inst);
>                 printf("\t");
>                 dump_func(inst, adr);
>                 printf("\n");
> @@ -2860,7 +2863,7 @@ memdiffs(unsigned char *p1, unsigned char *p2, unsi=
gned nb, unsigned maxpr)
>         for( n =3D nb; n > 0; --n )
>                 if( *p1++ !=3D *p2++ )
>                         if( ++prt <=3D maxpr )
> -                               printf("%.16x %.2x # %.16x %.2x\n", p1 - =
1,
> +                               printf("%p %.2x # %p %.2x\n", p1 - 1,
>                                         p1[-1], p2 - 1, p2[-1]);
>         if( prt > maxpr )
>                 printf("Total of %d differences\n", prt);
> @@ -2920,13 +2923,13 @@ memzcan(void)
>                 if (ok && !ook) {
>                         printf("%.8x .. ", a);
>                 } else if (!ok && ook)
> -                       printf("%.8x\n", a - mskip);
> +                       printf("%.8lx\n", a - mskip);
>                 ook =3D ok;
>                 if (a + mskip < a)
>                         break;
>         }
>         if (ook)
> -               printf("%.8x\n", a - mskip);
> +               printf("%.8lx\n", a - mskip);
>  }
>
>  static void show_task(struct task_struct *tsk)
> @@ -3010,13 +3013,13 @@ static void show_pte(unsigned long addr)
>                 return;
>         }
>
> -       printf("pgd  @ 0x%016lx\n", pgdir);
> +       printf("pgd  @ 0x%p\n", pgdir);
>
>         if (pgd_huge(*pgdp)) {
>                 format_pte(pgdp, pgd_val(*pgdp));
>                 return;
>         }
> -       printf("pgdp @ 0x%016lx =3D 0x%016lx\n", pgdp, pgd_val(*pgdp));
> +       printf("pgdp @ 0x%p =3D 0x%016lx\n", pgdp, pgd_val(*pgdp));
>
>         pudp =3D pud_offset(pgdp, addr);
>
> @@ -3030,7 +3033,7 @@ static void show_pte(unsigned long addr)
>                 return;
>         }
>
> -       printf("pudp @ 0x%016lx =3D 0x%016lx\n", pudp, pud_val(*pudp));
> +       printf("pudp @ 0x%p =3D 0x%016lx\n", pudp, pud_val(*pudp));
>
>         pmdp =3D pmd_offset(pudp, addr);
>
> @@ -3043,7 +3046,7 @@ static void show_pte(unsigned long addr)
>                 format_pte(pmdp, pmd_val(*pmdp));
>                 return;
>         }
> -       printf("pmdp @ 0x%016lx =3D 0x%016lx\n", pmdp, pmd_val(*pmdp));
> +       printf("pmdp @ 0x%p =3D 0x%016lx\n", pmdp, pmd_val(*pmdp));
>
>         ptep =3D pte_offset_map(pmdp, addr);
>         if (pte_none(*ptep)) {
> @@ -3847,19 +3850,19 @@ static void dump_spu_fields(struct spu *spu)
>         DUMP_FIELD(spu, "0x%lx", ls_size);
>         DUMP_FIELD(spu, "0x%x", node);
>         DUMP_FIELD(spu, "0x%lx", flags);
> -       DUMP_FIELD(spu, "%d", class_0_pending);
> -       DUMP_FIELD(spu, "0x%lx", class_0_dar);
> -       DUMP_FIELD(spu, "0x%lx", class_1_dar);
> -       DUMP_FIELD(spu, "0x%lx", class_1_dsisr);
> -       DUMP_FIELD(spu, "0x%lx", irqs[0]);
> -       DUMP_FIELD(spu, "0x%lx", irqs[1]);
> -       DUMP_FIELD(spu, "0x%lx", irqs[2]);
> +       DUMP_FIELD(spu, "%llu", class_0_pending);
> +       DUMP_FIELD(spu, "0x%llx", class_0_dar);
> +       DUMP_FIELD(spu, "0x%llx", class_1_dar);
> +       DUMP_FIELD(spu, "0x%llx", class_1_dsisr);
> +       DUMP_FIELD(spu, "0x%x", irqs[0]);
> +       DUMP_FIELD(spu, "0x%x", irqs[1]);
> +       DUMP_FIELD(spu, "0x%x", irqs[2]);
>         DUMP_FIELD(spu, "0x%x", slb_replace);
>         DUMP_FIELD(spu, "%d", pid);
>         DUMP_FIELD(spu, "0x%p", mm);
>         DUMP_FIELD(spu, "0x%p", ctx);
>         DUMP_FIELD(spu, "0x%p", rq);
> -       DUMP_FIELD(spu, "0x%p", timestamp);
> +       DUMP_FIELD(spu, "0x%llx", timestamp);
>         DUMP_FIELD(spu, "0x%lx", problem_phys);
>         DUMP_FIELD(spu, "0x%p", problem);
>         DUMP_VALUE("0x%x", problem->spu_runcntl_RW,
> @@ -3890,7 +3893,7 @@ static void dump_spu_ls(unsigned long num, int subc=
md)
>                 __delay(200);
>         } else {
>                 catch_memory_errors =3D 0;
> -               printf("*** Error: accessing spu info for spu %d\n", num)=
;
> +               printf("*** Error: accessing spu info for spu %ld\n", num=
);
>                 return;
>         }
>         catch_memory_errors =3D 0;
> --
> 2.11.0
>
