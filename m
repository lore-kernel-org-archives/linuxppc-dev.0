Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 633311A000A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Jul 2014 05:51:38 +1000 (EST)
Message-ID: <53B705C7.9090208@roeck-us.net>
Date: Fri, 04 Jul 2014 12:51:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Disable RELOCATABLE for COMPILE_TEST with PPC64
References: <1404153930-26568-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1404153930-26568-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping ...

Guenter

On 06/30/2014 11:45 AM, Guenter Roeck wrote:
> powerpc:allmodconfig has been failing for some time with the following
> error.
>
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1312: Error: attempt to move .org backwards
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
>
> A number of attempts to fix the problem by moving around code have been
> unsuccessful and resulted in failed builds for some configurations and
> the discovery of toolchain bugs.
>
> Fix the problem by disabling RELOCATABLE for COMPILE_TEST builds instead.
> While this is less than perfect, it avoids substantial code changes
> which would otherwise be necessary just to make COMPILE_TEST builds
> happy and might have undesired side effects.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   arch/powerpc/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index bd6dd6e..fefe7c8 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -414,7 +414,7 @@ config KEXEC
>   config CRASH_DUMP
>   	bool "Build a kdump crash kernel"
>   	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
> -	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
> +	select RELOCATABLE if (PPC64 && !COMPILE_TEST) || 44x || FSL_BOOKE
>   	help
>   	  Build a kernel suitable for use as a kdump capture kernel.
>   	  The same kernel binary can be used as production kernel and dump
> @@ -1017,6 +1017,7 @@ endmenu
>   if PPC64
>   config RELOCATABLE
>   	bool "Build a relocatable kernel"
> +	depends on !COMPILE_TEST
>   	select NONSTATIC_KERNEL
>   	help
>   	  This builds a kernel image that is capable of running anywhere
>
