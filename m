Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 230BD1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:09:50 +1000 (AEST)
In-Reply-To: <1436178334-15496-2-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [2/2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
Message-Id: <20150716060950.0AF361402A0@ozlabs.org>
Date: Thu, 16 Jul 2015 16:09:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-07 at 10:25:34 UTC, Anshuman Khandual wrote:
> This patch adds one helper function 'vmx_reserve_addr' which computes
> quad word aligned pointer for vmx_reserve array element in sigcontext
> structure making the code more readable.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/signal_64.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index c7c24d2..e8762f5 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -73,6 +73,12 @@ static const char fmt32[] = KERN_INFO \
>  static const char fmt64[] = KERN_INFO \
>  	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
>  
> +static elf_vrreg_t __user *vmx_reserve_addr(struct sigcontext __user *sc)
> +{
> +		return (elf_vrreg_t __user *)
> +			(((unsigned long)sc->vmx_reserve + 15) & ~0xful);

You have more tabs here than you need. Please put it on one line, I don't care
if it's a bit more than 80 chars.

Please add a comment describing what it's doing and why.

Also I think I'd prefer if it was named sigcontext_vmx_regs() or something more
like that, ie. it's about sigcontext primarily.

cheers
