Message-ID: <404C9F4B.7000406@246tNt.com>
Date: Mon, 08 Mar 2004 17:28:59 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel Memory map on PPC / MPC5200
References: <20040308141129.F0058C10B8@atlas.denx.de>
In-Reply-To: <20040308141129.F0058C10B8@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Wolfgang Denk wrote:

>In message <404C5E13.9000700@246tNt.com> you wrote:
>
>
>>But talking about this, I see in mpc5xxx_common
>>
>>
>...
>
>
>>        io_block_mapping(0x40000000, 0x40000000, 0x10000000, _PAGE_IO);
>>        io_block_mapping(0x50000000, 0x50000000, 0x01000000, _PAGE_IO);
>>        io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
>>        io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
>>}
>>
>>
>...
>
>
>>But then, what are the 3 other mappings ?
>>
>>
>
>See the U-Boot sources ("include/configs/IceCube.h").
>
>
I've just read the IceCube.h file as well as the mpc5xxx init code ( in
the cpu/mpc5xxx, board/icecube and some in lib_ppc ).

So yes, indeed U-Boot, does change the MBAR from it's boot default to
0xf000000 and setup the PCI Mem & IO space to 0x40000000 & 0x50000000.
Sorry I should have searched more in details what uboot does before asking.

What still surprises me is that it's mapped before the 0x80000000, so
isn't that inside the zone of per-process mapping ? ( < TASK_SIZE ).

As far as I understand it, Uboot does not use the mmu, it just ensure
that it's all clear ( tlb, bat, ... ). And I don't see anywhere what
could 0x8000000 be ? It's not the MBAR anymore. And I don't see anything
there anymore but still it can't be a map to nowhere ?


Thanks a lot.

    Sylvain Munaut

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
