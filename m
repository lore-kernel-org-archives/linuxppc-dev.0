Message-ID: <19990224124506.12141.rocketmail@send205.yahoomail.com>
Date: Wed, 24 Feb 1999 04:45:06 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: I believe I found a bug in /arch/ppc/kernel/signal.c
To: Lauro Whately <whately@cos.ufrj.br>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Lauro,

setjmp in glibc2 compiles to sigsetjmp(env,0) i.e. it doesn't save the
environment.

The sigsetjmp gets rid of the signal being blocked issue ( the main
symptom ), there still can be outstanding signals on the user stack
being trashed though.




---Lauro Whately <whately@cos.ufrj.br> wrote:
>
> > On Mon, Feb 22, 1999, D.J. Barrow <barrow_dj@yahoo.com> wrote:
> 
> > The bug manifested itself in tftp, when longjmp'ing out
> > of the signal handler on timeouts.
> >
> > Resulting in....
> > a )sys_sigreturn not get called
> > b) signals queued & trampoline stuff on the user stack being
trashed.
> > c) SIGALRM being blocked forever.
> 
> Have you tried the sigsetjmp/siglongjmp ?
> I've met a similar problem a month ago and found that POSIX.1 does not
> specify the effect of setjmp and longjmp on signal masks (SVR4 does
not save
> and restore the signal mask under  setjmp/longjmp, however 4.3 BSD
save and
> restore the signal mask) Instead, two new functions sigsetjmp and
siglongjmp
> are defined by POSIX.1
> Those new ones are working ok with linux 2.1.x releases (I've been
using them
> with linuxppc 2.1.112)
> It seems that the behavior of sigsetjmp/siglongjmp was changed to
the POSIX.1
> specification around the release 2.1.112.
> 
> --
>  Lauro Whately
>  Parallel Computing Lab. / COPPE
>  Federal University of Rio de Janeiro
>  Brazil
>  =====================================
>  "A distributed system is one on which I cannot get any work done,
because a
>  machine I have never heard of has crashed." -- Leslie Lamport
> 
> 
> 
> 

_________________________________________________________
DO YOU YAHOO!?
Get your free @yahoo.com address at http://mail.yahoo.com


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
