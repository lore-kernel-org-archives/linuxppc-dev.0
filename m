Date: Thu, 23 Nov 2000 12:11:11 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Avery Pennarun <apenwarr@worldvisions.ca>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Hadess <hadess@writeme.com>, debian-powerpc@lists.debian.org,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <20001123020959.A11952@worldvisions.ca>
Message-ID: <Pine.LNX.4.10.10011231200590.18581-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > The info logged to /proc/apm is currently logged to /etc/power/apm. I have
>
> Is this a typo?  Why is status information in /etc?

Because user space pmud can't create /proc/ entries?

> > no idea what /dev/apm does aside from providing that log info, and I have
> > no clue what /dev/apm_bios does, either. There should be no major problems
>
> The /dev device selects true for read() when a power event happens (such as
> a user suspend request or battery status change) and can be written to allow
> a user process to initiate a system suspend.

We use a TCP port on the loopback interface for that.

> > independent. I just don't see a good reason to change from pmud to
apmd,
> > if that's what you're suggesting.
>
> It's always better, IMHO, to keep Linux userspace as similar as possible

Granted, if that doesn't place a high burden on the kernel code. I thought
'keep it simple, stupid' was the kernel motto?

> between different architectures.  If pmud has features that apmd doesn't
> have, or vice versa, I would rather merge them than keep them separate.  In
> the process, we might as well work on making the kernel interfaces similar
> too.  That's the whole _point_ of the kernel.

I beg to differ. The whole point of the kernel is to separate critical
code and architecture dependant things from user space. It's not about
making interfaces as similar as possible. If the hardware is sufficiently
different, a different kernel interface is OK. That's why no one
implemented a VGA compatibility layer in the kernel for PPC, m68k and a
few other archs.

It all boils down to: how generic is the apm interface?

Side note: I only maintain the Debian package of pmud. The pmud author is
Stephan Leemburg <stephan@jvc.nl>.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
