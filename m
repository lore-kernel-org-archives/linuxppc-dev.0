Return-Path: <dhlii@comcast.net>
Received: from sccrmhc12.comcast.net (sccrmhc12.comcast.net [204.127.202.56])
	by ozlabs.org (Postfix) with ESMTP id B54FF6873F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Nov 2005 20:37:05 +1100 (EST)
Message-ID: <437C4E07.8020307@comcast.net>
Date: Thu, 17 Nov 2005 04:31:51 -0500
From: "David H. Lynch Jr." <dhlii@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <437308E6.2070804@ecrin.com>
In-Reply-To: <437308E6.2070804@ecrin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: "Now booting the kernel"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having similar difficulties on a Xilinx Virtex 4.

    I have some advantages over Nitesh in that I have a 32bit port at 
0x70000000 that I can write values to and see what they are (at least 
until the MMU is enabled)
    and with some additional complexity use as a sort of UART to write text.
   
    Thus far this is what I get:

Starting MonitorX.elf: V3.3.2.0.
Loading zImage.elf.

loaded at:     00400000 0048C138
board data at: 0048A124 0048A138
relocated to:  004050AC 004050C0
zimage at:     00405865 00489E79
avail ram:     0048D000 08000000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel

After that I am in arch/ppc/kernel/head_4xx.S and only get output from 
my debug port.
I have used that to determine as follows:

    B1B1B1B1                                         - @head_4xx.S
    00058001                                           - @initial_mmu
    C0000000                                          - output Virtual 
Address of KERNELBASE
    00000000                                           - output physical 
address of KERNELBASE
    00057003                                           - @setup tlb 
entry for debug console
    70000000                                           - physical 
address of memory to create tlb for debug console (same as debug port)
    00057002                                           - @turn_on_mmu
    00021032                                           - MSR Machine 
status register
   C00022A0                                           - virtual address 
of start_here
   40000000                                             - physical 
address of start_here ??? shouldn't this be 000022A0 ?
   
I can trace right up to the rfi that kicks the processor into virtual mode.
The very first thing I have done at start_here is write a unique value 
to my debug  - I never see that.

That should mean either:
          I do not have the correct tlb entry to enable my debug port to 
work once the MMU is enabled
          or
          I am not getting to start_here.

Interestingly I also output identifiers for exceptions - and I am 
getting repeated DTLB miss exceptions - all for address FFB13458

I also did memory dumps of what I thought were interesting regions at 
the end of load_kernel

The dump of 0x0 looks very much like the start of head_4xx.S - the  
signature values I am writing to my debug port (as well as the address 
of the debug port itself) all in close proximity
are tty good clues.

the dump of 0x400000 looks like the start of arch/ppc/boot/simple/head.S 
which is what I would expect.

the dump of 0x22a0 looks like start_here.


The only thing I see that seems to be wrong is that if I use tophys() to 
try to convert start_here to a physical address I don't think I should 
get 0x40000000
For reference a snippet of my debug output code is below.

             lis     r14,0x7000                                       // 
high address of debug port
             lis     r0,0x5
             ori    r0,r0,0x7002                          
             stw   r0,4(r14)
             eieio                                                      
   // output 0x57002

             lis     r0,start_here@h                                // 
output start_here (virtual)
             ori     r0,r0,start_here@l
             stw     r0,4(r14)
             eieio
   
             tophys  (r0,r0);                                          
// output start_here physical
             stw     r0,4(r14)
             eieio


Help !?
