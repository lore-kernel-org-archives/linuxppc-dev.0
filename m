Date: Sat, 06 Jan 2001 22:28:48 +0000
Subject: Re: Endianness and comparing IP's
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: drscholl <drscholl@users.sourceforge.net>
Cc: "Clayton,Keith - Programmer" <Clayton@ltcc.cc.ca.us>,
        "'alex@cosmo.allay.net'" <alex@cosmo.allay.net>,
        linuxppc-dev@lists.linuxppc.org, drscholl@users.sourceforge.net
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010106232734.85CF11BF77@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sat, Jan 6, 2001, drscholl wrote:

>> more to the point is that there are a set of macros/functions designed for
>> this purpose (try man htons)... which avoids thinking to hard about
>> transferring between endian-ness of machines.
>>
>> I'm not sure why the BSWAP32 is being used instead of one of the network
>> macros... maybe a red-herring but...
>
> Unfortunately Napster, Inc. chose to use little-endian format IP addresses
> in the protocol,

sheesh...

> so the traditional htonl() macros aren't useful in
> this case.  What gets stored in the context for the connection is the
> little-endian version so that each time the ip address is sent as part
> of the protocol, there is no need for bit manipulation.  The particular check
> that Alex set has the IP address in network byte order (from the
> gethostbyname() call), so its *required* that the bits be swapped to check
> against what is stored in the context.

fair enough. (I did admit it might be a red-herring ;-)

> All of the ints in question are unsigned, so there isn't an issue of
> conversion (I beleive gcc -W -Wall -pedantic would have warned if you
> tried to do a comparison of different types, anyway).

probably (but it wouldn't be difficult to check that anyway).

What is the code for the BSWAP32 macro?
...and what asm does it produce?
(or does it use __asm() statements?)

(or are you convinced it is OK?)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
