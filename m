Date: Sat, 6 Jan 2001 17:39:24 -0500
From: drscholl <drscholl@users.sourceforge.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: drscholl <drscholl@users.sourceforge.net>,
        "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Endianness and comparing IP's
Message-ID: <20010106173924.A71273@frostedflakes.neglected.net>
References: <20010106232734.85CF11BF77@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010106232734.85CF11BF77@atlas.valhalla.net>; from iain@sandoe.co.uk on Sat, Jan 06, 2001 at 10:28:48PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 06, 2001 at 10:28:48PM +0000, Iain Sandoe wrote:
> > All of the ints in question are unsigned, so there isn't an issue of
> > conversion (I beleive gcc -W -Wall -pedantic would have warned if you
> > tried to do a comparison of different types, anyway).
>
> probably (but it wouldn't be difficult to check that anyway).

Yes, I did verify that they are all unsigned int, not just relying on
that.  :-)

> What is the code for the BSWAP32 macro?
> ...and what asm does it produce?
> (or does it use __asm() statements?)

/* convert the bytes of a 32-bit integer to little endian */
#define BSWAP32(c)
((c>>24)&0xff)|((c>>8)&0xff00)|((c<<8)&0xff0000)|(c<<24)

> (or are you convinced it is OK?)

Seems to work fine under Solaris, otherwise nobody would be able to
download anything because the IP address would be reversed.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
