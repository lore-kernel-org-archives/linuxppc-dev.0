Date: Sat, 6 Jan 2001 17:14:07 -0500
From: drscholl <drscholl@users.sourceforge.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org, drscholl@users.sourceforge.net
Subject: Re: Endianness and comparing IP's
Message-ID: <20010106171407.A68753@frostedflakes.neglected.net>
References: <20010106012137.8A8651BFBA@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010106012137.8A8651BFBA@atlas.valhalla.net>; from iain@sandoe.co.uk on Sat, Jan 06, 2001 at 12:22:33AM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 06, 2001 at 12:22:33AM +0000, Iain Sandoe wrote:
> more to the point is that there are a set of macros/functions designed for
> this purpose (try man htons)... which avoids thinking to hard about
> transferring between endian-ness of machines.
>
> I'm not sure why the BSWAP32 is being used instead of one of the network
> macros... maybe a red-herring but...

Unfortunately Napster, Inc. chose to use little-endian format IP addresses
in the protocol, so the traditional htonl() macros aren't useful in
this case.  What gets stored in the context for the connection is the
little-endian version so that each time the ip address is sent as part
of the protocol, there is no need for bit manipulation.  The particular check
that Alex set has the IP address in network byte order (from the
gethostbyname() call), so its *required* that the bits be swapped to check
against what is stored in the context.

All of the ints in question are unsigned, so there isn't an issue of
conversion (I beleive gcc -W -Wall -pedantic would have warned if you
tried to do a comparison of different types, anyway).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
