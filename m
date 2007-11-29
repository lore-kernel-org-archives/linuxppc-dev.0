Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C10CDDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 09:45:38 +1100 (EST)
Message-Id: <67128081-C2EE-4FDB-A422-0C7075B01DB4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1196373406380-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: qe: change qe_setbrg() to take an enum qe_clock instead of an
	integer
Date: Thu, 29 Nov 2007 16:45:26 -0600
References: <1196373406380-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 29, 2007, at 3:56 PM, Timur Tabi wrote:

> qe_setbrg() currently takes an integer to indicate the BRG number.   
> Change that
> to take an enum qe_clock instead, since this enum is intended to  
> represent
> clock sources.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch applies to Kumar's for-2.6.25 branch.  You might need to  
> apply my
> other patch, "qe: fix device tree lookup code in qe_muram_init()",  
> first.
>
> It's safe to change the parameters to qe_setbrg() because no one is  
> using that
> function yet.
>
> arch/powerpc/sysdev/qe_lib/qe.c |   12 +++--
> include/asm-powerpc/qe.h        |   94 ++++++++++++++++++ 
> +-------------------
> 2 files changed, 54 insertions(+), 52 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/ 
> qe_lib/qe.c
> index 298e073..8ef4690 100644
> --- a/arch/powerpc/sysdev/qe_lib/qe.c
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -167,19 +167,20 @@ unsigned int get_brg_clk(void)
>
> /* Program the BRG to the given sampling rate and multiplier
>  *
> - * @brg: the BRG, 1-16
> + * @brg: the BRG, QE_BRG1 - QE_BRG16
>  * @rate: the desired sampling rate
>  * @multiplier: corresponds to the value programmed in GUMR_L[RDCR] or
>  * GUMR_L[TDCR].  E.g., if this BRG is the RX clock, and  
> GUMR_L[RDCR]=01,
>  * then 'multiplier' should be 8.
> - *
> - * Also note that the value programmed into the BRGC register must  
> be even.
>  */
> -void qe_setbrg(unsigned int brg, unsigned int rate, unsigned int  
> multiplier)
> +void qe_setbrg(enum qe_clock brg, unsigned int rate, unsigned int  
> multiplier)
> {
> 	u32 divisor, tempval;
> 	u32 div16 = 0;
>
> +	if ((brg < QE_BRG1) || (brg > QE_BRG16))
> +		return;

seems like we should report some form of error like -EINVAL instead.

>
> +
> 	divisor = get_brg_clk() / (rate * multiplier);
>
> 	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
> @@ -196,8 +197,9 @@ void qe_setbrg(unsigned int brg, unsigned int  
> rate, unsigned int multiplier)
> 	tempval = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) |
> 		QE_BRGC_ENABLE | div16;
>
> -	out_be32(&qe_immr->brg.brgc[brg - 1], tempval);
> +	out_be32(&qe_immr->brg.brgc[brg - QE_BRG1], tempval);
> }
> +EXPORT_SYMBOL(qe_setbrg);
>
> /* Initialize SNUMs (thread serial numbers) according to
>  * QE Module Control chapter, SNUM table

- k
