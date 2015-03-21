Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0111.outbound.protection.outlook.com [207.46.100.111])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 55C3E1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 11:47:24 +1100 (AEDT)
Message-ID: <1426898829.27998.256.camel@freescale.com>
Subject: Re: [PATCH v2 11/11] powerpc/8xx: Add support for TASK_SIZE greater
 than 0x80000000
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Fri, 20 Mar 2015 19:47:09 -0500
In-Reply-To: <20150120095736.518681A5E86@localhost.localdomain>
References: <20150120095736.518681A5E86@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 10:57 +0100, Christophe Leroy wrote:
> By default, TASK_SIZE is set to 0x80000000 for PPC_8xx, which is most likely
> sufficient for most cases. However, kernel configuration allows to set TASK_SIZE
> to another value, so the 8xx shall handle it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> v2: no change
> 
>  arch/powerpc/kernel/head_8xx.S | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index ead6448..92a6456 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -48,6 +48,19 @@
>  	mtspr	spr, reg
>  #endif
>  
> +/* Macro to test if an address is a kernel address */
> +#if CONFIG_TASK_SIZE <= 0x80000000
> +#define IS_KERNEL(tmp, addr)		\
> +	andis.	tmp, addr, 0x8000	/* Address >= 0x80000000 */
> +#define BRANCH_UNLESS_KERNEL(label)	beq	label
> +#else

This works if CONFIG_TASK_SIZE == 0x80000000, but what if it's less, and
you have a kernel address < 0x80000000?

-Scott
