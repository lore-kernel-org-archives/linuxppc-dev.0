Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: pnilesh@in.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: strange sigaction ()
Date: Tue, 6 Mar 2001 10:24:59 -0500
References: <CA256A07.003DA9D3.00@d73mta05.au.ibm.com>
In-Reply-To: <CA256A07.003DA9D3.00@d73mta05.au.ibm.com>
MIME-Version: 1.0
Message-Id: <01030610245900.20862@localhost>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,


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
>     printf ("si_signo   = %d, si_code  = %d, si_errno  = %d\n",s->si_signo,
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
