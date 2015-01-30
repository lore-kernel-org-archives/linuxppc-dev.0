Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0139.outbound.protection.outlook.com [207.46.100.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D10861A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:15:19 +1100 (AEDT)
Date: Thu, 29 Jan 2015 23:15:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [RFC,1/2] powerpc/fsl-pci: atomic get_user when pagefault_disabled
Message-ID: <20150130051501.GA14213@home.buserror.net>
References: <1416915806-24757-2-git-send-email-dahi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1416915806-24757-2-git-send-email-dahi@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 25, 2014 at 12:43:25PM +0100, David Hildenbrand wrote:
> Whenever we have pagefaults disabled, we have to use the atomic variants of
> (set|get)_user and copy_(from|to)_user.
> 
> Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
> ---
>  arch/powerpc/sysdev/fsl_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index 65d2ed4..c0af4ef 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1025,7 +1025,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
>  	if (is_in_pci_mem_space(addr)) {
>  		if (user_mode(regs)) {
>  			pagefault_disable();
> -			ret = get_user(regs->nip, &inst);
> +			ret = __get_user_inatomic(regs->nip, &inst);
>  			pagefault_enable();
>  		} else {
>  			ret = probe_kernel_address(regs->nip, inst);

Please post a non-RFC version if you're ready for this to be merged.

-Scott
