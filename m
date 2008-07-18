Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 49BC7DDF2E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 04:36:28 +1000 (EST)
In-Reply-To: <02ec01c8e8b2$52717890$ad289e86@LPSC0173W>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com>
	<20080718034727.GF18748@yookeroo.seuss>
	<02ec01c8e8b2$52717890$ad289e86@LPSC0173W>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <007a845ba2b60b02a256b58632490b27@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Fri, 18 Jul 2008 13:38:06 -0500
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, John Linn <John.Linn@xilinx.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri Jul 18 18:43:11 EST 2008, Guillaume Dargaud wrote:
> Hello Milton and David, thanks for the answers.
>> This is a very reasonable approach, and is quite similar to what
>> I do.
> Makes me feel better !!!
>
>> You actually have a few choices.   You can put just the loaded
>> data, or you can put the elf file and parse the header in your
>> boot loader.
> I cannot do that for memory constrains. I have 4Mb in the flash for the
> kernel and only a few Kb for the eprom of the bootloader. Also the 
> idea is
> to sometimes update the kernel but basically never the bootloader.

Then the zImage approach is definitly the way to go.  Actually, dtbImage
now, because you want the device tree to be compiled and linked into it.

(It only took me 33 lines of assembly, and 6 were labels or blank, to
skip over the elf header -- the vmlinux and zImage don't require they be
moved into a specific place - but keeping it just a binary blob is 
fine).

>> After seeing the advantages, I would keep the elf
>> header.   One big advantage of keeping the elf header is you can
>> see how much data will be zeroed for bss when the kernel starts.
>> Another choice is rather than loading the kernel, build a zImage
>> of some kind (see the code in arch/powerpc/boot).  This way the
>> kernel code and static data is compressed.  I often see a 3-fold
>> reduction in size.  You can also attach an initrd, should you
>> decide to use initramfs later.  More o this below.
>
> I'm not too familiar with the sequence of events that unfolds when the
> kernel start.
> The JTAG debugger copies the kernel at a given address. A program 
> dumps a
> copy of that address range in flash. A bootloader does the reverse and
> launches it, so it shouldn't really matter what form the kernel takes, 
> as
> long as the original _did_ work.

Ok, should not be a problem.  You will want the wrapper code to create a
flat binary image, so have your platform set the binary variable like
cuboot.  Whatever you specify for your platform file  will be linked at
the beginning of the image.

When choosing where to laod the zImage into memory, you should consider
that the linked kernel size (including its bss) needs to fit below the
load address, and the extracted device tree and random malloc heap 
normally
reside the wrapper.

>
>> Ahh ... you are still on ppc.   Please note that we just merged
>> the removal of arch/ppc, everyone needs to use powerpc now.  The
> Yes, my code works on the ML405, now I'm just trying to get it to work 
> on
> our custom board... I haven't been able to follow closely the 
> PPC/PowerPC
> change but it got me worried so I stopped updating at 2.6.15. I'm 
> using the
> Xilinx git tree because I rely on a lot of their drivers, so I don't 
> know if
> the change will be seemless. From the change of xparameters.h to and
> entirely different device description method, I'd say I'm not ready to 
> take
> the jump.
>
> Any Xilinx user care to comment on that ?

I'm not a user, but from reading the list, they have integrated creating
the dts file into their build system.

>
> And I'm supposed to release the alpha version of our code today !!!
>
>> good news is: its easier to state the requirements, and its
> Hmmm...
>
>> easier to share the code in vmlinux.  The bad news is you have to
>> follow the rules for passing data to the kernel.  Its not hard.
>> We have defined a data structure that is parsed to become a tree
>> of data describing the machine, and based the contents on open
>> firmware.  We call this the flattened device tree.
> Our firmware is custom VHDL code. I'll go ask the 'tronics guy if it 
> fits
> open firmware requirements, but I'd be surprised.

I'm sure your firmware does not presently create this tree, but
the dtbImage format is designed to be a delivery vehicle for it.

>
>> Please read Documentation/powerpc/booting-without-of for more
> Will do. Last update is 2005. Is this still relevant  ?

That's might be the last time we changed the structure of the tree,
but we have been updating the definition of what goes into the tree
structure pretty much every month since then.   In the 2.6.27 kernel,
I think we started breaking out these descriptions into the
dts-bindings directory tree.

>
>> I will point out the minimal rom image I did for qemu where the
>> device tree is linked into the assembly, the kernel elf file is
>> already loaded, but I had to copy the nvram data serially into
>> ram and then poke the memory size and initrd location into the
>> device tree.
>
> Maybe I can just use an elementary approach like that: have the 
> bootloader
> write a single byte with the jumper positions somewhere in RAM, and 
> then
> have the kernel read it to use for the Mac address. With the flat 
> addressing
> it could work if there aren't built-in securities.

We are happy for you to read such information in the zImage (or 
dtbImage).
In fact we have a hook "fixups" that is the designated place for this to
happen.  If the location to read the jumper is well defined, I would
suggest doing all of it from your fixup function, you don't need to save
the jumper position in ram (less code for your bootloader, and probably
a simpler handoff).  (Needing the mac address does mean you can't use 
the
simpleboot.c).

Hope you find these comments helpful,
milton
