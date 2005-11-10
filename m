Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id CE555686EE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 21:37:57 +1100 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 3DD53280072
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 11:37:56 +0100 (CET)
Message-ID: <4373238E.8000405@cpe.fr>
Date: Thu, 10 Nov 2005 11:40:14 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
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
