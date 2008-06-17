Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8983BDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 08:38:09 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5HMc6Zt015331
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:38:06 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5HMc6YJ123188
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:38:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5HMc6Pj014217
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 18:38:06 -0400
Date: Tue, 17 Jun 2008 18:36:08 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Re: [PATCH] [POWERPC] 4xx: Clear new TLB cache attribute bits in
	Data Storage vector
Message-ID: <20080617183608.4f61e6e8@zod.rchland.ibm.com>
In-Reply-To: <20080617183439.63d2aa3c@zod.rchland.ibm.com>
References: <20080617183439.63d2aa3c@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jun 2008 18:34:39 -0400
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> A recent commit added support for the new 440x6 and 464 cores that have the
> added WL1, IL1I, IL1D, IL2I, and ILD2 bits for the caching attributes in the
> TLBs.  The new bits were cleared in the finish_tlb_load function, however a
> similar bit of code was missed in the DataStorage interrupt vector.
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Paul,  this needs to go into 2.6.26.  Do you have anything else queued
up at the moment, or should I put this in my tree and ask Linus to pull
it in?

Sorry for the late fix.  It was just noticed today.

josh

> ---
>  arch/powerpc/kernel/head_44x.S |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
> index c2b9dc4..22b5d2c 100644
> --- a/arch/powerpc/kernel/head_44x.S
> +++ b/arch/powerpc/kernel/head_44x.S
> @@ -368,7 +368,12 @@ interrupt_base:
>  
>  	rlwimi	r11,r13,0,26,31		/* Insert static perms */
>  
> -	rlwinm	r11,r11,0,20,15		/* Clear U0-U3 */
> +	/*
> +	 * Clear U0-U3 and WL1 IL1I IL1D IL2I IL2D bits which are added
> +	 * on newer 440 cores like the 440x6 used on AMCC 460EX/460GT (see
> +	 * include/asm-powerpc/pgtable-ppc32.h for details).
> +	 */
> +	rlwinm	r11,r11,0,20,10
>  
>  	/* find the TLB index that caused the fault.  It has to be here. */
>  	tlbsx	r10, 0, r10
