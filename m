Date: Tue, 26 Mar 2002 07:16:49 -0700
From: Matt Porter <mporter@mvista.com>
To: Greg Griffes <ggg@ieee.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory map on custom MPC7400 board
Message-ID: <20020326141649.GA10015@beef.az.mvista.com>
References: <004701c1d44e$3d643700$6401a8c0@attbi.com> <20020325221409.A871@home.com> <000901c1d4ba$63f9b7c0$6401a8c0@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000901c1d4ba$63f9b7c0$6401a8c0@attbi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 26, 2002 at 06:35:54AM -0500, Greg Griffes wrote:
> Matt,
>
> Thanks very much for your advice.  You have saved me a big headache!
>
> > I really recommend using the linuxppc_2_4_devel tree as a starting
> > kernel source base...but it's your choice.
>
> I will try using the linuxppc_2_4_devel tree.  Unforeseen problems I don't need.
>
> > Do you really have to map a contiguous 384MB of physical address
> > space? If these are typical RTC and PIC parts...why?
>
> The RTC is typical but the PIC is split between a custom ASIC and
> another device.  The RTC is at 0xE400_0000phys, one part of the PIC
> is at 0xEC00_0000phys and the other part is at 0xF700_0000phys.
> Their size is small, but they are spread out.  If I have to map them with
> BATs, I would have to map 384Mb (because the BAT base address
> must be a multiple of the mapped size.) Once the KVM is up,
> I think that I can use ioremap(), or io_block_mapping() to map in
> only what I need.  Is that right?

You can ioremap() the devices in your board-specific *_setup_arch()
routine.  Early ioremap() calls start at ioremap_base and grow
down.  After the VM system is up, normal allocations in vmalloc
space kick in.  You can use io_block_mapping(), but ioremap()
allows the kernel to efficiently manage your VM.  Too often,
people waste VM space by dropping arbitrary io_block_mappings
everywhere so I would discourage it's use unless you want to
utilize a BAT for specific performance/optmizations reasons in
your application.

> > You are misunderstanding the mapping of kernel RAM using BATs. The
> > 16MB mapping is a temporary translation used before MMU_init().
> > If you look at arch/ppc/mm/ppc_mmu.c:bat_mapin_ram() you'll see
> > that the final mapping is done using BAT2 and BAT3 (the third
> > pair of bats is only used if total_lowmem > 256MB).
>
> Does this mean that before MMU_init() I can use BATs 2&3, then in
> ppc_md.setup_io_mappings() (called after mapin_ram()) I would use
> io_block_mapping() (as is done in chrp_setup.c?)

Do you need to use the parts very early?  95% of cases don't need
devices accessible within head.S.  I understand anything goes
with a custom board but if you are not utilizing the PIC and RTC
hardware until init_IRQ() and time_init(), respectively, then
you don't need to worry about early mappings via BATs.

If you must use a BAT then use io_block_mapping() to accomplish it
from your *_setup_arch().  If you need early access to the I/O,
utilize BATs, you can utilize DBATs 2&3.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
