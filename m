Return-Path: <SRS0=Vxku=F5=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxLfL1WggzF0Pq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 04:45:58 +1100 (AEDT)
Date: Wed, 7 Mar 2018 12:45:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Anton Blanchard
 <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/1] powerpc/ftrace: Exclude real mode code from
Message-ID: <20180307124553.312ea88c@vmware.local.home>
In-Reply-To: <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
 <ecbf7e8d6895a7d56b4eb60cbf7461bd463086b3.1520435958.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  7 Mar 2018 22:16:19 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

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

I do prefer this trade off.


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

OK, I assume this check and branch is negligible compared to the mfmsr
call?

-- Steve


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
