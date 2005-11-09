Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Wed, 9 Nov 2005 10:47:32 +0100
References: <20051107124917.C1671@cox.net> <200511081838.11236.sr@denx.de>
	<20051108153036.F27232@cox.net>
In-Reply-To: <20051108153036.F27232@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511091047.32662.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: 440EP FPU support missing
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 November 2005 23:30, Matt Porter wrote:
> On Tue, Nov 08, 2005 at 06:38:11PM +0100, Stefan Roese wrote:
> > Somehow arch/ppc/kernel/fpu.S has disappeared. :-( I assume, this
> > happened in the ppc/ppc64 -> powerpc merge. Any thoughts, why this file
> > disappeared and how to solve this problem (just restore the original
> > file)?
>
> arch/powerpc/kernel/fpu.S is being used now which doesn't have KernelFP.
> I don't know why the 44x fpu support wasn't using
> kernel_fp_unavailable_exception() before but I must have missed that
> reviewing it.
>
> Try this patch.
>
> -Matt
>
> diff --git a/arch/ppc/kernel/head_booke.h b/arch/ppc/kernel/head_booke.h
> index aeb349b..f3d274c 100644
> --- a/arch/ppc/kernel/head_booke.h
> +++ b/arch/ppc/kernel/head_booke.h
> @@ -358,6 +358,6 @@ label:
>  	NORMAL_EXCEPTION_PROLOG;					      \
>  	bne	load_up_fpu;		/* if from user, just load it up */   \
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;				      \
> -	EXC_XFER_EE_LITE(0x800, KernelFP)
> +	EXC_XFER_EE_LITE(0x800, kernel_fp_unavailable_exception)
>
>  #endif /* __HEAD_BOOKE_H__ */

Thanks Matt. That fixes the problem. Please send this patch upstream.

Best regards,
Stefan
