Date: Fri, 10 Aug 2001 14:34:23 -0500
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP and generic PCI resource assignment
Message-ID: <20010810143423.B28326@austin.ibm.com>
References: <20010809091402.A11768@beef.az.mvista.com> <Pine.LNX.4.05.10108101034110.2083-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.05.10108101034110.2083-100000@callisto.of.borg>; from geert@linux-m68k.org on Fri, Aug 10, 2001 at 10:38:04AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Aug 10, 2001 at 10:38:04AM +0200, Geert Uytterhoeven wrote:
>
> There are (or were, read as in `were the last time I
> tried it, a few months ago) still some problems, though. One of them is that
> the hardcoded ISA motherboard resources (i8259 and legacy stuff) are
> requested before PCI resources are done, and that the PCI bus parent
> resources were not requested and thus don't appear in the full resource
> tree.

There is still that problem with VGA console, which does a
request_resource(&ioport_resource,...) after the PCI host bridge has been
found, but well before the PCI code has reserved all of *its* resources. So
reserving 0-ffffffff IO fails because VGA already grabbed a tiny chunk at
0x3d0 or so.

Even regardless of order, VGA console is requesting directly from
ioport_resource, which probably should be changed (Paul suggested
request_region instead)...

I didn't see any similar problem with i8259, but I wasn't looking for it
either.

I get a ton of failed request_resources on the boxes I play with the most, but
luckily most things work ok. Except for this video controller, which doesn't
like being moved away from 0x0... :/

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
