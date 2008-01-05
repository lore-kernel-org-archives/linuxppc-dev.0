Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 28A73DDE9B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 23:12:03 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] [POWERPC] Provide a way to protect 4k subpages when
	using 64k pages
Date: Sat, 5 Jan 2008 13:11:32 +0100
References: <18303.25551.433692.29677@cargo.ozlabs.ibm.com>
In-Reply-To: <18303.25551.433692.29677@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801051311.33119.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 January 2008, Paul Mackerras wrote:
> This version allocates a new system call number for the subpage_prot
> syscall.

Ah, good. Thanks!

> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -328,3 +328,7 @@ void do_show_syscall_exit(unsigned long r3)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0printk(" -> %lx, current=3D%p cpu=3D%d\n", r3, cu=
rrent, smp_processor_id());
> =A0}
> +
> +#ifndef CONFIG_PPC_SUBPAGE_PROT
> +cond_syscall(subpage_prot);
> +#endif

cond_syscall is defined in a way that you don't need the #ifdef here,
and the other users always have it unconditionally.

> +/*
> + * Copy in a subpage protection map for an address range.
> + * The map has 2 bits per 4k subpage, so 32 bits per 64k page.
> + * Each 2-bit field is 0 to allow any access, 1 to prevent writes,
> + * 2 or 3 to prevent all accesses.
> + * Note that the normal page protections also apply; the subpage
> + * protection mechanism is an additional constraint, so putting 0
> + * in a 2-bit field won't allow writes to a page that is otherwise
> + * write-protected.
> + */
> +long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user =
*map)

syscalls are normally marked asmlinkage, right? I know that it doesn't
have an effect on powerpc, but so far, we have been using the convention
anyway, AFAIK.

Also, I think there should be a declaration in asm/syscalls.h so we don't
get a warning about an undeclared global function from sparse.

> diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
> index 11d5383..0c8b0d6 100644
> --- a/include/asm-powerpc/systbl.h
> +++ b/include/asm-powerpc/systbl.h
> @@ -313,3 +313,4 @@ COMPAT_SYS_SPU(timerfd)
> =A0SYSCALL_SPU(eventfd)
> =A0COMPAT_SYS_SPU(sync_file_range2)
> =A0COMPAT_SYS(fallocate)
> +SYSCALL(subpage_prot)

The convention I've used for SPU syscalls is to allow them unless there is
a specific reason why it's harmful or not possible for the SPU to do it.
I think it should be SYSCALL_SPU because of that.

I already missed the addition of fallocate, which I think should have been
COMPAT_SYS_SPU. I can send you a patch for that one if you like.

	Arnd <><
