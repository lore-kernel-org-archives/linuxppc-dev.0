Date: Tue, 24 Aug 2004 10:51:18 +0200
To: Patrick Huesmann <tricknology@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to port ppc-linux to new custom boards? (virtexII)
Message-ID: <20040824085118.GO2698@mind.be>
References: <23479.1093274235@www38.gmx.net>
Mime-Version: 1.0
In-Reply-To: <23479.1093274235@www38.gmx.net>
From: "Peter 'p2' De Schrijver" <p2@mind.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Aug 23, 2004 at 05:17:15PM +0200, Patrick Huesmann wrote:
>
> I'm trying to port Linux to a custom board built around a
> virtexII-fpga which features a PPC-405 cpu.
>
> I've downloaded the Montavista 2_4_devel tree, which already has some
> platform and driver support for the ml300 eval board, and made a
> few changes to the xilinx specific header files to reflect our FPGA
> design. Then I changed the tophys macro in include/asm/ppc_asm.h
> to have a sensible initial mmu. #define MY_PHYS_RAM 0x90000000
> #define tophys(rd,rs) addis rd,rs,(MY_PHYS_RAM-KERNELBASE)@h; #define
> tovirt(rd,rs) addis rd,rs,(KERNELBASE-MY_PHYS_RAM)@h;
>
> My kernel gets past the initial mmu setup, enters the C code and
> freezes in the middle of early_init in arch/ppc/kernel/setup.c when
> (after?) memset_io is called to zero the BSS region.

That's a problem. A lot of the 405 specific kernel code relies on the
fact that main memory is mapped at address 0. It would require quite
some work to make it work on other addresses too.

> I've some experience with porting ARM-Linux but, unfortunately, the
> PPC port seems to be significantly different (there are no mach-types
> and ATAG lists, for example).

Indeed. Although this is supposed to change some day...

> 1) Is there any comprehensive documentation / tutorial on how to port
> the ppc-linux to new machines? Where does my board specific fixup
> stuff go (for example, memory and IRQ declarations and such).

I haven't seen one. Most of the board specific fixup stuff resides in
platforms/boardname.[ch]. Look at arch/ppc/platforms/insightv2pro.[ch]
for an example how we did this for the insight V2Pro board.

> 2) What requirements and responsibilities are imposed on the
> bootloader? I suspect that I can't use u-boot or something like that,
> because we have our own "company-specific" bootloader so that all our
> products use the same protocol for firmware updates.

The bootloader should load the kernel at address 0 and initialize the
registers as follows :

r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
r4 - Starting address of the init RAM disk
r5 - Ending address of the init RAM disk
r6 - Start of kernel command line string (e.g. "mem=96m")
r7 - End of kernel command line string

(See also arch/ppc/kernel/head_4xx.S). The board info structure is
defined in asm-ppc/ppcboot.h (struct bd_info).

> 3) Is there a way to get a self-decompressing kernel image? ARM
> linux provides a zImage which the cpu just has to jump into (with
> some registers initialized) and then decompresses vmlinux by itself.
> Now I have to use a vmlinux file and write it to flash directly,
> because zImage on powerpc lacks decompressor code (at least with my
> configuration). But the 1.3meg vmlinux file makes for pretty long
> turnaround times (I can only upload at 115k at the moment).

Yes. look at arc/ppc/boot/simple for some targets which have a
self-decompressing kernel. (Amongst which is our port to the Insight
V2PRO board).

> Any help is greatly appreciated ;)

You're welcome.

Cheers,

Peter (p2).

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
