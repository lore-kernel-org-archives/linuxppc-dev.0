In-Reply-To: <19991122144054.C12973@hq.fsmlabs.com>
Date: Tue, 23 Nov 1999 11:40:01 +0100
To: Cort Dougan <cort@fsmlabs.com>, linuxppc-dev@lists.linuxppc.org,
        paulus@linuxcare.com
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: bootloader & head.S weirdness (patch)
Message-Id: <19991123114001.002761@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 22, 1999, Cort Dougan <cort@fsmlabs.com> wrote:

>I'll check this patch with the latest 2.2 to see how it goes.  Would using
>the bootinfo structure we talked about a few weeks ago help?  I'd like to
>unify things a bit with it but I'm not sure how many problems it would
>solve and how many it could cause.

I'd really like to see this happen. There is really an urgent need to
cleanup the mess with initrd and the way the command line is passed to
the kernel too and this would get rid of those.

There is one idea suggested to me by Gabriel Paubert which would be worth
considering:

Define some kind of bootx-like bootinfo structure (will all addresses
relative to the beginning of the structure) and move out of the kernel
_all_ those head.S hacks AND all the prom_init code (reading the OF tree,
initing the display, instanciating RTAS, ...).

All this would be done from a head-appended bootloader which would built
a device tree when OF is available, and then enter the kernel with a
unified entry point based on a structure, known mappings.

I don't know if it's worth doing that _now_ (it involves almost breaking
everything), but I like the idea of cleaning all this up.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
