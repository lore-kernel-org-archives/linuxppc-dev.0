From: "DONG-IN KANG" <dkang@east.isi.edu>
To: "'Joao Vicente'" <joao.vicente@spectel.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board 
Date: Thu, 9 Oct 2003 15:02:51 -0400
Message-ID: <001f01c38e97$f02a5d60$45a97241@Yongkoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <DEF39A0710293E489D45B10E06645CBD0243B1E7@dub-msx1.spectelcorp.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Did you set the compiler flag "-g -gdb" when you configure the kernel?

 Dong-In

-----Original Message-----
From: Joao Vicente
Sent: Thursday, October 09, 2003 10:55 AM
Subject: RE: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom MPC8260 board

I am affraid I am still unable to debug the kernel.

I have tried to define the line
MMU  XLAT
and defined the PTBASE as shown below

MMU         XLAT        ;translate effective to physical address
PTBASE      0x000000f0  ;address where kernel/user stores pointer to page
table

As you can see I defined PTBASE as 0x000000f0.
Is this the right address for this build ?

I tried it to debug the target with this configuration file but was
still unable to get the symbols.

I notice the BDI user manual suggests to use the following line
WM32    0x000000f0      0x00000000      ;Invalidate page table base.

which I also tried without success.

I also got a trial version of 5.1.1 which I believe you recommended to
fix a similar problem.

"Wolfgang was able to point me to a trial version of gdb which reports
itself as 5.1.1 but which has a patch applied that fixes the problem.
I have attached this version to this email so you can try it for
yourself."

I am not unsure if this is relevant but this is the method I am using to
build the kernel

make TQM8260_config
make menuconfig (where I am changing FCC, MDIO and SCC parameters only)
make oldconfig
make dep
make uImage

Do you reckon is there anything else I could try to fix this problem.

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Thursday, October 09, 2003 1:38 PM
Subject: Re: Problem debugging ppc kernel with DDD/GDB/BDI2000 on a custom
MPC8260 board

in message <DEF39A0710293E489D45B10E06645CBD0243B1A7@dub-msx1.spectelcorp.com> you wrote:
>
> I am trying to boot the ppc kernel on a MPC8260 based custom board.
...
> One of the doubts that I have is that when I look into the system.map
> file, it shows that the start address is at 0xc0000000 (as shown below)
>
> c0000000 T _start

Yes, this is the correct kernel virtual address.

> To the best of my knowledge the kernel image is not relocatable, so
> I am wondering if this could be my problem or just one of them ...
> Should the map file be showing
>
> 00000000 T _start

No!!!

> If so, where should I change the .text address so that that happens ?

Don't change anything!

> I am also trying to debug the code from that address with gdb/BDI2000,
> but I am not getting very far. Basically I can see the program counter
> incrementing when I single step, but I cannot see the source even
> though I am trying to load the symbol table at 0x00000000 with the
> 'add-symbol-file vmlinux 0x00000000' gdb command, after invoking gdb
> from the kernel base directory (where vmlinux is)

Just use the vmlinux file _without_ relocating  any  addresses.  Make
sure  to  enable  "MMU  XLAT"  and define "PTBASE" in your BDI config
file.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
