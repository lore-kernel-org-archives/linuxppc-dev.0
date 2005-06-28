Return-Path: <grave@ipno.in2p3.fr>
Received: from ipnmail.in2p3.fr (ipnmail.in2p3.fr [134.158.92.208])
	by ozlabs.org (Postfix) with ESMTP id 732B967B5D
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 01:01:06 +1000 (EST)
Received: from ipnnarval.in2p3.fr (ipnnarval.in2p3.fr [134.158.92.7])
	by ipnmail.in2p3.fr (8.13.4/8.13.4/IN2P3.FR) with ESMTP id
	j5SF15UW015357
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2005 17:01:05 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1119964226.28013.35.camel@ipnnarval>
References: <1119964226.28013.35.camel@ipnnarval>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 28 Jun 2005 17:01:05 +0200
Message-Id: <1119970865.28013.38.camel@ipnnarval>
Mime-Version: 1.0
Subject: Re: porting linux ppc on custom board, stuck in timer loop ?
Reply-To: grave@ipno.in2p3.fr
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

montavista 2.4.20 kernel code from preview kit boot without any
problems... Thanks to them ! I'll have a look at the 2.6.12 kernel later
once my application run on my embedded board :-)

So sorry for the previous mail...

Le mardi 28 juin 2005 à 15:10 +0200, Xavier Grave a écrit :
> Hi !
> 
> I still try to port linux ppc on our ppc405 based hardware, after a look
> at xilinx_ml300.c file that gives the list of function calls I wait for
> a call to start_kernel but I found that start_kernel is never reached...
> In fact the code in head_4xx.S jumps to 0x00001000 which is Decrementer
> exception :
> 
> 	bl	machine_init
> 	bl	MMU_init
> 	/* Go back to running unmapped so we can load up new values
>  * and change to using our exception vectors.
>  * On the 4xx, all we have to do is invalidate the TLB to clear
>  * the old 16M byte TLB mappings.
>  */
> 	lis	r4,2f@h
> 	ori	r4,r4,2f@l
> 	tophys(r4,r4) /* r4 seems to hold 0x00001000 */
> 	lis	r3,(MSR_KERNEL & ~(MSR_IR|MSR_DR))@h
> 	ori	r3,r3,(MSR_KERNEL & ~(MSR_IR|MSR_DR))@l
> 	mtspr	SPRN_SRR0,r4
> 	mtspr	SPRN_SRR1,r3
> 	rfi
> 	b	.	/*	 prevent prefetch past rfi */
> 
> the previous code jump to decrementer and the code after is never
> reached... And so start_kernel also...
> 
> /* Load up the kernel context */
> 2:
> 	sync			/* Flush to memory before changing TLB */
> 	tlbia
> 	isync			/* Flush shadow TLBs */
> 	/* set up the PTE pointers for the Abatron bdiGDB.
> 	*/
> 	lis	r6, swapper_pg_dir@h
> 	ori	r6, r6, swapper_pg_dir@l
> 	lis	r5, abatron_pteptrs@h
> 	ori	r5, r5, abatron_pteptrs@l
> 	stw	r5, 0xf0(r0)	/* Must match your Abatron config file */
> 	tophys(r5,r5)
> 	stw	r6, 0(r5)
> /* Now turn on the MMU for real! */
> 	lis	r4,MSR_KERNEL@h
> 	ori	r4,r4,MSR_KERNEL@l
> 	lis	r3,start_kernel@h
> 	ori	r3,r3,start_kernel@l
> 	mtspr	SPRN_SRR0,r3
> 	mtspr	SPRN_SRR1,r4
> 	rfi			/* enable MMU and jump to start_kernel */
> 	b	.		/* prevent prefetch past rfi */
> 
> Is this my hardware implementation that is incorrect ? Or I missed
> something in my kernel configuration ?
> 
> Thanks in advance for any answer...
> 
> xavier
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
