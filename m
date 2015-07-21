Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 455C71A05FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 11:37:54 +1000 (AEST)
In-Reply-To: <1437361123-18615-1-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [V2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
Message-Id: <20150721013754.0C58A140DDA@ozlabs.org>
Date: Tue, 21 Jul 2015 11:37:53 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-20-07 at 02:58:43 UTC, Anshuman Khandual wrote:
> This patch adds one helper function 'sigcontext_vmx_regs' which computes
> quad word aligned pointer for 'vmx_reserve' array element in sigcontext
> structure making the code more readable.
> 
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index c7c24d2..bb9c939 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -74,6 +74,16 @@ static const char fmt64[] = KERN_INFO \
>  	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
>  
>  /*
> + * This computes quad word aligned pointer for 'vmx_reserve' array element
> + * which is used primarily in assigning to the preceding pointer 'v_regs'
> + * in sigcontext structure.

How about:

  * This computes a quad word aligned pointer inside the vmx_reserve array
  * element. For historical reasons sigcontext might not be quad word aligned,
  * but the location we write the VMX regs to must be. See the comment in
  * sigcontext for more detail.


> + */
> +static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
> +{
> +	return (elf_vrreg_t __user *) (((unsigned long)sc->vmx_reserve + 15) & ~0xful);
> +}

This doesn't build for ppc64e_defconfig:

  arch/powerpc/kernel/signal_64.c:82:28: error: 'sigcontext_vmx_regs' defined but not used [-Werror=unused-function]
   static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
                            ^

For now I'll just #ifdef it.

Please do a test build of ppc64e_defconfig in future.

cheers
