Message-Id: <199904011626.KAA14371@www2.tuckeris.com>
Date: Thu, 01 Apr 1999 09:18:19 -0600
Subject: Bug in LinuxThreads?
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all:
    I apologize if this is too off topic, but I am trying to figure out
where to go in order to get this problem fixed and this listserv seemed to
be the best place.  A few days ago I posted the attached message below to
the comp.programming.threads newsgroup in relation to a problem I've been
having with running a piece of threaded code I've written on a standard R4
installation (running the 2.1.125) kernel.  The issue is described is detail
below.

    I have had a few responses back from people telling me they compiled the
included code on an Intel box and it worked fine.  This leads me to believe
there might be a bug in the pthreads or kernel (probably pthreads) code that
is causing the problem.  My question: is there an update that I have missed,
or whom do I need to contact to work on getting this thing fixed.  I don't
mind working on finding the bug myself, I'm just not even sure of where I
can find the pthreads source code for LinuxPPC!

Thanks,
-Charles

-------------------------------------------------ATTACHED MESSAGE--------

Hi,

I have been trying to write a program that involves a thread pool which,
over the course of the operation of the program, will create and exit
several threads.  I am finding that if I have exited any threads during
the program run, then it hangs upon exiting from main().  [Specifically,
GDB shows it hanging in the function pthread_exit_process(), which is
called automatically by the tear-down code, I presume.]

I can't figure out why it is doing this and if there is anything that I
need to do or if it is a bug in this version or what.  I am currently
running the 4.2 release of LinuxPPC (2.1.125 kernel, based on the 5.0
RedHat release) with lib6 and egcs (so when I use C++, this should not
be a problem) and I am doing the normal _REENTRANT/-lpthreads linking
thing.

I have included some code below that will cause the problem to occur
when compiled.  Any help is greatly appreciated.

Thanks,
-Charles

----
NON-FUNCTIONAL CODE
Compiled with "gcc -D_REENTRANT -s -o buggy1 buggy1.c -lpthreads"

--NOTE THE LINE TO UNCOMMENT THAT WILL MAKE THE PROGRAM "WORK"; i.e. it
will now exit normally, but this is obviously not a real fix.--

----

/* --- Messed up Threading Code Begins --- */

#include <pthread.h>
#include <stdio.h>

void *thread_routine(void *arg)
{
/*      while(1) ; //Uncomment this (so thread doesn't die) and proc
exits! */
        return (void*)3 ;
}

main ()
{
        pthread_t thread_id ;
        void *thread_result ;
        int status ;

        status = pthread_create(
                &thread_id, NULL, thread_routine, NULL) ;
        if (status!=0) {
                printf("Create Thread!\n") ;
                exit(1) ;
        }

        status = pthread_detach(thread_id) ;
        if (status!=0) {
                printf("Detach Thread!\n") ;
                exit(1) ;
        }

        sleep(1) ;
        return 1 ;
}

/* --- Messed up Thread Code Ends --- */

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
