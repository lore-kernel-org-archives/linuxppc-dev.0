MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <16134.52251.943207.814024@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jul 2003 23:01:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: joakim.tjernlund@lumentis.se,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
In-Reply-To: <20030705072119.GA32363@wohnheim.fh-wedel.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com>
	<IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se>
	<16134.4102.899233.25492@cargo.ozlabs.ibm.com>
	<20030705072119.GA32363@wohnheim.fh-wedel.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jörn Engel writes:

> > Why is it an issue?  Is the performance of the byte-by-byte loop
> > really a limiting factor for you?
>
> Not a limiting factor, but it should be noticable.  What is more
> important - in my eyes - is that we can replace magic with obvious
> code.

You are proposing to replace simple, working code with considerably
more complex code.  You need to be able to point to a specific real
situation where your change makes a significant difference if you want
to get it accepted.

If the behaviour of the copy loop is non-obvious then the thing to do
is to add a comment rather than make it more complicated.

> That should not be a problem.  memcpy has a very defined behaviour, as
> long as source and destination don't overlap at all or as the sourse
> is smaller, than the distination.  Cool.

The behaviour is defined as long as source and destination don't
overlap.  You get no guarantees from having source < destination.  It
could quite legitimately copy backwards in all situations, or work
exactly the same as memmove.

> We should be able to do something like this in the zlib:
> if (repeat one byte over and over) /* undefined behaviour for memcpy */
> 	memset();
> else {
> 	if (copy is wrapped) {
> 		memcpy(wrapped part);
> 		tweak pointers;
> 	}
> 	memcpy();
>
> With that, source should always be smaller than destination for
> memcpy, so the implementation details don't matter, as long as memcpy
> doesn't do a reverse memcpy.
>
> Plus, the zlib code is shorter and tells the reader exactly what it
> does, without the need for extra comments.

Well no, I think it still isn't right.  What if the length is large
but dst - src == 2 (e.g. if you compress "abababababab") or 3 (e.g. if
you compress "abcabcabcabcabc")?  Or 4 or 5 or ...?  You will end up
with an awfully large number of special cases.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
