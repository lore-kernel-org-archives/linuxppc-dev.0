Date: Wed, 11 Aug 1999 00:38:05 -0700
From: Richard Henderson <rth@cygnus.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
Cc: Paul.Mackerras@cs.anu.edu.au, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        Richard Henderson <rth@cygnus.com>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990811003805.A11890@cygnus.com>
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d34si6kcge.fsf@lxp03.cern.ch>; from Jes Sorensen on Wed, Aug 11, 1999 at 09:23:29AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 11, 1999 at 09:23:29AM +0200, Jes Sorensen wrote:
> Paul> On ultrasparc at least, there is a "side-effect" bit in each
> Paul> PTE.  If that bit is set, it tells the cpu not to reorder
> Paul> accesses to that page.  I don't know whether alpha has the same
> Paul> facility, do you?

No, it doesn't.

> I don't know enough about the PPC architecture to comment on this,
> however I can see that wmb() translates into an eieio. wmb() is more
> fine grained and it would make sense to promote it over plain mb() in
> the places where it makes sense.

Definitely.  Alpha's wmb and mb are very similar to ppc's sync and eieio.

> Paul> Well, if alpha is actually like that, then IMO it is broken.

IMO it is Most Correct.

Memory barriers on alpha are a fact of life.  It's not just I/O that
requires it, though that is where it shows up most often with drivers.

There are a great many cards that do memory mapped i/o that don't care
about the ordering and write combining of the data setup, only that the
data setup all be done before receiving the "go code".  In these drivers,
we need only one wmb insn, not one between each and every writel.

This benefit is marked enough that there is zero chance you can convince
me to add wmb() to writel().  The driver writer is the only one that
knows whether this barrier is necessary.



r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
