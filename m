From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <199911231139.MAA10910@mcp.cpu.lu>
Subject: Re: Error accessing PCI config space
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Tue, 23 Nov 1999 12:39:25 MET
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19991123120412.007803@mailhost.mipsys.com>; from "Benjamin Herrenschmidt" at Nov 23, 99 12:04 (noon)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

> On Tue, Nov 23, 1999, Michel Lanners <mlan@cpu.lu> wrote:
> 
> >The error is that whenever I read from config space, I get the value of
> >the previous read, however long ago that read occured. See this:
> 
> Could you try reading back the config address before actually reading the
> value ? That's how I got the uni-north config space accesses to work.

Actually I've tried that (it's hinted at in some Apple documentation
as the only way to make sure a PCI posted write has completed); however,
I'm only getting garbage in that case. Or maybe I didn't look hard enough
at the garbage to identify it ;-)

> Also, there was a weird thing about the data location that had to be
> offseted by modulo 8. If Apple used the same bits of ASIC design for it,
> then it may work.  (Look at the uni-n code in my iBook patches).

OK, I'll take a look at that when I'm back at home tonight. I'll also
try whether older kernels didn't work correctly in thsi respect; maybe
something in the system setup changed and broke this specific PCI access.

On a related note, the PCI bus scanning code in drivers/pci/pci.c seems
to get at least part of the config space right; as it gets vendor and
device ID ok. I'll investigate...

Thanks

Michel
-------------------------------------------------
.signature at home

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
