MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16134.4102.899233.25492@cargo.ozlabs.ibm.com>
Date: Sat, 5 Jul 2003 09:38:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>,
	Jorn Engel <joern@wohnheim.fh-wedel.de>
Subject: RE: memmove broken
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se>
References: <16133.19178.764449.966821@cargo.ozlabs.ibm.com>
	<IGEFJKJNHJDCBKALBJLLOEPGFNAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund writes:

> Currenly this works, but it is PPC specific:
> static inline void memcpy_update(Byte **dest, Byte **src, size_t *n)
> {
>   if(*dest - *src <= 8){ /* memcpy on PPC will do 8 bytes in a chunk */
>     **dest = **src;
>     --(*n);
>     do {
>       *++(*dest) = *++(*src);
>     } while (--(*n));
>     (*dest)++;  (*src)++;
>   } else {
>     memcpy(*dest, *src, *n);
>     *dest += *n;
>     *src += *n;
>     *n = 0;
>   }

Why is it an issue?  Is the performance of the byte-by-byte loop
really a limiting factor for you?

In general the behaviour of memcpy with overlapping regions is very
implementation-dependent.  If we use the code above then that would
place constraints on what we can do in memcpy - and very non-obvious
constraints at that.  For example if we decided to use altivec loads
and stores in memcpy, it would then do 16 or 32 bytes in a chunk and
thus break zlib again.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
