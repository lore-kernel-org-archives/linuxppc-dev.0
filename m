Date: Fri, 12 Nov 1999 14:03:45 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Ethan Benson <erbenson@alaska.net>, Florent <flobo@iname.com>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Re : Newworld OF boot 
In-Reply-To: <9911111606.AA37454@marc.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.9911121337330.16204-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 11 Nov 1999, David Edelsohn wrote:

> 
> >>>>> Ethan Benson writes:
> 
> Ethan> because you have to recompile your booter every time you recompile 
> Ethan> the kernel, or keep the kernel in a nonstandard location.
> 
> 	One does not need to recompile the booter, only rebuild the boot
> file with new piggyback information.  If one piggybacks the kernel then
> network booting becomes much simpler because the file loaded via BOOTP
> contains all of the information to boot into the kernel.

Indeed, that's fairly close to what I do for my MVME boards (which don't
have Open Firmware, or rather no more have it). The bootloader is compiled
with the -mrelocatable option because you never know where it will be
loaded on these machines (netboots load low, disk boots load close to the
top). The bootloader with the piggybacked compressed kernels: 

a) performs load time relocations where it has been loaded by firmware

b) analyzes residual data to find free memory

c) moves itself to the highest possible address as one big chunk,
allocates some stack space and initializes its own memory management.

d) performs again the load time relocations, clear the bss now that it
is guaranteed that it does not conflict with system data. Prior to this
point, no bss variable could be used and pointers were subject to
change, requiring very careful usagge of global variable and pointers.

e) perform some more initialization, on my boards it switches from PreP
to CHRP mappings and reallocates all PCI I/O and MMIO in a smarter way.

f) unzips the kernel and starts it.

Actually the code includes some possibly interesting features: 
- a simple memory management system,
- an x86 ROM BIOS emulator,

And the image is built using a linker script, no need for mkprep... I have
no machines wit OF (actually I do, but the MVME2600 OF is such a nest of
bugs), so I can't extend it to support OF although it should not be too
difficult. The patches for 2.2.12 can be found at

	ftp://vlab1.iram.es/pub/linux-2.2/

Actually I think that this code could even be extended to perform the last
linking step of the kernel depending on the machine (I already import a
few symbols from vmlinux in the bootloader, which for example clears the
bss,  but it could do other things too). 

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
