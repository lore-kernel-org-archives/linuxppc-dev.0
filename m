MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16133.7153.556139.440023@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jul 2003 16:17:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: memmove broken
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEPCFNAA.joakim.tjernlund@lumentis.se>
References: <IGEFJKJNHJDCBKALBJLLKEPCFNAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund writes:

> I just tried to used memmove in zlib(zlib_inflate_fast) to avoid expensive
> byte copies. That didn't work and the reason is that the ppc memmove can handle
> overlapping memory it seems.

I assume you mean "can't handle"?

If so, this is interesting because it is supposed to work. :)

> memmove(dst, dst-x, n) where x is between 1 and 39, n >= x will cause corruption for me.

Gack.  It should be using backwards_memcpy in arch/ppc/lib/string.S.
I'll have to take a look at it.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
