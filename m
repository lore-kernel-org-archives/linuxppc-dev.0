From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PowerPC Devel List
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
Date: Fri, 13 Oct 2000 23:36:28 +0200
Message-Id: <19340907150812.9049@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10010132302530.381-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10010132302530.381-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>But you can fixup all pci_dev's so bus 0 takes 0x00000-0x0fffff, bus 1 takes
>0x10000-0x1ffff, and so on. ioportremap() finds out the bus by looking at the
>region.
>
>I/O space is not limited to 64 kB on non-ia32, we can use the full size of an
>unsigned long.
>
>Legacy I/O mappings (`I have legacy lp0 on bus 0 and legacy lp1 on bus
1') can
>be sorted out in ioportremap() as well.

Ok, If I follow you correctly, that mean that if we have, for example,
bus 1 set to 0x10000-0x1ffff, ioportremap() would return, for an address
in this range, the address + bus_io_base - 0x10000. At least on Macs,
AFAIK, we have only 64k or 128k of IOs available.

I still need to think about this, I'll leave the code in bk _2_5 as it is
now (which is the good old IO_BASE) and leave those IO changes for after
I'm finished with per-hose resources.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
