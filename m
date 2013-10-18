Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 350462C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 09:43:42 +1100 (EST)
Message-ID: <1382136213.7979.908.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 2/6] powerpc/book3e: store critical/machine/debug
 exception thread info
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 17:43:33 -0500
In-Reply-To: <1371724110-8250-3-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-3-git-send-email-tiejun.chen@windriver.com>
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
> We need to store thread info to these exception thread info like something
> we already did for PPC32.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4d8e57f..07cf657 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -67,6 +67,18 @@
>  	std	r10,PACA_##level##_STACK(r13);
>  #endif
>  
> +/* Store something to exception thread info */
> +#define	BOOK3E_STORE_EXC_LEVEL_THEAD_INFO(type)					\
> +	ld	r14,PACAKSAVE(r13);						\
> +	CURRENT_THREAD_INFO(r14, r14);						\
> +	CURRENT_THREAD_INFO(r15, r1);						\
> +	ld	r10,TI_FLAGS(r14);		     				\
> +	std	r10,TI_FLAGS(r15);			     			\
> +	ld	r10,TI_PREEMPT(r14);		     				\
> +	std	r10,TI_PREEMPT(r15);		     				\
> +	ld	r10,TI_TASK(r14);			     			\
> +	std	r10,TI_TASK(r15);

Where is "type" used?

BTW, no need for a BOOK3E prefix for things local to this file.

-Scott
