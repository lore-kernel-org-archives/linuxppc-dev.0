Message-ID: <411009D9.7090802@mvista.com>
Date: Tue, 03 Aug 2004 14:55:37 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Brian Waite <linwoes@gmail.com>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Workaround for 745x data corruption bug
References: <1091291276.987.57.camel@localhost> <410E85EE.8050707@mvista.com> <36b714c804080306175c5dc3f6@mail.gmail.com>
In-Reply-To: <36b714c804080306175c5dc3f6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian,

One of us must be seriously misunderstanding that erratum.  Below is my
thinking.

--
Brian Waite wrote:

>Mark,
>
>Looking at this errata, I don't think poeple using Marvell chips will
>be affected by this errata.
>I don't see this as impacting the IO subsystem only the internal MPX system.
>

Please define exactly what you mean by "MPX system".

> IE
>using a 2 74xx system and not using the M bit.
>

Doubtful.  Assuming you mean a dual *SMP* 745x system, you'll almost
certainly want "coherency required" (i.e., M=1) so the erratum doesn't
apply.

> This race can also
>occur on a single processor system with the M disabled,
>

Yep.

> as it is in
>Linux, but it has nothing to do with the memory controller mapping its
>PCI<->mem windows as non cacheable.
>

This statement is wrong.  Firstly (nit pick), its not the memory
controller part of the chip that does that mapping, its the "PCI bridge"
part of that chip that does.

Secondly, you can't define a pci mem->system mem window as "non
cacheable"; you can only specify what type of snooping you want (none,
WB or WT).  Caches are assumed to exist and be turned on.  If they
aren't, you can just specify "none" for your snooping option.

Thirdly, it has everything to do with pci mem->system mem windows
because that mapping points to normal old system memory that PCI devices
are going to DMA into and out of.  If CONFIG_NOT_COHERENT_CACHE is NOT
defined, the the processor will set M=1 for data mappings so the
processor will assume that when a PCI device DMAs into memory, the
bridge will follow whatever coherency protocol they've agreed upon
(i.e., all that MEI, MESI, MERSI stuff) so the processor can
flush/invalidate cachelines as necessary.  Everyone has to follow the
protocol or you will end up with stale cachelines and seemingly broken
I/O sooner or later.

So, if CONFIG_NOT_COHERENT_CACHE is not defined, we must set up the
snoop windows on the bridge to either WB or WT.  If we don't set the
snoop windows correctly, coherency will be broken.  Also remember that
when CONFIG_NOT_COHERENT_CACHE is not defined the pci_/dma_ calls that
drivers use are essentially null (i.e., no manual cache management).

If CONFIG_NOT_COHERENT_CACHE is defined, then M=0 and now we set the
snoop windows on the bridge to "none".  The pci_/dma_ calls used by
drivers manage the caches and, assuming the driver is correctly written,
I/O works.

The point is, the bridge snoop window setting have to match the M bit
the processor uses.

> You should be able to boost the IO
>throughput using non coherency without this errata impacting you any
>more than it already is.
>

Hopefully my comments above show that this statement is incorrect.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
