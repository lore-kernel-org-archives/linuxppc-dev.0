Message-ID: <005501c34305$f8c4f260$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Paul Mackerras" <paulus@samba.org>,
	"J?rn Engel" <joern@wohnheim.fh-wedel.de>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com><IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se><16134.4102.899233.25492@cargo.ozlabs.ibm.com><20030705072119.GA32363@wohnheim.fh-wedel.de> <16134.52251.943207.814024@cargo.ozlabs.ibm.com>
Subject: Re: memmove broken
Date: Sat, 5 Jul 2003 16:57:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > We should be able to do something like this in the zlib:
> > if (repeat one byte over and over) /* undefined behaviour for memcpy */
> > memset();
> > else {
> > if (copy is wrapped) {
> > memcpy(wrapped part);
> > tweak pointers;
> > }
> > memcpy();
> >
> > With that, source should always be smaller than destination for
> > memcpy, so the implementation details don't matter, as long as memcpy
> > doesn't do a reverse memcpy.
> >
> > Plus, the zlib code is shorter and tells the reader exactly what it
> > does, without the need for extra comments.
>
> Well no, I think it still isn't right.  What if the length is large
> but dst - src == 2 (e.g. if you compress "abababababab") or 3 (e.g. if
> you compress "abcabcabcabcabc")?  Or 4 or 5 or ...?  You will end up
> with an awfully large number of special cases.

Hi,
sorry for being a bit late to reply, but as of now I am on vacation.

This works and does not depend on any arch or memcpy/memmove impl. details:

static inline Byte * memmove_update(Byte *dest, Byte *src, size_t n)
{
/* n is always >= 3 and dest > src */
  Byte *ret = dest + n;

  if (dest - src >= n)
      memmove(dest, src, n); /* no overlapping here */
  else if(dest - src == 1)
      memset(dest, *src, n); /* special case of the pattern copy loop below, can be removed  */
  else {
     /* 1 > dest - src < n */
     /* copy patten at *src to *dest, pattern len is dest - src */
     /* one could use 2 byte chunks here, since dest - src is >= 2 */
    *dest = *src;
    --n;
    do {
      *++dest = *++src;
    } while (--n);
  }
  return ret;
}

simple enough?

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
