Message-ID: <38CFD959.52E9F85@clickvision.com>
Date: Wed, 15 Mar 2000 13:41:29 -0500
From: "Peter M. Jansson" <petej@clickvision.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: SIGALRM can't be delivered after longjmp from handler?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote the example that follows to illustrate what I think is a
problem with signal delivery.  If this program works, then it should run
in 5 cycles; the first 2 end with the "Timed out" message, while the
last 3 end with the "Wait interrupted" message.  On my PowerMac 7200
running 2.2.15pre3, I get 2 "Timed out" cycles, one "Wait interrupted"
cycle, and then two more "Timed out" cycles.  What I think is going on
is that, once the SIGALRM handler executes the longjmp, no further
SIGALRM signals are delivered to the process -- I don't know if this is
because the signals aren't delivered, or because the setitimer call
isn't working.  I've observed this example to run correctly on BSD/OS,
IRIX, and Solaris, and seen it fail on LinuxPPC and Linux x86.

Anyone seen this, and possibly know of a fix or workaround?

Pete.

-------------------------------

#include <signal.h>
#include <setjmp.h>
#include <sys/time.h>
#include <stdio.h>

static jmp_buf env;
static unsigned int count = 0;

static void
interrupt()
{
        printf ("Interrupt: %d\n", count);
        if (count > 2)
                longjmp(env, 1);
}

main ()
{
        struct timeval tv;
        struct itimerval it, oit;

        while (count++ < 5) {
                printf("Cycle %d\n", count);

                if (setjmp(env)) {
                        printf ("Wait interrupted\n");
                } else {
                        if (signal(SIGALRM, interrupt) == SIG_ERR)
                                perror("signal");
                        getitimer(ITIMER_REAL, &oit);
                        timerclear(&it.it_interval);
                        it.it_value.tv_sec = 2;
                        it.it_value.tv_usec = 16665;
                        if (setitimer(ITIMER_REAL, &it, &oit) < 0)
                        perror("tick");
                        printf ("Set timer; waiting...\n");
                        tv.tv_sec = 5;
                        tv.tv_usec = 0;
                        select(0, NULL, NULL, NULL, &tv);
                        printf ("Timed out\n");
                }
        }
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
