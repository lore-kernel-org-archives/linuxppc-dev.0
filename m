MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16133.19178.764449.966821@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jul 2003 19:37:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: memmove broken
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEPEFNAA.joakim.tjernlund@lumentis.se>
References: <16133.7153.556139.440023@cargo.ozlabs.ibm.com>
	<IGEFJKJNHJDCBKALBJLLOEPEFNAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund writes:

> I just realized that there is something strange going on in zlib.
> zlib_inflate_fast() does a standard byte copy:
> do{
>   *q++ = *r++;
> while(--c); /* c >= 3 */
>
> q is always greater than r and this works. This is something else than a
> regular mem copy. I havn't figured out yet what is happening here but I don't
> think there is a problem with backwards_memcpy()

Ah. Yes.  This is actually quite clever.  If you have for example 256
zero bytes to compress, zlib will output a single literal zero byte
and then a block reference of length 255 and offset -1, saying that
the block from 1..255 is the same as the block from 0..254.  So the
fact that it copies forwards byte by byte is essential.  So you
couldn't use memcpy() either since it copies in larger chunks than 1
byte.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
