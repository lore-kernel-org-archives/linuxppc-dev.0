Message-ID: <20001028172451.A10220@lx.c-side.com>
Date: Sat, 28 Oct 2000 17:24:51 -0700
From: Neil Russell <caret@c-side.com>
To: David Riley <oscar@the-rileys.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC byte ordering
References: <39FB3C16.3359BC41@the-rileys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39FB3C16.3359BC41@the-rileys.net>; from David Riley on Sat, Oct 28, 2000 at 04:50:38PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Some PPC CPUs don't implement all load/store instructions for little
endian;  for instance, the 603 CPUs don't do lmw, stmw, lswi, lswx,
stswi, stswx for little endian.  I seem to remember that there are other
problems aside from the ones that I mentioned.  Later CPUs don't seem
to have a problem.

It would in theory be possible to have the kernel run big-endian as it is
and have certain user programs run little endian by setting the LE bit in
the MSR register for the process in question.  The real problem here is
that you have to add a *lot* of code to system calls to make this work.
There are a few system calls that this would be real difficult, such
as ioctl().  I once looked into doing this for the MIPS with SVR4 UNIX.


Neil.


On Sat, Oct 28, 2000 at 04:50:38PM -0400, David Riley wrote:
> Before I get dirty looks, I know the PowerPC's default byte ordering is
> big-endian (the way things *should* be :-).  What I'm asking is slightly
> irrelevant to most development discussion here, but...
>
> I know that the PowerPC does allow both endian modes.  My big question
> is how well it works in little endian mode.  I know we'll never switch
> Linux to this, since that would be too much unnecessary work, but just
> for reference:  Is it broken?  I have heard reports to this effect.
>
> Thanks,
> 	David
>

--
Neil Russell <caret@c-side.com>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
