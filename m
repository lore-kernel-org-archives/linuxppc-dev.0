To: Tom Rini <trini@kernel.crashing.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 19 Mar 2002 15:44:20 MST."
             <20020319224420.GO3762@opus.bloom.county>
Date: Wed, 20 Mar 2002 00:00:18 +0100
Message-Id: <20020319230023.8D72C109F3@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20020319224420.GO3762@opus.bloom.county> you wrote:
>
> > BI_GT64260_ETH_CFG to a more generic BI_ETH_CFG.
>
> I don't know about this.  Why?  From what I can tell, this is something
> that will be useful for 8xx/8260, but would require changing the driver
> to know about this, and it's currently over bd_t, and I'd rather leave
> it for now.

I  have  seen  enough  requests  for   a   more   flexible   ethernet
configuration  (systems with 2 or 3 or more ethernet interfaces) that
I'm willing to adapt the 8xx and  82xx  drivers  rather  sooner  than
later.

BTW: the structure should probably be extended by one entry  for  the
interface (eth0, eth1, etc...).

> > New (and [pretty much] generic):
> > --------------------------------
> >   BI_MEMSTART -- mem start
>
> GT-64260 doesn't use this, does it?  We'll need this for Nubus and other
> discontig memory situations, but not right now (except for APUS).

How about my proposal to replace MEMSIZE and  MEMSTART  with  a  more
general description which allows for _several_ memory areas, probably
of  different type (RAM, ROM, Flash, SRAM, ...), different bus witdth
etc. ?

For instance, we have MPC8260 systems with both global and local  RAM
which  are  not  contiguous  (they  could  be,  but it makes no sense
anyway).

How to handle this?

We have boards with several flash banks - one 8 bit wide,  the  other
64 bit.

Etc. etc. IMHO we should do it right from the  beginning  and  use  a
more flexible way to describe memory.

You can probably #define a simple macro for backward compatibility.

> >   BI_INTFREQ -- internal CPU frequency??
> >   BI_BUSFREQ -- CPU bus freqency?
> >   BI_ETH_CFG -> struct with following:
> >    -- mac addr
> >    -- hdx/fdx; 10/100/1000/...; OR autonegotiate
> >    -- phy addr
> >    -- some bytes for driver specific info (e.g., on gt64260, is_rmii)

==> please add interface (index)

> >   BI_BAUDRATE -- Console baudrate
>
> Is this actually needed?  iirc, the ns1655x serial driver _should_ pick
> up what things are running at.  But either way I don't see how we'd use
> this, except in custom serial drivers.

Yes, This _is_ necessary. Not every board has a ns1655x UART.

> >   BI_IMMRBASE -- Base Address of CPU internal memory (82xx/8xx only)
> >   BI_SCCFREQ  -- SCC frequency in Hz (82xx, 8xx only)
>
> See my comment about about bd_t stuffs.  I don't think bi_recs will
> become useful to PPCBoot until 2.5, when we can expand/otherwise flesh

You are wrong. We'll switch faster than you seem to think.

> out things and be done with it, and use it in 2.6.0.

Why postpone a decision that will make life easier to us?

We have these requirements NOW, and no clean way to solve them. Let's
do it NOW.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
