Date: Fri, 28 May 2004 16:43:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.6-7-rc1 8xx - No go
Message-ID: <20040528234313.GY6763@smtp.west.cox.net>
References: <40B6FAFB.8020803@intracom.gr> <16567.51701.749266.450133@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16567.51701.749266.450133@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, May 29, 2004 at 09:23:33AM +1000, Paul Mackerras wrote:

> Pantelis Antoniou writes:
>
> > I'm reporting that my tree, after updating from 2.6.6 -> 2.6.7-rc1
> > does not work any more.
>
> You probably need this patch.  I changed things a bit so that we get
> the full registers set dumped on an oops due to a bad address in the
> kernel.
>
> Paul.
>
> diff -urN linuxppc-2.5/arch/ppc/kernel/head_8xx.S pmac-2.5/arch/ppc/kernel/head_8xx.S
> --- linuxppc-2.5/arch/ppc/kernel/head_8xx.S	2004-05-25 21:48:41.000000000 +1000
> +++ pmac-2.5/arch/ppc/kernel/head_8xx.S	2004-05-29 09:22:18.828955856 +1000
> @@ -228,9 +228,7 @@
>  	stw	r10,_DSISR(r11)
>  	mr	r5,r10
>  	mfspr	r4,DAR
> -	stw	r4,_DAR(r11)
> -	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	EXC_XFER_EE_LITE(0x300, do_page_fault)
> +	EXC_XFER_EE_LITE(0x300, handle_page_fault)
>
>  /* Instruction access exception.
>   * This is "never generated" by the MPC8xx.  We jump to it for other
> @@ -242,7 +240,7 @@
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	mr	r4,r12
>  	mr	r5,r9
> -	EXC_XFER_EE_LITE(0x400, do_page_fault)
> +	EXC_XFER_EE_LITE(0x400, handle_page_fault)
>
>  /* External interrupt */
>  	EXCEPTION(0x500, HardwareInterrupt, do_IRQ, EXC_XFER_LITE)

It actually needs to remove that 'addi' as well.  We found that ~30
minutes ago.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
