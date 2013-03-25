Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Stuart Yoder <stuart.yoder@freescale.com>
Subject: Re: [PATCH] PPC: define the conditions where the ePAPR idle hcall can
 be supported
In-reply-to: <1363979533-24485-1-git-send-email-stuart.yoder@freescale.com>
References: <1363979533-24485-1-git-send-email-stuart.yoder@freescale.com>
Date: Mon, 25 Mar 2013 11:34:04 +1100
Message-ID: <18100.1364171644@ale.ozlabs.ibm.com>
Cc: sfr@canb.auug.org.au, matt@ozlabs.org, gang.chen@asianux.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, imunsie@au1.ibm.com,
 chen.gang.flying.transformer@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stuart Yoder <stuart.yoder@freescale.com> wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> For 32-bit, CONFIG_EPAPR_PARAVIRT pulls in both epapr_paravirt.c
> and epapr_hcalls.c which contains the 32-bit paravirt idle loop.
> 
> For 64-bit, the paravirt idle loop is in idle_book3e.S and that
> source file is included only if CONFIG_PPC_BOOK3E_64 defined.
> 
> This patch makes that dependency for 64-bit explicit.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>

It works for me.  Thanks.


> ---
>  arch/powerpc/kernel/epapr_paravirt.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
> index f3eab85..d44a571 100644
> --- a/arch/powerpc/kernel/epapr_paravirt.c
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -23,8 +23,10 @@
>  #include <asm/code-patching.h>
>  #include <asm/machdep.h>
>  
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>  extern void epapr_ev_idle(void);
>  extern u32 epapr_ev_idle_start[];
> +#endif

You don't need this #ifdef

>  
>  bool epapr_paravirt_enabled;
>  
> @@ -47,11 +49,15 @@ static int __init epapr_paravirt_init(void)
>  
>  	for (i = 0; i < (len / 4); i++) {
>  		patch_instruction(epapr_hypercall_start + i, insts[i]);
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>  		patch_instruction(epapr_ev_idle_start + i, insts[i]);
> +#endif
>  	}
>  
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
>  	if (of_get_property(hyper_node, "has-idle", NULL))
>  		ppc_md.power_save = epapr_ev_idle;
> +#endif
>  
>  	epapr_paravirt_enabled = true;
>  
> -- 
> 1.7.9.7
> 
> 
