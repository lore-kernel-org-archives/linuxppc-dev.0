Date: Sat, 14 Sep 2002 20:37:21 -0500
From: Rob Latham <rob@terizla.org>
To: Segher Boessenkool <segher@koffie.nl>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: Performance Monitor Counters device
Message-ID: <20020915013721.GH1169@terizla.org>
References: <3D80F2F7.3FB3AE4B@koffie.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D80F2F7.3FB3AE4B@koffie.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 12, 2002 at 10:03:02PM +0200, Segher Boessenkool wrote:

> Now the questions ;)
>
> 1) What's the best interface for this kind of thing?  A char
>    device?  With ioctl()'s?  a sysctl?  something in /proc?
>    I'm not interested in ease of implementation (I'll have to
>    hack some on gprof too, for this -- so I'm not afraid of
>    the kernel ;) ), but in what's philosophically/technically/
>    procatically the best interface.
> 2) Do we want to be able to profile several tasks (independently
>    from each other) at once?  This will require some bookkeeping
>    and task switch overhead, and is probably not necessary in
>    practice; also, it will degrade the quality of the results some.
> 3) [I'm ashamed I have to ask this...]  Is there a good tutorial
>    to kernel locks somewhere?
> 4) Security: I want to generate most of the settings in userland,
>    for maximum ease of use and ease of implementation; but that
>    brings up some security issues.  Only allowing root to
>    profile code isn't ideal, either.  So:
>    a) Don't automagically load the module; if root loads it, let's
>       hope he knows what he's doing;
>    b) Have the pmc device be accessible only to a 'trusted' group;
>    c) A setuid driver program to start profiling;
>    d) Something much more clever?

it'd be really cool if the performance counter stuff looked like
perfctr  (http://user.it.uu.se/~mikpe/linux/perfctr/). it uses a /dev/
entry.

The nice thing about making it perfctr-like is that it can tie into
oprofile (as mentioned in another reply) and also tie into PAPI
(http://icl.cs.utk.edu/projects/papi/).

PAPI has support for all kinds of performance counters on all sorts of
platforms.  PAPI can be ported to whatever interface you end up
deciding upon: it's just that if it's perfctr-like, the porting
becomes a lot eaiser :>

just my non-hacker two cents.
==rob

--
Rob Latham                                        Woodridge, IL USA

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
