From: pnilesh@in.ibm.com
To: khendricks@ivey.uwo.ca
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <CA256A08.00488A4C.00@d73mta03.au.ibm.com>
Date: Wed, 7 Mar 2001 18:10:48 +0530
Subject: Re: strange sigaction ()
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It did not work for me !!
Is the problem with kernel or it is elsewhere ?
Which kernel patch will fix this ?



Try the following, it works for me:

#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

static struct sigaction act;
static void handler (int,siginfo_t *,void *);

int
main ()
{
  act.sa_sigaction=handler;
  act.sa_flags=SA_SIGINFO;
  sigaction (SIGALRM,&act,NULL);
  alarm (1);
  sleep (2);
}

void handler (int x, siginfo_t *s,void *v)
{
    printf ("si_signo   = %d, si_code  = %d, si_errno  = %d\n",s->si_signo,
s->si_code, s->si_errno);
}

[kbhend@localhost kbhend]$ gcc -otest test.c
[kbhend@localhost kbhend]$ ./test
si_signo   = 14, si_code  = 0, si_errno  = 0
[kbhend@localhost kbhend]$


On Tuesday 06 March 2001 06:04, pnilesh@in.ibm.com wrote:
> I am seeing a strange problem with sigaction on powerpc.
>
> static struct sigaction act;
> static void handler (int,siginfo_t *,void *);
> main ()
> {
> sigaction (SIGALRM,&act,NULL);
> alarm (1);
> sleep (2);
> }
>
> void handler (int x, siginfo_t *s,void *v)
> {
>     printf ("si_signo   = %d, si_code  = %d, si_errno  =
%d\n",s->si_signo,
> s->si_code, s->si_errno);
> }
>
> This program gives meaningful values on Linux Intel Redhat.
> On Apple Dual G4 PowerPC I am getting junk values
> si_signo = 805464356
> si_errno = 805464640
> si_code = 21
>
> I dont know what is happening.
> Please educate me.
>
> Nilesh
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
