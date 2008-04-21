Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 0FDFBDE41F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 06:20:03 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 21 Apr 2008 22:19:59 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] ppc32: Fix errata for 603 CPUs
Message-ID: <20080421201959.GA2281@iram.es>
References: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 02:57:47PM -0500, Kumar Gala wrote:
> 603 CPUs have the same issue that some 750 CPUs have in that they can crash
> in funny ways if a store from an FPU register instruction is executed on a
> register that has never been initialized since power on.  This patch fixes
> it by making sure all FP registers have been properly initialized at kernel
> boot.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Paul, I've put this into my powerpc-next tree since its a pretty trivial
> patch.
> 
> - k
> 
>  arch/powerpc/kernel/cpu_setup_6xx.S |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
> index f1ee0b3..4a1c3cd 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -17,7 +17,14 @@
>  #include <asm/cache.h>
> 
>  _GLOBAL(__setup_cpu_603)
> -	b	setup_common_caches
> +	mflr	r4
> +BEGIN_FTR_SECTION
> +	bl	__init_fpu_registers
> +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
> +	bl	__init_fpu_registers

I don't understand that code. 

What does the second bl __init_fpu_regiters do?

As I understand it, the first one is conditional on the presence 
of an FPU (reasonable). But the secone one makes no sense.

Finally wouldn't it be simpler to initialize the FPU on all CPU
that have it? 

> +	bl	setup_common_caches
> +	mtlr	r4
> +	blr

You can use tail call elimination and save one instruction there :-)


	Regards,
	Gabriel
