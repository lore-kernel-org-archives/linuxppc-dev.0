Date: Sat, 5 Jul 2003 09:21:19 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: joakim.tjernlund@lumentis.se,
	"Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
Message-ID: <20030705072119.GA32363@wohnheim.fh-wedel.de>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com> <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se> <16134.4102.899233.25492@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <16134.4102.899233.25492@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 July 2003 09:38:46 +1000, Paul Mackerras wrote:
> Joakim Tjernlund writes:
>
> > Currenly this works, but it is PPC specific:
> > static inline void memcpy_update(Byte **dest, Byte **src, size_t *n)
> > {
> >   if(*dest - *src <= 8){ /* memcpy on PPC will do 8 bytes in a chunk */
> >     **dest = **src;
> >     --(*n);
> >     do {
> >       *++(*dest) = *++(*src);
> >     } while (--(*n));
> >     (*dest)++;  (*src)++;
> >   } else {
> >     memcpy(*dest, *src, *n);
> >     *dest += *n;
> >     *src += *n;
> >     *n = 0;
> >   }
>
> Why is it an issue?  Is the performance of the byte-by-byte loop
> really a limiting factor for you?

Not a limiting factor, but it should be noticable.  What is more
important - in my eyes - is that we can replace magic with obvious
code.

> In general the behaviour of memcpy with overlapping regions is very
> implementation-dependent.  If we use the code above then that would
> place constraints on what we can do in memcpy - and very non-obvious
> constraints at that.  For example if we decided to use altivec loads
> and stores in memcpy, it would then do 16 or 32 bytes in a chunk and
> thus break zlib again.

That should not be a problem.  memcpy has a very defined behaviour, as
long as source and destination don't overlap at all or as the sourse
is smaller, than the distination.  Cool.

We should be able to do something like this in the zlib:
if (repeat one byte over and over) /* undefined behaviour for memcpy */
	memset();
else {
	if (copy is wrapped) {
		memcpy(wrapped part);
		tweak pointers;
	}
	memcpy();

With that, source should always be smaller than destination for
memcpy, so the implementation details don't matter, as long as memcpy
doesn't do a reverse memcpy.

Plus, the zlib code is shorter and tells the reader exactly what it
does, without the need for extra comments.

Jörn

--
Don't worry about people stealing your ideas. If your ideas are any good,
you'll have to ram them down people's throats.
-- Howard Aiken quoted by Ken Iverson quoted by Jim Horning quoted by
   Raph Levien, 1979

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
