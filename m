Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C3FFDDE45
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 02:56:49 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6PGujPE006001
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 12:56:45 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6PGujVU045318
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 10:56:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6PGuijk021553
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 10:56:45 -0600
Subject: Re: [PATCH] [POWERPC] iSeries: fix section mismatch warnings
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070725092735.0a5a1c52.sfr@canb.auug.org.au>
References: <20070725092735.0a5a1c52.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 11:55:31 -0500
Message-Id: <1185382531.22237.46.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 8cdd48e..1448af9 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -809,8 +809,9 @@ system_reset_iSeries:
>  	mtmsrd	r24			/* RI on */
>  	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
>  	cmpwi	0,r24,0			/* Are we processor 0? */
> -	beq	.__start_initialization_iSeries	/* Start up the first processor */
> -	mfspr	r4,SPRN_CTRLF
> +	bne	1f
> +	b	.__start_initialization_iSeries	/* Start up the first processor */
> +1:	mfspr	r4,SPRN_CTRLF
>  	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
>  	andc	r4,r4,r5
>  	mtspr	SPRN_CTRLT,r4

This part isnt clicking for me.. 
How does changing a "beq" to a "bne" over a "b" fit into changing
__start_initialization_iSeries static?  


-Will
