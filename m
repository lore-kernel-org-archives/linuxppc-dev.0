Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by ozlabs.org (Postfix) with ESMTP id 92B881007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 06:02:06 +1000 (EST)
Received: by gwb20 with SMTP id 20so302856gwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 13:02:04 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201005262104.48938.temerkhanov@cifronik.ru>
References: <201005262104.48938.temerkhanov@cifronik.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 16 Jun 2010 14:01:44 -0600
Message-ID: <AANLkTinx5nCwng6tFz8h1VC_2qZ69xMF1SCCGD9iv3MM@mail.gmail.com>
Subject: Re: [PATCHv3] [RFC] Xilinx Virtex 4 FX Soft FPU support
To: Sergey Temerkhanov <temerkhanov@cifronik.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@lists.ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 26, 2010 at 11:04 AM, Sergey Temerkhanov
<temerkhanov@cifronik.ru> wrote:
> This patch enables support for Xilinx Virtex 4 FX singe-float FPU.
>
> Changelog v2-v3:
> =9A =9A =9A =9A-Fixed whitespaces for SAVE_FPR/REST_FPR.
> =9A =9A =9A =9A-Changed description of MSR_AP bit.
> =9A =9A =9A =9A-Removed the stub for APU unavailable exception.
>
> Changelog v1->v2:
> =9A =9A =9A =9A-Added MSR_AP bit definition
> =9A =9A =9A =9A-Renamed CONFIG_XILINX_FPU to CONFIG_XILINX_SOFTFPU, moved=
 it to
> =9A =9A =9A =9A 'Platform support' and made it Virtex4-FX-only.
> =9A =9A =9A =9A-Changed SAVE_FPR/REST_FPR definition style.
>
> Caveats:
> =9A =9A =9A =9A- Hard-float binaries which rely on in-kernel math emulati=
on will
> =9A =9A =9A =9Agive wrong results since they expect 64-bit double-precisi=
on instead of
> =9A =9A =9A =9A32-bit single-precision numbers which Xilinx V4-FX Soft FP=
U produces.
>
>
> Signed-off-by: Sergey Temerkhanov<temerkhanov@cifronik.ru>

Seems okay to me.  Josh & Ben, what do you think?

>
> diff -r 626de0d94469 arch/powerpc/include/asm/ppc_asm.h
> --- a/arch/powerpc/include/asm/ppc_asm.h =9A =9A =9A =9AWed May 26 15:33:=
32 2010 +0400
> +++ b/arch/powerpc/include/asm/ppc_asm.h =9A =9A =9A =9AWed May 26 20:30:=
43 2010 +0400
> @@ -85,13 +85,21 @@
> =9A#define REST_8GPRS(n, base) =9A =9AREST_4GPRS(n, base); REST_4GPRS(n+4=
, base)
> =9A#define REST_10GPRS(n, base) =9A REST_8GPRS(n, base); REST_2GPRS(n+8, =
base)
>
> +
> +#ifdef CONFIG_XILINX_SOFTFPU
> +#define SAVE_FPR(n, base) =9A =9A =9Astfs =9A =9An,THREAD_FPR0+8*TS_FPRW=
IDTH*(n)(base)
> +#define REST_FPR(n, base) =9A =9A =9Alfs =9A =9A n,THREAD_FPR0+8*TS_FPRW=
IDTH*(n)(base)
> +#else
> =9A#define SAVE_FPR(n, base) =9A =9A =9Astfd =9A =9An,THREAD_FPR0+8*TS_FP=
RWIDTH*(n)(base)
> +#define REST_FPR(n, base) =9A =9A =9Alfd =9A =9A n,THREAD_FPR0+8*TS_FPRW=
IDTH*(n)(base)
> +#endif
> +
> =9A#define SAVE_2FPRS(n, base) =9A =9ASAVE_FPR(n, base); SAVE_FPR(n+1, ba=
se)
> =9A#define SAVE_4FPRS(n, base) =9A =9ASAVE_2FPRS(n, base); SAVE_2FPRS(n+2=
, base)
> =9A#define SAVE_8FPRS(n, base) =9A =9ASAVE_4FPRS(n, base); SAVE_4FPRS(n+4=
, base)
> =9A#define SAVE_16FPRS(n, base) =9A SAVE_8FPRS(n, base); SAVE_8FPRS(n+8, =
base)
> =9A#define SAVE_32FPRS(n, base) =9A SAVE_16FPRS(n, base); SAVE_16FPRS(n+1=
6, base)
> -#define REST_FPR(n, base) =9A =9A =9Alfd =9A =9A n,THREAD_FPR0+8*TS_FPRW=
IDTH*(n)(base)
> +
> =9A#define REST_2FPRS(n, base) =9A =9AREST_FPR(n, base); REST_FPR(n+1, ba=
se)
> =9A#define REST_4FPRS(n, base) =9A =9AREST_2FPRS(n, base); REST_2FPRS(n+2=
, base)
> =9A#define REST_8FPRS(n, base) =9A =9AREST_4FPRS(n, base); REST_4FPRS(n+4=
, base)
> diff -r 626de0d94469 arch/powerpc/include/asm/reg.h
> --- a/arch/powerpc/include/asm/reg.h =9A =9AWed May 26 15:33:32 2010 +040=
0
> +++ b/arch/powerpc/include/asm/reg.h =9A =9AWed May 26 20:30:43 2010 +040=
0
> @@ -30,6 +30,7 @@
> =9A#define MSR_ISF_LG =9A =9A 61 =9A =9A =9A =9A =9A =9A =9A/* Interrupt =
64b mode valid on 630 */
> =9A#define MSR_HV_LG =9A =9A =9A60 =9A =9A =9A =9A =9A =9A =9A/* Hypervis=
or state */
> =9A#define MSR_VEC_LG =9A =9A 25 =9A =9A =9A =9A =9A =9A =9A/* Enable Alt=
iVec */
> +#define MSR_AP_LG =9A =9A =9A25 =9A =9A =9A =9A =9A =9A =9A/* Enable PPC=
405 APU */
> =9A#define MSR_VSX_LG =9A =9A 23 =9A =9A =9A =9A =9A =9A =9A/* Enable VSX=
 */
> =9A#define MSR_POW_LG =9A =9A 18 =9A =9A =9A =9A =9A =9A =9A/* Enable Pow=
er Management */
> =9A#define MSR_WE_LG =9A =9A =9A18 =9A =9A =9A =9A =9A =9A =9A/* Wait Sta=
te Enable */
> @@ -71,6 +72,7 @@
> =9A#define MSR_HV =9A =9A =9A =9A 0
> =9A#endif
>
> +#define MSR_AP =9A =9A =9A =9A __MASK(MSR_AP_LG) =9A =9A =9A /* Enable P=
PC405 APU */
> =9A#define MSR_VEC =9A =9A =9A =9A =9A =9A =9A =9A__MASK(MSR_VEC_LG) =9A =
=9A =9A/* Enable AltiVec */
> =9A#define MSR_VSX =9A =9A =9A =9A =9A =9A =9A =9A__MASK(MSR_VSX_LG) =9A =
=9A =9A/* Enable VSX */
> =9A#define MSR_POW =9A =9A =9A =9A =9A =9A =9A =9A__MASK(MSR_POW_LG) =9A =
=9A =9A/* Enable Power Management */
> diff -r 626de0d94469 arch/powerpc/kernel/fpu.S
> --- a/arch/powerpc/kernel/fpu.S Wed May 26 15:33:32 2010 +0400
> +++ b/arch/powerpc/kernel/fpu.S Wed May 26 20:30:43 2010 +0400
> @@ -57,6 +57,9 @@
> =9A_GLOBAL(load_up_fpu)
> =9A =9A =9A =9Amfmsr =9A r5
> =9A =9A =9A =9Aori =9A =9A r5,r5,MSR_FP
> +#ifdef CONFIG_XILINX_SOFTFPU
> + =9A =9A =9A oris =9A =9Ar5,r5,MSR_AP@h
> +#endif
> =9A#ifdef CONFIG_VSX
> =9ABEGIN_FTR_SECTION
> =9A =9A =9A =9Aoris =9A =9Ar5,r5,MSR_VSX@h
> @@ -85,6 +88,9 @@
> =9A =9A =9A =9Atoreal(r5)
> =9A =9A =9A =9APPC_LL =9Ar4,_MSR-STACK_FRAME_OVERHEAD(r5)
> =9A =9A =9A =9Ali =9A =9A =9Ar10,MSR_FP|MSR_FE0|MSR_FE1
> +#ifdef CONFIG_XILINX_SOFTFPU
> + =9A =9A =9A oris =9A =9Ar10,r10,MSR_AP@h
> +#endif
> =9A =9A =9A =9Aandc =9A =9Ar4,r4,r10 =9A =9A =9A =9A =9A =9A =9A /* disab=
le FP for previous task */
> =9A =9A =9A =9APPC_STL r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> =9A1:
> @@ -94,6 +100,9 @@
> =9A =9A =9A =9Amfspr =9A r5,SPRN_SPRG3 =9A =9A =9A =9A =9A /* current tas=
k's THREAD (phys) */
> =9A =9A =9A =9Alwz =9A =9A r4,THREAD_FPEXC_MODE(r5)
> =9A =9A =9A =9Aori =9A =9A r9,r9,MSR_FP =9A =9A =9A =9A =9A =9A/* enable =
FP for current */
> +#ifdef CONFIG_XILINX_SOFTFPU
> + =9A =9A =9A oris =9A =9Ar9,r9,MSR_AP@h
> +#endif
> =9A =9A =9A =9Aor =9A =9A =9Ar9,r9,r4
> =9A#else
> =9A =9A =9A =9Ald =9A =9A =9Ar4,PACACURRENT(r13)
> @@ -124,6 +133,9 @@
> =9A_GLOBAL(giveup_fpu)
> =9A =9A =9A =9Amfmsr =9A r5
> =9A =9A =9A =9Aori =9A =9A r5,r5,MSR_FP
> +#ifdef CONFIG_XILINX_SOFTFPU
> + =9A =9A =9A oris =9A =9Ar5,r5,MSR_AP@h
> +#endif
> =9A#ifdef CONFIG_VSX
> =9ABEGIN_FTR_SECTION
> =9A =9A =9A =9Aoris =9A =9Ar5,r5,MSR_VSX@h
> @@ -145,6 +157,9 @@
> =9A =9A =9A =9Abeq =9A =9A 1f
> =9A =9A =9A =9APPC_LL =9Ar4,_MSR-STACK_FRAME_OVERHEAD(r5)
> =9A =9A =9A =9Ali =9A =9A =9Ar3,MSR_FP|MSR_FE0|MSR_FE1
> +#ifdef CONFIG_XILINX_SOFTFPU
> + =9A =9A =9A oris =9A =9Ar3,r3,MSR_AP@h
> +#endif
> =9A#ifdef CONFIG_VSX
> =9ABEGIN_FTR_SECTION
> =9A =9A =9A =9Aoris =9A =9Ar3,r3,MSR_VSX@h
> diff -r 626de0d94469 arch/powerpc/kernel/head_40x.S
> --- a/arch/powerpc/kernel/head_40x.S =9A =9AWed May 26 15:33:32 2010 +040=
0
> +++ b/arch/powerpc/kernel/head_40x.S =9A =9AWed May 26 20:30:43 2010 +040=
0
> @@ -420,7 +420,19 @@
> =9A =9A =9A =9Aaddi =9A =9Ar3,r1,STACK_FRAME_OVERHEAD
> =9A =9A =9A =9AEXC_XFER_STD(0x700, program_check_exception)
>
> +/* 0x0800 - FPU unavailable Exception */
> +#ifdef CONFIG_PPC_FPU
> + =9A =9A =9A START_EXCEPTION(0x0800, FloatingPointUnavailable)
> + =9A =9A =9A NORMAL_EXCEPTION_PROLOG
> + =9A =9A =9A beq =9A =9A 1f; =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A=
 =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A \
> + =9A =9A =9A bl =9A =9A =9Aload_up_fpu; =9A =9A =9A =9A =9A =9A/* if fro=
m user, just load it up */ =9A \
> + =9A =9A =9A b =9A =9A =9A fast_exception_return; =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A\
> +1: =9A =9A addi =9A =9Ar3,r1,STACK_FRAME_OVERHEAD; =9A =9A =9A =9A =9A =
=9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A \
> + =9A =9A =9A EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
> +#else
> =9A =9A =9A =9AEXCEPTION(0x0800, Trap_08, unknown_exception, EXC_XFER_EE)
> +#endif
> +
> =9A =9A =9A =9AEXCEPTION(0x0900, Trap_09, unknown_exception, EXC_XFER_EE)
> =9A =9A =9A =9AEXCEPTION(0x0A00, Trap_0A, unknown_exception, EXC_XFER_EE)
> =9A =9A =9A =9AEXCEPTION(0x0B00, Trap_0B, unknown_exception, EXC_XFER_EE)
> @@ -821,8 +833,10 @@
> =9A* The PowerPC 4xx family of processors do not have an FPU, so this jus=
t
> =9A* returns.
> =9A*/
> +#ifndef CONFIG_PPC_FPU
> =9A_ENTRY(giveup_fpu)
> =9A =9A =9A =9Ablr
> +#endif
>
> =9A/* This is where the main kernel code starts.
> =9A*/
> diff -r 626de0d94469 arch/powerpc/platforms/Kconfig
> --- a/arch/powerpc/platforms/Kconfig =9A =9AWed May 26 15:33:32 2010 +040=
0
> +++ b/arch/powerpc/platforms/Kconfig =9A =9AWed May 26 20:30:43 2010 +040=
0
> @@ -333,4 +333,9 @@
> =9A =9A =9A =9Abool "Xilinx PCI host bridge support"
> =9A =9A =9A =9Adepends on PCI && XILINX_VIRTEX
>
> +config XILINX_SOFTFPU
> + =9A =9A =9A bool "Xilinx Soft FPU"
> + =9A =9A =9A select PPC_FPU
> + =9A =9A =9A depends on XILINX_VIRTEX_4_FX && !PPC40x_SIMPLE && !405GP &=
& !405GPR
> +
> =9Aendmenu
>
> --
> Regards, Sergey Temerkhanov,
> Cifronic ZAO
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
