Date: Sun, 12 Aug 2001 11:59:03 +0100
Subject: Re: Fix for PPC audio devices that can't reendianize samples
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010812110432.463FB2F068@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Sun, Aug 12, 2001,  Geert Uytterhoeven wrote:
> On Sun, 12 Aug 2001, Iain Sandoe wrote:
>> On Sat, Aug 11, 2001,  Geert Uytterhoeven wrote:
>> > On Fri, 10 Aug 2001, Iain Sandoe wrote:
>> (a) working out what to do about mksound() - this is messy as it is and
>> needs fixing in order to deal with DACA & Tumbler (it fiddles with the H/W
>> which makes it chip-specific at present)...
>
> Yes, mksound() messes with the sound hardware on most m68k boxes too.

right.

> Perhaps we should make it more generic, and move it to dmasound?

My thoughts of the last few weeks are along these lines...

At the moment we (PPC/PMac) have a wavetable synthesis of the beep in
dmasound_awacs.c.  Unfortunately, it changes sample-rate and AFMT settings
in a way that is quite AWACS/Screamer/Burgundy - specific... this must
altered to implement DACA & Tumbler drivers properly (we have temporary
separate hacks for these at the moment).

What I was thinking of doing is moving the WT synthesis into dmasound_core.c
and implementing it by mixing the beep into the incoming sound stream.  The
the wavetable parameters would be driven by current AFMT/sample rate
settings (rather than changing them to-and-fro 'behind the back' of
dmasound_core.c).

Of course, that works for any Low-Level driver backed onto dmasound_core.c
(including all the m68k ones)...  and we can lose all the chip-specific
mksound code from the LL drivers.

there are two objections to this:

(a) This is not quite 'zero-kernel-code' (the mixing will require some
arithmetic in a per-sample loop)

- it would be better (and more flexible) if the mksound beep was generated
by User-land code and mixed via something like aRtsd ... but, of course,
that imposes a requirement to have such a thing running to have console beep
(at least on PMac PPC)... which might not suit everyone.

(b) it would mean that mksound would cease to function if mmio is
implemented and that mode is in use.  However, AFAICT this second point is
pretty un-solvable...

> The disadvantage is that you can't get system beep anymore without dmasound.

well, PPC/PMac doesn't have mksound without dmasound anyway.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
