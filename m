Message-ID: <000a01bf8e67$dec9dc50$571170c1@honda.isltd.insignia.com>
From: "jjs" <Jerry.Sexton@insignia.com>
To: "Kevin Buettner" <kev@primenet.com>, <linuxppc-dev@lists.linuxppc.org>
Cc: "Michael Snyder" <msnyder@cygnus.com>
Subject: Re: gdb and multi-threaded applications.
Date: Wed, 15 Mar 2000 10:18:50 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Note to Jerry: I'd still like a small example, preferably one that
>we could eventually put into the testsuite.
>
>Kevin
>

Kevin,

OK, here is an example.

gdb_thread.c
=================================================================

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <errno.h>

char *signame[] =
{
  "0",
  "SIGHUP",
  "SIGINT",
  "SIGQUIT",
  "SIGILL",
  "SIGTRAP",
  "SIGABRT",
  "SIGBUS",
  "SIGFPE",
  "SIGKILL",
  "SIGUSR1",
  "SIGSEGV",
  "SIGUSR2",
  "SIGPIPE",
  "SIGALRM",
  "SIGTERM",
  "SIGSTKFLT",
  "SIGCHLD",
  "SIGCONT",
  "SIGSTOP",
  "SIGTSTP",
  "SIGTTIN",
  "SIGTTOU",
  "SIGURG",
  "SIGXCPU",
  "SIGXFSZ",
  "SIGVTALRM",
  "SIGPROF",
  "SIGWINCH",
  "SIGIO",
  "SIGPWR",
  "SIGUNUSED",
  "SIG32",
  "SIG33",
  "SIG34",
  "SIG35",
  "SIG36",
  "SIG37",
  "SIG38",
  "SIG39",
  "SIG40",
  "SIG41",
  "SIG42",
  "SIG43",
  "SIG44",
  "SIG45",
  "SIG46",
  "SIG47",
  "SIG48",
  "SIG49",
  "SIG50",
  "SIG51",
  "SIG52",
  "SIG53",
  "SIG54",
  "SIG55",
  "SIG56",
  "SIG57",
  "SIG58",
  "SIG59",
  "SIG60",
  "SIG61",
  "SIG62",
  "SIG63"
};
#define NSIGS (sizeof(signame) / sizeof(signame[0]))

void
attrInit(pthread_attr_t *attrPtr)
{
 struct sched_param schedParam;

 schedParam.sched_priority = 0;
 pthread_attr_init(attrPtr);
 pthread_attr_setdetachstate(attrPtr, PTHREAD_CREATE_DETACHED);
 pthread_attr_setschedpolicy(attrPtr, SCHED_OTHER);
 pthread_attr_setschedparam(attrPtr, &schedParam);
 pthread_attr_setinheritsched(attrPtr, PTHREAD_EXPLICIT_SCHED);
 pthread_attr_setscope(attrPtr, PTHREAD_SCOPE_PROCESS);
 pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedParam);
 pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
}

void *
threadStartPoint(void *arg)
{
 int retVal;

 printf("Thread started successfully.\n");
 return NULL;
}

main(int argc, char *argv[])
{
 pthread_t  newThread;
 sigset_t  sigmask;
 sigset_t  fullSigMask;
 pthread_attr_t threadAttr;
 int    err;
 int    signal;

 if (argc == 2)
 {
  signal = atoi(argv[1]);
 }
 else
 {
  fprintf(stderr, "usage: thread signal\n");
  exit(-1);
 }
 attrInit(&threadAttr);
 sigemptyset(&sigmask);
 sigaddset(&sigmask, signal);
 sigfillset(&fullSigMask);
 if (pthread_sigmask(SIG_BLOCK, &sigmask, NULL) == 0)
 {
  printf("Blocked signal %s before creating thread.\n", signame[signal]);
 }
 else
 {
  printf("Failed to block signal %s before creating thread.\n",
      signame[signal]);
  exit(-1);
 }
 err = pthread_create(&newThread, &threadAttr,
       (void *(*)(void *)) threadStartPoint,
       (void *) NULL);

 switch(err)
 {
 case 0:
  printf("pthread_create succeeded\n");
  break;
 case EAGAIN:
  printf("pthread_create failed: System resources not available\n");
  break;
 case EINVAL:
  printf("pthread_create failed: Invalid thread attributes\n");
  break;
 default:
  printf("pthread_create failed: Unknown error - %d\n", err);
  break;
 }
 exit(0);
}

Makefile
====================================================================

CFLAGS=-g
CC=gcc

gdb_thread: gdb_thread.o
   gcc -g -o $@ gdb_thread.o -lpthread

===========================================================================

Running this program under gdb, I get the following output:

(gdb) r 1
Starting program: /tmp_mnt/home/wolf/jjs/src/thread/gdb_thread 1
Blocked signal SIGHUP before creating thread.
[New Thread 12358 (manager thread)]
[New Thread 12352 (initial thread)]
[New Thread 12359]
pthread_create succeeded

Program exited normally.
(gdb) r 2
Starting program: /tmp_mnt/home/wolf/jjs/src/thread/gdb_thread 2
Blocked signal SIGINT before creating thread.
[New Thread 12366 (manager thread)]
[New Thread 12360 (initial thread)]
[New Thread 12367]
pthread_create succeeded

Program exited normally.
(gdb)

Note that the "Thread started successfully." message from threadStartPoint
is not printed out. I think this is just because we fall off the end of the
program before we get a chance to ececute the printf. This pattern is
repeated for all signal numbers except 34, which gives the following output:

(gdb) r 34
Starting program: /tmp_mnt/home/wolf/jjs/src/thread/gdb_thread 34
Blocked signal SIG34 before creating thread.

and then gdb hangs and I have to kill gdb_thread externally to continue.

Note that I tried blocking each signal in turn in a loop first of all and
the program sailed past signal 34 without a problem. Experimenting a little,
it turns out that after pthread_create succeeds once, it will subsequently
succeed under gdb even if signal 34 is blocked.

I have tried running our proprietory application under gdb with all signals
except signal 34 blocked when pthread_create is called and it works fine. I
will make sure that all the signals Michael suggests are unblocked in our
application and hopefully every thing will work OK.

Thanks for your help, guys.

Cheers, Jerry.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
