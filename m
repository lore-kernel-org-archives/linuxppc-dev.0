Message-ID: <3806D73E.19182EFF@fadata.bg>
Date: Fri, 15 Oct 1999 10:26:54 +0300
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: serial on lombard
References: <199910141610.SAA10877@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
> 
> > I think the code should be as follows:
> >    signal( SIGALRM, a_signal_handler_which_just_returns );
> >    alarm(4);
> >    portfd = open( dial_tty, O_RDWR|O_NONBLOCK);
> >    alarm(0);
> >    if( portfd >= 0 ) {
> >       ...
> >
> > In old code (and in the patched one too) there is a race condition
> > between clearing the alarm and signal delivery. A sequence similar
> > to the above one relies only on the return value of open().
> > Regards,
> 
> alarm(0) only clears the timer and won't change the return value of open.
> Watching the strace output closely you will see that the return value of
> open is filled in only after the alarm fired. The macserial open fails to
> check for pending signals after completing the modem powerup wait, and
> can't detect the timeout.

There is no need to change the return value of open(). One should _examine_ it,
and the minicom doesn't do this -- its on the 0-branch of setjmp.
Actually, there is _absolutely_ no need for alarm() -- if you say
O_NONBLOCK, you should not expect to block and you should not try to work
around with some fancy timeouts and stuff. The old code, the proposed patch
and my proposal are simply pointless -- that's to say, they all try
to solve a problem which doesn't exist (and thay fail, of course ;-).

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
