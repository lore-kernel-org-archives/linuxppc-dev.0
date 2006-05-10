Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFFF0679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 21:08:29 +1000 (EST)
Message-ID: <4461C8BE.4050504@dlasys.net>
Date: Wed, 10 May 2006 07:04:30 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Chris Dumoulin <cdumoulin@ics-ltd.com>
Subject: Re: Calculating virtual address from physical address
References: <200605061843.k46Ih5Vd032048@www-webmail1.magma.ca>
In-Reply-To: <200605061843.k46Ih5Vd032048@www-webmail1.magma.ca>
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
> Thanks for your reply; I found it very useful and interesting. Now, I have a whole bunch
> of questions.
>
> You said that the temporary TLB entries setup in head_4xx.S will eventually be replaced.
> Where is the code that creates these new TLB entries later on? Are the 'real' TLB entries
> only created once, and persist for as long as the system is running, or do TLB entries
> change often while the system is running?
>   
    It has been a few months since I was deep in this, so I am weaker on
details at the moment.

    But the gist is that the MMU in PowerPC's is primarily software
driven. It functions as a cache - there are alot of details, but unless
you arfe getting really deep into memory management you can think of the
MMU as a 64 entry cache. Software - in this instance the Linux VM system
is responsible for deciding exactly what happens when the cache is full
and a new entry needs added.
    Manually stuffing an entry into the MMU is safe up until that event
occurs.

    The VM system entries ("real" entries if you wish) are in Linux
Memory management data structures - page tables etc. When a page fault
occurs Linux looks up the correct entry in its tables and replaces one
in the MMU with the required one. Unlike X86's where much of this is
implimented in hardware, in a PowerPC the replacement algorithm can be
anything you want - it is written in software. Therefore handling page
faults is likely to be slower, but the OS is in total control of all
aspects of Memory management. It has very few constraints imposed on it
by the MMU.

    "Real" entries are created and destroyed inside the kernel by
anything that wants memory. Drivers demand mapping of IO based memory
typically when they initiallize and should release it when they unload.
    Programs request memory when they need it and release it when they
are done. There are subtle differences between IO memory mapping - the
virtual address for an IO mapped memory device MUST corresponf to a
specific set of addresses, while ordinary requests for a memory mapping
can be satisfied by most any block of memory.


> Do you know what state the MSR will be in at this point in the code? I know what the
> power-on reset state is, but I'm wondering if it'll be in a different state by the time we
> get to this point in head_4xx.S.
>   
    I am not sure that Linux sets the MSR at any point prior to
head_4xx.S. Regardless, greping the ppc directories within kernel source
for MSR_KERNEL will expose the bits their definitions and the normal state,
    In my instance to avoid machine checks I had to conditionally
redefine MSR_KERNEL in one header file to avoid machine checks.


> When you suggest disabling instruction or data address translation, is that just so I
> could access my hardware directly, or is there some other reason?
>   
    Atleast for me getting through the rfi to start_here: which should
be where you end up immediately after the rfi proved very difficult.

    by enabling bits one at a time I was able to test what was happening
and establish what was working. I.E if you only enable instruction
translation, you can still write to your physical IO port, but the 'rfi'
will take you to the virtual address 'start_here:'

    This was solely a debugging and problem isolation approach. It also
enabled me to test things bit by bit and assure my self that everything
worked, while loading the MSR with the default KERNEL MSR value and
executing the rfi presumes that a number of things are all setup
properly - a failure in any of them would create a problem. It is not
often in programming that a single instructions makes so many changes
all at once, and therefore in one instant requires so many of them to be
right.

    I actually wrote some code the stuffed a value at specific physical
addresses, turned on data address mapping, read the value from the
correct virtual address turned of mapping and then wrote the value to my
debug port.
    I also was able to test the TLB entry I inserted the same way.

    The bit by bit approach is just a way to figure out why you can not
get from "real" mode to "virtual" mode by dividing the problem into
small testable peices.

> You were enabling the MSR bits, one at a time, and found that the machine check was
> causing the hang (I'm assuming that's what you meant by 'sent me to space'). Was the idea
> there to just isolate what type of exception was causing the hang, or were you looking to
> make some permanent changes to the MSR? Is a machine check interrupt caused by trying to
> access an address that doesn't have a TLB entry?
>   
    Unless I am completely mistaken, machine checks are not cause by
softwded are or programming errors, they are cause by hardware problems,
or atleast by hardware reporting problems  In my instance I forwarded I
c the problem to the FPGA programmers, and disabled the machine check so
that I could move on.

    I was able to get some clues prior to my bit by bit tests. I had
established fairly quickly that instead of going to start_here that I
was getting into the exception handlers. But that mislead me into the
belief I had something worng with my memory configuration. I was not
trying to isolate the exception. Maybe I should have. I made the
asumption that the exception was programming related and therfore had
something to do with my choices regarding memory.
I was messing with the MSR to try to cut the problem into peices and
deal with each individually.

    As I understand it a machine check is generated by hardware. It is a
general purpose something bad that should nto have happened happened
with the hardware. I think it can happen if you address physical memory
that does nto exists. My theory for whatever it is worth is that I asked
the FPGA programmers to reorganize the memory map to zero org all RAM.
as I was advised that getting Linux up otherwise was going to be very
hard. I beleive that when they did that the screwed up the memory check
logic and now it is generating checks on valid accesses. But that is
just a theory. The FPGA people tell me I am wrong and that Machine check
is actually hardwired permanently to the correct level and does nothing.

    Regardless I was getting Machine Checks, and disabling them got
Linux booted. If and when the FPGA people ever figure out what is wrong
I can re-enable them in about 10 minutes.


> Can you point me to some information about Grant's platform bus changes that you were
> talking about? I am using a custom V2Pro board, and I'd be interested to see if this code
> is something I should be looking at.
>   
    Look at the changes to xilinx devices in arch/ppc/platform/4xx/
between maybe 2.6.13 and 2.6.16. There are changes elsewhere, but that
is where I tripped over them.



> Thanks alot,
> Chris
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
