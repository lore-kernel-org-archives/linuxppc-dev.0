Date: Fri, 27 Aug 2004 15:06:39 +0200 (MEST)
From: "Patrick Huesmann" <tricknology@gmx.de>
To: "Mark Chambers" <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
References: <003901c48c34$6e73fe20$0301a8c0@chuck2>
Subject: Re: Kernel oops when initializing ethernet driver
Message-ID: <3987.1093611999@www44.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> > Interestingly, the kernel only crashes when accessing that one
> particular
> > register (at offset 0x0040). Every other register in that range can be
> > written to and read from w/o problems.
>
> So that sounds like a hardware problem, doesn't it.  This is one of those
> things where the FPGA has a hard PPC core and a bunch of VHDL
> peripherals?

Yes, exactly. The peripherals are connected to the PPC core via the OPB
(on-chip peripheral bus) and now I must assume that the address decode /
"chip" select logic within that OPB is buggy or not configured right.

> The good thing there is that the VHDL isn't much harder
> to fix than C code.  That would be my wild guess - the VHDL is not
> decoding the address correctly.

I don't even know if we have the VHDL source - the peripherals are
ready-to-go logic units that are just inserted in the FPGA design.

> However, also check that you are not accidentally writing past 0x0040.
> For instance, if 0x0040 is a byte address and you write 16 bits you'll
> be writing to 0x0040 and 0x0041.

It is a 32-bit access at 0x0040.

Thanks,
Patrick


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
