Date: Thu, 12 Aug 1999 12:00:45 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Paul.Mackerras@cs.anu.edu.au
cc: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <199908112352.JAA25021@tango.anu.edu.au>
Message-ID: <Pine.LNX.3.96.990812115345.25431A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Aug 1999, Paul Mackerras wrote:

> Jes Sorensen <Jes.Sorensen@cern.ch> wrote:
> 
> > I will have to disagree with you on this one, I consider the PPC
> > implementation to be very broken in this regard.
> 
> "Very broken" - because drivers work and there is no measurable
> performance impact?? !!! ??
> 
> The only possible argument for *not* having the eieio in readl/writel
> is that it hurts performance (actually and measurably, not just
> potentially).

No, that's not the only argument.  eieio and... isync, I think... causes
the PPC 601 to shift one of its registers a few bits and send out an
address only transaction using the address that results from that.  I
can't remember which register off the top of my head.  MkLinux ran into
this in the late Pre-DR3 stage and it nearly cost us a large percentage of
x100 support do to a hardware bug that can cause the machine to hang if an
address only transaction is done into certain parts of the address space.

The workaround is a really nasty bunch of code that creates a sizable
performance hit by forcing that register to be cleared before the eieio
and restored afterwards.  As a result, putting eieio in those macros will
have a _very_ major performance hit if yuo ever start supporting x100
PowerMacs.  It will also require lots of really nasty #ifdef structures in
the readl and writel code that can be avoided just by making a macro
eieio() and using it only where needed.  It will also greatly decrease the
headaches for x100 folks have in their efforts to find all the eieios and
figure out why their machines crash randomly.  :-)


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
