Subject: Re: GLIBC wont compile for MPC860
To: dmalek@jlc.net (Dan Malek)
Date: Mon, 6 Sep 1999 11:15:06 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <37CFEDCD.ACA47B7C@jlc.net> from "Dan Malek" at Sep 3, 99 11:48:29 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990906011506.87848730@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> Some of us actually creating embedded applications in this space
> are a little concerned with the size of glibc2, and I suspect
> we will be doing some major hacking to fit some of the smaller
> environments.

I think newlib would be a promising candidate given its emphasis on small size,
although the current version needs some porting work to run under Linux/PPC.
My application also needs threads, but I'm hoping I might be able to drop
LinuxThreads from glibc into newlib without too much bloat. For a first cut
though, I'll just drop lots of RAM in and link statically against glibc-2.1.2.

> > ..... but this
> > also means that I don't know what you should do to build a compiler that
> > generates 860 code by default and also is capable of generate code for
> > other CPUs.
> 
> I don't know if this is important.  Most of us are used to using the
> proper flags, want to use the same compiler on our Linux/PPC Macs
> as is used for the other processors.  With the new 82xx stuff
> coming up now, a different set of flags are necessary, and the
> compiler supports it just fine.

Sure, but I'm cross compiling from an Intel box and it would be nice to be able
to configure a gcc --with-cpu=860 and have it imply -msoft-float, -D_SOFT_FLOAT
and whatever else is needed when building glibc/newlib etc.

> > I like the former solution. Having the compiler keep track of what
> > line sizes different CPUs have is good, but forcing other user-land
> > code to know this isn't nice IMHO.
> 
> Well, see the comment below.  There is some merit to using a
> standard binary distribution on all processors.

Sure; I agree 100%. The tiny extra bloat involved to retain binary
compatibility seems worth it even for an embedded app.

> In general, for all of the real world products I have done
> using Linux/PPC and 8xx, I use the old libc-1.99 and static
> linking.  Don't forget about trying that, as it could result
> in the smallest (and fastest) executables.

Any chance you could put your libc-1.99 (or a pointer to it) up at
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/ ?

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
