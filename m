Date: Fri, 04 Jul 2003 13:07:53 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: memmove broken
In-reply-to: <16133.19178.764449.966821@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>,
	Jorn Engel <joern@wohnheim.fh-wedel.de>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > I just realized that there is something strange going on in zlib.
> > zlib_inflate_fast() does a standard byte copy:
> > do{
> >   *q++ = *r++;
> > while(--c); /* c >= 3 */
> >
> > q is always greater than r and this works. This is something else than a
> > regular mem copy. I havn't figured out yet what is happening here but I don't
> > think there is a problem with backwards_memcpy()
>
> Ah. Yes.  This is actually quite clever.  If you have for example 256
> zero bytes to compress, zlib will output a single literal zero byte
> and then a block reference of length 255 and offset -1, saying that
> the block from 1..255 is the same as the block from 0..254.  So the
> fact that it copies forwards byte by byte is essential.  So you
> couldn't use memcpy() either since it copies in larger chunks than 1
> byte.

I see, thanks.

Currenly this works, but it is PPC specific:
static inline void memcpy_update(Byte **dest, Byte **src, size_t *n)
{
  if(*dest - *src <= 8){ /* memcpy on PPC will do 8 bytes in a chunk */
    **dest = **src;
    --(*n);
    do {
      *++(*dest) = *++(*src);
    } while (--(*n));
    (*dest)++;  (*src)++;
  } else {
    memcpy(*dest, *src, *n);
    *dest += *n;
    *src += *n;
    *n = 0;
  }

Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
