Date: Wed, 19 May 2004 15:09:04 +1000 (EST)
Message-Id: <200405190509.PAA20836@sprint.tenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Error calling timer_create
From: "MERRITT Nigel" <Nigel.MERRITT@Tenix.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to get timers working on a Embedded Planet 405GP running Timesys Linux.
The code is compiled using the correct tool chain and is based on the example in Timesys documentation, however, when calling the timer_create function, I get an error, and errno is set to 38, which is listed as:

   #define ENOSYS  38 /* Function not implemented */

in errno.h

The code for calling timer_create is:


#include <time.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

// Define a timer signal value.
#define TEMP_MON_TIMER_SIGNAL (SIGRTMIN + 1)

// Prototype for the timer handling function.
void TimerHandler(int signo, siginfo_t *info, void *context);

int main(int argc, char** argv) {

   struct sigevent   stEvent;
   struct sigaction  stSignalAction;
   struct itimerspec stITimerSpec;

   struct timespec stClockRes;
   timer_t nTimerId;if (sigemptyset(&stSignalAction.sa_mask))
{
   printf("Signal mask could not be emptied (err=%d).\n", errno);
   return -1;
}

stSignalAction.sa_flags = SA_SIGINFO;
stSignalAction.sa_sigaction = TimerHandler;

// Register the handler.
if (sigaction(TEMP_MON_TIMER_SIGNAL, &stSignalAction, NULL))
{
   printf("Signal mask could not be emptied (err=%d).\n", errno);
   return -1;
}

// The signal has been created, now set up the event that will
// trigger the signal.
stEvent.sigev_signo = TEMP_MON_TIMER_SIGNAL;
stEvent.sigev_notify = SIGEV_SIGNAL;
stEvent.sigev_value.sival_ptr = &nTimerId;

// Use the event that was just set up to set up the timer.
if ((clock_getres(CLOCK_REALTIME, &stClockRes)) < 0)
{
   printf("Clock resolution could not be obtained (err=%d).\n", errno);
   return -1;
}

stITimerSpec.it_interval.tv_sec = 1;
stITimerSpec.it_interval.tv_nsec = 0 * stClockRes.tv_nsec;
stITimerSpec.it_value = stITimerSpec.it_interval;

// Initialise the timer.
if (timer_create(CLOCK_REALTIME, &stEvent, &nTimerId))
{
   printf("Timer could not be created (err=%d).\n", errno);
   return -1;
}
.
.
.

... with the result:

   Timer could not be created (err=38).

The code obviously compiles so I can't work out why it would claim the function does not exist.  The code is compiled with static linking so all libraries should be included in the executable.

Any help would be appreciated...

   NJM

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
