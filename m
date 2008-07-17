Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id AC9BCDE4AD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 02:12:26 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <93c791ba2d4ce372589da84acd14a15c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Thu, 17 Jul 2008 11:14:11 -0500
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu Jul 17 at 23:22:28 EST in 2008, Guillaume Dargaud wrote:
> Hello all,
> I'm in the process of writing a mini-bootloaler for a custom board and  
> would
> like some feedback on my boot methodology.
>
> Basically the kernel code (elf file) is copied into memory by a JTAG
> debugger. A custom program (yet to be finished) then copies it onto an
> onboard flash memory using serial commands. This flash is not part of  
> the
> flat memory addressing.
>
> When I want to boot, I have a small bootloader put into an eprom that  
> _is_
> part of the flat memory addressing. This (finished but not tested yet)
> bootloader basically does two things:
> - it copies the content of the first flash into RAM
> - it launches it using a custom function call like "0x400000();"
>
> Now, I'd like to know if this is a reasonable approach ? I couldn't  
> think of
> a better way, but maybe there are issues I didn't think off.

This is a very reasonable approach, and is quite similar to what
I do.

You actually have a few choices.   You can put just the loaded
data, or you can put the elf file and parse the header in your
boot loader.  After seeing the advantages, I would keep the elf
header.   One big advantage of keeping the elf header is you can
see how much data will be zeroed for bss when the kernel starts.
Another choice is rather than loading the kernel, build a zImage
of some kind (see the code in arch/powerpc/boot).  This way the
kernel code and static data is compressed.  I often see a 3-fold
reduction in size.  You can also attach an initrd, should you
decide to use initramfs later.  More o this below.

Both the kernel and zImage will build an elf file with a single
load header.  Both can run regardless of where they are loaded,
so you don't have to worry about parsing the load address, just
calculating the relatve entry point.  (The kernel will move
itself down to address 0 (except book-e parts), and the zImage
will run where it is started.  However, the default zImage will
fail to start the kernel if it isn't loaded above the link size
of the kernel (including bss).

> One additional question, if the above is valid, is that I would like  
> to pass
> a particular argument to the kernel to set its MAC address. I can read  
> an
> external value (similar to jumpers) from the bootloader via GPIO. Is  
> there a
> way to pass this value to the kernel so that a modified
> arch/ppc/boot/simple/embed_config.c can use it to set the MAC address ?
>
> Maybe the main() of the kernel can receive argv/argc the usual way,  
> and I
> just need to call "0x400000(argc, argv);" but I have no idea if that  
> works.

Ahh ... you are still on ppc.   Please note that we just merged
the removal of arch/ppc, everyone needs to use powerpc now.  The
good news is: its easier to state the requirements, and its
easier to share the code in vmlinux.  The bad news is you have to
follow the rules for passing data to the kernel.  Its not hard.
We have defined a data structure that is parsed to become a tree
of data describing the machine, and based the contents on open
firmware.  We call this the flattened device tree.

To pass the MAC address, one uses a property to the device node
which also describes what the hardware is (by name) and the
address space it uses.  Similarly, the kernel finds out how fast
the cpu and timebase are running by reading properties in the cpu
node.

Please read Documentation/powerpc/booting-without-of for more
information.  To summarize, the kernel is started with a pointer
to the device tree structure, and it contains all the information
needed.  All the data the kernel needs will be in one flat linear
chunk, but the kernel will move itself in memory to its linked
location.   The 32 bit kernel does require r1 to be set to the
top of a memory block that can be used as a stack.


There are several options to get the data into the device tree.
If you choose to use the zImage format mentioned above, the
device tree library is compiled in and you would just write a bit
of c code to read your structure and tell the library to put it
in the device tree.  The standard initialization preserves r3-r6
so you get 4 32 bit args (or maybe 5) to pass data or pointers.

Ohterwise, there is a tool called dtc (device tree compiler) that
that creates the binary structure from a source file that is
human readable.  From this, there is a library that will modify
the tree at runtime.

Another approach is to modify the device tree directly from your
first stage.   While you can link the library into your first
stage, you can also just tell dtc to output an assembly file with
symbolic labels on the data you need to modify.  You would then
pass this structure to the zImage wrapper or directly to the
kernel.

To see how simple this approach can be when you only need to
modify a few parameters, I will point out my [qemu-rom v2 patch.
Hmm, thats not it, where is it?  I thought I had posted this to
linuxppc-dev but can't find it.]

I will point out the minimal rom image I did for qemu where the
device tree is linked into the assembly, the kernel elf file is
already loaded, but I had to copy the nvram data serially into
ram and then poke the memory size and initrd location into the
device tree.

http://landley.net/hg/firmware/raw-file/92f89c9c9495/sources/toys/make- 
ppc_rom.tar.bz2

> Thanks for suggestions.

You're welcome.
milton
