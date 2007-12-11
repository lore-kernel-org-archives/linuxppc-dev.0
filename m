Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B69C0DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Dec 2007 13:17:10 +1100 (EST)
Message-ID: <475DF30A.1080202@ovro.caltech.edu>
Date: Mon, 10 Dec 2007 18:16:42 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "R. Ebersole (VTI - new)" <rje@valleytech.com>
Subject: Re: mmap + segfaults on MPC8349E
References: <475B5680.30303@valleytech.com> <475B68AE.5000302@ovro.caltech.edu>
	<475DED86.1040409@valleytech.com>
In-Reply-To: <475DED86.1040409@valleytech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

>> You haven't really provided enough information.
> 
> Sorry about that.  I grabbed one of the h/w guys to help out.

No problem. Just wanted to check the basics had been covered.
Sounds like they have.

> On the local bus frequency is 33.0 MHz. (66.0 PCI_CLK_IN).  See the 
> attached .cfg script for memory map.

It got dropped by the mailer. Don't sweat it.

>> 2. If its on the local bus, do you access it using GPCM or UPM?
>>    Have you setup either correctly?
>>    Have you confirmed the bus timing with a logic analyzer? 
> 
> GPCM.
> We have confirmed the timing both in functionality (in the debugger) and 
> with a logic analyzer (plus oscope for setup and hold times).
> We have stand-alone C-code that runs in CodeWarrior that bangs away at 
> the registers of this device and the hardware runs perfectly using the 
> .cfg script settings..

Great.

>> 3. Have you created a bus functional model of the processor bus
>>    that you have then run with your FPGA bus in ModelSim to
>>    confirm that your FPGA performs correctly. 
> 
> Yes, we have.  Also, checked in h/w (see 2 above)

Nice :)

>> 4. Have you tried burst and non-burst access by either using
>>    DMA, or treating the memory area as cacheable or non-cacheable?
>>    Have you checked those cases with simulation and then
>>    with a scope or logic analyzer?
> 
> Always non-burst at this point.

Are you sure?

When I was playing with the Yosemite board, I was having trouble
with a PCI card due to caching ... here's a code snippet from
the mmap routine of a driver:


	/* Flags to stop the processor treating PCI memory as
	 * cacheable (see asm-ppc/pgtable.h)
	 *
	 * (thanks to Travis Sawyer from the ppc-embedded list)
	 *
	 * I could have used '#ifdef CONFIG_44x', but 40x uses
	 * these flags too, as do other processors. So just check
	 * whether the flag exists.
	 *
	 * TODO:
	 * p425 Rubini; use pgprot_noncached()
	 *
	 * asm-ppc/pgtable.h defines it as setting these two flags
	 *
	 * So, that appears to be the 'portable' way to do it.
	 *
	 * drivers/char/mem.c uses pgprot_noncached()
	 */
#ifdef pgprot_noncached
	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
#endif

In that particular case, I think I wasn't seeing data transferred
to the bus until a cache flush occurred. Its possible that in your
case a burst is triggered to your hardware.

How does your BFM+simulation react to bus bursts?

Can you probe the bus when you trigger the seg-fault to see
if caching is the problem?

I'm not sure that a bus error can cause a segfault. When I
get my boards, I'll generate bus parity errors to see what
kernel routines it triggers. So, chances are this is not
the source of your error.

>> 5. Did you try running stand-alone tests in U-Boot, to go for a
>>    more bare-metal debug approach?
> 
> I assume the bare-metal debug approach is using a JTAG debugger 
> connection and CodeWarrior.  We started there and now are trying to 
> access the same device(s) via linux drivers.

Yep, sounds good.

Ok, so assuming you come back with the fact that the seg-fault
occurs without bursting. Lets take a look at your driver code.

Cheers,
Dave
