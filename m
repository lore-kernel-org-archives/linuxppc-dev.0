Date: Mon, 25 Mar 2002 22:14:09 -0700
From: Matt Porter <mporter@mvista.com>
To: Greg Griffes <ggg@ieee.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map on custom MPC7400 board
Message-ID: <20020325221409.A871@home.com>
References: <004701c1d44e$3d643700$6401a8c0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <004701c1d44e$3d643700$6401a8c0@attbi.com>; from ggg@ieee.org on Mon, Mar 25, 2002 at 05:41:43PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 25, 2002 at 05:41:43PM -0500, Greg Griffes wrote:
>
> Hello,
>
> I am porting the kernel.org 2.4.18 kernel to a custom PowerPC board
> based on the MPC7400 processor.  I am using the gnu.org gcc-2.95.3
> and binutils-2.11.2 tools and cross-compiling on i686.

I really recommend using the linuxppc_2_4_devel tree as a starting
kernel source base...but it's your choice.

> My questions deal with memory mapping in the machine dependent layer
> in (my)_setup.c - platform_init().  To provide hardware support for the
> RTC and IRQ functions I need to use two DBATs to map a range of
> 384Mb.  The rtc and irq hardware lies between phys 0xE000_0000
> and 0xF800_0000.  I plan to use DBAT2 and DBAT3 to map this
> memory 1:1.  DBAT0 and DBAT1 are used to map 16Mb of RAM
> from 0x0 (phys) to 0xC000_0000 (virt) for the kernel (this is the way
> it came from kernel.org). Does anyone foresee any problems with this
> approach?

You are misunderstanding the mapping of kernel RAM using BATs. The
16MB mapping is a temporary translation used before MMU_init().
If you look at arch/ppc/mm/ppc_mmu.c:bat_mapin_ram() you'll see
that the final mapping is done using BAT2 and BAT3 (the third
pair of bats is only used if total_lowmem > 256MB).

> On our board, there is 256Mb RAM at physical 0x0. Is there any reason why
> I should not change the kernel to map all 256Mb of RAM at phys 0x0 to virt
> 0xC000_0000 with a single IBAT and DBAT?  This would allow me to use
> a DBAT to map additional PCI bus space.

That's fine.  In a 256MB RAM system only BAT2 is used, so BAT1,3,4 are
free for I/O translations.

Do you really have to map a contiguous 384MB of physical address
space? If these are typical RTC and PIC parts...why?

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
