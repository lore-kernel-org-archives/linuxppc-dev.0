Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BF81DDD07
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 07:48:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l71Lm8W2004596
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 17:48:08 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l71Lm7co269808
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 15:48:07 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l71Lm7Ob023607
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Aug 2007 15:48:07 -0600
Subject: Re: [PATCH] fixes for the SLB shadow buffer
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <31580.1185948147@neuling.org>
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
Content-Type: text/plain
Date: Wed, 01 Aug 2007 16:48:05 -0500
Message-Id: <1186004885.22717.50.camel@farscape.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-08-01 at 16:02 +1000, Michael Neuling wrote:
> --- linux-2.6-ozlabs.orig/arch/powerpc/kernel/entry_64.S
> +++ linux-2.6-ozlabs/arch/powerpc/kernel/entry_64.S
> @@ -389,7 +389,9 @@ BEGIN_FTR_SECTION
>  	ld	r9,PACA_SLBSHADOWPTR(r13)
>  	li	r12,0
>  	std	r12,SLBSHADOW_STACKESID(r9) /* Clear ESID */
> +	eieio
>  	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
> +	eieio
>  	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
> 
Hi Michael, 

I was going to ask if we really needed both of them, but think I
convinced myself that we do.
 
Do we also want/need an eieio after the /* Save ESID */ statement, or is
that somehow handled by the slbie following?

-Will 
