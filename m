Message-Id: <v04003a00b5614aa89cff@[24.66.67.194]>
In-Reply-To: <200006050548.HAA00780@piglet.grunz.lu>
References: <20000604104844.A13914@quaketop.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 5 Jun 2000 07:40:22 -0500
To: mlan@cpu.lu, drow@false.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: [patch] VRAM detection in controlfb
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:48 AM -0500 6/5/2000, Michel Lanners wrote:
>On   4 Jun, this message from Daniel Jacobowitz echoed through cyberspace:
>>
>> On Sun, Jun 04, 2000 at 10:08:39AM -0500, Tony Mantler wrote:
[...]
>>> If you have a block that's both dirty and incoherent... well, don't do
>>>that. :)
>>
>> Ew.  I wonder if that's our problem...
>
>Would make sense, and I thought so too.... dcbi is wrong in any case for
>us, since we did modify that block. However, I wonder whether caching is
>on at all for the framebuffer adresses? (And if so, is that a good idea?
>Do we want to trash the cache with a xsetroot?)

I'm not sure of the design specifics of the Control video, but most of the
Apple video designs I've seen put the high-bandwidth low-latency video ram
right on the main bus, so it's already half way to being a cache in and of
itself (I seem to recall apple's sound manager using vram for buffer
space), and would benefit very little from the CPU cache, except perhaps in
a multi-cpu machine to keep bus chatter down to a minimum, but the exact
tradeoffs of that would take a bit of consideration to quantify.

Besides that, unlike main ram, what has and hasn't been written back to the
framebuffer makes a big difference in what you see on screen. Caching would
probably make for some mighty weird flicker, jumpy or inconsistent video
playback, and all sorts of evil visual gremlins. You could always cache the
framebuffer as write-through, but then any value you might have got from
the caching goes right out the window, as framebuffer writes should
outnumber framebuffer reads by an order of magnitude.

Anyways, that's the long answer. The short answer is: no, you probably
don't want to cache the framebuffer.


Cheers - Tony :)


--
Tony Mantler       Renaissance Nerd Extraordinaire     nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada                     http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
