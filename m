From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910141610.SAA10877@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <3805EE77.DFC69FCA@fadata.bg> from Momchil Velikov at "Oct 14, 1999 05:53:43 pm"
To: velco@fadata.bg (Momchil Velikov)
Date: Thu, 14 Oct 1999 18:10:12 +0200 (CEST)
Cc: bh40@calva.net, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I think the code should be as follows:
>    signal( SIGALRM, a_signal_handler_which_just_returns );
>    alarm(4);
>    portfd = open( dial_tty, O_RDWR|O_NONBLOCK);
>    alarm(0);
>    if( portfd >= 0 ) {
>       ...
> 
> In old code (and in the patched one too) there is a race condition
> between clearing the alarm and signal delivery. A sequence similar
> to the above one relies only on the return value of open().
> Regards,

alarm(0) only clears the timer and won't change the return value of open. 
Watching the strace output closely you will see that the return value of 
open is filled in only after the alarm fired. The macserial open fails to 
check for pending signals after completing the modem powerup wait, and 
can't detect the timeout. 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
