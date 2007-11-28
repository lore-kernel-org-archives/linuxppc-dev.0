Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23344DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 05:54:28 +1100 (EST)
Date: Wed, 28 Nov 2007 10:43:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: 2.6.24-rc3-mm2 - Build Failure on powerpc timerfd() undeclared
Message-Id: <20071128104345.9474025e.akpm@linux-foundation.org>
In-Reply-To: <200711281432.09178.arnd@arndb.de>
References: <20071128034140.648383f0.akpm@linux-foundation.org>
	<474D61CF.6080400@linux.vnet.ibm.com>
	<200711281432.09178.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Davide Libenzi <davidel@xmailserver.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 28 Nov 2007 14:32:07 +0100 Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 28 November 2007, Kamalesh Babulal wrote:
> > Kernel build fails, with build error
> > 
> >   CC      arch/powerpc/platforms/cell/spu_callbacks.o
> > In file included from arch/powerpc/platforms/cell/spu_callbacks.c:49:
> > include/asm/systbl.h:312: error: ‘sys_timerfd’ undeclared here (not in a function)
> > make[2]: *** [arch/powerpc/platforms/cell/spu_callbacks.o] Error 1
> > make[1]: *** [arch/powerpc/platforms/cell] Error 2
> > make: *** [arch/powerpc/platforms] Error 2
> > 
> 
> I guess all architectures except x86 are currently broken because they
> reference the old sys_timerfd function.

None of them were broken in my testing and I'm unsure why powerpc broke
here.

> This patch should add the missing
> bits to powerpc.
> 

Because the patches in -mm left the stubs in place in sys_ni.c and powerpc
_should_ have (incorrectly) picked those up.

Odd.

> 
> ---
> 
> Disclaimer: Not tested at all, just applied common sense.
> Disclaimer2: conflicts with the sys_indirect kernel implementation
> sent by paulus last week.
> 
> diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
> index 11d5383..b029368 100644
> --- a/include/asm-powerpc/systbl.h
> +++ b/include/asm-powerpc/systbl.h
> @@ -309,7 +309,9 @@ SYSCALL_SPU(getcpu)
>  COMPAT_SYS(epoll_pwait)
>  COMPAT_SYS_SPU(utimensat)
>  COMPAT_SYS_SPU(signalfd)
> -COMPAT_SYS_SPU(timerfd)
> +COMPAT_SYS_SPU(timerfd_create)
>  SYSCALL_SPU(eventfd)
>  COMPAT_SYS_SPU(sync_file_range2)
>  COMPAT_SYS(fallocate)
> +COMPAT_SYS_SPU(sys_timerfd_settime)
> +COMPAT_SYS_SPU(sys_timerfd_gettime)
> diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
> index 97d82b6..4ba2d20 100644
> --- a/include/asm-powerpc/unistd.h
> +++ b/include/asm-powerpc/unistd.h
> @@ -328,14 +328,16 @@
>  #define __NR_epoll_pwait	303
>  #define __NR_utimensat		304
>  #define __NR_signalfd		305
> -#define __NR_timerfd		306
> +#define __NR_timerfd_create	306
>  #define __NR_eventfd		307
>  #define __NR_sync_file_range2	308
>  #define __NR_fallocate		309
> +#define __NR_sys_timerfd_settime 310
> +#define __NR_sys_timerfd_gettime 311
>  
>  #ifdef __KERNEL__
>  
> -#define __NR_syscalls		310
> +#define __NR_syscalls		312
>  
>  #define __NR__exit __NR_exit
>  #define NR_syscalls	__NR_syscalls
