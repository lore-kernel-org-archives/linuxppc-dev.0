Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3881F2C0080
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2013 11:12:08 +1100 (EST)
Message-ID: <1360887119.22260.10.camel@pasglop>
Subject: Re: [PATCH][RFC] Replaced tlbilx with tlbwe in the initialization code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Diana Craciun <diana.craciun@freescale.com>
Date: Fri, 15 Feb 2013 11:11:59 +1100
In-Reply-To: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
References: <1360846595-3397-1-git-send-email-diana.craciun@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-02-14 at 14:56 +0200, Diana Craciun wrote:
> From: Diana Craciun <Diana.Craciun@freescale.com>
> 
> On Freescale e6500 cores EPCR[DGTMI] controls whether guest supervisor
> state can execute TLB management instructions. If EPCR[DGTMI]=0
> tlbwe and tlbilx are allowed to execute normally in the guest state.
> 
> A hypervisor may choose to virtualize TLB1 and for this purpose it
> may use IPROT to protect the entries for being invalidated by the
> guest. However, because tlbwe and tlbilx execution in the guest state
> are sharing the same bit, it is not possible to have a scenario where
> tlbwe is allowed to be executed in guest state and tlbilx traps. When
> guest TLB management instructions are allowed to be executed in guest
> state the guest cannot use tlbilx to invalidate TLB1 guest entries.

Sorry, I don't understand the explanation... can you be more detailed ?

> Linux is using tlbilx in the boot code to invalidate the temporary
> entries it creates when initializing the MMU. The patch is replacing
> the usage of tlbilx in initialization code with tlbwe with VALID bit
> cleared.
> 
> Linux is also using tlbilx in other contexts (like huge pages or
> indirect entries) but removing the tlbilx from the initialization code
> offers the possibility to have scenarios under hypervisor which are
> not using huge pages or indirect entries.
> 
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 4684e33..1f0ae33 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -1010,12 +1010,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
>  	mtspr	SPRN_MAS0,r3
>  	tlbre
>  	mfspr	r6,SPRN_MAS1
> -	rlwinm	r6,r6,0,2,0	/* clear IPROT */
> +	rlwinm	r6,r6,0,2,31	/* clear IPROT and VALID */
>  	mtspr	SPRN_MAS1,r6
>  	tlbwe
> -
> -	/* Invalidate TLB1 */
> -	PPC_TLBILX_ALL(0,R0)
>  	sync
>  	isync
>  
> @@ -1069,12 +1066,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
>  	mtspr	SPRN_MAS0,r4
>  	tlbre
>  	mfspr	r5,SPRN_MAS1
> -	rlwinm	r5,r5,0,2,0	/* clear IPROT */
> +	rlwinm	r5,r5,0,2,31	/* clear IPROT and VALID */
>  	mtspr	SPRN_MAS1,r5
>  	tlbwe
> -
> -	/* Invalidate TLB1 */
> -	PPC_TLBILX_ALL(0,R0)
>  	sync
>  	isync
>  
