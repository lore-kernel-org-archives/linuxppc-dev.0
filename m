Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <404C5E13.9000700@246tNt.com>
Date: Mon, 08 Mar 2004 12:50:43 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel Memory map on PPC / MPC5200
References: <40486C64.80803@246tNt.com> <4048B287.6010501@246tNt.com> <200403080843.26481.g.jaeger@sysgo.com>
In-Reply-To: <200403080843.26481.g.jaeger@sysgo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I've got more general question about the memory mapping on the MPC5200.


Gerhard Jaeger wrote:

>>My questions currently are :
>> - Apparently 0xf0000000 is mapped to somewhere ( the MBAR ) but I don't
>>see where it's done ... And how do I tell it that it's IO and should not
>>be cached. Apparently on 2.4 it works but I don't see where is the piece
>>of code that just does that ...
>>
>>
>
>checkout kernel/mpc5xxx_common.c
>
>
>
Thanks, I've seen this but that code is executed way later. I'm talking
about the mapping that exists at near the kernel entry point, in head.S.
Maybe it's just a residual mapping of U-Boot, I should check that.

But talking about this, I see in mpc5xxx_common


void __init
mpc5xxx_map_io(void)
{
        io_block_mapping(0x40000000, 0x40000000, 0x10000000, _PAGE_IO);
        io_block_mapping(0x50000000, 0x50000000, 0x01000000, _PAGE_IO);
        io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
        io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
}

I've read the relevant part of the MPC5200 manual and still don't
understand ...

0x80000000 is the default address of the MBAR. But AFAIK, MBAR is
changed by U-Boot to remap the registers to 0xf0000000 ( physical
address space, not remapped using the mmu ).
So I see the last line as a 1:1 mapping of the internal mpc5200
registers. And looking at all the consts, it seems correct.
But then, what are the 3 other mappings ?

Also, to be sure of what I understood. When the 0xf0000000 area is 1:1
mapped via the BAT, I suppose it's just to get serial debug during early
init and the map_io call. Because the BAT2 is gonna be overwritten when
the kernel maps all the physical memory. I'm not sure whether the call
to map_io occurs after or before that. I suppose it's after, else the
same mapping would exists in two different ways and that's discribed as
a bad situation in the user manual.

Finally ( I know, I have a lot of questions ), the kernel doesn't use
the HIGH_BATS features ? I mean there is 8 BAT on this processor and I
don' t see where the 5 6 7 8 are gonna be used ? io_block_mapping could
be slightly modified to use them as well or am I wrong ?


Thanks,

    Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
