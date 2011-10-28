Return-Path: <xenidis@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
 [209.85.161.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E514EB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2011 07:43:57 +1100 (EST)
Received: by ggnk1 with SMTP id k1so4788353ggn.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2011 13:43:54 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
Content-Type: text/plain; charset=us-ascii
Subject: RFC: ESR_I/DLK processing
Date: Fri, 28 Oct 2011 15:43:52 -0500
Message-Id: <00A1F69B-FCB7-4F45-8BE4-4C4B35D53D59@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/kernel/head_fsl_booke.S has the following code:
> 	/* Data Storage Interrupt */
> 	START_EXCEPTION(DataStorage)
> 	NORMAL_EXCEPTION_PROLOG
> 	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass =
arg3 */
> 	stw	r5,_ESR(r11)
> 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass =
arg2 */
> 	andis.	r10,r5,(ESR_ILK|ESR_DLK)@h
> 	bne	1f
> 	EXC_XFER_EE_LITE(0x0300, handle_page_fault)
> 1:
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	EXC_XFER_EE_LITE(0x0300, CacheLockingException)


I need something similar for A2 (and all book3e) and was wondering, why =
this isn't just:

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 88abe70..8451822 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -159,6 +159,14 @@ int __kprobes do_page_fault(struct pt_regs *regs, =
unsigned long address,
>  	}
>  #endif
> =20
> +#ifdef CONFIG_PPC_BOOK3E
> +	if (error_code & (ESR_DLK|ESR_ILK)) {
> +		/* detect that this is a privileged op and SIGILL */
> +		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
> +		return 0;
> +	}
> +#endif
> +
>  	if (notify_page_fault(regs))
>  		return 0;

Its not like this need to be fast or anything.
I'd be happy to submit a patch that adds to fault.c and removed the =
I/DLK processing from head_fsl_booke.S

Thoughts?
-jx
