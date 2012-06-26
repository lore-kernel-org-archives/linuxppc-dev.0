Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ABA35100B95
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:13:56 +1000 (EST)
Message-ID: <1340748818.3732.30.camel@pasglop>
Subject: Re: [RFC PATCH 11/17] PowerPC: booke64: Fix machine check handler
 to use the right prolog
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Wed, 27 Jun 2012 08:13:38 +1000
In-Reply-To: <1340627195-11544-12-git-send-email-mihai.caraman@freescale.com>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-12-git-send-email-mihai.caraman@freescale.com>
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
> Machine check exception handler was using a wrong prolog. Hypervisors, like
> KVM, which are called early from the exception handler rely on the interrupt
> source.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Ack.

Please separate your "core" patches from your KVM series and submit them
separately. I'll take care of the core Book3E part.

Cheers,
Ben.

> ---
>  arch/powerpc/kernel/exceptions-64e.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 52aa96b..06f7aec 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -290,7 +290,7 @@ interrupt_end_book3e:
>  
>  /* Machine Check Interrupt */
>  	START_EXCEPTION(machine_check);
> -	CRIT_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
> +	MC_EXCEPTION_PROLOG(0x200, PROLOG_ADDITION_NONE)
>  //	EXCEPTION_COMMON(0x200, PACA_EXMC, INTS_DISABLE)
>  //	bl	special_reg_save_mc
>  //	addi	r3,r1,STACK_FRAME_OVERHEAD
