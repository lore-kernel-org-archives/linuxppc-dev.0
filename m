Return-Path: <SRS0=vN3B=GJ=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404dN05THFzF1YH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 01:13:48 +1100 (AEDT)
Date: Mon, 19 Mar 2018 10:13:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras
 <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Anton Blanchard <anton@samba.org>, Nicholas
 Piggin <npiggin@gmail.com>, sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Message-ID: <20180319101344.72144f30@gandalf.local.home>
In-Reply-To: <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 19 Mar 2018 14:43:00 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> index 3f3e81852422..fdf702b4df25 100644
> --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> @@ -60,6 +60,19 @@ _GLOBAL(ftrace_caller)
>  	mfxer   r10
>  	mfcr	r11
>  
> +#ifdef CONFIG_KVM
> +	lbz	r3, PACA_FTRACE_DISABLED(r13)
> +	cmpdi	r3, 0
> +	beq	1f
> +	mflr	r3
> +	mtctr	r3
> +	REST_GPR(3, r1)
> +	addi	r1, r1, SWITCH_FRAME_SIZE
> +	mtlr	r0
> +	bctr
> +1:
> +#endif

I wonder if we should try to move the return out of the fast path (for
cache reasons), as most of the time the above compare will be true. That
is:

#ifdef CONFIG_KVM
	lbz	r3, PACA_FTRACE_DISABLED(r13)
	cmpdi	r3, 0
	bne	no_trace
#endif

/* rest of ftrace_caller code */

/* after ftrace_caller... */
        bctr                    /* jump after _mcount site */

#ifdef	CONFIG_KVM
no_trace:
	mflr	r3
	mtctr	r3
	REST_GPR(3, r1)
	addi	r1, r1, SWITCH_FRAME_SIZE
	mtlr	r0
	bctr
#endif


-- Steve

> +
>  	/* Get the _mcount() call site out of LR */
>  	mflr	r7
>  	/* Save it as pt_regs->nip */
