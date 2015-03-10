Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 635021A0246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 20:35:44 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1F4161401AD
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2015 20:35:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Mar 2015 19:35:42 +1000
Message-ID: <1425980077.4636.265.camel@au1.ibm.com>
Subject: Re: [RFC PATCH 1/2] powerpc: Add a proper syscall for switching
 endianness
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 10 Mar 2015 20:34:37 +1100
In-Reply-To: <1425973006-22759-1-git-send-email-mpe@ellerman.id.au>
References: <1425973006-22759-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-10 at 18:36 +1100, Michael Ellerman wrote:
> We currently have a "special" syscall for switching endianness. This is
> syscall number 0x1ebe, which is handled explicitly in the 64-bit syscall
> exception entry.
> 
> That has a few problems, firstly the syscall number is outside of the
> usual range, which confuses various tools. For example strace doesn't
> recognise the syscalls at all.
> 
> Secondly it's handled explicitly as a special case in the syscall
> exception entry, which is complicated enough without it.
> 
> As a first step toward removing the special syscall, we need to add a
> regular syscall that implements the same functionality.
> 
> The logic is simple, it simply toggles the MSR_LE bit in the userspace
> MSR. This is the same as the special syscall, with the caveat that the
> special syscall clobbers fewer registers.

You can set _TIF_RESTOREALL to force a restore of all the registers on
the way back which should do the job.

Cheers,
Ben.

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/systbl.h      | 1 +
>  arch/powerpc/include/asm/unistd.h      | 2 +-
>  arch/powerpc/include/uapi/asm/unistd.h | 1 +
>  arch/powerpc/kernel/syscalls.c         | 7 +++++++
>  4 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index 91062eef582f..524bf5dff9f9 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -367,3 +367,4 @@ SYSCALL_SPU(getrandom)
>  SYSCALL_SPU(memfd_create)
>  SYSCALL_SPU(bpf)
>  COMPAT_SYS(execveat)
> +SYSCALL(switch_endian)
> diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
> index 36b79c31eedd..f4f8b667d75b 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -12,7 +12,7 @@
>  #include <uapi/asm/unistd.h>
>  
> 
> -#define __NR_syscalls		363
> +#define __NR_syscalls		364
>  
>  #define __NR__exit __NR_exit
>  #define NR_syscalls	__NR_syscalls
> diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
> index ef5b5b1f3123..e4aa173dae62 100644
> --- a/arch/powerpc/include/uapi/asm/unistd.h
> +++ b/arch/powerpc/include/uapi/asm/unistd.h
> @@ -385,5 +385,6 @@
>  #define __NR_memfd_create	360
>  #define __NR_bpf		361
>  #define __NR_execveat		362
> +#define __NR_switch_endian	363
>  
>  #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
> diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
> index b2702e87db0d..0ea01957990e 100644
> --- a/arch/powerpc/kernel/syscalls.c
> +++ b/arch/powerpc/kernel/syscalls.c
> @@ -121,3 +121,10 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
>  	return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
>  			     (u64)len_high << 32 | len_low, advice);
>  }
> +
> +long sys_switch_endian(void)
> +{
> +	current->thread.regs->msr ^= MSR_LE;
> +
> +	return 0;
> +}
