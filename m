Message-ID: <001401c44188$07d6c590$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Venkatesh Savithri Mahesh" <vsmahesh@cdotb.ernet.in>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <Pine.OSF.4.21.0405241202110.19979-100000@ws9.cdotb.ernet.in>
Subject: Re: Query about KERNELLOAD. 
Date: Mon, 24 May 2004 08:09:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Venkatesh,

I think your problem is with the emulator setup.  You don't ever want to
change KERNELLOAD unless you are a very advanced user.  0xc0000000 is a
virtual address - when the processor puts out an address in this range it is
translated by the MMU to an actual memory address.  So when you change to
0x0600000 you are running without the MMU translation.  So some things work,
but the kernel will never work properly this way.

Your emulator has to be smart enough to know how to translate
virtual-to-physical addresses in the linux kernel.  Not all emulators can do
this, I don't think TRACE32 does (but check with manufacturer!). The
emulator that has the most support from linux is Abatron:  www.abatron.ch
Also, once you get your kernel to boot, don't forget that you can use gdb
and gdbserver.  You may be able to do some debugging by just realizing that
the physical address is usually the virtual address minus 0xc0000000.  So if
the debugger shows 0xc0012345 the physical address is 0x12345.

Good luck,
Mark Chambers

>   I am a novice, please forgive me if this is very trivial.
>
>   I am trying to run 2.4.16 kernel on a custom 8260 board with 128MB
> sdram. I am using the TRACE32 JTAG emulator from Lauterbach.
>
>   I am unable to load with KERNELLOAD=0xc0000000.
>
>   When the KERNELLOAD is changed to some other value, say 0x06000000


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
