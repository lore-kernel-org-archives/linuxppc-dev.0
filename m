To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 8xx_io/uart.c 
In-reply-to: Your message of "Tue, 11 Feb 2003 11:40:45 -0500"
             <3E49278D.3020306@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 12 Feb 2003 10:11:03 +1100
Message-ID: <23285.1045005063@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 11 Feb 2003 11:40:45 -0500, Dan Malek <dan@embeddededge.com> writes:
>I've looked at it.  I know it well.  I wrote it.  I know how its used.
>xmon and kgdb format their own strings/packets and expect read/write of
>a simple uart fifo.

The point was, and always has been, can it be guaranteed that kgdb/xmon will
never output a character with decimal value 10? As a simple logic exercise,
it cannot be guaranteed - of course, in practice it is unlikely to happen,
because they encode everything as two hex digits.

But someone in the future may decide to make everything scroll nicely on
output by adding a (redundant) linefeed to the end of every packet - then
the kernel starts crashing in early boot when KGDB or XMON is enabled and
they will have no idea why.

>> http://lists.linuxppc.org/linuxppc-embedded/200205/msg00268.html
>
>Well, ahhh, there isn't anything mentioned there about fixing bugs.

It wasn't mentioned because it is trivial - the code as it stood was
logically inconsistent - I fixed it, as have (many?) others.

>From
>your description it's all about yet another scc uart configuration method.
>I have lots of those on the shelf, all conflicting, that always seem to
>be useful to the person/platform/application.  The easiest way to keep
>everyone (un)happy is to leave things alone.  I used to apply those,
>a new one every other week, and the only person happy about it was the
>last one that had the patch applied.  :-)

This illustrates my point(s) - linuxppc on the 8260 is stuck with the amazingly
bad uart configuration/management arrangement it has had for years (and which
was spawned back in the 8xx days) because I don't work for the right company.

Like I said - I will shut up now - it isn't that important to me. I made my
points in the previous message, and it is on the public record (such as it
is), but now I don't want to distract either of us from our work. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
