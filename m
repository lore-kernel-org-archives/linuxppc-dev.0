Date: Sat, 5 Jul 2003 19:01:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: joakim.tjernlund@lumentis.se,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
Message-ID: <20030705170145.GA29928@wohnheim.fh-wedel.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com> <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se> <16134.4102.899233.25492@cargo.ozlabs.ibm.com> <20030705072119.GA32363@wohnheim.fh-wedel.de> <16134.52251.943207.814024@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <16134.52251.943207.814024@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 July 2003 23:01:15 +1000, Paul Mackerras wrote:
> >
> > Not a limiting factor, but it should be noticable.  What is more
> > important - in my eyes - is that we can replace magic with obvious
> > code.
>
> You are proposing to replace simple, working code with considerably
> more complex code.  You need to be able to point to a specific real
> situation where your change makes a significant difference if you want
> to get it accepted.

Agreed.  And even then, I don't want to submit it before 2.7.

> If the behaviour of the copy loop is non-obvious then the thing to do
> is to add a comment rather than make it more complicated.

This may be highly subjective, but I consider the existing code to be
more complicated.

*q++ = *r++; c--;
*q++ = *r++; c--;

Those two lines are found three times in the current code.  Why?  Loop
unrolling, nothing but an optimization, and not a very good one, if
you look at current cpus.

> The behaviour is defined as long as source and destination don't
> overlap.  You get no guarantees from having source < destination.  It
> could quite legitimately copy backwards in all situations, or work
> exactly the same as memmove.

Also agreed.  It is hard to imagine a sane implementation that doesn't
give these guarantees, but that doesn't mean much.

> Well no, I think it still isn't right.  What if the length is large
> but dst - src == 2 (e.g. if you compress "abababababab") or 3 (e.g. if
> you compress "abcabcabcabcabc")?  Or 4 or 5 or ...?  You will end up
> with an awfully large number of special cases.

That would really make my approach more complicated.  Back to the
drawing board then...

Jörn

--
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
