Date: Sat, 5 Jul 2003 11:55:08 +0200 (MEST)
From: Holger Bettag <hobold@informatik.uni-bremen.de>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: memmove broken
In-Reply-To: <20030705072119.GA32363@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.53.0307051135310.3848@bob.informatik.uni-bremen.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com>
 <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se>
 <16134.4102.899233.25492@cargo.ozlabs.ibm.com> <20030705072119.GA32363@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Jul 2003, [iso-8859-1] Jörn Engel wrote:

[...]
> > Why is it an issue?  Is the performance of the byte-by-byte loop
> > really a limiting factor for you?
>
> Not a limiting factor, but it should be noticable.  What is more
> important - in my eyes - is that we can replace magic with obvious
> code.
>
Doing runlength coding with LZ-style compressors is not magic, it's
actually a fairly old trick.

[...]
> memcpy has a very defined behaviour, as
> long as source and destination don't overlap at all or as the sourse
> is smaller, than the distination.  Cool.
>
The direction of memcpy is not guaranteed. Non-overlap is the only
situation when memcpy has portable behaviour.

[...]
> With that, source should always be smaller than destination for
> memcpy, so the implementation details don't matter, as long as memcpy
> doesn't do a reverse memcpy.
>
Not even a guarantee of direction helps, because memcpy might copy in
larger units than single chars. This also breaks the dependency chain of
an originally byte-wise copy. (If you copy in units of 32 bits, the first
char of the source block will definitely not be replicated over the
successive three chars, as a byte copy would do.)

> Plus, the zlib code is shorter and tells the reader exactly what it
> does, without the need for extra comments.
>
There is only one portable and correct way to use memcpy in an LZ
decompressor: the source data must be completely within the "past" part of
data (already decompressed, immutable), and the destination address must
be completely within the "future" part (the undefined memory buffer ahead of
the pointer to the current byte).

So you have to check if the ending address of the source block is smaller
than the current address (the "present moment"). In that case, memcpy will
work correctly no matter how it is implemented. Otherwise, you must use a
byte-wise copy, because the semantics of the compressed stream rely on
that.

If you want to optimize further, you can shorten source blocks to the
largest legal size (i.e. up to "present"), and recursively call memcpy
several times. This preserves the data dependencies as expected by the
decompressor, but allows you to call memcpy with exponentially increasing
block sizes.

Another optimization would be to check for a source block that is only a
single byte into the past, and then use memset to replicate it.

Anything else violates the assumptions made by the
compressor/decompressor.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
