Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNdct2fRTzDvwr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 08:18:54 +1100 (AEDT)
Date: Wed, 23 Nov 2016 08:18:41 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powernv: Handle wakeup from idle due to SRESET
Message-ID: <20161122211841.GB6487@fergus.ozlabs.ibm.com>
References: <1479753469-10625-1-git-send-email-ego@linux.vnet.ibm.com>
 <1479836192-21233-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479836192-21233-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2016 at 11:06:32PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The existing code doesn't handle the case when CPU which was in a
> hardware-idle state (nap,sleep,winkle on POWER8 and various stop
> states on POWER9) gets woken up due to a System Reset interrupt.
> 
> This patch checks if the CPU was woken up due to System Reset, in
> which case, after restoring the required hardware state, it jumps to
> the system reset handler.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> v1 -> v2: Set r9,r11,r12 to CR,SRR0,SRR1 values
> before jumping to system_reset_common as expected by
> EXCEPTION_PROLOG_COMMON
> 
>  arch/powerpc/kernel/idle_book3s.S | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 72dac0b..06afe0e 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -353,6 +353,22 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>  	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
>  20:	nop;
>  
> +#define CHECK_SRESET_INTERRUPT                                          \
> +BEGIN_FTR_SECTION_NESTED(67);						\
> +	mfspr	r0,SPRN_SRR1;						\
> +	rlwinm	r0,r0,45-31,0xf; /* Extract wake reason field (P8,9) */ \
> +	cmpwi	r0,0x4;		  /* System Reset ? 	*/		\
> +	bne	21f;							\
> +	ld	r1,PACAR1(r13);						\
> +	ld	r9,_CCR(r1);						\
> +	ld	r11,_NIP(r1);						\
> +	mfspr	r12, SPRN_SRR1;						\
> +	b	system_reset_common ;					\
> +	b	.; 		/* We shouldn't return here */		\
> +FTR_SECTION_ELSE_NESTED(67);						\
> +	nop		   ;						\
> +ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 67); \

What's the point of the else section?

Paul.
