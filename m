Date: Fri, 04 Jul 2003 10:32:50 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: memmove broken
In-reply-to: <16133.7153.556139.440023@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEPEFNAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Joakim Tjernlund writes:
>
> > I just tried to used memmove in zlib(zlib_inflate_fast) to avoid expensive
> > byte copies. That didn't work and the reason is that the ppc memmove can handle
> > overlapping memory it seems.
>
> I assume you mean "can't handle"?

Yes :)
>
> If so, this is interesting because it is supposed to work. :)
>
> > memmove(dst, dst-x, n) where x is between 1 and 39, n >= x will cause corruption for me.
>
> Gack.  It should be using backwards_memcpy in arch/ppc/lib/string.S.
> I'll have to take a look at it.

Paul,
I just realized that there is something strange going on in zlib.
zlib_inflate_fast() does a standard byte copy:
do{
  *q++ = *r++;
while(--c); /* c >= 3 */

q is always greater than r and this works. This is something else than a
regular mem copy. I havn't figured out yet what is happening here but I don't
think there is a problem with backwards_memcpy()

    Jocke


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
