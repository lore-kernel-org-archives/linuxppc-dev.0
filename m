Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27AFA679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 09:36:18 +1000 (EST)
Message-ID: <445BE15C.4080003@dlasys.net>
Date: Fri, 05 May 2006 19:35:56 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Chris Dumoulin <cdumoulin@ics-ltd.com>
Subject: Re: Calculating virtual address from physical address
References: <445B6A80.2090202@ics-ltd.com>
In-Reply-To: <445B6A80.2090202@ics-ltd.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chris Dumoulin wrote:
> My LEDs are at address 0x4F600000 and my CONFIG_KERNEL_START is 
> 0xC0000000. If this address were low enough, I would just add 0xC0000000 
> to the address to get the virtual address, but since my LED address is 
> so high, the sum will be well past the 32-bit maximum address value. How 
> is a virtual address calculated for a high address like 0x4F600000?
>   
    There are macros tophys and tovirt  that convert addresses between
physical and virtual. There are use example in the head_4xx.S file you
are already in.

    If you are going to use a port for debugging you need to create a
tlb entry for it.
    Same file in initial_mmu the code inside the if
defined(CONFIG_SERIAL_TEXT_DEBUG) should provide an example how to do that.

    Be forwarned that any entries you create now will eventually
disappear (took 2 weeks to figure that out once), but that may not
happen intil after /init starts.

    Also with a little of jiggering arround the bits in MSR_KERNEL you
can enable Data address translation independently of instruction address
translation as well as disable or enable a variety of
    checks. It took me three weeks to get a new Xilinx V4 board through
the rfi and to start_here in the same turn_on_mmu code you are working on.

    Eventually I ended up enabling the MSR bits one at a time until I
discovered that enabling the Machine Check sent me to space.

    Regardless, once I relialized I could test the code with the MSR
bits enabled one at a time isolating the problem became easier.

   
    The two issues I addressed above which relate specifically to your
efforts with the ml300, constituted more than 80% of my effort to get a
Xilinx Virtex 4 running.

    Finally, I started prior to grants platform bus changes. I have been
adapting my V4 code to fit with Grants changes (the client has what they
want so they do not care)
    I have not put alot of effort into this, but I currently get
waylayed much later in new platform bus specific initialization code.
    I had no problem with the older board specific initialization code.

    If you are running on a real ml300 I am surprised you are having any
problems though I do not have an ml300 to check that.
    But if you are running on a custom V2Pro board you have to get the
board specific initalization right and therefore could trip over the
issue I am currently having migrating from old to new.



   



> BTW, he is the assembly code that I'm working with (from 
> arch/ppc/kernel/head_4xx.S):
>
>     .text
> _GLOBAL(_stext)
> _GLOBAL(_start)
>
>     /* Save parameters we are passed.
>     */
>     mr    r31,r3
>     mr    r30,r4
>     mr    r29,r5
>     mr    r28,r6
>     mr    r27,r7
>    
>     /* CRD: set LED state here */
>     lis    r26,0x4F600000@h
>     ori    r26,r26,0x4F600000@l
>     li  r25,LED_STATE_0
>     stw r25,0(r26)
>    
>     /* We have to turn on the MMU right away so we get cache modes
>      * set correctly.
>      */
>     bl    initial_mmu
>    
>     /* CRD: set LED state here */
>     lis    r26,0x4F600000@h
>     ori    r26,r26,0x4F600000@l
>     li  r25,LED_STATE_1
>     stw r25,0(r26)
>
> /* We now have the lower 16 Meg mapped into TLB entries, and the caches
>  * ready to work.
>  */
> turn_on_mmu:
>     lis    r0,MSR_KERNEL@h
>     ori    r0,r0,MSR_KERNEL@l
>     mtspr    SPRN_SRR1,r0
>     lis    r0,start_here@h
>     ori    r0,r0,start_here@l
>     mtspr    SPRN_SRR0,r0
>     SYNC
>    
>     /* CRD: set LED state here */
>     lis    r26,0x4F600000@h
>     ori    r26,r26,0x4F600000@l
>     li  r25,LED_STATE_2
>     stw r25,0(r26)
>    
>     rfi                /* enables MMU */
>    
>     /* CRD: set LED state here */
>     /* This address should be a virtual address */
>     lis    r26,0x4F600000@h
>     ori    r26,r26,0x4F600000@l
>     li  r25,LED_STATE_3
>     stw r25,0(r26)
>    
>     b    .            /* prevent prefetch past rfi */
>
> Regards,
> Chris Dumoulin
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
