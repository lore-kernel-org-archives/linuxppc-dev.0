Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 591A1B70AF
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Mar 2011 11:43:48 +1100 (EST)
Subject: Re: [PATCH v4 1/2] add icswx support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
In-Reply-To: <1299086450.28840.9.camel@flin.austin.ibm.com>
References: <1299086450.28840.9.camel@flin.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Mar 2011 11:43:40 +1100
Message-ID: <1299199420.8833.853.camel@pasglop>
Mime-Version: 1.0
Cc: tsenglin@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-03-02 at 11:20 -0600, Tseng-Hui (Frank) Lin wrote:
> Move SPRN_PID declearations in various locations into one place.

Applied.

> Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
> 
> ---
>  arch/powerpc/include/asm/reg.h       |   10 ++++++++++
>  arch/powerpc/include/asm/reg_booke.h |    3 ---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 125fc1a..bd0d36e 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -170,6 +170,16 @@
>  #define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control */
>  
>  /* Special Purpose Registers (SPRNs)*/
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
>  #define SPRN_CTRLF	0x088
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index e68c69b..86ad812 100644
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
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
