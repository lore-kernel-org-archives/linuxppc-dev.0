Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67C7A2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 09:14:16 +1000 (EST)
Received: from mail118-db8 (localhost [127.0.0.1])	by
 mail118-db8-R.bigfish.com (Postfix) with ESMTP id 52B863E03D4	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 23:14:10 +0000 (UTC)
Received: from DB8EHSMHS032.bigfish.com (unknown [10.174.8.232])	by
 mail118-db8.bigfish.com (Postfix) with ESMTP id DF243C004A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 23:14:08 +0000 (UTC)
Date: Tue, 25 Jun 2013 18:14:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
Subject: Re: powerpc/85xx: Move ePAPR paravirt initialization earlier
Message-ID: <20130625231404.GA29587@home.buserror.net>
References: <1362498756-395-1-git-send-email-Laurentiu.Tudor@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1362498756-395-1-git-send-email-Laurentiu.Tudor@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 05, 2013 at 05:52:36PM +0200, Laurentiu TUDOR wrote:
> From: Tudor Laurentiu <laurentiu.tudor@freescale.com>
> 
> The ePAPR para-virtualization needs to happen very early
> otherwise the bytechannel based console will silently
> drop some of the early boot messages.
> 
> Before this patch, this is how the kernel log started:
> -----------------------------------------------------
>  > Brought up 2 CPUs
>  > devtmpfs: initialized
>  > NET: Registered protocol family 16
>  [...]
> -----------------------------------------------------
> 
> After the patch the early messages show up:
> -----------------------------------------------------
>  > Using P5020 DS machine description
>  > MMU: Supported page sizes
>  >          4 KB as direct
>  >       4096 KB as direct
>  [...]
> -----------------------------------------------------
> 
> At console init, the kernel tried to flush the log buffer.
> Since the paravirt was not yet initialized the console write
> function failed silently, thus losing the buffered messages.
[snip]
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 6da881b..ce092ac 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -66,6 +66,7 @@
>  #include <asm/code-patching.h>
>  #include <asm/kvm_ppc.h>
>  #include <asm/hugetlb.h>
> +#include <asm/epapr_hcalls.h>
>  
>  #include "setup.h"
>  
> @@ -599,6 +600,8 @@ void __init setup_arch(char **cmdline_p)
>  	/* Initialize the MMU context management stuff */
>  	mmu_context_init();
>  
> +	epapr_paravirt_init();
> +
>  	kvm_linear_init();
>  
>  	/* Interrupt code needs to be 64K-aligned */

Is this early enough?  There's udbg activity before this.  Maybe it
should even go before udbg_early_init...  This would require converting
the code to use the early device tree functions.

-Scott
