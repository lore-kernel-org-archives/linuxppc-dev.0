Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4160F1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 11:09:33 +1100 (AEDT)
Message-ID: <1457568572.17010.12.camel@neuling.org>
Subject: Re: [PATCH 2/2] powerpc: Batch up loads/stores on saving and
 restoring VSX
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Cc: anton@samba.org
Date: Thu, 10 Mar 2016 11:09:32 +1100
In-Reply-To: <1456811735-1289-2-git-send-email-cyrilbur@gmail.com>
References: <1456811735-1289-1-git-send-email-cyrilbur@gmail.com>
 <1456811735-1289-2-git-send-email-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-01 at 16:55 +1100, Cyril Bur wrote:

> Currently the assembly to save and restore VSX registers boils down to a
> load immediate of the offset of the specific VSX register in memory
> followed by the load/store which repeats in sequence for each VSX registe=
r.
>=20
> This patch attempts to do better by loading up four registers with
> immediates so that the loads and stores can be batched up and better
> pipelined by the processor.
>=20
> This patch results in four load/stores in sequence and one add between
> groups of four. Also, by using a pair of base registers it means that the
> result of the add is not needed by the following instruction.
>=20
> Due to the overlapping layout of FPU registers and VSX registers on POWER
> chips, this patch also benefits FPU loads and stores when VSX is compiled
> in and the CPU is VSX capable.

The extra use of registers scares the hell out of me. That being said
I've eyeballed each use and they look ok to me though.

What is the performance gain?  I think there's a trade off here
between code complexity/fragility verse what it gains us.  If it's a
tiny improvement, this may not be worth it.

> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/ppc_asm.h | 65 ++++++++++++++++++++++++++++++--=
------
>  arch/powerpc/kernel/fpu.S          | 43 ++++++++++++++++---------
>  arch/powerpc/kernel/tm.S           | 46 ++++++++++++++-------------
>  3 files changed, 104 insertions(+), 50 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/as=
m/ppc_asm.h
> index 5ba69ed..dd0df12 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -173,19 +173,58 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #define LXVD2X_ROT(n,b,base)  	  	> LXVD2X(n,b,base);  	  \
>    	  	  	  	  	  XXSWAPD(n,n)
>  #endif
> -/* Save the lower 32 VSRs in the thread VSR region */
> -#define SAVE_VSR(n,b,base)  	  li b,16*(n);  STXVD2X_ROT(n,R##base,R##b)
> -#define SAVE_2VSRS(n,b,base)  	  SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base=
)
> -#define SAVE_4VSRS(n,b,base)  	  SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,=
base)
> -#define SAVE_8VSRS(n,b,base)  	  SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,=
base)
> -#define SAVE_16VSRS(n,b,base)  	  SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b=
,base)
> -#define SAVE_32VSRS(n,b,base)  	  SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+1=
6,b,base)
> -#define REST_VSR(n,b,base)  	  li b,16*(n); LXVD2X_ROT(n,R##base,R##b)
> -#define REST_2VSRS(n,b,base)  	  REST_VSR(n,b,base); REST_VSR(n+1,b,base=
)
> -#define REST_4VSRS(n,b,base)  	  REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,=
base)
> -#define REST_8VSRS(n,b,base)  	  REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,=
base)
> -#define REST_16VSRS(n,b,base)  	  REST_8VSRS(n,b,base); REST_8VSRS(n+8,b=
,base)
> -#define REST_32VSRS(n,b,base)  	  REST_16VSRS(n,b,base); REST_16VSRS(n+1=
6,b,base)
> +
> +#define __SAVE_4VSRS(n,off0,off1,off2,off3,base) \
> +  	  STXVD2X_ROT(n,R##base,R##off0); \
> +  	  STXVD2X_ROT(n+1,R##base,R##off1); \
> +  	  STXVD2X_ROT(n+2,R##base,R##off2); \
> +  	  STXVD2X_ROT(n+3,R##base,R##off3)

same comment about off vs reg=20


> +/* Restores the base for the caller */
> +#define SAVE_32VSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +  	  addi reg4,base,64; \
> +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> +  	  __SAVE_4VSRS(0,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __SAVE_4VSRS(4,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __SAVE_4VSRS(8,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __SAVE_4VSRS(12,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __SAVE_4VSRS(16,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __SAVE_4VSRS(20,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __SAVE_4VSRS(24,reg0,reg1,reg2,reg3,base); \
> +  	  __SAVE_4VSRS(28,reg0,reg1,reg2,reg3,reg4); \
> +  	  subi base,base,384
> +
> +#define __REST_4VSRS(n,off0,off1,off2,off3,base) \
> +  	  LXVD2X_ROT(n,R##base,R##off0); \
> +  	  LXVD2X_ROT(n+1,R##base,R##off1); \
> +  	  LXVD2X_ROT(n+2,R##base,R##off2); \
> +  	  LXVD2X_ROT(n+3,R##base,R##off3)
> +
> +/* Restores the base for the caller */
> +#define REST_32VSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +  	  addi reg4,base,64; \
> +  	  li reg0,0; li reg1,16; li reg2,32; li reg3,48; \
> +  	  __REST_4VSRS(0,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __REST_4VSRS(4,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __REST_4VSRS(8,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __REST_4VSRS(12,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __REST_4VSRS(16,reg0,reg1,reg2,reg3,base); \
> +  	  addi base,base,128; \
> +  	  __REST_4VSRS(20,reg0,reg1,reg2,reg3,reg4); \
> +  	  addi reg4,reg4,128; \
> +  	  __REST_4VSRS(24,reg0,reg1,reg2,reg3,base); \
> +  	  __REST_4VSRS(28,reg0,reg1,reg2,reg3,reg4); \
> +  	  subi base,base,384
> =20
>  /*
>   * b =3D base register for addressing, o =3D base offset from register o=
f 1st EVR
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index 15da2b5..dc57ff1 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -26,29 +26,32 @@
>  #include <asm/ptrace.h>
> =20
>  #ifdef CONFIG_VSX
> -#define __REST_32FPVSRS(n,c,base)  	  	  	  	  	  \
> +#define __REST_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base)  	  \
>  BEGIN_FTR_SECTION  	  	  	  	  	  	  	  \
>    	  b  	  2f;  	  	  	  	  	  	  	  \
>  END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	  	  	  	  \
> -  	  REST_32FPRS(n,base);  	  	  	  	  	  	> \
> +  	  REST_32FPRS(0,base);  	  	  	  	  	  	> \
>    	  b  	  3f;  	  	  	  	  	  	  	  \
> -2:  	  REST_32VSRS(n,c,base);  	  	  	  	  	  	> \
> +2:  	  REST_32VSRS(reg0,reg1,reg2,reg3,reg4,base); \
>  3:
> =20
> -#define __SAVE_32FPVSRS(n,c,base)  	  	  	  	  	  \
> +#define __SAVE_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base) \
>  BEGIN_FTR_SECTION  	  	  	  	  	  	  	  \
>    	  b  	  2f;  	  	  	  	  	  	  	  \
>  END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	  	  	  	  \
> -  	  SAVE_32FPRS(n,base);  	  	  	  	  	  	> \
> +  	  SAVE_32FPRS(0,base);  	  	  	  	  	  	> \
>    	  b  	  3f;  	  	  	  	  	  	  	  \
> -2:  	  SAVE_32VSRS(n,c,base);  	  	  	  	  	  	> \
> +2:  	  SAVE_32VSRS(reg0,reg1,reg2,reg3,reg4,base); \
>  3:
>  #else
> -#define __REST_32FPVSRS(n,b,base)  	  REST_32FPRS(n, base)
> -#define __SAVE_32FPVSRS(n,b,base)  	  SAVE_32FPRS(n, base)
> +#define __REST_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base)  	  REST_32FPRS(0=
, base)
> +#define __SAVE_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base)  	  SAVE_32FPRS(0=
, base)
>  #endif
> -#define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base=
)
> -#define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base=
)
> +#define REST_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +__REST_32FPVSRS(__REG_##reg0,__REG_##reg1,__REG_##reg2,__REG_##reg3,__RE=
G_##reg4,__REG_##base)
> +
> +#define SAVE_32FPVSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +__SAVE_32FPVSRS(__REG_##reg0,__REG_##reg1,__REG_##reg2,__REG_##reg3,__RE=
G_##reg4,__REG_##base)
> =20
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  /* void do_load_up_transact_fpu(struct thread_struct *thread)
> @@ -56,6 +59,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	  	  	  	  \
>   * This is similar to load_up_fpu but for the transactional version of t=
he FP
>   * register set.  It doesn't mess with the task MSR or valid flags.
>   * Furthermore, we don't do lazy FP with TM currently.
> + *
> + * Is called from C
>   */
>  _GLOBAL(do_load_up_transact_fpu)
>    	  mfmsr  	  r6
> @@ -71,7 +76,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>    	  addi  	  r7,r3,THREAD_TRANSACT_FPSTATE
>    	  lfd  	  fr0,FPSTATE_FPSCR(r7)
>    	  MTFSF_L(fr0)
> -  	  REST_32FPVSRS(0, R4, R7)
> +  	  REST_32FPVSRS(R4,R5,R6,R8,R9,R7)
> =20
>    	  blr
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> @@ -79,19 +84,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  /*
>   * Load state from memory into FP registers including FPSCR.
>   * Assumes the caller has enabled FP in the MSR.
> + *
> + * Is called from C
>   */
>  _GLOBAL(load_fp_state)
>    	  lfd  	  fr0,FPSTATE_FPSCR(r3)
>    	  MTFSF_L(fr0)
> -  	  REST_32FPVSRS(0, R4, R3)
> +  	  REST_32FPVSRS(R4,R5,R6,R7,R8,R3)
>    	  blr
> =20
>  /*
>   * Store FP state into memory, including FPSCR
>   * Assumes the caller has enabled FP in the MSR.
> + *
> + * NOT called from C
>   */
>  _GLOBAL(store_fp_state)
> -  	  SAVE_32FPVSRS(0, R4, R3)
> +  	  SAVE_32FPVSRS(R4,R5,R6,R7,R8,R3)
>    	  mffs  	  fr0
>    	  stfd  	  fr0,FPSTATE_FPSCR(r3)
>    	  blr
> @@ -104,6 +113,8 @@ _GLOBAL(store_fp_state)
>   * enable the FPU for the current task and return to the task.
>   * Note that on 32-bit this can only use registers that will be
>   * restored by fast_exception_return, i.e. r3 - r6, r10 and r11.
> + *
> + * NOT called from C
>   */
>  _GLOBAL(load_up_fpu)
>    	  mfmsr  	  r5
> @@ -137,7 +148,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>    	  addi  	  r10,r5,THREAD_FPSTATE
>    	  lfd  	  fr0,FPSTATE_FPSCR(r10)
>    	  MTFSF_L(fr0)
> -  	  REST_32FPVSRS(0, R4, R10)
> +  	  REST_32FPVSRS(R3,R4,R5,R6,R11,R10)
>    	  /* restore registers and return */
>    	  /* we haven't used ctr or xer or lr */
>    	  blr
> @@ -146,6 +157,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>   * save_fpu(tsk)
>   * Save the floating-point registers in its thread_struct.
>   * Enables the FPU for use in the kernel on return.
> + *
> + * Is called from C
>   */
>  _GLOBAL(save_fpu)
>    	  addi  	  r3,r3,THREAD  	          /* want THREAD of task */
> @@ -154,7 +167,7 @@ _GLOBAL(save_fpu)
>    	  PPC_LCMPI  	  0,r6,0
>    	  bne  	  2f
>    	  addi  	  r6,r3,THREAD_FPSTATE
> -2:  	  SAVE_32FPVSRS(0, R4, R6)
> +2:  	  SAVE_32FPVSRS(R4,R5,R7,R8,R9,R6)
>    	  mffs  	  fr0
>    	  stfd  	  fr0,FPSTATE_FPSCR(r6)
>    	  blr
> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index 81e1305..61900b8 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -14,30 +14,32 @@
> =20
>  #ifdef CONFIG_VSX
>  /* See fpu.S, this is borrowed from there */
> -#define __SAVE_32FPRS_VSRS(n,c,base)  	  	> \
> -BEGIN_FTR_SECTION  	  	  	  	> \
> -  	  b  	  2f;  	  	  	  	> \
> -END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	> \
> -  	  SAVE_32FPRS(n,base);  	  	  	  \
> -  	  b  	  3f;  	  	  	  	> \
> -2:  	  SAVE_32VSRS(n,c,base);  	  	  	  \
> +#define __SAVE_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +BEGIN_FTR_SECTION  	  	  	  	  	  	  	  \
> +  	  b  	  2f;  	  	  	  	  	  	  	  \
> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	  	  	  	  \
> +  	  SAVE_32FPRS(0,base);  	  	  	  	  	  	> \
> +  	  b  	  3f;  	  	  	  	  	  	  	  \
> +2:  	  SAVE_32VSRS(reg0,reg1,reg2,reg3,reg4,base); \
>  3:
> -#define __REST_32FPRS_VSRS(n,c,base)  	  	> \
> -BEGIN_FTR_SECTION  	  	  	  	> \
> -  	  b  	  2f;  	  	  	  	> \
> -END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	> \
> -  	  REST_32FPRS(n,base);  	  	  	  \
> -  	  b  	  3f;  	  	  	  	> \
> -2:  	  REST_32VSRS(n,c,base);  	  	  	  \
> +
> +#define __REST_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base)  	  \
> +BEGIN_FTR_SECTION  	  	  	  	  	  	  	  \
> +  	  b  	  2f;  	  	  	  	  	  	  	  \
> +END_FTR_SECTION_IFSET(CPU_FTR_VSX);  	  	  	  	  	  \
> +  	  REST_32FPRS(0,base);  	  	  	  	  	  	> \
> +  	  b  	  3f;  	  	  	  	  	  	  	  \
> +2:  	  REST_32VSRS(reg0,reg1,reg2,reg3,reg4,base); \
>  3:
> +
>  #else
> -#define __SAVE_32FPRS_VSRS(n,c,base)  	  SAVE_32FPRS(n, base)
> -#define __REST_32FPRS_VSRS(n,c,base)  	  REST_32FPRS(n, base)
> +#define __SAVE_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base)  	  SAVE_32FPR=
S(0, base)
> +#define __REST_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base)  	  REST_32FPR=
S(0, base)
>  #endif
> -#define SAVE_32FPRS_VSRS(n,c,base) \
> -  	  __SAVE_32FPRS_VSRS(n,__REG_##c,__REG_##base)
> -#define REST_32FPRS_VSRS(n,c,base) \
> -  	  __REST_32FPRS_VSRS(n,__REG_##c,__REG_##base)
> +#define SAVE_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +__SAVE_32FPRS_VSRS(__REG_##reg0,__REG_##reg1,__REG_##reg2,__REG_##reg3,_=
_REG_##reg4,__REG_##base)
> +#define REST_32FPRS_VSRS(reg0,reg1,reg2,reg3,reg4,base) \
> +__REST_32FPRS_VSRS(__REG_##reg0,__REG_##reg1,__REG_##reg2,__REG_##reg3,_=
_REG_##reg4,__REG_##base)
> =20
>  /* Stack frame offsets for local variables. */
>  #define TM_FRAME_L0  	  TM_FRAME_SIZE-16
> @@ -165,7 +167,7 @@ dont_backup_vec:
>    	  beq  	  dont_backup_fp
> =20
>    	  addi  	  r7, r3, THREAD_TRANSACT_FPSTATE
> -  	  SAVE_32FPRS_VSRS(0, R6, R7)  	  /* r6 scratch, r7 transact fp state=
 */
> +  	  SAVE_32FPRS_VSRS(R6,R8,R9,R10,R11,R7) /* r6,r8,r9,r10,r11 scratch, =
r7 transact fp state */
> =20
>    	  mffs    fr0
>    	  stfd    fr0,FPSTATE_FPSCR(r7)
> @@ -375,7 +377,7 @@ dont_restore_vec:
>    	  addi  	  r8, r3, THREAD_FPSTATE
>    	  lfd  	  fr0, FPSTATE_FPSCR(r8)
>    	  MTFSF_L(fr0)
> -  	  REST_32FPRS_VSRS(0, R4, R8)
> +  	  REST_32FPRS_VSRS(R4,R5,R6,R7,R9,R8)
> =20
>  dont_restore_fp:
>    	  mtmsr  	  r6  	  	  	  	> /* FP/Vec off again! */
