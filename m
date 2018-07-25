Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bKjH6SBKzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 02:01:39 +1000 (AEST)
Date: Wed, 25 Jul 2018 18:01:34 +0200
Message-ID: <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Simon Guo
 <wei.guo.simon@gmail.com>, Paul Mackerras <paulus@samba.org>, Nicholas
 Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>, Michael
 Ellerman <mpe@ellerman.id.au>, "Eric W . Biederman" <ebiederm@xmission.com>,
 Cyril Bur <cyrilbur@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>, Andrew
 Donnellan <andrew.donnellan@au1.ibm.com>, Alastair D'Silva
 <alastair@d-silva.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-8-muriloo@linux.ibm.com>
In-Reply-To: <20180724192720.32417-8-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a =C3=A9crit=C2=A0:

> Move show_instructions() declaration to arch/powerpc/include/asm/stacktra=
ce.h
> and include asm/stracktrace.h in arch/powerpc/kernel/process.c,=20=20
>=20which contains
> the implementation.
>
> Modify show_instructions() not to call __kernel_text_address(), allowing
> userspace instruction dump.  probe_kernel_address(), which returns -EFAUL=
T if
> something goes wrong, is still being called.
>
> Call show_instructions() in arch/powerpc/kernel/traps.c to dump=20=20
>=20instructions at
> faulty location, useful to debugging.

Shouldn't this part be in a second patch ?

Wouldn't it be better to also see regs in addition if we want to use=20=20
this=20to understand what happened ?
So you could call show_regs() instead of show_instructions() ?

Christophe

>
> Before this patch, an unhandled signal message looked like:
>
>     Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault=20=20
>=20(11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100=20=20
>=20code 2 in pandafault[10000000+10000]
>
> After this patch, it looks like:
>
>     Jul 24 09:57:00 localhost kernel: pandafault[10524]: segfault=20=20
>=20(11) at 00000000100007d0 nip 000000001000061c lr 00007fffbd295100=20=20
>=20code 2 in pandafault[10000000+10000]
>     Jul 24 09:57:00 localhost kernel: Instruction dump:
>     Jul 24 09:57:00 localhost kernel: 4bfffeec 4bfffee8 3c401002=20=20
>=2038427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     Jul 24 09:57:00 localhost kernel: 392988d0 f93f0020 e93f0020=20=20
>=2039400048 <99490000> 39200000 7d234b78 383f0040
>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/stacktrace.h | 7 +++++++
>  arch/powerpc/kernel/process.c         | 6 +++---
>  arch/powerpc/kernel/traps.c           | 3 +++
>  3 files changed, 13 insertions(+), 3 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/stacktrace.h
>
> diff --git a/arch/powerpc/include/asm/stacktrace.h=20=20
>=20b/arch/powerpc/include/asm/stacktrace.h
> new file mode 100644
> index 000000000000..46e5ef451578
> --- /dev/null
> +++ b/arch/powerpc/include/asm/stacktrace.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_STACKTRACE_H
> +#define _ASM_POWERPC_STACKTRACE_H
> +
> +void show_instructions(struct pt_regs *regs);
> +
> +#endif /* _ASM_POWERPC_STACKTRACE_H */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index b1af3390249c..ee1d63e03c52 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -52,6 +52,7 @@
>  #include <asm/machdep.h>
>  #include <asm/time.h>
>  #include <asm/runlatch.h>
> +#include <asm/stacktrace.h>
>  #include <asm/syscalls.h>
>  #include <asm/switch_to.h>
>  #include <asm/tm.h>
> @@ -1261,7 +1262,7 @@ struct task_struct *__switch_to(struct=20=20
>=20task_struct *prev,
>
>  static int instructions_to_print =3D 16;
>
> -static void show_instructions(struct pt_regs *regs)
> +void show_instructions(struct pt_regs *regs)
>  {
>  	int i;
>  	unsigned long pc =3D regs->nip - (instructions_to_print * 3 / 4 *
> @@ -1283,8 +1284,7 @@ static void show_instructions(struct pt_regs *regs)
>  			pc =3D (unsigned long)phys_to_virt(pc);
>  #endif
>
> -		if (!__kernel_text_address(pc) ||
> -		     probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip =3D=3D pc)
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index e55ee639d010..3beca17ac1b1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -70,6 +70,7 @@
>  #include <asm/hmi.h>
>  #include <sysdev/fsl_pci.h>
>  #include <asm/kprobes.h>
> +#include <asm/stacktrace.h>
>
>  #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC_CORE)
>  int (*__debugger)(struct pt_regs *regs) __read_mostly;
> @@ -357,6 +358,8 @@ static void show_signal_msg(int signr, struct=20=20
>=20pt_regs *regs, int code,
>  	print_vma_addr(KERN_CONT " in ", regs->nip);
>
>  	pr_cont("\n");
> +
> +	show_instructions(regs);
>  }
>
>  void _exception_pkey(int signr, struct pt_regs *regs, int code,
> --
> 2.17.1
