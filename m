Message-ID: <19990222143657.28939.rocketmail@send206.yahoomail.com>
Date: Mon, 22 Feb 1999 06:36:57 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: I believe I found a bug in /arch/ppc/kernel/signal.c
To: Gary Thomas <gdt@linuxppc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gary/Others,
I'm currently using 2.1.123 ( yup I know this is old but the bug on
reading the source is still in 2.1.124 DR4 ) & possibly is still
there. Unfortunately my net connection isn't good enough to download
the latest 2.2 stuff in less than a few hours.

The bug manifested itself in tftp, when longjmp'ing out
of the signal handler on timeouts.

Resulting in....
a )sys_sigreturn not get called 
b) signals queued & trampoline stuff on the user stack being trashed.
c) SIGALRM being blocked forever.

The stuff works on intel & it also works if I kludge handle signal not
to block SIGALRM.

I originally thought fixing longjmp with a syscall would be a good
idea on conversing with other hackers it isn't.

The code here I believe can be simplified if you didn't do all the
queueing in handle_signal & remove the while/dequeue loop from
do_signal & make do_signal also work as sys_sigreturn & unblock the
signals just before sending them, this way I don't think you'll lose
any ( however I haven't fully investigated any possible problems
caused unblocking signals before sending them ). As sys_sigreturn is
getting called for every signal delivered, there is no benefit gained
by queueing them in the first place.

If you still aren't maintaining signal.c anymore could someone forward
on this bug report.

Also could you tell me a good place where I can find some info on the
rt_signal stuff & tell me if a fix gets/already is posted....






_________________________________________________________
DO YOU YAHOO!?
Get your free @yahoo.com address at http://mail.yahoo.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
