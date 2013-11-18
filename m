Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Only print PACATMSCRATCH in oops when TM is
 active
In-reply-to: <20131118131917.6718ff5b@kryten>
References: <20131118131917.6718ff5b@kryten>
Date: Mon, 18 Nov 2013 13:38:22 +1100
Message-ID: <3997.1384742302@ale.ozlabs.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> wrote:

> 
> If TM is not active there is no need to print PACATMSCRATCH
> so we can save ourselves a line.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> 
> Index: b/arch/powerpc/kernel/process.c
> ===================================================================
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -871,7 +871,8 @@ void show_regs(struct pt_regs * regs)
>  	printk("SOFTE: %ld ", regs->softe);
>  #endif
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> -	printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
> +	if (MSR_TM_ACTIVE(regs->msr))
> +		printk("\nPACATMSCRATCH: %016llx ", get_paca()->tm_scratch);
>  #endif
>  
>  	for (i = 0;  i < 32;  i++) {
> 
