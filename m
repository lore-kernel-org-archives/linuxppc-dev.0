Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQk9C5Fy6zDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 20:49:51 +1100 (AEDT)
Date: Thu, 17 Mar 2016 16:21:40 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 mahesh@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH 1/3] powerpc/powernv: Move CHECK_HMI_INTERRUPT to
 exception-64s header
Message-ID: <20160317052140.GB4854@oak.ozlabs.ibm.com>
References: <1456748580-10519-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1456748580-10519-2-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456748580-10519-2-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 29, 2016 at 05:52:58PM +0530, Shreyas B. Prabhu wrote:
> CHECK_HMI_INTERRUPT is used to check for HMI's in reset vector. Move
> the macro to a common location (exception-64s.h)
> This patch does not change any functionality.

Comments below...

> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 93ae809fe5ea..0082290314eb 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -254,6 +254,25 @@ do_kvm_##n:								\
>  #define KVM_HANDLER_SKIP(area, h, n)
>  #endif
>  
> +#define CHECK_HMI_INTERRUPT						\
> +	mfspr	r0,SPRN_SRR1;						\
> +BEGIN_FTR_SECTION_NESTED(66);						\
> +	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
> +FTR_SECTION_ELSE_NESTED(66);						\
> +	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
> +ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
> +	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
> +	bne	20f;							\
> +	/* Invoke opal call to handle hmi */				\
> +	ld	r2,PACATOC(r13);					\
> +	ld	r1,PACAR1(r13);						\
> +	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
> +	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
> +	bl	opal_call_realmode;					\
> +	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
> +20:	nop;
> +
> +
>  #define NOTEST(n)

I'd rather keep NOTEST together with the definitions of KVMTEST etc.
I suggest you add this block at the end of exceptions-64s.h (just
before the final #endif).

Paul.
