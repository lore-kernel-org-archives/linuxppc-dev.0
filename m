Date: Mon, 23 Aug 2004 21:14:10 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
In-reply-to: <23479.1093274235@www38.gmx.net>
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <412AC092.30206@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <23479.1093274235@www38.gmx.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You might want to have a look at
http://direct.xilinx.com/bvdocs/appnotes/xapp765.pdf
It explains on how to get started with Xilinx EDK and MontaVista Linux
Preview Kit on the ML300 board. The steps are pretty much the same for a
custom board.

- Peter


Patrick Huesmann wrote:

>Hi,
>
>I'm trying to port Linux to a custom board built around a virtexII-fpga
>which features a PPC-405 cpu.
>
>I've downloaded the Montavista 2_4_devel tree, which already has some
>platform and driver support for the ml300 eval board, and made a few changes
>to the xilinx specific header files to reflect our FPGA design.
>Then I changed the tophys macro in include/asm/ppc_asm.h to have a sensible
>initial mmu.
>#define MY_PHYS_RAM 0x90000000
>#define tophys(rd,rs) addis	rd,rs,(MY_PHYS_RAM-KERNELBASE)@h;
>#define tovirt(rd,rs) addis	rd,rs,(KERNELBASE-MY_PHYS_RAM)@h;
>
>My kernel gets past the initial mmu setup, enters the C code and freezes in
>the middle of early_init in arch/ppc/kernel/setup.c when (after?) memset_io
>is called to zero the BSS region.
>
>I've some experience with porting ARM-Linux but, unfortunately, the PPC port
>seems to be significantly different (there are no mach-types and ATAG lists,
>for example).
>
>1) Is there any comprehensive documentation / tutorial on how to port the
>ppc-linux to new machines? Where does my board specific fixup stuff go (for
>example, memory and IRQ declarations and such).
>
>2) What requirements and responsibilities are imposed on the bootloader? I
>suspect that I can't use u-boot or something like that, because we have our
>own "company-specific" bootloader so that all our products use the same
>protocol for firmware updates.
>
>3) Is there a way to get a self-decompressing kernel image? ARM linux
>provides a zImage which the cpu just has to jump into (with some registers
>initialized) and then decompresses vmlinux by itself. Now I have to use a
>vmlinux file and write it to flash directly, because zImage on powerpc lacks
>decompressor code (at least with my configuration). But the 1.3meg vmlinux
>file makes for pretty long turnaround times (I can only upload at 115k at
>the moment).
>
>Any help is greatly appreciated ;)
>
>Regards,
>Patrick
>
>
>
>
>
>
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
