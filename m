Message-ID: <000901c1d4ba$63f9b7c0$6401a8c0@attbi.com>
Reply-To: "Greg Griffes" <ggg@ieee.org>
From: "Greg Griffes" <ggg@ieee.org>
To: "Matt Porter" <mporter@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <004701c1d44e$3d643700$6401a8c0@attbi.com> <20020325221409.A871@home.com>
Subject: Re: Memory map on custom MPC7400 board
Date: Tue, 26 Mar 2002 06:35:54 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt,

Thanks very much for your advice.  You have saved me a big headache!

> I really recommend using the linuxppc_2_4_devel tree as a starting
> kernel source base...but it's your choice.

I will try using the linuxppc_2_4_devel tree.  Unforeseen problems I don't need.

> Do you really have to map a contiguous 384MB of physical address
> space? If these are typical RTC and PIC parts...why?

The RTC is typical but the PIC is split between a custom ASIC and
another device.  The RTC is at 0xE400_0000phys, one part of the PIC
is at 0xEC00_0000phys and the other part is at 0xF700_0000phys.
Their size is small, but they are spread out.  If I have to map them with
BATs, I would have to map 384Mb (because the BAT base address
must be a multiple of the mapped size.) Once the KVM is up,
I think that I can use ioremap(), or io_block_mapping() to map in
only what I need.  Is that right?

> You are misunderstanding the mapping of kernel RAM using BATs. The
> 16MB mapping is a temporary translation used before MMU_init().
> If you look at arch/ppc/mm/ppc_mmu.c:bat_mapin_ram() you'll see
> that the final mapping is done using BAT2 and BAT3 (the third
> pair of bats is only used if total_lowmem > 256MB).

Does this mean that before MMU_init() I can use BATs 2&3, then in
ppc_md.setup_io_mappings() (called after mapin_ram()) I would use
io_block_mapping() (as is done in chrp_setup.c?)

This helps a lot!  Thanks again for your advice.

Greg Griffes


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
