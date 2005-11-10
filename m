Return-Path: <rmcguire@uwbt.com>
Received: from mail19b.g19.rapidsite.net (mail19b.dulles19-verio.com
	[204.202.242.88]) by ozlabs.org (Postfix) with SMTP id 676CB6868F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Nov 2005 08:17:12 +1100 (EST)
Received: from mx32.stngva01.us.mxservers.net (204.202.242.10)
	by mail19b.g19.rapidsite.net (RS ver 1.0.95vs) with SMTP id
	3-0235457428 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 16:17:10 -0500 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 10 Nov 2005 13:16:59 -0800
Message-ID: <000001c5e63c$170c8590$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20051110145136.3E4EC68715@ozlabs.org>
Subject: 82xxHCI driver for MPC8280 Specifically
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

I have been trying to get the 82xxHCI driver to work on our protoboard and
after a lot of correspondence with Freescale FAE's there are some real
differences in code implementation for some CPU parts.

Our board is using a MPC8280 Rev 0.1 part, the Rev number of course is the
last bit of the IMMR register. So 0xXXXX0A01 is our CPU, the 0A is all 8280
parts.

I was curious if anyone else has gotten this driver to operation
specifically on an 8280 CPU. Freescale says that ALL 8280's do NOT NEED any
microcode patch only some Rev's only need hardware workarounds to generate
the SOF packets, mainly wiring a BRG or TIMER to the DREQ1 / 4 lines at
least for Rev 0.0 and Rev 0.1. Rev A parts do not need this, as it is all
working internally, guess they finally fixed it.

This documentation is not conclusive as to how to wire and setup the DREQ
lines, and is no longer available on their websites, I have the PDF file
entitled MPC8280UMAD_D.pdf if anyone is curious about Rev 0.0 and Rev 0.1
parts.

So help, has anyone got this working with the Rev 0.0 and Rev 0.1 parts, and
if so, how? I have been spending way to much time reading and hacking code
to this barely functional. I would be happy to send anyone the code I have
currently, if they want to start in on this.

Russell McGuire

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of
linuxppc-embedded-request@ozlabs.org
Sent: Thursday, November 10, 2005 6:52 AM
To: linuxppc-embedded@ozlabs.org
Subject: Linuxppc-embedded Digest, Vol 15, Issue 21

Send Linuxppc-embedded mailing list submissions to
	linuxppc-embedded@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
or, via email, send a message with subject or body 'help' to
	linuxppc-embedded-request@ozlabs.org

You can reach the person managing the list at
	linuxppc-embedded-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-embedded digest..."


Today's Topics:

   1. Re: [PATCH 2.6.14] mm: 8xx MM fix for (David Jander)
   2. PowerPC reservations (Kalle Pokki)
   3. Re: "Now booting the kernel" (Nathael PAJANI)
   4. floating point  + kernel (PPC) (srideep.devireddy@wipro.com)
   5. SCC QMC driver for 8247 (Robin Mathew)
   6. Re: "Now booting the kernel" (Nathael PAJANI)
   7. Re: [PATCH] ppc32 8xx: MPC8xx PCMCIA update (Dominik Brodowski)


----------------------------------------------------------------------

Message: 1
Date: Thu, 10 Nov 2005 10:18:07 +0200
From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
To: linuxppc-embedded@ozlabs.org
Message-ID: <200511100918.08060.david.jander@protonic.nl>
Content-Type: text/plain;  charset="iso-8859-1"

On Thursday 10 November 2005 08:48, David Jander wrote:
>[...]
> Hmmm. This is a lot in the line of the tests I did with (the more generic
> benchmark) nbench. After looking at those results (see my other post in
> this thread) I already suspected something like this.

Sorry, I obviously did not mean this thread, but the following post on
another 
thread:

http://ozlabs.org/pipermail/linuxppc-embedded/2005-November/020775.html

Regards,

-- 
David Jander


------------------------------

Message: 2
Date: Thu, 10 Nov 2005 10:20:30 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
Subject: PowerPC reservations
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <437302CE.8070309@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hi,

Can someone please help me understand how the memory reservations in 
PowerPC actually work. Let's just assume uniprocessor with a pre-emptive 
scheduler, and take a text-book example of an atomic increment case, 
which is also frequently used in e.g. the Linux kernel. With two atomic 
operations, everything seems to be just fine. But how about with three 
concurrent threads of execution?

 From the following code, assume r3 contains the same address for each 
incrementing operation. If the first atomic increment is pre-empted  in 
the middle, execution then jumps to the second increment (by the 
scheduler). The second increment runs through and succeeds, and 
continues straight to the third increment. Then it is again pre-empted 
in the middle, execution returning to the first increment. Now the 
processor has the reservation with the correct address, and the first 
increment succeeds when still holding the original input value. The 
first and the second increment thus write the same value in memory. 
After the first increment, the scheduler again continues the third 
increment, which doesn't succeed a first, but the second round succeeds. 
However, the value in the address pointed by r3 was not increased by 
three, but by two.

Am I just not getting how this is really supposed to work? Are there 
still some other constructs in use to prevent this, e.g. extra stwcx. 
instructions when changing the thread of execution?

I'm also wondering why the architecture specifically defines the stwcx. 
instruction to have, well, undefined behavior in case the reservation 
address differs from the address of the previous lwarx...

1:      lwarx r6, r0, r3
        addi r6, r6, 1
        stwcx. r6, r0, r3
        bne- 1b

.....

2:      lwarx r7, r0, r3
        addi r7, r7, 1
        stwcx. r7, r0, r3
        bne- 2b

3:      lwarx r8, r0, r3
        addi r8, r8, 1
        stwcx. r8, r0, r3
        bne- 3b




------------------------------

Message: 3
Date: Thu, 10 Nov 2005 11:40:14 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
Subject: Re: "Now booting the kernel"
To: linuxppc-embedded@ozlabs.org
Message-ID: <4373238E.8000405@cpe.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

(Sorry, I first replyed with the wrong mail address)

 >Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw
 >Uncompressing Linux...done.
 >Now booting the kernel

Hi!

At this state the bootloader stops executing and the Linux Kernel 
starts. The problem is that the Linux kernel does not know yet how to 
use the serial.

You won't have any message before it is set up (in early-console if my 
memory is allright)

So what you can do to check what's going on, is put "breakpoints" in the 
boot sequence. This means in the file arch/ppc/kernel/head*.S used for 
your board you should try to comment the line with the "tlbwe" 
instruction in the section "/* 2. Invalidate all entries except the 
entry we're executing in */"
This will allow you to keep access to your board registers.

Then you go step by step, putting some code which will reboot the board 
when executed, so you know you're going up to that point, and then move 
the "breakpoint" further.

This code does the reboot (for the booke I can reboot the board by 
writting '4' at address 0xfa001001):

ASM:
   lis r4,0xfa00
   li  r5,4
   stb r5,0x1001(r4)
   msync

C:
*((volatile unsigned char*)0xfa001001 = 4;


This way, instead of hanging up, the board reboots and you know where 
you are.

If you're going up to this:
         bl      machine_init    /* arch/ppc/kernel/setup.c */
         bl      MMU_init    /* arch/ppc/mm/init.c */
It's quite good, these are C functions, but they are processor specific, 
once again, check that the ones used (compiled) are those you need.

And next you've got the "start_kernel" call, which leads you to C code 
definitely. It's in init/main.c.


I hope I did not tell anything wrong, and that this will help.

Have fun.
Nathael.


------------------------------

Message: 4
Date: Thu, 10 Nov 2005 18:07:31 +0530
From: <srideep.devireddy@wipro.com>
Subject: floating point  + kernel (PPC)
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
	<6AD9F6A5F6E096408F0B703773355A07605C40@CHN-SNR-MBX01.wipro.com>
Content-Type: text/plain; charset="us-ascii"


Thanks for your help friends ...



     I am able to bring my kernel up ...... right now I have a problem
after some time at the console .... I get floating point used in kernel
(task=C0188480,pc=1100)



10.0.0.2 login: root

Last login: Tnhu Jan  1 00:00sole

Linux 10.0.0.2 2.4.22 #1 Tue Nov 8 12:03:26 UTC 2005 ppc unknown




MontaVista(R) Linux(R) Professional Edition 3.1




root@10.0.0.2:~# <mailto:root@10.0.0.2:~> 



root@10.0.0.2:/home# cd ..

root@10.0.0.2:/# ls

bin  boot  dev  etc  home  lib  mnt  opt  proc  root  sbin  tmp  usr
var

root@10.0.0.2:/# floating point used in kernel (task=c0188480, pc=1100)





What does this mean ...? This makes the console hang .....Can any 1 help
me on in this?



Best Regards

srideep






Confidentiality Notice

The information contained in this electronic message and any attachments to
this message are intended
for the exclusive use of the addressee(s) and may contain confidential or
privileged information. If
you are not the intended recipient, please notify the sender at Wipro or
Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
-------------- next part --------------
An HTML attachment was scrubbed...
URL:
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20051110/30c43a42/
attachment-0001.htm

------------------------------

Message: 5
Date: Thu, 10 Nov 2005 20:18:48 +0530
From: Robin Mathew <robin@india.tejasnetworks.com>
Subject: SCC QMC driver for 8247
To: Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Cc: Nicholas Basker <nbasker@india.tejasnetworks.com>
Message-ID: <43735DD0.9030205@india.tejasnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Hello:

We are working on implementing driver for SCC operating in QMC mode that 
supports multiple HDLC channels. The details of the system we are using 
are the following.

CPU Version = 8247 based on 82xx family of processor(PVR 80822014)
The Linux OS Version = DENKS Linux version 2.4.20.
The Peripherals used are = FCC1 in 10/100 ethernet
                                            FCC2 in 10/100 ethernet
                                            SCC1 currently not used, but 
proposed to be used in HDLC mode.
                                            SCC3 is not used.
                                            SCC4 operating in QMC mode 
with super -channel capability. Trying to operate 192kbps HDLC channel 
(using 3x64kbps QMC channels).
                                            SMC2 in UART mode (as a 
simple debug port without any modem signals).
                                            SPI interface currently not 
used but shall be used in future.
                                            I2C is being used.

01. Can the channel specific parameters of the SCC4 in QMC mode be 
relocated from DPRAM base address?? There is no mention in the 
8272RM.pdf about configuring the base address of channel specific 
parameters. From the QMC memory structure diagram, it looks like the 
channel specific parameters will be taken from the the DPRAM base 
address. Can you please confirm it?

02. We have changed the function m8260_cpm_dpalloc() used for DPRAM 
allocation in the linux source code. It was allocating memory from 
128Byte location to 8KByte location in DPRAM. But since QMC requires the 
lower 4KByte for channel specific parameters, we changed the function to 
allocate DPRAM from 4KByte location. Will this change lead to any 
problem for proper linux operation?

03. We are encountering a strange problem with scc4 parameter RAM. When 
the driver is coming up, its trying to initialize the SCC4 parameter RAM 
for QMC. In the location (immr + 0x8318), we are writing the value 
0x8320 but the value magically changes to 0x8300. We tried to write to 
the location using BDI and again the problem is seen. Is this a known 
problem with the processor?? This problem doesnot appear everytime. Is 
there any known cause for this problem?

Regards,
Robin


------------------------------

Message: 6
Date: Thu, 10 Nov 2005 09:46:30 +0100
From: Nathael PAJANI <nathael.pajani@ecrin.com>
Subject: Re: "Now booting the kernel"
To: linuxppc-embedded@ozlabs.org
Message-ID: <437308E6.2070804@ecrin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

 >Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part2 rw
 >Uncompressing Linux...done.
 >Now booting the kernel

Hi!

At this state the bootloader stops executing and the Linux Kernel 
starts. The problem is that the Linux kernel does not know yet how to 
use the serial.

You won't have any message before it is set up (in early-console if my 
memory is allright)

So what you can do to check what's going on, is put "breakpoints" in the 
boot sequence. This means in the file arch/ppc/kernel/head*.S used for 
your board you should try to comment the line with the "tlbwe" 
instruction in the section "/* 2. Invalidate all entries except the 
entry we're executing in */"
This will allow you to keep access to your board registers.

Then you go step by step, putting some code which will reboot the board 
when executed, so you know you're going up to that point, and then move 
the "breakpoint" further.

This code does the reboot (for the booke I can reboot the board by 
writting '4' at address 0xfa001001):

ASM:
   lis r4,0xfa00
   li  r5,4
   stb r5,0x1001(r4)
   msync

C:
*((volatile unsigned char*)0xfa001001 = 4;


This way, instead of hanging up, the board reboots and you know where 
you are.

If you're going up to this:
         bl      machine_init	/* arch/ppc/kernel/setup.c */
         bl      MMU_init	/* arch/ppc/mm/init.c */
It's quite good, these are C functions, but they are processor specific, 
once again, check that the ones used (compiled) are those you need.

And next you've got the "start_kernel" call, which leads you to C code 
definitely. It's in init/main.c.


I hope I did not tell anything wrong, and that this will help.

Have fun.
Nathael.


------------------------------

Message: 7
Date: Thu, 10 Nov 2005 11:03:04 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH] ppc32 8xx: MPC8xx PCMCIA update
To: Paul Mackerras <paulus@samba.org>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20051110100304.GA21855@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii

Hi,

On Mon, Nov 07, 2005 at 12:03:45PM +1100, Paul Mackerras wrote:
> Marcelo Tosatti writes:
> 
> > The following patch updates the MPC8xx PCMCIA driver:
> 
> This and the following patch look OK as far as I can tell - Dominik,
> will you take care of sending them to Linus?

Yes, will do.

Thanks,
	Dominik


------------------------------

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

End of Linuxppc-embedded Digest, Vol 15, Issue 21
*************************************************
