To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Subject: Re: apmd and other archs
Message-ID: <974986581.3a1d1d55698b0@imp.free.fr>
Date: Thu, 23 Nov 2000 14:36:21 +0100 (MET)
From: Hadess <hadess@writeme.com>
Cc: Avery Pennarun <apenwarr@worldvisions.ca>,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10011231200590.18581-100000@zirkon.biophys.uni-duesseldorf.de>
In-Reply-To: <Pine.LNX.4.10.10011231200590.18581-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Quoting Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>:

> > > The info logged to /proc/apm is currently logged to /etc/power/apm.
> I have
> >
> > Is this a typo?  Why is status information in /etc?
>
> Because user space pmud can't create /proc/ entries?
>
> > > no idea what /dev/apm does aside from providing that log info, and I
> have
> > > no clue what /dev/apm_bios does, either. There should be no major
> problems
> >
> > The /dev device selects true for read() when a power event happens
> (such as
> > a user suspend request or battery status change) and can be written to
> allow
> > a user process to initiate a system suspend.
>
> We use a TCP port on the loopback interface for that.
>
> > > independent. I just don't see a good reason to change from pmud to
> apmd,
> > > if that's what you're suggesting.
> >
> > It's always better, IMHO, to keep Linux userspace as similar as
> possible
>
> Granted, if that doesn't place a high burden on the kernel code. I
> thought
> 'keep it simple, stupid' was the kernel motto?
>
> > between different architectures.  If pmud has features that apmd
> doesn't
> > have, or vice versa, I would rather merge them than keep them
> separate.  In
> > the process, we might as well work on making the kernel interfaces
> similar
> > too.  That's the whole _point_ of the kernel.
>
> I beg to differ. The whole point of the kernel is to separate critical
> code and architecture dependant things from user space. It's not about
> making interfaces as similar as possible. If the hardware is
> sufficiently
> different, a different kernel interface is OK. That's why no one
> implemented a VGA compatibility layer in the kernel for PPC, m68k and a
> few other archs.
>
> It all boils down to: how generic is the apm interface?

Hi,

Seems like I missed a good part of the discussion... First reason I wanted apmd
marked as x86 only, is because it is useless _now_ on power-pc. We have a PMU,
not an APM BIOS (ugh!), we have pmud not apmd. What is the point compiling it
for powerpc if it's not working and will probably never ?

We have here a big fat hardware difference. A PMU's a PMU, and an APM BIOS's an
APM BIOS. I'm now working (with help from Joseph Garcia) on an APM library for
PMUD. It hides PMUD from the libapm-using battery applets. I posted last week a
first "socket" version that uses the TCP socket on the loopback interface to get
its information. And I could compile some programs from the apmd distribution
and battstat with it.

I'm working right now on 1) Debugging socket version, 2) Implementing a version
getting its info from /etc/power/apm (soon to be moved, better tell Stephan I
guess), 3) Implement the rest of the functions from the apm library (like sleep
and everything...)

IMHO, an apm interface in the kernel would be "evil", that's a (simple)
userspace job.

Cheers

/Hadess
http://hadess.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
