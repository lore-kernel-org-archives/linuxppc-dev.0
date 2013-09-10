Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 82A442C00D0
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Sep 2013 03:07:57 +1000 (EST)
Subject: Re: [PATCH 1/6] powerpc: Put FP/VSX and VR state into structures
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130910102041.GB28145@iris.ozlabs.ibm.com>
Date: Tue, 10 Sep 2013 12:07:46 -0500
Message-Id: <992F9967-6DA8-4BDF-A6BC-A8F9E8F4FF7D@suse.de>
References: <20130910102000.GA28145@iris.ozlabs.ibm.com>
 <20130910102041.GB28145@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.09.2013, at 05:20, Paul Mackerras wrote:

> This creates new 'thread_fp_state' and 'thread_vr_state' structures
> to store FP/VSX state (including FPSCR) and Altivec/VSX state
> (including VSCR), and uses them in the thread_struct.  In the
> thread_fp_state, the FPRs and VSRs are represented as u64 rather
> than double, since we rarely perform floating-point computations
> on the values, and this will enable the structures to be used
> in KVM code as well.  Similarly FPSCR is now a u64 rather than
> a structure of two 32-bit values.
>=20
> This takes the offsets out of the macros such as SAVE_32FPRS,
> REST_32FPRS, etc.  This enables the same macros to be used for normal
> and transactional state, enabling us to delete the transactional
> versions of the macros.   This also removes the unused do_load_up_fpu
> and do_load_up_altivec, which were in fact buggy since they didn't
> create large enough stack frames to account for the fact that
> load_up_fpu and load_up_altivec are not designed to be called from C
> and assume that their caller's stack frame is an interrupt frame.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>

I like the idea of this patch. However this really needs an ack from Ben =
(or get applied by him). I also found the patch pretty large and =
subtile, so there's a good chance I missed a register overwrite if there =
was any :).

> ---
> arch/powerpc/include/asm/ppc_asm.h     | 95 =
+++-------------------------------
> arch/powerpc/include/asm/processor.h   | 40 +++++++-------
> arch/powerpc/include/asm/sfp-machine.h |  2 +-
> arch/powerpc/kernel/align.c            |  6 +--
> arch/powerpc/kernel/asm-offsets.c      | 25 +++------
> arch/powerpc/kernel/fpu.S              | 59 +++++----------------
> arch/powerpc/kernel/process.c          |  8 ++-
> arch/powerpc/kernel/ptrace.c           | 49 +++++++++---------
> arch/powerpc/kernel/ptrace32.c         | 11 ++--
> arch/powerpc/kernel/signal_32.c        | 72 +++++++++++++-------------
> arch/powerpc/kernel/signal_64.c        | 29 ++++++-----
> arch/powerpc/kernel/tm.S               | 41 ++++++++-------
> arch/powerpc/kernel/traps.c            | 10 ++--
> arch/powerpc/kernel/vecemu.c           |  6 +--
> arch/powerpc/kernel/vector.S           | 50 ++++++------------
> arch/powerpc/kvm/book3s_pr.c           | 36 ++++++-------
> arch/powerpc/kvm/booke.c               | 19 ++++---
> 17 files changed, 200 insertions(+), 358 deletions(-)
>=20
>=20

[...]

> diff --git a/arch/powerpc/include/asm/sfp-machine.h =
b/arch/powerpc/include/asm/sfp-machine.h
> index 3a7a67a..d89beab 100644
> --- a/arch/powerpc/include/asm/sfp-machine.h
> +++ b/arch/powerpc/include/asm/sfp-machine.h
> @@ -125,7 +125,7 @@
> #define FP_EX_DIVZERO         (1 << (31 - 5))
> #define FP_EX_INEXACT         (1 << (31 - 6))
>=20
> -#define __FPU_FPSCR	(current->thread.fpscr.val)
> +#define __FPU_FPSCR	(current->thread.fp_state.fpscr)
>=20
> /* We only actually write to the destination register
>  * if exceptions signalled (if any) will not trap.
> diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
> index a27ccd5..eaa16bc 100644
> --- a/arch/powerpc/kernel/align.c
> +++ b/arch/powerpc/kernel/align.c
> @@ -660,7 +660,7 @@ static int emulate_vsx(unsigned char __user *addr, =
unsigned int reg,
> 	if (reg < 32)
> 		ptr =3D (char *) &current->thread.TS_FPR(reg);
> 	else
> -		ptr =3D (char *) &current->thread.vr[reg - 32];
> +		ptr =3D (char *) &current->thread.vr_state.vr[reg - 32];
>=20
> 	lptr =3D (unsigned long *) ptr;
>=20
> @@ -897,7 +897,7 @@ int fix_alignment(struct pt_regs *regs)
> 				return -EFAULT;
> 		}
> 	} else if (flags & F) {
> -		data.dd =3D current->thread.TS_FPR(reg);
> +		data.ll =3D current->thread.TS_FPR(reg);

I don't understand this change. Could you please explain?

> 		if (flags & S) {
> 			/* Single-precision FP store requires =
conversion... */
> #ifdef CONFIG_PPC_FPU
> @@ -975,7 +975,7 @@ int fix_alignment(struct pt_regs *regs)
> 		if (unlikely(ret))
> 			return -EFAULT;
> 	} else if (flags & F)
> -		current->thread.TS_FPR(reg) =3D data.dd;
> +		current->thread.TS_FPR(reg) =3D data.ll;
> 	else
> 		regs->gpr[reg] =3D data.ll;
>=20

[...]

> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index 7b60b98..d781ca5 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -12,16 +12,15 @@
> #include <asm/reg.h>
>=20
> #ifdef CONFIG_VSX
> -/* See fpu.S, this is very similar but to save/restore checkpointed =
FPRs/VSRs */
> -#define __SAVE_32FPRS_VSRS_TRANSACT(n,c,base)	\
> +/* See fpu.S, this is borrowed from there */
> +#define __SAVE_32FPRS_VSRS(n,c,base)		\

Should this really be in tm.S with its new name?


Alex
