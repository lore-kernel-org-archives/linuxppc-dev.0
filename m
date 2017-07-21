Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDcT22tZ1zDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 03:00:06 +1000 (AEST)
Date: Fri, 21 Jul 2017 18:59:47 +0200
Message-ID: <20170721185947.Horde.e8_0DAuKLUb1znI0Zfx-aQ2@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 23/24] powerpc/mm: Cleanup check for stack expansion
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-23-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-23-benh@kernel.crashing.org>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:

> When hitting below a VM_GROWSDOWN vma (typically growing the stack),
> we check whether it's a valid stack-growing instruction and we
> check the distance to GPR1. This is largely open coded with lots
> of comments, so move it out to a helper.

Did you have a look at the following patch ? It's been waiting for=20=20
application=20for some weeks now.=20=20
https://patchwork.ozlabs.org/patch/771869
It=20limits number of calls to get_user()
Can you have a look and merge it with your serie ?

>
> While at it, make store_update_sp a boolean.

My patch requires a tristate here

Christophe

>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/mm/fault.c | 84=20=20
>=20++++++++++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 36 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a229fd2d82d6..c2720ebb6a62 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -71,15 +71,15 @@ static inline bool notify_page_fault(struct=20=20
>=20pt_regs *regs)
>   * Check whether the instruction at regs->nip is a store using
>   * an update addressing form which will update r1.
>   */
> -static int store_updates_sp(struct pt_regs *regs)
> +static bool store_updates_sp(struct pt_regs *regs)
>  {
>  	unsigned int inst;
>
>  	if (get_user(inst, (unsigned int __user *)regs->nip))
> -		return 0;
> +		return false;
>  	/* check for 1 in the rA field */
>  	if (((inst >> 16) & 0x1f) !=3D 1)
> -		return 0;
> +		return false;
>  	/* check major opcode */
>  	switch (inst >> 26) {
>  	case 37:	/* stwu */
> @@ -87,7 +87,7 @@ static int store_updates_sp(struct pt_regs *regs)
>  	case 45:	/* sthu */
>  	case 53:	/* stfsu */
>  	case 55:	/* stfdu */
> -		return 1;
> +		return true;
>  	case 62:	/* std or stdu */
>  		return (inst & 3) =3D=3D 1;
>  	case 31:
> @@ -99,10 +99,10 @@ static int store_updates_sp(struct pt_regs *regs)
>  		case 439:	/* sthux */
>  		case 695:	/* stfsux */
>  		case 759:	/* stfdux */
> -			return 1;
> +			return true;
>  		}
>  	}
> -	return 0;
> +	return false;
>  }
>  /*
>   * do_page_fault error handling helpers
> @@ -222,6 +222,43 @@ static bool bad_kernel_fault(bool is_exec,=20=20
>=20unsigned long error_code,
>  	return is_exec || (address >=3D TASK_SIZE);
>  }
>
> +static bool bad_stack_expansion(struct pt_regs *regs, unsigned long addr=
ess,
> +				struct vm_area_struct *vma,
> +				bool store_update_sp)
> +{
> +	/*
> +	 * N.B. The POWER/Open ABI allows programs to access up to
> +	 * 288 bytes below the stack pointer.
> +	 * The kernel signal delivery code writes up to about 1.5kB
> +	 * below the stack pointer (r1) before decrementing it.
> +	 * The exec code can write slightly over 640kB to the stack
> +	 * before setting the user r1.  Thus we allow the stack to
> +	 * expand to 1MB without further checks.
> +	 */
> +	if (address + 0x100000 < vma->vm_end) {
> +		/* get user regs even if this fault is in kernel mode */
> +		struct pt_regs *uregs =3D current->thread.regs;
> +		if (uregs =3D=3D NULL)
> +			return true;
> +
> +		/*
> +		 * A user-mode access to an address a long way below
> +		 * the stack pointer is only valid if the instruction
> +		 * is one which would update the stack pointer to the
> +		 * address accessed if the instruction completed,
> +		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
> +		 * (or the byte, halfword, float or double forms).
> +		 *
> +		 * If we don't check this then any write to the area
> +		 * between the last mapped region and the stack will
> +		 * expand the stack rather than segfaulting.
> +		 */
> +		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static bool access_error(bool is_write, bool is_exec,
>  			 struct vm_area_struct *vma)
>  {
> @@ -350,7 +387,7 @@ static int __do_page_fault(struct pt_regs *regs,=20=
=20
>=20unsigned long address,
>  	int is_user =3D user_mode(regs);
>  	int is_write =3D page_fault_is_write(error_code);
>  	int fault, major =3D 0;
> -	int store_update_sp =3D 0;
> +	bool store_update_sp =3D false;
>
>  #ifdef CONFIG_PPC_ICSWX
>  	/*
> @@ -458,36 +495,11 @@ static int __do_page_fault(struct pt_regs=20=20
>=20*regs, unsigned long address,
>  	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>  		return bad_area(regs, address);
>
> -	/*
> -	 * N.B. The POWER/Open ABI allows programs to access up to
> -	 * 288 bytes below the stack pointer.
> -	 * The kernel signal delivery code writes up to about 1.5kB
> -	 * below the stack pointer (r1) before decrementing it.
> -	 * The exec code can write slightly over 640kB to the stack
> -	 * before setting the user r1.  Thus we allow the stack to
> -	 * expand to 1MB without further checks.
> -	 */
> -	if (address + 0x100000 < vma->vm_end) {
> -		/* get user regs even if this fault is in kernel mode */
> -		struct pt_regs *uregs =3D current->thread.regs;
> -		if (uregs =3D=3D NULL)
> -			return bad_area(regs, address);
> +	/* The stack is being expanded, check if it's valid */
> +	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
> +		return bad_area(regs, address);
>
> -		/*
> -		 * A user-mode access to an address a long way below
> -		 * the stack pointer is only valid if the instruction
> -		 * is one which would update the stack pointer to the
> -		 * address accessed if the instruction completed,
> -		 * i.e. either stwu rs,n(r1) or stwux rs,r1,rb
> -		 * (or the byte, halfword, float or double forms).
> -		 *
> -		 * If we don't check this then any write to the area
> -		 * between the last mapped region and the stack will
> -		 * expand the stack rather than segfaulting.
> -		 */
> -		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> -			return bad_area(regs, address);
> -	}
> +	/* Try to expand it */
>  	if (unlikely(expand_stack(vma, address)))
>  		return bad_area(regs, address);
>
> --
> 2.13.3
