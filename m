Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-dupuy.atl.sa.earthlink.net
	(elasmtp-dupuy.atl.sa.earthlink.net [209.86.89.62])
	by ozlabs.org (Postfix) with ESMTP id 35AFBDDDE7
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 10:51:11 +1000 (EST)
Message-ID: <48892376.4060004@mindspring.com>
Date: Thu, 24 Jul 2008 20:51:02 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix compile error with binutils 2.15
References: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
In-Reply-To: <25a77ae6580f7ea388ccae2f190b1b3f7415a928.1216944498.git.segher@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
> My previous patch to fix compilation with binutils-2.17 causes
> a "file truncated" build error from ld with binutils 2.15 (and
> possibly older), and a warning with 2.16 and 2.17.
> 
> This fixes it.
> 
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

Hi Segher,

That fixes it!  Thanks very much for that.

Best regards,
Chuck

Acked-by: Chuck Meade <chuckmeade@mindspring.com>

> ---
>  arch/powerpc/kernel/vmlinux.lds.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
> index a914411..4a8ce62 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -85,7 +85,7 @@ SECTIONS
>  
>  	/* The dummy segment contents for the bug workaround mentioned above
>  	   near PHDRS.  */
> -	.dummy : {
> +	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
>  		LONG(0xf177)
>  	} :kernel :dummy
>  
