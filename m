Date: Sat, 28 Apr 2001 19:16:07 -0400 (EDT)
Message-Id: <200104282316.f3SNG7D365341@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linuxppc-embedded@lists.linuxppc.org
Cc: cort@fsmlabs.com, dan@mvista.com, Alexandre.Nikolaev@matrox.com
Subject: Re: ppc little-endian port
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Cort Dougan wrote:
>
>> Why?
>
> Yeah, we really don't care about little-endian.  Like I always
> say, getting a kernel built and booted is the easy part.  The
> entire world runs big endian tools, libraries and applications.
> Making all of that work is a task no one is going to tackle.

I'm going to tackle it. Alexandre Nikolaev already is tackling
it I guess.

Lots of PowerPC processors run in little-endian mode today.
They could be running Linux if the ppc port was as flexible
as the mips port. Modern medical scanners (CAT, MRI, PET...)
all use little-endian PowerPC processors. So if I need to get
my head examined, I'll be doing it with little-endian. :-)

Now that you know, please avoid writing endian-dependent code.
The hard-coded offsets that Alexandre Nikolaev had to change
should have been done with a #define. We're going to have to
fix this; expect patches within a year.

> While refreshing my PowerPC history the other day, I found a UISA
> book from 1991.....The Little-Endian Byte Ordering chapter introduction
> has this to say:
>
>         It is computed that eleven Thousand Persons have, at several
>         Times, suffered Death, rather than submit to break their
>         Eggs at the smaller End.  Many hundred large Volumes have been
>         published upon this Controversy...
>
>                         Jonathan Swift, "Gulliver's Travels"
>
> Later in the text it states "There are 24 ways to specify the
> ordering of four bytes withing a word, but only two of these
> orderings are sensible."
>
> I contend there is only one sensible ordering, and we are already
> using it.........

>From best to worst:

1. true little-endian, as found on IBM's 405 (and on x86)
2. true big-endian, default on the PowerPC
3. crappy "little-endian" hack, as found on Motorola's 7400
4. crappy "big-endian" hack, as found on the Alpha
5. anything else

Opinions on this don't matter when you put a 7400 on a PCI board
and try to share memory with an x86 host computer. In this case
you do whatever is needed to make user-space data structures look
the same to both processors. This may include both hardware and
compiler hacking, as well as the more obvious OS and libc hacks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
