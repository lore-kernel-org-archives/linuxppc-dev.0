Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0141.outbound.protection.outlook.com [157.56.111.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7489C1A0A07
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 13:22:58 +1100 (AEDT)
Message-ID: <1418869363.5581.123.camel@freescale.com>
Subject: Re: [v2 PATCH 2/2] powerpc/8xx: use _PAGE_RO instead of _PAGE_RW
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 17 Dec 2014 20:22:43 -0600
In-Reply-To: <20141217091432.072901A5E12@localhost.localdomain>
References: <20141217091432.072901A5E12@localhost.localdomain>
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

On Wed, 2014-12-17 at 10:14 +0100, Christophe Leroy wrote:
> On powerpc 8xx, in TLB entries, 0x400 bit is set to 1 for read-only pages
> and is set to 0 for RW pages. So we should use _PAGE_RO instead of _PAGE_RW
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> v2 is a complete rework compared to v1
> 
>  arch/powerpc/include/asm/pte-8xx.h | 7 +++----
>  arch/powerpc/kernel/head_8xx.S     | 3 ---
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pte-8xx.h b/arch/powerpc/include/asm/pte-8xx.h
> index daa4616..4f5583e 100644
> --- a/arch/powerpc/include/asm/pte-8xx.h
> +++ b/arch/powerpc/include/asm/pte-8xx.h
> @@ -46,7 +46,7 @@
>   * require a TLB exception handler change.  It is assumed unused bits
>   * are always zero.
>   */
> -#define _PAGE_RW	0x0400	/* lsb PP bits, inverted in HW */
> +#define _PAGE_RO	0x0400	/* lsb PP bits */

It looks like pte_update() needs to be updated to match.

>  #define _PAGE_USER	0x0800	/* msb PP bits */
>  /* set when neither _PAGE_USER nor _PAGE_RW are set */

Also update this comment.

>  #define _PAGE_KNLRO	0x0200
> @@ -62,9 +62,8 @@
>  #define PTE_ATOMIC_UPDATES	1
>  
>  /* We need to add _PAGE_SHARED to kernel pages */
> -#define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_KNLRO)
> -#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_KNLRO)
> -#define _PAGE_KERNEL_RW	(_PAGE_DIRTY | _PAGE_RW | _PAGE_HWWRITE)
> +#define _PAGE_KERNEL_RO	(_PAGE_SHARED | _PAGE_RO | _PAGE_KNLRO)
> +#define _PAGE_KERNEL_ROX	(_PAGE_EXEC | _PAGE_RO | _PAGE_KNLRO)
>  
>  #endif /* __KERNEL__ */
>  #endif /*  _ASM_POWERPC_PTE_8xx_H */

Where did _PAGE_KERNEL_RW go?

-Scott
