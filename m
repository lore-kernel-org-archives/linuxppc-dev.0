Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6E8D8100A38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:13:01 +1000 (EST)
Message-ID: <1340748766.3732.29.camel@pasglop>
Subject: Re: [RFC PATCH 10/17] PowerPC: booke64: Refactor exception prolog
 for save/restore regs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 27 Jun 2012 08:12:46 +1000
In-Reply-To: <1340627195-11544-11-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-11-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-06-25 at 15:26 +0300, Mihai Caraman wrote:
> Refactor exception prolog to allow save/restore register parameters. Add
> addition none definition for exception prolog usage.
> This is needed for exceptions like Guest Doorbell that use GSRRx regsiters
> which do not map on exception type.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kernel/exceptions-64e.S |   23 ++++++++---------------
>  1 files changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 7215cc2..52aa96b 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -35,7 +35,7 @@
>  #define	SPECIAL_EXC_FRAME_SIZE	INT_FRAME_SIZE
>  
>  /* Exception prolog code for all exceptions */
> -#define EXCEPTION_PROLOG(n, type, addition)				    \
> +#define EXCEPTION_PROLOG(n, type, srr0, srr1, addition)		     	    \
>  	mtspr	SPRN_SPRG_##type##_SCRATCH,r13;	/* get spare registers */   \
>  	mfspr	r13,SPRN_SPRG_PACA;	/* get PACA */			    \
>  	std	r10,PACA_EX##type+EX_R10(r13);				    \
> @@ -44,54 +44,47 @@
>  	addition;			/* additional code for that exc. */ \
>  	std	r1,PACA_EX##type+EX_R1(r13); /* save old r1 in the PACA */  \
>  	stw	r10,PACA_EX##type+EX_CR(r13); /* save old CR in the PACA */ \
> -	mfspr	r11,SPRN_##type##_SRR1;/* what are we coming from */	    \
> +	mfspr	r11,srr1;/* what are we coming from */	    		    \
>  	type##_SET_KSTACK;		/* get special stack if necessary */\
>  	andi.	r10,r11,MSR_PR;		/* save stack pointer */	    \
>  	beq	1f;			/* branch around if supervisor */   \
>  	ld	r1,PACAKSAVE(r13);	/* get kernel stack coming from usr */\
>  1:	cmpdi	cr1,r1,0;		/* check if SP makes sense */	    \
>  	bge-	cr1,exc_##n##_bad_stack;/* bad stack (TODO: out of line) */ \
> -	mfspr	r10,SPRN_##type##_SRR0;	/* read SRR0 before touching stack */
> +	mfspr	r10,srr0;		/* read SRR0 before touching stack */

No, use the existing macro, use a ##type## specific to guest doorbells,
with appropriate definitions of the corresponding SPRN_ macros.

Cheers,
Ben.
