Date: Fri, 10 Oct 2003 01:12:54 -0400
From: Bill Fink <billfink@mindspring.com>
To: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: Bill Fink <billfink@mindspring.com>
Subject: Re: Time precision, adjtime(x) vs. gettimeofday
Message-Id: <20031010011254.078c84a8.billfink@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 08 Oct 2003, Benjamin Herrenschmidt wrote:

> > I repeat the question: what are the values of drift on the machines
> > that encounter the problem ? Is this drift stable or unstable?
>
> So far, there is no problem. The problem that was happening
> was a via_calibrate_decr() bug with HZ != 100, but when
> investigating, I figured out that we had a potential problem
> there, that's all and that's why I want people like you who
> know those problems well to state if it's worth bothering ;)
>
> > > On all cases, those will drift some way from what the NTP server
> > > will give, either a lot or not, it will. So we may end up adjusting
> > > our kernel rate and thus opening a window for the problem.
> >
> > The worst variations of drift I've seen are a few ppm for a given
> > machine, barring the occasional boot-time calibration problems that I
> > have encountered.
>
> OK.

This discussion prompted me to finally ask about another clock related
problem I see on the 867 MHz G4 systems at work.  The clocks on these
systems continuously run 0.2% slow (about 3 minutes per day).  Apparently
this is more than ntp can adjust for (using scaling), as I get many of
these error messages in the log:

Oct 10 00:11:29 clifford ntpd[425]: time reset 2.641342 s
Oct 10 00:11:29 clifford ntpd[425]: synchronisation lost
Oct 10 00:32:07 clifford ntpd[425]: time reset 2.671741 s
Oct 10 00:32:07 clifford ntpd[425]: synchronisation lost
Oct 10 00:52:46 clifford ntpd[425]: time reset 2.671729 s
Oct 10 00:52:46 clifford ntpd[425]: synchronisation lost

This causes problems if I take these systems off the network for a few
hours, if I forget to reset them to the correct time when I reconnect
them, since we use Kerberos for security, and the time difference between
the system and the Kerberos KDC will prevent remote logins.

These systems are using a 2.4.20-ben1 kernel.

						-Bill

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
