Message-ID: <386ADE53.D3411F6A@ctam.com.au>
Date: Thu, 30 Dec 1999 15:23:48 +1100
From: Brendan J Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <386ABF52.922267E9@ctam.com.au> <38701F3A.FAD6263E@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> Brendan J Simon wrote:
>
> > dony wrote:
> >
> > > Hi,
> > >       Now I am trying to embed linux onto our MPC860-based board. I have
> > > some questions which may be solved by you embed-linux gurus....
> > >      What I want to do  is the following:
> > >     1     Initialize the MPC860 CPU , memory, serial port, enet port .
> > >     2    Download  the linux powerpc kernel (which I have cross-compiled
> > > on my X86 box)
> > >            from the TFTP server to RAM on board.
> > >     3    run the kernel.
> > > Now the 1 and 2 step work well, but when I download the kernel to RAM on
> > > board, It just cannot run.Do you know why? How can I programme to make
> > > it run? Since the kernel is a compressed image (zvmlinux), need I make
> > > some codes to decompress it and then run it? if so, how to do it?
> >
> > So I take it that you have written your own boot loader that is in
> > ROM/Flash which fetches the kerenl from a TFTP server and places it in RAM
> > somewhere.
>
> Yes, you are right. The monitor program I use is based on vxWorks BSP .
> All the implement details about BOOTP/TFTP are wraped in some functions
> supplied by vxWorks along with some share libraries. What I should do is just
> to call these functions and compiled them under its IDE .
>
> > Good.  How does your bootloader know where to put the code ?
> > Does it look at the internals of the elf image or is it an s-record file
> > you are downloading ?
>
> Yes, It will handle the Elf headers after downloading the kernel from tftp
> server, and then jump there to start. but it failed to run.
>
> > The image must be placed at or above 2MB.  You will
> > have problems if it is below 2MB.
>
>  If I try to downloaded it to 2MB, it cannot download succesfully and halt. But
> If I download it to 1MB, it can do successfully. Why?

I don't know.  Our bootloader is very simple.  It has 3 basic functions.
1) Basic hardware diagnostics (RAM check, etc).
2) Program an S-Record into flash if a dipswitch is set.
3) Run application code from flash if present.

There is no OS involved.  I have never used vxWorks so I don't know how it
allocates it's memory or what.  Is it that you have a vxWorks bootloader that is
expecting a vxWorks kernel and that the kernel is expected to be compiled for a
certain location ?  If so, you will probably have to modify your bootloader to
cater for a linux kernel (or any elf program).


> > I have my kernel in Flash at FFE00000 or
> > FF800000.
>
> If you translate FF8000000 into decimal, it is so huge! Does the 860 support
> it?

Why translate it to decimal ?  It is a big number whether it is in decimal,
hexadecimal, octal or binary.
The MPC860 has a 32 bit address space which means it can access memory from
0x00000000-0xFFFFFFFF.  You program the chip selects with the appropriate base
address and size to your liking for RAM, Flash and other peripherals.


> And how you put it in flash?

Our bootloader has routines to receive S-records and program them into our flash
modules.


> > Once the kernel is loaded, you have to jump to the start
> > address.
> >
> > I assume you are using the mbxboot code for the kernel.  Are you ?  What
> > board are you using ?
>
> Yes. And I use our own MPC860-based board.

Have you made any modifications to the linux kernel to cater for your board
differences (if any).  The main thing is that the console is on SMC1 and ethernet
on SCC1.  I think the mbx board MAY use COM1 instead of SMC1 for the console.  You
better double check that.


> > The mbxboot code will copy the iteself to location 0x100000 (1MB) and jump
> > to that address so it is running from RAM.  It then decompress the kernel
> > image to location 0 and jumps to the start of the kernel.
>
> Do you mean the mbxboot code will copy itself from FF800000 to 1MB?

Yep.


> > Can you send the output of "objcopy --headers zImage" to the list.
>
> The "powerpc-linux-objcopy --headers zImage" cannot work. Maybe the semantics
> is wrong?

My mistake.  It should be objdump instead of objcopy.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
