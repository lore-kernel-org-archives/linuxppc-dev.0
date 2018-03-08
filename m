Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxb1z2B3MzF0yZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 14:03:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
In-Reply-To: <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
Date: Thu, 08 Mar 2018 14:03:49 +1100
Message-ID: <87efkve0a2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> We can't take a trap in most parts of real mode code. Instead of adding
> the 'notrace' annotation to all C functions that can be invoked from
> real mode, detect that we are in real mode on ftrace entry and return
> back.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> This RFC only handles -mprofile-kernel to demonstrate the approach being 
> considered. We will need to handle other ftrace entry if we decide to 
> continue down this path.

Paul and I were talking about having a paca flag for this, ie.
paca->safe_to_ftrace (or whatever). I'm not sure if you've talked to
him and decided this is a better approach.

I guess I'm 50/50 on which is better, they both have pluses and minuses.

cheers

> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> index 3f3e81852422..ecc0e8e38ead 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -56,6 +56,21 @@ _GLOBAL(ftrace_caller)
>  
>  	/* Load special regs for save below */
>  	mfmsr   r8
> +
> +	/* Only proceed if we are not in real mode and can take interrupts */
> +	andi.	r9, r8, MSR_IR|MSR_DR|MSR_RI
> +	cmpdi	r9, MSR_IR|MSR_DR|MSR_RI
> +	beq	1f
> +	mflr	r8
> +	mtctr	r8
> +	REST_GPR(9, r1)
> +	REST_GPR(8, r1)
> +	addi	r1, r1, SWITCH_FRAME_SIZE
> +	ld	r0, LRSAVE(r1)
> +	mtlr	r0
> +	bctr
> +
> +1:
>  	mfctr   r9
>  	mfxer   r10
>  	mfcr	r11
> -- 
> 2.16.1
