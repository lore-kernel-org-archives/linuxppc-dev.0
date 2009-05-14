Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C36CDDFFF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:50:13 +1000 (EST)
Subject: Re: [RFC Patch 2/6] Introduce PPC64 specific Hardware Breakpoint
	interfaces
From: Michael Ellerman <michael@ellerman.id.au>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
In-Reply-To: <20090514134439.GC14229@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134439.GC14229@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-yKZsebQMh69A1HKpjTZX"
Date: Fri, 15 May 2009 00:50:11 +1000
Message-Id: <1242312611.8608.32.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yKZsebQMh69A1HKpjTZX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-14 at 19:14 +0530, K.Prasad wrote:
> plain text document attachment (ppc64_arch_hwbkpt_implementation_02)
> Introduce PPC64 implementation for the generic hardware breakpoint interf=
aces
> defined in kernel/hw_breakpoint.c. Enable the HAVE_HW_BREAKPOINT flag and=
 the
> Makefile.

Hi, some comments inline ...


> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /dev/null
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/hw_breakpoint.c
> @@ -0,0 +1,281 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
> + *
> + * Copyright (C) 2009 IBM Corporation
> + */

Don't use (C), either use a proper =C2=A9, or just skip it. I don't know
why :)

> +/*
> + * HW_breakpoint: a unified kernel/user-space hardware breakpoint facili=
ty,
> + * using the CPU's debug registers.
> + */

This comment would normally go at the top of the file.

> +
> +#include <linux/notifier.h>
> +#include <linux/kallsyms.h>
> +#include <linux/kprobes.h>
> +#include <linux/percpu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +
> +#include <asm/hw_breakpoint.h>
> +#include <asm/processor.h>
> +#include <asm/sstep.h>
> +
> +/* Store the kernel-space breakpoint address value */
> +static unsigned long kdabr;
> +
> +/*
> + * Temporarily stores address for DABR before it is written by the
> + * single-step handler routine
> + */
> +static DEFINE_PER_CPU(unsigned long, dabr_data);

How does this relate to the existing current_dabr per-cpu variable?

> +void arch_update_kernel_hw_breakpoint(void *unused)
> +{
> +	struct hw_breakpoint *bp;
> +
> +	/* Check if there is nothing to update */
> +	if (hbp_kernel_pos =3D=3D HBP_NUM)
> +		return;

Should that be hbp_kernel_pos >=3D HBP_NUM, you're checking array bounds
right?

> +	bp =3D hbp_kernel[hbp_kernel_pos];
> +	if (bp =3D=3D NULL)
> +		kdabr =3D 0;
> +	else
> +		kdabr =3D bp->info.address | bp->info.type | DABR_TRANSLATION;
> +	set_dabr(kdabr);
> +}
> +
> +/*
> + * Install the thread breakpoints in their debug registers.
> + */
> +void arch_install_thread_hw_breakpoint(struct task_struct *tsk)
> +{
> +	set_dabr(tsk->thread.dabr);

Can we avoid setting this value if it's not necessary? It might require
an hcall. See for example what we do in __switch_to().

> +/*
> + * Check for virtual address in user space.
> + */
> +static int arch_check_va_in_userspace(unsigned long va)
> +{
> +	return (!(is_kernel_addr(va)));
> +}
> +
> +/*
> + * Check for virtual address in kernel space.
> + */
> +static int arch_check_va_in_kernelspace(unsigned long va)
> +{
> +	return is_kernel_addr(va);
> +}

You don't need these two routines. Just use is_kernel_addr() directly,
that way people will know what the code is doing without having to
lookup these new functions.

> +/*
> + * Store a breakpoint's encoded address, length, and type.
> + */

This doesn't "store" in the sense I was thinking, it actually does a
lookup and returns info in the arg.

> +int arch_store_info(struct hw_breakpoint *bp)
> +{
> +	/*
> +	 * User-space requests will always have the address field populated
> +	 * For kernel-addresses, either the address or symbol name can be
> +	 * specified.
> +	 */

Do user-space requests never have the name populated? Otherwise aren't
you overwriting the supplied address with the one from kallsyms?

> +	if (bp->info.name)
> +		bp->info.address =3D (unsigned long)
> +					kallsyms_lookup_name(bp->info.name);
> +	if (bp->info.address)
> +		return 0;
> +	return -EINVAL;
> +}
> +
> +/*
> + * Validate the arch-specific HW Breakpoint register settings
> + */
> +int arch_validate_hwbkpt_settings(struct hw_breakpoint *bp,
> +						struct task_struct *tsk)
> +{
> +	int ret =3D -EINVAL;
> +
> +	if (!bp)
> +		return ret;
> +
> +	switch (bp->info.type) {
> +	case DABR_DATA_READ:
> +		break;
> +	case DABR_DATA_WRITE:
> +		break;
> +	case DABR_DATA_RW:
> +		break;

You only need the final break here.

> +	default:
> +		return ret;
> +	}
> +
> +	if (bp->triggered)
> +		ret =3D arch_store_info(bp);

Shouldn't you check ret here, bp->info.address might be bogus.
> +
> +	/* Check for double word alignment - 8 bytes */
> +	if (bp->info.address & HW_BREAKPOINT_ALIGN)
> +		return -EINVAL;
> +
> +	/* Check that the virtual address is in the proper range */
> +	if (tsk) {
> +		if (!arch_check_va_in_userspace(bp->info.address))
> +			return -EFAULT;
> +	} else {
> +		if (!arch_check_va_in_kernelspace(bp->info.address))
> +			return -EFAULT;
> +	}

Which becomes:

is_kernel =3D is_kernel_addr(bp->info.address);
if (tsk && is_kernel || !tsk && !is_kernel)
	return -EFAULT;

> +void arch_update_user_hw_breakpoint(int pos, struct task_struct *tsk)
> +{
> +	struct thread_struct *thread =3D &(tsk->thread);
> +	struct hw_breakpoint *bp =3D thread->hbp[0];
> +
> +	if (bp)
> +		thread->dabr =3D bp->info.address	| bp->info.type |
> +				DABR_TRANSLATION;

2nd place I've seen that pattern.

> +	else
> +		thread->dabr =3D 0;
> +}
> +
> +void arch_flush_thread_hw_breakpoint(struct task_struct *tsk)
> +{
> +	struct thread_struct *thread =3D &(tsk->thread);
> +
> +	thread->dabr =3D 0;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	int rc =3D NOTIFY_STOP;
> +	struct hw_breakpoint *bp;
> +	struct pt_regs *regs =3D args->regs;
> +	unsigned long dar;
> +	int cpu, stepped, is_kernel;
> +
> +	/* Disable breakpoints during exception handling */
> +	set_dabr(0);
> +
> +	dar =3D regs->dar & (~HW_BREAKPOINT_ALIGN);
> +	is_kernel =3D (dar >=3D TASK_SIZE) ? 1 : 0;

is_kernel_addr() ?

> +	if (is_kernel)
> +		bp =3D hbp_kernel[0];
> +	else {
> +		bp =3D current->thread.hbp[0];
> +		/* Lazy debug register switching */
> +		if (!bp)
> +			return rc;

What if we keep hitting this case?

> +		rc =3D NOTIFY_DONE;
> +	}
> +
> +	(bp->triggered)(bp, regs);
> +
> +	cpu =3D get_cpu();
> +	if (is_kernel)
> +		per_cpu(dabr_data, cpu) =3D kdabr;
> +	else
> +		per_cpu(dabr_data, cpu) =3D current->thread.dabr;
> +
> +	stepped =3D emulate_step(regs, regs->nip);
> +	/*
> +	 * Single-step the causative instruction manually if
> +	 * emulate_step() could not execute it
> +	 */
> +	if (stepped =3D=3D 0) {
> +		regs->msr |=3D MSR_SE;
> +		goto out;
> +	}
> +
> +	set_dabr(per_cpu(dabr_data, cpu));
> +out:
> +	/* Enable pre-emption only if single-stepping is finished */
> +	if (stepped)
> +		put_cpu_no_resched();
> +	return rc;
> +}

Gotta run, laptop battery running out! :)

cheers


--=-yKZsebQMh69A1HKpjTZX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoML6MACgkQdSjSd0sB4dJunQCeO/3BirjWSyymV4QlJBsdGM3U
wGgAoLxJlMUZl8CfpYCg0w73+yol2xro
=HWFV
-----END PGP SIGNATURE-----

--=-yKZsebQMh69A1HKpjTZX--
