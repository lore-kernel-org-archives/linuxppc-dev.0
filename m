From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15542.55726.605404.888541@argo.ozlabs.ibm.com>
Date: Fri, 12 Apr 2002 22:57:18 +1000 (EST)
To: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <0204110308.AA27139@ivan.Harhan.ORG>
References: <0204110308.AA27139@ivan.Harhan.ORG>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov writes:

> > A laudable goal.  I like the idea of having each platform selected
> > with a bool rather than just having a single choice of platform.
>
> So how about pushing it into 2_4_devel?

When I'm happy with the implementation, sure.

> > However, there are some aspects of the way you have done your
> > CONFIG_GENERIC_PPC32 that I don't like.
>
> So can you promise that if I change those to the way you said you'll accept my
> patch into 2_4_devel? Without that there is no incentive for me to do any more
> work.

How can I promise to accept code that I haven't yet seen?  I can (and
do) promise to take a good look at it and seriously consider it,
though.

> > Instead I think that both the names of the pieces of information, and
> > the values of things like the device type, should be represented as
> > strings.  Using strings just gives us orders of magnitude more
> > flexibility and extensibility, and is much more suitable for the sort
> > of decentralized and distributed development that we do.
>
> But this is not how bi_recs work. Do you want to break compatibility with the
> existing bi_recs, to add a whole new boot info mechanism independent of
> bi_recs, or what? And if I am to implement it, I need to be given some kind of
> spec as to what to implement.

I think there are two tenable positions: the first is to have very
simple bi_recs, i.e. basically what we have at the moment, that convey
a small number of global pieces of information about the system.  If
we really need to convey information about individual devices then I
think we want something approaching the OF device tree, which is a
flexible and extensible structure that conveys arbitrary information
about the devices and their relationships very well.  So the second
position is to encode information about devices as a set of
properties, each of which has a string name and a value which is an
array of bytes.  In this case we would probably have one bi_rec per
device.  Ideally we would also have parent/child/sibling pointers for
each device as well.

> On all machines I've supported so far one of the system serial ports that are
> supported in this manner is the system console and the serial driver therefore
> has to be compiled in anyway. I don't see a problem with making a requirement
> that the serial driver be compiled in for CONFIG_GENERIC_PPC32. After all, we
> are not dealing with a PeeCee where the serial ports are an auxiliary feature,
> we are dealing with real computers where the system serial ports are central
> system resources like on a VAX.

Except on a powermac, as Ben has pointed out in another message.

One solution to the problem of the serial driver as a module is to
have the serial.o module have an empty rs_table (so it assumes no
ports when it loads), and then have a ppc_serial module which does
whatever magic is needed to find out about the serial ports on the
system and calls register_serial for each one.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
