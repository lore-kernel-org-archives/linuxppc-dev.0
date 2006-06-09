Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DB44367C18
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 14:18:10 +1000 (EST)
Subject: Re: [PATCH 4/10 v2] Guard L3CR references with CPU_FTR_L3CR.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1149803912.23938.282.camel@cashmere.sps.mot.com>
References: <1149803912.23938.282.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 14:17:59 +1000
Message-Id: <1149826679.12687.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-06-08 at 16:58 -0500, Jon Loeliger wrote:
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Beware about this one... the CPU setup code might run before the feature
fixup in the future... you should probably do a separate setup function
for your core or go read the feature bit directly in the structure
rather than relying on the fixup mecanism.

> ---
> 
>  arch/powerpc/kernel/cpu_setup_6xx.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
> index 55ed771..365381f 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -210,9 +210,11 @@ setup_745x_specifics:
>  	 * the firmware. If any, we disable NAP capability as
>  	 * it's known to be bogus on rev 2.1 and earlier
>  	 */
> +BEGIN_FTR_SECTION
>  	mfspr	r11,SPRN_L3CR
>  	andis.	r11,r11,L3CR_L3E@h
>  	beq	1f
> +END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
>  	lwz	r6,CPU_SPEC_FEATURES(r5)
>  	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
>  	beq	1f
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
