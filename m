Message-ID: <3D86B6A4.7D77B588@koffie.nl>
Date: Tue, 17 Sep 2002 06:59:16 +0200
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Dave Engebretsen <engebret@vnet.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
References: <3D80F2F7.3FB3AE4B@koffie.nl> <3D8264FF.999DD217@vnet.ibm.com> <3D831BF6.EA2412E1@koffie.nl> <3D85F54F.5C0D9187@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dave Engebretsen wrote:
>
> Segher Boessenkool wrote:
> >
> > David Engebretsen wrote:
>
> > The 64-bit idea is very very nice :)  That'll allow a program to just set
> > the counters at the start of eexecution, and only read them again when it's
> > finished.  Can't get much simpler ;)
>
> Of course this depends on what you are trying to achive.  For profiling
> or when timeslicing the counters, this is not needed generally. If you
> want to just collect a fixed set of values over a long run, it is
> usefull.  This however is not the mode I have generally been finding
> useful.

Well, it's an easy way to see if a change in a program actually did help ;)

Note that the 32-bit (31, actually) counters can already overflow in about
one or two seconds.

> > I don't want to have the profiling buffers in kernel space, as they can very well
> > be bigger than physical memory...  On the other hand, it might be needed for
> > performance (or to avoid races) if doing very fine-grained profiling.  I think
> > I'll just sneak out of this by not allowing so fine-grained stuff ;)
>
> Not sure I follow here - allowing a profiling buffer which is even a
> fraction of total system memory will significantly perturb the data.

Not necessarily, like when counting number of insns completed, or something
like that.  But for most things, yes of course cache effects will be huge
with a profiling buffer >= 10% of L1 cache or so.  Even more so with bigger
buffers.


Cheers,

Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
