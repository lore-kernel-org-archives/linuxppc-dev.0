Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C65567A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 11:25:14 +1000 (EST)
Date: Mon, 4 Apr 2005 17:09:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050404200922.GC30252@logos.cnet>
References: <20050404191718.GA30281@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050404191718.GA30281@logos.cnet>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: 8xx v2.6 TLB problems and suggested workaround
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hum,

The machine seems to be acting strange, but it boots normally 
and applications run (more importantly there is no TLB entry 
which could cause dcbst fault strangeness).

Some "dd" hangs till I press "ctrl+c", others just work. Really strange. 

G'night, I'll look at it tomorrow.
 
[root@(none) /]# time dd if=/dev/zero of=file bs=16k count=400
400+0 records in
400+0 records out
                                                                                        
real    0m4.261s
user    0m0.040s
sys     0m1.240s
[root@(none) /]# time dd if=/dev/zero of=file bs=32k count=400
                                                                                        
                                                                                        
real    0m50.369s
user    0m0.040s
sys     0m1.680s  (ctrl+c)
[root@(none) /]# 


> --- a/arch/ppc/kernel/head_8xx.S.orig	2005-04-04 19:43:23.000000000 -0300
> +++ b/arch/ppc/kernel/head_8xx.S	2005-04-04 19:47:40.000000000 -0300
> @@ -359,9 +359,7 @@
>  
>  	. = 0x1200
>  DataStoreTLBMiss:
> -#ifdef CONFIG_8xx_CPU6
>  	stw	r3, 8(r0)
> -#endif
>  	DO_8xx_CPU6(0x3f80, r3)
>  	mtspr	M_TW, r10	/* Save a couple of working registers */
>  	mfcr	r10
> @@ -390,6 +388,16 @@
>  	mfspr	r10, MD_TWC	/* ....and get the pte address */
>  	lwz	r10, 0(r10)	/* Get the pte */
>  
> +	li	r3, 0
> +	cmpw	r10, r3            /* does the pte contain a valid address? */
> +	bne	4f
> +	mfspr   r10, M_TW       /* Restore registers */
> +	lwz     r11, 0(r0)
> +	mtcr    r11
> +	lwz     r11, 4(r0)
> +	lwz	r3, 8(r0)
> +	b DataAccess
> +4:
>  	/* Insert the Guarded flag into the TWC from the Linux PTE.
>  	 * It is bit 27 of both the Linux PTE and the TWC (at least
>  	 * I got that right :-).  It will be better when we can put
> @@ -419,9 +427,7 @@
>  	lwz	r11, 0(r0)
>  	mtcr	r11
>  	lwz	r11, 4(r0)
> -#ifdef CONFIG_8xx_CPU6
>  	lwz	r3, 8(r0)
> -#endif
>  	rfi
>  
>  /* This is an instruction TLB error on the MPC8xx.  This could be due
