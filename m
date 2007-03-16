Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E843BDDF06
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Mar 2007 02:34:11 +1100 (EST)
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B3C@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
	<653893AD-CB60-4123-B4FC-FB9B886BD895@kernel.crashing.org>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B3C@MERCURY.inside.istor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B6E0A97C-D5E5-4588-BD87-3B884C52DF88@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Exception in kernel mode
Date: Fri, 16 Mar 2007 10:33:19 -0500
To: Charles Krinke <ckrinke@istor.com>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 16, 2007, at 9:45 AM, Charles Krinke wrote:

> It this a system you are just bringing up or one that's been running
> for a while.  It really seems like memory corruption of some form.
> I'd suggest checking memory controller settings.
>
> Also, what happens if you disassemble the kernel image and look at
> the addresses pointed to by NIP:
> C00DEE18 & C002CE68.
>
> - k
> Dear Kumar:
>
> We have two systems. One based on an 8241, and one based on an  
> 8541. The 8241 has been running for some time with Linux 2.4 and  
> the 8541 is coming up. Both are using the 2.6.17.11 kernel from  
> kernel.org with modifications for our hardware.
>
> In the case of the 8241, I started out with the 2.4 modifications,  
> which were originally based on the 8260 and ported them to 2.6. In  
> the case of the 8541, I started out with the embedded planet 8555EP  
> 2.6 kernel source and added that to the 2.6.
>
> I dont see this exception in the 8541, although extensive testing  
> has not yet been completed. The 8241 exhibits this exception on  
> three different 8241 boards, so I dont suspect the hardware.
>
> We are using the Montavista toolchain and their root filesystem  
> including 'tar' and 'cp' which are the programs that currently  
> exhibit the fault.
>
> Yesterday, when I saw an NIP at 0x900, I was ready to jump on the  
> interrupts not being setup correctly, but after a few hours of  
> going through that, I am now convinced the interrupts are setup  
> correctly, so it is something more subtle.
>
> Certainly, memory corruption is the next thing to be concerned with.
>
> One thing that has concerned me a bit is that we have no swap space  
> available at all. This is an embedded system with 64MByte of RAM  
> and JFFS2 NAND flash with no swap partitions.
>
> I suspect auditing the MMU setup differences between the original  
> 2.4 kernel and the new 2.6 kernel for the 8241 board is the next step.
>
> The three exceptions I saw yesterday were 1)0x900 in the  
> timer_interrupt, 2) C00DEE18 (inside the tar program) and 3)  
> C002CE68 (in one of the kernel routines).

#2 is inside the kernel as well.  Look at the System.map or objdump - 
d vmlinux to see what exactly is at those instructions.

> I suspect the actual addresses are red-herrings and this exception  
> can occur at any address. This certainly would tend to indicate  
> some sort of memory setup issue.

I think it's useful to know if the instructions at the two offsets  
C00DEE18 & C002CE68 are similar in some way before jumping to that  
conclusion.

> Changing the Oops logic to printout the NextInstruction as well as  
> the NIP might be helpful so I could discern the difference between  
> what the program is trying to do and what it is really doing.
>
> Are there any other thoughts you might have on diagnosis techniques  
> at this point?

Try turning on KALLSYMS, this should provide more info on the oops as  
well.

- k
