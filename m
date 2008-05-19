Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 630AFDE11C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:12:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4JL9Uih025410
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 17:09:30 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4JLCr6C107414
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 15:12:53 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4JLCrcT022996
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 15:12:53 -0600
Date: Mon, 19 May 2008 16:08:45 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3 1/3] [POWERPC] Move to runtime allocated exception
	stacks
Message-ID: <20080519160845.77ebde62@zod.rchland.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805161404410.6286@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 16 May 2008 14:04:54 -0500 (CDT)
Kumar Gala <galak@kernel.crashing.org> wrote:

> For the additonal exception levels (critical, debug, machine check) on
> 40x/book-e we were using "static" allocations of the stack in the
> associated head.S.
> 
> Move to a runtime allocation to make the code a bit easier to read as
> we mimic how we handle IRQ stacks.  Its also a bit easier to setup the
> stack with a "dummy" thread_info in C code.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/head_40x.S       |   14 ++------------
>  arch/powerpc/kernel/head_44x.S       |    9 ---------
>  arch/powerpc/kernel/head_booke.h     |   29 +++++++++++------------------
>  arch/powerpc/kernel/head_fsl_booke.S |    9 ---------
>  arch/powerpc/kernel/irq.c            |   33 +++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/setup_32.c       |   24 ++++++++++++++++++++++++
>  include/asm-powerpc/irq.h            |   13 +++++++++++++
>  7 files changed, 83 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index 8552e67..ca75eaf 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -148,8 +148,8 @@ _ENTRY(crit_r11)
>  	mfcr	r10;			/* save CR in r10 for now	   */\
>  	mfspr	r11,SPRN_SRR3;		/* check whether user or kernel    */\
>  	andi.	r11,r11,MSR_PR;						     \
> -	lis	r11,critical_stack_top@h;				     \
> -	ori	r11,r11,critical_stack_top@l;				     \
> +	lis	r11,critirq_ctx@ha;					     \

You need a:

	tophys(r11,r11); \

here.  That fixes the hangs I see on my Walnut (PPC405GP) board when
using gdb.  The problem is that we're in real mode at this point, but
using the virtual address of critirq_ctx.  That seems to be a bad idea
when trying to load values out of it... ;)

> +	lwz	r11,critirq_ctx@l(r11);					     \
>  	beq	1f;							     \
>  	/* COMING FROM USER MODE */					     \
>  	mfspr	r11,SPRN_SPRG3;		/* if from user, start at top of   */\

josh
