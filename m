Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B29701007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 09:59:17 +1000 (EST)
Message-ID: <4DA78A44.1000704@windriver.com>
Date: Thu, 14 Apr 2011 19:59:00 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Shaun Ruffell <sruffell@digium.com>
Subject: Re: [PATCH] powerpc: Define 'crash_kexec_wait_realmode' for Non-SMP
	systems.
References: <20110414222719.GA16256@digium.com>
In-Reply-To: <20110414222719.GA16256@digium.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11-04-14 06:27 PM, Shaun Ruffell wrote:
> This fixes a regression from b987812b3fcaf70fdf0037589e5d2f5f2453e6ce

A fix was already sent yesterday:

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html

which relocates the stub function to where it needs to be.  Your fix
below would end up making duplicate stub functions.

Thanks,
Paul.

> "powerpc/kexec: Fix mismatched ifdefs for PPC64/SMP" which resulted in
> 
> arch/powerpc/kernel/crash.c: In function ‘default_machine_crash_shutdown’:
>   arch/powerpc/kernel/crash.c:349: error: implicit declaration of function
>   ‘crash_kexec_wait_realmode’
> 
> message on when compiling on Blue&White G3 and CONFIG_SMP is not defined.
> 
> Signed-off-by: Shaun Ruffell <sruffell@digium.com>
> ---
>  arch/powerpc/kernel/crash.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
> index 3d3d416..5e6e37f 100644
> --- a/arch/powerpc/kernel/crash.c
> +++ b/arch/powerpc/kernel/crash.c
> @@ -255,6 +255,9 @@ void crash_kexec_secondary(struct pt_regs *regs)
>  {
>  	cpus_in_sr = CPU_MASK_NONE;
>  }
> +
> +static inline void crash_kexec_wait_realmode(int cpu) {}
> +
>  #endif
>  
>  /*
