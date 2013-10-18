Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6CECB2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 10:55:30 +1100 (EST)
Message-ID: <1382140519.7979.936.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 1/6] powerpc/book3e: load critical/machine/debug
 exception stack
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 18:55:19 -0500
In-Reply-To: <1371724110-8250-2-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-2-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-20 at 18:28 +0800, Tiejun Chen wrote:
> We always alloc critical/machine/debug check exceptions. This is
> different from the normal exception. So we should load these exception
> stack properly like we did for booke.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |   49 +++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4b23119..4d8e57f 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -36,6 +36,37 @@
>   */
>  #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>  
> +/* only on book3e */
> +#define DBG_STACK_BASE		dbgirq_ctx
> +#define MC_STACK_BASE		mcheckirq_ctx
> +#define CRIT_STACK_BASE		critirq_ctx
> +
> +#ifdef CONFIG_RELOCATABLE
> +#define LOAD_STACK_BASE(reg, level)			\
> +	tovirt(r2,r2);					\
> +	LOAD_REG_ADDR(reg, level##_STACK_BASE);

Where does r2 come from here, where does it get used, and why do we need
tovirt() on book3e?

-Scott
