Subject: Re: multiple separate pci bridges ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcus Barrow <mbarrow@sangate.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1073423344.5358.160.camel@boat.sangate.com>
References: <1073423344.5358.160.camel@boat.sangate.com>
Content-Type: text/plain
Message-Id: <1073430050.773.19.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Jan 2004 10:00:51 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-01-07 at 08:09, Marcus Barrow wrote:
> oops, sorry i sent wrong note previously...
>
>         I enabled the debugging option in drivers/pci.c and rebooted.
>         Here is the pertinent output. As you can see, the two pci busses
>         have different bus numbers (in dev->bus->number ).
>
>         We use a modified version of the Marvell eval. board code. It
>         doesn't seem to have been changed for some time now. Perhaps you
>         need to look at your "agp ops"? Is this helpfull?

You do NOT care about bus numbers on the primary segment of a given
PCI domain. These are type 0 config cycles and so do not carry any
kind of bus numbers.

If the host bridge do try to muck with those, then it's not fully
on spec, but then, that can be worked around.

I'd still like to see the docs of this chipset though...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
