Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8564EB7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 10:37:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add compat_sys_truncate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chase Douglas <cndougla@linux.vnet.ibm.com>
In-Reply-To: <8349EEAE-34B9-4D7E-837F-1320057E59D2@linux.vnet.ibm.com>
References: <8349EEAE-34B9-4D7E-837F-1320057E59D2@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 10:37:13 +1000
Message-Id: <1248655033.28464.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-07-23 at 11:12 -0400, Chase Douglas wrote:
> The truncate syscall has a signed long parameter, so when using a 32- 
> bit userspace with a 64-bit kernel the argument is zero-extended  
> instead of sign-extended. Adding the compat_sys_truncate function  
> fixes the issue.
> 
> This was noticed during an LSB truncate test failure. The test was  
> checking for the correct error number set when truncate is called with  
> a length of -1. The test can be found at:

Hi Chase !

Unfortunately, your patch have been mangled by your mailer
our your mail gateway in about every possible way (word
wrapped, tabs and whitespace damaged etc...)

I'll hand apply this time around but please, look into
fixing your setup :-)

Cheers,
Ben.

> http://bzr.linuxfoundation.org/lsb/devel/runtime-test?cmd=inventory;rev=stewb%40linux-foundation.org-20090626205411-sfb23cc0tjj7jzgm;path=modules/vsx-pcts/tset/POSIX.os/files/truncate/
> 
> Signed-off-by: Chase Douglas <cndougla@linux.vnet.ibm.com>
> 
> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/ 
> asm/systbl.h
> index 370600c..3cca167 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -95,7 +95,7 @@ SYSCALL(reboot)
> SYSX(sys_ni_syscall,compat_sys_old_readdir,sys_old_readdir)
> SYSCALL_SPU(mmap)
> SYSCALL_SPU(munmap)
> -SYSCALL_SPU(truncate)
> +COMPAT_SYS_SPU(truncate)
> SYSCALL_SPU(ftruncate)
> SYSCALL_SPU(fchmod)
> SYSCALL_SPU(fchown)
> diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/ 
> sys_ppc32.c
> index bb1cfcf..da9a65b 100644
> --- a/arch/powerpc/kernel/sys_ppc32.c
> +++ b/arch/powerpc/kernel/sys_ppc32.c
> @@ -343,6 +343,12 @@ off_t ppc32_lseek(unsigned int fd, u32 offset,  
> unsigned int origin)
>         return sys_lseek(fd, (int)offset, origin);
> }
> 
> +long compat_sys_truncate(const char __user * path, u32 length)
> +{
> +       /* sign extend length */
> +       return sys_truncate(path, (int)length);
> +}
> +
> /* Note: it is necessary to treat bufsiz as an unsigned int,
>   * with the corresponding cast to a signed int to insure that the
>   * proper conversion (sign extension) between the register  
> representation of a signed int (msr in 32-bit mode)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
