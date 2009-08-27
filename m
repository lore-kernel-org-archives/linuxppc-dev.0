Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 08B04B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 13:55:06 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6722EDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 13:55:05 +1000 (EST)
Subject: Re: [PATCH] powerpc: Invoke kdump for system reset exception
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mohan@in.ibm.com
In-Reply-To: <20090824031244.GA3590@in.ibm.com>
References: <20090824031244.GA3590@in.ibm.com>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 13:54:47 +1000
Message-Id: <1251345287.20467.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kamalesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-08-24 at 08:42 +0530, M. Mohan Kumar wrote:
> Invoke kdump for system reset exception
> 
> Dump restart operation from HMC raises system reset exception
> (0x100) and xmon is invoked(even if kdump kernel is loaded). User has to
> exit from xmon by saying 'Don't recover' to invoke kdump. Modify this
> behaviour so that xmon will return immediately for system reset
> exception and kdump kernel will be invoked (if its loaded). If kdump
> kernel is not loaded, proceed with xmon

Hi Mohan !

This is not right. The way things -should- already work is that xmon
will only kick in if it's been enabled (aka initialized). This happens
normally if either:

	- CONFIG_XMON_DEFAULT is set, which forces enable it at boot. This
should not be set on distro kernels

	- The command line says xmon=early or xmon=on, in which case xmon will
be enabled during early boot (and in the case of xmon=early, you'll drop
into it early during boot, for example to get a chance to set some
breakpoints).

So on a normal distro kernel, where CONFIG_XMON_DEFAULT should not be
set (if it is, they need to fix it), xmon will not be initialized, and a
System Reset exception should trigger a kdump. If it doesn't, then
there's a bug elsewhere, but the fix isn't to modify xmon.

Cheers,
Ben.


> Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
> ---
>  arch/powerpc/xmon/xmon.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index e1f33a8..6847334 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -23,6 +23,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/bug.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/ptrace.h>
>  #include <asm/string.h>
> @@ -348,6 +349,14 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
>  	unsigned long timeout;
>  #endif
>  
> +	/*
> +	 * If the exception is 0x100 and if kexec crash image is loaded,
> +	 * continue with kexec_crash
> +	 */
> +	if (kexec_should_crash(current) && kexec_crash_image &&
> +					regs->trap == 0x100)
> +		return 0;
> +
>  	local_irq_save(flags);
>  
>  	bp = in_breakpoint_table(regs->nip, &offset);
