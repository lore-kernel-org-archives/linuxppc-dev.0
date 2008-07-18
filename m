Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB5B4DDF5F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 18:43:21 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m6I8hGrQ003794
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 10:43:16 +0200
Message-ID: <02ec01c8e8b2$52717890$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: "ppcdev" <linuxppc-dev@ozlabs.org>
References: <93c791ba2d4ce372589da84acd14a15c@bga.com>
Subject: Re: Calling the kernel from a mini-bootloader
Date: Fri, 18 Jul 2008 10:43:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Milton and David, thanks t=for the answers.

> This is a very reasonable approach, and is quite similar to what
> I do.
Makes me feel better !!!

> You actually have a few choices.   You can put just the loaded
> data, or you can put the elf file and parse the header in your
> boot loader.
I cannot do that for memory constrains. I have 4Mb in the flash for the 
kernel and only a few Kb for the eprom of the bootloader. Also the idea is 
to sometimes update the kernel but basically never the bootloader.

> After seeing the advantages, I would keep the elf
> header.   One big advantage of keeping the elf header is you can
> see how much data will be zeroed for bss when the kernel starts.
> Another choice is rather than loading the kernel, build a zImage
> of some kind (see the code in arch/powerpc/boot).  This way the
> kernel code and static data is compressed.  I often see a 3-fold
> reduction in size.  You can also attach an initrd, should you
> decide to use initramfs later.  More o this below.
I'm not too familiar with the sequence of events that unfolds when the 
kernel start.
The JTAG debugger copies the kernel at a given address. A program dumps a 
copy of that address range in flash. A bootloader does the reverse and 
launches it, so it shouldn't really matter what form the kernel takes, as 
long as the original _did_ work.

> Ahh ... you are still on ppc.   Please note that we just merged
> the removal of arch/ppc, everyone needs to use powerpc now.  The
Yes, my code works on the ML405, now I'm just trying to get it to work on 
our custom board... I haven't been able to follow closely the PPC/PowerPC 
change but it got me worried so I stopped updating at 2.6.15. I'm using the 
Xilinx git tree because I rely on a lot of their drivers, so I don't know if 
the change will be seemless. From the change of xparameters.h to and 
entirely different device description method, I'd say I'm not ready to take 
the jump.

Any Xilinx user care to comment on that ?

And I'm supposed to release the alpha version of our code today !!!

> good news is: its easier to state the requirements, and its
Hmmm...

> easier to share the code in vmlinux.  The bad news is you have to
> follow the rules for passing data to the kernel.  Its not hard.
> We have defined a data structure that is parsed to become a tree
> of data describing the machine, and based the contents on open
> firmware.  We call this the flattened device tree.
Our firmware is custom VHDL code. I'll go ask the 'tronics guy if it fits 
open firmware requirements, but I'd be surprised.

> Please read Documentation/powerpc/booting-without-of for more
Will do. Last update is 2005. Is this still relevant  ?

> I will point out the minimal rom image I did for qemu where the
> device tree is linked into the assembly, the kernel elf file is
> already loaded, but I had to copy the nvram data serially into
> ram and then poke the memory size and initrd location into the
> device tree.
Maybe I can just use an elementary approach like that: have the bootloader 
write a single byte with the jumper positions somewhere in RAM, and then 
have the kernel read it to use for the Mac address. With the flat addressing 
it could work if there aren't built-in securities.

Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
