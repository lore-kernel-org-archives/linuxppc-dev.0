Message-ID: <399B647A.A09F337@motorola.com>
Date: Wed, 16 Aug 2000 23:05:14 -0500
From: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>
MIME-Version: 1.0
To: frank@jrware.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Signal mask restore anomaly
References: <200008161925.MAA00373@tallis.jrware.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank,

I am able to reproduce the same failures on a 2.2.13
PPC Kernel, with GCC 2.95.3-2c and GLIBC 2.1.3-15d.
Ran same test code on Solaris with correct operation.

The failure is definitely a MASK restoration problem.
Since, one can recover from the problem by UNBLOCKING
the SIGINT.

I believe the problem may be an interaction between the
Terminal I/O related SIGNALS being used (SIGTSTP and
SIGINT) and the use of the STDIO Library calls (printf
and getch).  By replacing the SIGTSTP and SIGINT signals
with SIGUSR1 and SIGUSR2, everything worked correctly
(tested via "kill" command from a separate terminal
window).

Looking at the GLIBC Bug Database, I didn't see any bugs
which seem to correspond to this failure mechanism.  Most
of the SIGNALS bugs seem to be related THREADS.

Looks like it is time submit a bug report to GNU....

Jeff


Frank Jas wrote:
>
> Under certain circumstances, a signal blocked while a
> signal handler is executing will not be restored.
>
> This is my kernel info:
>
> Linux 2.2.6-15apmac #1 Mon May 31 03:54:09 EDT 1999 ppc unknown
>
> The behavior does not occur under Intel versions (2.2.5-15smp).
>
> Below is a program that tests out the use of signal masks
> with sigaction().  It sets up a handler for SIGINT and
> SIGTSTP.  The handler for SIGTSTP adds SIGINT to
> the signal mask for that handler.  So while the SIGTSTP
> handler is executing, occurences of SIGINT will be
> blocked until the handler returns.  SIGTSTP will also
> be blocked.
>
> #define _POSIX_SOURCE 1
> #define _GNU_SOURCE 1
>
> #include <signal.h>
> #include <errno.h>
> #include <stdio.h>
>
> void on_intr (signum)
>         int signum ;
> {
>         printf("\n    Interrupted with signal %d. \n", signum) ;
> }
>
> void on_tstp (signum)
>         int signum;
> {
>         printf ("\n     Handler for SIGTSTP wants text or ^C or ^Z: ") ;
>         getchar () ;
> }
>
> void main ()
> {
>         struct sigaction  new_intr_action;
>         struct sigaction  new_tstp_action;
>         int    c ;
>
>         sigemptyset (&new_intr_action.sa_mask);
>         new_intr_action.sa_handler = on_intr;
>         new_intr_action.sa_flags   = SA_RESTART;
>
>         sigaction  (SIGINT, &new_intr_action, 0);
>
>         sigemptyset (&new_tstp_action.sa_mask);
>         sigaddset   (&new_tstp_action.sa_mask, SIGINT);
>         new_tstp_action.sa_handler = on_tstp;
>         new_tstp_action.sa_flags   = SA_RESTART;
>
>         sigaction  (SIGTSTP, &new_tstp_action, 0);
>
>         printf("Starting main input loop enter text or ^Z or ^C:\n") ;
>
>         while ((c = getchar ()) != EOF) {
>                 putchar (c);
>         }
> }
>
> The following execution sequence leads to the anomalous behavior.
>
> Trigger the SIGTSTP handler with a ^Z
> While executing the handler, deliver a ^Z and ^C
> Hit return to return from the handler.
> Another instance of the SIGTSTP handler should execute.
> Hit return to return from that instance of the handler.
> Notice that the SIGINT handler does not execute and should have.
> Any subsequent SIGINT are apparently blocked.
>
> Apparently the nested occurence of SIGTSTP effected the restore
> of the SIGINT mask, and the handling of the pending SIGINT.
>
> The same behavior will result using 'kill' from another window
> to send the signals.
>
> Please let me know if this is not the appropriate venue for this
> post.
>
> Frank Jas
>

--
********************************************************

Jeffrey Hawkins

Senior Staff Software Engineer
Motorola Wireless Data Solutions Engineering

Address: DEPT:  DQ525
         MS:    IL-02-1055A
         1301 East Algonquin Road
         Schaumburg, IL 60196

Phone:   (847)576-7463
FAX:     (847)576-7737

********************************************************

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
