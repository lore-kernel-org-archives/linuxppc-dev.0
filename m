From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104302214.f3UMEsn143131@saturn.cs.uml.edu>
Subject: Re: ppc little-endian port
To: dan@mvista.com (Dan Malek)
Date: Mon, 30 Apr 2001 18:14:54 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
	linuxppc-embedded@lists.linuxppc.org, cort@fsmlabs.com,
	Alexandre.Nikolaev@matrox.com
In-Reply-To: <3AED9DB8.7B15F60D@mvista.com> from "Dan Malek" at Apr 30, 2001 01:15:36 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> "Albert D. Cahalan" wrote:

>> I'm going to tackle it. Alexandre Nikolaev already is tackling
>> it I guess.
>
> That's way beyond the scope of discussion or interest on this
> list.  Make sure you contact the proper tools, library, and
> application folks.

Huh? This is the linuxppc-embedded list if I'm not mistaken.
Do you mean that this discussion belongs on a list where the
workstation developers can participate?

(ouch, must switch mode after calling Open Firmware)

>> Lots of PowerPC processors run in little-endian mode today.
>
> Lots?  Maybe a few.  Since the first days of PowerPC I have only
> seen one ill-fated attempt.  Every time I'm part of a PPC silicon
> design discussion the question is always raised whether it is
> worth wasting silicon trying to support it.

Dropping little-endian would seriously piss off Motorola's #2
customer for high-end PowerPC chips.

> It's getting harder to use little endian on PowerPC.  The 7450 has
> only a big endian bus, with some weird lane swapping internally.

This matters for what, IO accesses? Normal memory access is in
large chunks to feed the cache. The 7450 manual looks an awful
lot like the 7400 manual. Perhaps you can supply a chapter and
section number.

> Misaligned little endian accesses still cause processor exceptions,

Good. Misaligned big-endian accesses perform poorly. The mere
existance of a little-endian port will help you get better
performance in big-endian mode because the bad alignment gets
cleaned up.

> and the 7450 states it doesn't support it at all (some contradiction
> here), so you are always at a performance disadvantage when using
> it.  Besides, the bytes are all backward from the normal order of
> the world and you end up spending cycles swapping them, anyway :-).

The normal order of the world is little-endian, given the
dominance of PCI and PC data formats. Big-endian is a mistake
that won't die because it was written into network standards.

Performance? Here: lhbrx, lwbrx, sthbrx, stwbrx

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
