Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AD6CB679E0
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 05:54:56 +1000 (EST)
Date: Fri, 14 Apr 2006 14:54:36 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Message-ID: <20060414195436.GC24769@pb15.lixom.net>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17471.62187.774127.783000@cargo.ozlabs.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
	debian-powerpc@lists.debian.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Apr 14, 2006 at 12:07:23PM -0700, Paul Mackerras wrote:
> Becky Bruce writes:
> 
> > Actually, I think the problem is that the code linux is using to turn  
> > on nap mode is not guaranteed to put the processor in nap mode by the  
> > time the blr in ppc6xx_idle occurs.
> 
> Thanks, Becky.
> 
> This patch fixes it for me.  Comments, anyone?

The bf mnemonics had me scratching my head a while, it's not listed as
a simplified mnemonic in the 64-bit PEM. Two questions below.

>  _GLOBAL(power_save_6xx_restore)
> +	tophys(r11, r1)		/* Make the idle task do a blr */
> +	lwz	r9,_LINK(r11)
> +	stw	r9,_NIP(r11)
>  	mfspr	r11,SPRN_HID0
> -	rlwinm.	r11,r11,0,10,8	/* Clear NAP & copy NAP bit !state to cr1 EQ */
> -	cror	4*cr1+eq,4*cr0+eq,4*cr0+eq
> +	rlwinm	r11,r11,0,10,8	/* Clear NAP */
>  BEGIN_FTR_SECTION
>  	rlwinm	r11,r11,0,9,7	/* Clear DOZE */
>  END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
>  	mtspr	SPRN_HID0, r11
>  
>  #ifdef DEBUG
> -	beq	cr1,1f
> +	bf	9,1f

Where is cr0 set now -- you took the dot off of rlwinm?

>  	lis	r11,(nap_return_count-KERNELBASE)@ha
>  	lwz	r9,nap_return_count@l(r11)
>  	addi	r9,r9,1
>  	stw	r9,nap_return_count@l(r11)
>  1:
>  #endif
> -	
> +
> +#ifdef CONFIG_SMP
>  	rlwinm	r9,r1,0,0,18
>  	tophys(r9,r9)
>  	lwz	r11,TI_CPU(r9)
>  	slwi	r11,r11,2
> +#else
> +	li	r11,0
> +#endif
>  	/* Todo make sure all these are in the same page
> -	 * and load r22 (@ha part + CPU offset) only once
> +	 * and load r11 (@ha part + CPU offset) only once
>  	 */
>  BEGIN_FTR_SECTION
> -	beq	cr1,1f
> +	bf	9,1f

Same comment as above w.r.t. cr0?



-Olof
