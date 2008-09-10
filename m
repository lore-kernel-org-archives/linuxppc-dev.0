Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	by ozlabs.org (Postfix) with ESMTP id E3748DDF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Sep 2008 10:51:08 +1000 (EST)
Message-ID: <48C85AF9.3060106@bucknell.edu>
Date: Wed, 10 Sep 2008 19:40:41 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Re: Re: PCI support on the ML310 (Linux 2.4/2.6) (Juliana Su)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "Huang, Bin" <bhuang2@uncc.edu>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

To recap, I am using the MontaVista Linux 2.4 kernel and Xilinx EDK 9.1 
and 10.1. My goal is to port Linux onto the ML310 board with PCI 
support. I am having a lot of difficultly accomplishing this goal, however.

When I turn on the board using the MVL-2.4-EDK-9.1 system off of a CF 
card, it still gets stuck after "Now booting the kernel". When I look 
into the contents of the log_buf after the hang, all I get is 1032, 
which is a data link escape and then the number 2 (if I translated that 
from hex to ASCII correctly), over and over again. I believe that I am 
looking in the right place. In system.map, __log_buf is located at 
0xc01fa494, so I issue the command mrd 0x1fa494 200 to look at the 
contents of the log_buf.

Now, when I try booting the MVL-2.4-EDK-10.1 system off of the CF card, 
I get no output. Interestingly, when I download the ELF file onto the 
board using a JTAG cable, I get output, but again it hangs after "Now 
booting the kernel". In this case, the log_buf after the hang is just 
filled with junk.

So, this brings me to a few questions, which I hope people could help 
answer for me...

1) Does anybody have any additional ideas about why my kernel isn't 
booting? This seems to be a common problem; I've looked through the 
archives for a solution, but unfortunately, I haven't found one. Even 
suggestions on where to look for problems would be helpful.
  
2) Is anybody aware of any issues with using EDK 10.1 to generate a base 
hardware system for the ML310? I noticed that 10.1 builds the hardware 
differently (for instance, there is no PLB2OPB bridge option in the Base 
System Builder), however the Base System Builder should still build a 
compatible hardware system despite having different IO and peripheral 
device options, right? I personally prefer 9.1, but I was asked to try 
10.1.

3) Does anybody know from experience if the MontaVista Linux 2.6 kernel 
that comes with MontaVista Professional Edition 4.0 works on the ML310? 
Specifically, does it support the PCI? (I like how you only have to deal 
with one BSP file if you use 2.6, as opposed to many BSP files when 
using 2.4.)

Let me know if you need more information from me. Thanks for your help!


-Juliana


------------------------------

Message: 3
Date: Fri, 8 Aug 2008 19:49:22 -0400
From: "Huang, Bin" <bhuang2@uncc.edu>
Subject: Re: Re: PCI support on the ML310 (Linux 2.4/2.6) (Juliana Su)
To: <linuxppc-embedded@ozlabs.org>
Message-ID:
    <61B0EE7C247C1349881F63414448FC1F920F27@EXEVS06.its.uncc.edu>
Content-Type: text/plain; charset="gb2312"


There are a lot of pitfalls that might give you such kernel panic and I 
am sure I did not have a chance to experience them all. But I can share 
with you my check list for the panic of hanging at "Now booting the kernel".

Firstly, you may uncheck PCI bus option in your kernel config. If you 
still cannot get "Now booting the kernel" passed, then you need to make 
sure there are 128Mb ddr RAM on your ML310. From your booting message, I 
assume you have 128Mb RAM. But if actually you don't have that much 
size, the kernel may get confused and stuck.

Secondly, if you see this panic only when enabling PCI bus option, then 
I suggest you look into your arch/ppc/kernel/ppc405_pci.c, make sure the 
kernel actually execute this piece of code:

#ifdef CONFIG_XILINX_OCP
    /* Eliminate "unused variable" warning for pcip.  Optimizer removes. */
    pcip = NULL;
    new_pmm_min = PPC405_PCI_LOWER_MEM;
    new_pmm_max = PPC405_PCI_UPPER_MEM;

Some mainline kernel does not have CONFIG_XILINX_OCP setting for you , 
and ML310/ML410 does need them to boot up PCI bus.

Let me know if you still have problem.

Bin
