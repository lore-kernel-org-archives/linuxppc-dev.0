Date: Fri, 19 Apr 2002 12:07:53 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Brennan <dmb8@optonline.net>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: as question
In-Reply-To: <3CBF29F4.B00B75B6@optonline.net>
Message-ID: <Pine.LNX.4.33.0204191204450.16060-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Apr 2002, Dan Brennan wrote:

>
> In arch/ppc/kernel/head.S the following code segment exists:
>
> turn_on_mmu:
>         mfmsr   r0
>         ori     r0,r0,MSR_DR|MSR_IR
>         mtspr   SRR1,r0
>         lis     r0,start_here@h
>         ori     r0,r0,start_here@l
>         mtspr   SRR0,r0
>         SYNC
> 	RFI
>
> However, when I do objdump on head.o this is what appears:
>
> 00000088 <turn_on_mmu>:
>       88:       7c 00 00 a6     mfmsr   r0
>       8c:       60 00 00 30     ori     r0,r0,48
>       90:       7c 1b 03 a6     mtsrr1  r0
>       94:       3c 00 00 00     lis     r0,0
>       98:       60 00 00 00     nop
>       9c:       7c 1a 03 a6     mtsrr0  r0
>       a0:       4c 00 00 64     rfi
>
> It appears that the code which loads the address of the label start_here
> does not get assembled correctly. Is this observation correct?

No, the code is not yet linked. Hint: add --reloc to the objdump command
to see what instructions will be modified by the linker.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
