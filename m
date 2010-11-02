Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 536F7B70E6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Nov 2010 11:27:31 +1100 (EST)
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] add icswx support
In-reply-to: <1287547340.14049.25.camel@flin.austin.ibm.com>
References: <1287547340.14049.25.camel@flin.austin.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 02 Nov 2010 11:27:31 +1100
Message-ID: <2390.1288657651@neuling.org>
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>
> +
> +#ifdef CONFIG_40x
> +#define SPRN_PID	0x3B1	/* Process ID */
> +#else
> +#define SPRN_PID	0x030	/* Process ID */
> +#ifdef CONFIG_BOOKE
> +#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
> +#endif
> +#endif
> +
>  #define SPRN_CTR	0x009	/* Count Register */
>  #define SPRN_DSCR	0x11
> +#define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
>  #define SPRN_CTRLF	0x088
>  #define SPRN_CTRLT	0x098
>  #define   CTRL_CT	0xc0000000	/* current thread */
> diff --git a/arch/powerpc/include/asm/reg_booke.h
> b/arch/powerpc/include/asm/reg_booke.h
> index 667a498..5b0c781 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -150,8 +150,6 @@
>   * or IBM 40x.
>   */
>  #ifdef CONFIG_BOOKE
> -#define SPRN_PID	0x030	/* Process ID */
> -#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
>  #define SPRN_CSRR0	0x03A	/* Critical Save and Restore Register 0 */
>  #define SPRN_CSRR1	0x03B	/* Critical Save and Restore Register 1 */
>  #define SPRN_DEAR	0x03D	/* Data Error Address Register */
> @@ -168,7 +166,6 @@
>  #define SPRN_TCR	0x154	/* Timer Control Register */
>  #endif /* Book E */
>  #ifdef CONFIG_40x
> -#define SPRN_PID	0x3B1	/* Process ID */
>  #define SPRN_DBCR1	0x3BD	/* Debug Control Register 1 */		
>  #define SPRN_ESR	0x3D4	/* Exception Syndrome Register */
>  #define SPRN_DEAR	0x3D5	/* Data Error Address Register */


These PID changes should be in a separate patch.  They should be just a
cleanup that this patch can depend on.

Mikey
