From: Michel Lanners <mlan@mcp.cpu.lu>
Message-Id: <200006051351.PAA19854@mcp.cpu.lu>
Subject: Re: [patch] VRAM detection in controlfb
To: nicoya@apia.dhs.org (Tony Mantler)
Date: Mon, 05 Jun 2000 15:51:47 METDST
Cc: mlan@cpu.lu, drow@false.org, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <v04003a00b5614aa89cff@[24.66.67.194]>; from "Tony Mantler" at Jun 5, 100 7:40 am
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

[about caching and framebuffers]
> I'm not sure of the design specifics of the Control video, but most of the
> Apple video designs I've seen put the high-bandwidth low-latency video ram
> right on the main bus, so it's already half way to being a cache in and of
> itself (I seem to recall apple's sound manager using vram for buffer
> space), and would benefit very little from the CPU cache, except perhaps in
> a multi-cpu machine to keep bus chatter down to a minimum, but the exact
> tradeoffs of that would take a bit of consideration to quantify.

In the case of control, the VRAM seems to be the same basic type as main
RAM (i.e. 60/70ns DRAM), and it is conceptually behind a PCI bridge. So
by itself it is not faster than main RAM....

> Besides that, unlike main ram, what has and hasn't been written back to the
> framebuffer makes a big difference in what you see on screen. Caching would
> probably make for some mighty weird flicker, jumpy or inconsistent video
> playback, and all sorts of evil visual gremlins. You could always cache the
> framebuffer as write-through, but then any value you might have got from
> the caching goes right out the window, as framebuffer writes should
> outnumber framebuffer reads by an order of magnitude.

The main reason for marking the VRAM cacheable (_how_ is a different story)
would be so that the CPU can burst to it; the net result being (as I have
understood it, but I may be wrong) that the CPU can fill the PCI bridge's
buffer with fast burst writes, and let the bridge take care of getting
the data to VRAM. According to Apple's doc on their PCI implementation,
all address space excpet main RAM is marked uncacheable by default, but
only cacheable space gets bursted to by the CPU.

So I guess the optimum would be to mark the VRAM cacheable, but in a way that
writes don't go into the cache. Would that be write-through?

> Anyways, that's the long answer. The short answer is: no, you probably
> don't want to cache the framebuffer.

Except for the above reasons ;-)

Cheers

Michel
-------------------------------------------------------
.sig enjoying a day off

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
