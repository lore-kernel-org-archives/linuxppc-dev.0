Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 65AD4DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 18:32:03 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cc783558d0d687131f756488692cc34b@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] [POWERPC] Check that the syscall table matches the
	syscall
Date: Thu, 3 Jan 2008 01:32:21 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hmmm, in-reply-to on the web archive is broken again, sfr alerted.

On Thu Jan 3 16:41:41 EST 2008, Stephen Rothwell wrote:

> Hopefully this will catch any out of order additions to the
> table in the future.

>  #ifdef CONFIG_PPC64
> -#define SYSCALL(func)          .llong  .sys_##func,.sys_##func
> -#define COMPAT_SYS(func)       .llong  .sys_##func,.compat_sys_##func
> -#define PPC_SYS(func)          .llong  .ppc_##func,.ppc_##func
> +#define CHECK_SYS(n)           .org .sys_call_table + n * 16
> +
> +#define SYSCALL(func)          CHECK_SYS(__NR_##func); \
> +                               .llong  .sys_##func,.sys_##func
> +#define COMPAT_SYS(func)       CHECK_SYS(__NR_##func); \
> +                               .llong  .sys_##func,.compat_sys_##func
>

While it may detect misordered additions, it does nothing to check for 
holes.   Actually, it would hide holes:  presently, if you leave a hole 
the entry you add at the end of the table will not work / crash the 
kernel.  After this patch, the hole will crash the kernel but the new 
syscall will work.

I'm still thinking this through, but perhaps instead of checking the 
numbers by org in asm, we can define another way to include the 
systable.h, possibly as a build-only check target.

Something compareing the line number to __NR_##func perhaps cpp into a 
simple awk script ...

later,
milton
