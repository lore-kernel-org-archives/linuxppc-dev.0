Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18650.27350.410563.484089@cargo.ozlabs.ibm.com>
Date: Wed, 24 Sep 2008 11:29:10 -0500
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] remove bogus ppc_select syscall
In-Reply-To: <200809240839.14902.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop>
	<200809240823.12484.arnd@arndb.de>
	<200809240839.14902.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
> index f6cc7a4..5a69b32 100644
> --- a/arch/powerpc/include/asm/systbl.h
> +++ b/arch/powerpc/include/asm/systbl.h
> @@ -85,7 +85,7 @@ COMPAT_SYS_SPU(gettimeofday)
>  COMPAT_SYS_SPU(settimeofday)
>  COMPAT_SYS_SPU(getgroups)
>  COMPAT_SYS_SPU(setgroups)
> -SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
> +SYSCALL(sys_ni_syscall)

I don't see any reason to remove the old select syscall on 32-bit
kernels.  I think this hunk below is the only part of the patch that
we actually need:

> @@ -145,7 +145,7 @@ SYSCALL_SPU(setfsuid)
>  SYSCALL_SPU(setfsgid)
>  SYSCALL_SPU(llseek)
>  COMPAT_SYS_SPU(getdents)
> -SYSX_SPU(sys_select,ppc32_select,ppc_select)
> +SYSX_SPU(sys_select,ppc32_select,sys_select)

Paul.
