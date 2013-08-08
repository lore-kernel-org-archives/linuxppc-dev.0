Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 260342C00A6
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 15:01:49 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 14:50:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 57ED12CE8053
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 15:01:44 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r784jrNk57212968
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 14:45:53 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7851gsB018271
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 15:01:43 +1000
Message-ID: <5203260C.4000705@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 10:31:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/9] powerpc: handle machine check in Linux host.
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093815.5389.7668.stgit@mars.in.ibm.com>
In-Reply-To: <20130807093815.5389.7668.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/2013 03:08 PM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Move machine check entry point into Linux. So far we were dependent on
> firmware to decode MCE error details and handover the high level info to OS.
> 
> This patch introduces early machine check routine that saves the MCE
> information (srr1, srr0, dar and dsisr) to the emergency stack. We allocate
> stack frame on emergency stack and set the r1 accordingly. This allows us
> to be prepared to take another exception without loosing context. One thing
> to note here that, if we get another machine check while ME bit is off then
> we risk a checkstop. Hence we restrict ourselves to save only MCE information
> and turn the ME bit on.
> 
> This is the code flow:
> 
> 		Machine Check Interrupt
> 			|
> 			V
> 		   0x200 vector				  ME=0, IR=0, DR=0
> 			|
> 			V
> 	+-----------------------------------------------+
> 	|machine_check_pSeries_early:			| ME=0, IR=0, DR=0
> 	|	Alloc frame on emergency stack		|
> 	|	Save srr1, srr0, dar and dsisr on stack |
> 	+-----------------------------------------------+
> 			|
> 		(ME=1, IR=0, DR=0, RFID)
> 			|
> 			V
> 		machine_check_handle_early		  ME=1, IR=0, DR=0
> 			|
> 			V
> 	+-----------------------------------------------+
> 	|	machine_check_early (r3=pt_regs)	| ME=1, IR=0, DR=0
> 	|	Things to do: (in next patches)		|
> 	|		Flush SLB for SLB errors	|
> 	|		Flush TLB for TLB errors	|
> 	|		Decode and save MCE info	|
> 	+-----------------------------------------------+
> 			|
> 	(Fall through existing exception handler routine.)
> 			|
> 			V
> 		machine_check_pSerie			  ME=1, IR=0, DR=0
> 			|
> 		(ME=1, IR=1, DR=1, RFID)
> 			|
> 			V
> 		machine_check_common			  ME=1, IR=1, DR=1
> 			.
> 			.
> 			.
> 
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h |   43 ++++++++++++++++++++++++++
>  arch/powerpc/kernel/exceptions-64s.S     |   50 +++++++++++++++++++++++++++++-
>  arch/powerpc/kernel/traps.c              |   12 +++++++
>  3 files changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 2386d40..c5d2cbc 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -174,6 +174,49 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  #define EXCEPTION_PROLOG_1(area, extra, vec)				\
>  	__EXCEPTION_PROLOG_1(area, extra, vec)
> 
> +/*
> + * Register contents:
> + * R12		= interrupt vector
> + * R13		= PACA
> + * R9		= CR
> + * R11 & R12 is saved on PACA_EXMC
> + *
> + * Swicth to emergency stack and handle re-entrancy (though we currently
> + * don't test for overflow). Save MCE registers srr1, srr0, dar and
> + * dsisr and then turn the ME bit on.
> + */
> +#define __EARLY_MACHINE_CHECK_HANDLER(area, label)			\
> +	/* Check if we are laready using emergency stack. */		\
> +	ld	r10,PACAEMERGSP(r13);					\
> +	subi	r10,r10,THREAD_SIZE;					\
> +	rldicr	r10,r10,0,(63 - THREAD_SHIFT);				\
> +	rldicr	r11,r1,0,(63 - THREAD_SHIFT);				\
> +	cmpd	r10,r11;	/* Are we using emergency stack? */	\
> +	mr	r11,r1;			/* Save current stack pointer */\
> +	beq	0f;							\
> +	ld	r1,PACAEMERGSP(r13);	/* Use emergency stack */	\
> +0:	subi	r1,r1,INT_FRAME_SIZE;	/* alloc stack frame */		\
> +	std	r11,GPR1(r1);						\
> +	std	r11,0(r1);		/* make stack chain pointer */	\
> +	mfspr	r11,SPRN_SRR0;		/* Save SRR0 */			\
> +	std	r11,_NIP(r1);						\
> +	mfspr	r11,SPRN_SRR1;		/* Save SRR1 */			\
> +	std	r11,_MSR(r1);						\
> +	mfspr	r11,SPRN_DAR;		/* Save DAR */			\
> +	std 	r11,_DAR(r1);						\
> +	mfspr	r11,SPRN_DSISR;		/* Save DSISR */		\
> +	std	r11,_DSISR(r1);						\
> +	mfmsr	r11;			/* get MSR value */		\
> +	ori	r11,r11,MSR_ME;		/* turn on ME bit */		\

You need to mention here the fact that we are vulnerable to a core check
stop possibility if we get another machine check exception till we set
the ME bit ON (from the occurrence of the interrupt).
