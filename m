Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 895442C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 09:58:58 +1100 (EST)
Message-ID: <1382137119.7979.916.camel@snotra.buserror.net>
Subject: Re: [v5][PATCH 4/6] powerpc/book3e: support kgdb for kernel space
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Fri, 18 Oct 2013 17:58:39 -0500
In-Reply-To: <1371724110-8250-5-git-send-email-tiejun.chen@windriver.com>
References: <1371724110-8250-1-git-send-email-tiejun.chen@windriver.com>
 <1371724110-8250-5-git-send-email-tiejun.chen@windriver.com>
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
> Currently we need to skip this for supporting KGDB.

Does it need to depend on CONFIG_KGDB?  Either you've fixed the "can't
quite save properly" part, or you haven't.

-Scott

> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 07cf657..a286b51 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -639,11 +639,13 @@ kernel_dbg_exc:
>  	rfdi
>  
>  	/* Normal debug exception */
> +1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
> +#ifndef CONFIG_KGDB
>  	/* XXX We only handle coming from userspace for now since we can't
>  	 *     quite save properly an interrupted kernel state yet
>  	 */
> -1:	andi.	r14,r11,MSR_PR;		/* check for userspace again */
>  	beq	kernel_dbg_exc;		/* if from kernel mode */
> +#endif
>  
>  	/* Now we mash up things to make it look like we are coming on a
>  	 * normal exception
