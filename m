Message-ID: <3AC0EF44.E2BCE2F6@mvista.com>
Date: Tue, 27 Mar 2001 14:51:32 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Cc: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>,
	linuxppc-commit@fsmlabs.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PVR hell
References: <Pine.HPX.4.10.10103271719590.392-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gabriel Paubert wrote:
>
> On Tue, 27 Mar 2001, Benjamin Herrenschmidt wrote:
>

> > Currently we have bloat of code testing against PVR,

I have been thinking of this quite a bit recently because most of
my projects are new processors with different PVRs.  Fortunately, I
believe a majority of conditional execution is done only at set up
time, so it shouldn't be a major concern.  I would like to find a way
to opimize some of the more frequent cache management.....

> .... in different ways &
> > places, sometimes using constants, sometimes, not, and possibly missing
> > some CPUs (in fact, we do miss some: with the 7410 used in the TiPB, we
> > will miss the L2 cache and Altivec).

With 7450, we not only miss it but there are changes in bit positions
in HID0, more things to enable/initialize, and the addition of the L3
cache.

> That's exactly why I did not like the solution of emulting mfpvr in user
> space: applications or libraries using Altivec on a 7400 will have to be
> at least recompiled when run on later processors.

That has nothing to do with emulating mfpvr (which I think most people
don't like because they didn't think of it first :-).  You can't predict
the future, only anticipate what may be coming and be prepared.  You
would have to recompile software in any case, and worse link against
a specific library for all Altivec processors.  We have to even do it
again for 7450 even if we got it right for 7410.  The real advantage to
doing this is we have a single set of library functions, that once we
add something for the new processor all of the older ones will continue
to work just fine.  The funny thing is, in the kernel we seem very
sensitive to any extra instruction we execute to help with such
modularity,
but we fully expect user applications to operate this way.

I think we should just continue the ppc_md indirect function call
concept and just use it earlier in the kernel for more things.  All
of the low level initialization in 'head.S' or other processor specific
things in other files should just be indirect fucntion calls that are
processor specific.  Sure makes porting and understanding the software
much easier.


> I basically agree for now (the definitive solution would be a boot time
> link of all the critical code, but that's a long term project).

It's kind of hard to link in a cache invalidate function when you
need a cache invalidate function for the linking (for example).  It
would
also be nice if people keep in mind that a majority of systems running
Linux today are not desktops with lots of flexibility and disk
drives......

Thanks.


	-- Dan

>
>         Regards,
>         Gabriel.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
