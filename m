Date: Sat, 26 Feb 2000 09:01:40 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1000226160140.ZM9111@saguaro.lan>
In-Reply-To: "jjs" <Jerry.Sexton@insignia.com>
        "Re: gdb and multi-threaded applications." (Feb 26, 12:38pm)
References: <031401bf8056$678deb00$571170c1@honda.isltd.insignia.com>
To: "jjs" <Jerry.Sexton@insignia.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gdb and multi-threaded applications.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Feb 26, 12:38pm, jjs wrote:

> Thanks for your reply the other day, I have tried taking the gdb-000222
> snapshot from the ftp site and compiled it, but I am getting the same
> behaviour as I was with 4.17.0.14, which unfortunately I did not fully
> describe in my original message. I am seeing the described behaviour with
> 'info threads' but also when I run my program under gdb, it hangs when
> trying to create a new thread via a call to pthread_create. It works as
> expected outside the debugger, creating the thread and continuing.
>
> I have tried attaching gdb to the gdb process that is hanging and get the
> following stack trace:
>
> #0  0x15c64c0 in __syscall_rt_sigsuspend () at soinit.c:59
> #1  0x15c51f0 in __sigsuspend (set=0x19da444)

Would it be possible for you to print out the contents of set at this
point?  (Go "up" a frame and do "print *set".)

>     at ../sysdeps/unix/sysv/linux/sigsuspend.c:48
> #2  0x184aa88 in linux_child_wait (pid=-1, rpid=0x7fffe0f0,
> status=0x7fffe0f4)
>     at linux-thread.c:1338

And I'd like to see what linux_threads_block_mask is at this point too.

> #3  0x184ad14 in linuxthreads_wait (pid=-1, ourstatus=0x7fffe150)
>     at linux-thread.c:1415
> #4  0x18316e4 in wait_for_inferior () at infrun.c:1261

I have seen this backtrace before.  For a time, I was seeing hangs
under certain circumstances when debugging single threaded
applications too.  The problem was that the SIGCHLD signal was being
blocked.  This is why I want to know the signal mask is which is being
passed to sigsuspend().

> I am running with kernel 2.2.6-15apmac, which came with the linuxppc-1999
> distribution.

We're running the same kernels at least.

> Any assistance you can give me will be gratefully received.

Are you running a proprietary applicaton?  If not, it may be useful at
some point for me to get a copy of it and try to reproduce the problems
you're seeing myself.

In the interim, it may be useful for you to try out the threaded
program testsuite/gdb.threads/linux-dp which is (obviously) in the gdb
testsuite.  Here's part of a sample run when I try it.  (Note:  If you
do "make check" from the gdb directory, all of the programs will be
built and the test suite will be run.  After the testsuite finishes
running, all of the programs are built and you can try running them
yourself.)

    [kev@arroyo testsuite]$ ../gdb gdb.threads/linux-dp
    GNU gdb 20000204
    Copyright 1998 Free Software Foundation, Inc.
    GDB is free software, covered by the GNU General Public License, and you are
    welcome to change it and/or distribute copies of it under certain conditions.
    Type "show copying" to see the conditions.
    There is absolutely no warranty for GDB.  Type "show warranty" for details.
    This GDB was configured as "powerpc-unknown-linux-gnu"...
    (gdb) b 187
    Breakpoint 1 at 0x10000d7c: file /ocotillo1/kev/sourceware/src/gdb/testsuite/gdb.threads/linux-dp.c, line 187.
    (gdb) r
    Starting program: /home/kev/sourceware-gdb-bld/gdb/testsuite/gdb.threads/linux-dp

    Breakpoint 1, main (argc=1, argv=0x7ffffd04)
	at /ocotillo1/kev/sourceware/src/gdb/testsuite/gdb.threads/linux-dp.c:187
    187         for (i = 0; i < num_philosophers; i++)
    (gdb) info thread
    (gdb) n
    189             numbers[i] = i;
    (gdb) n
    191             pthread_create (&philosophers[i], &ta, philosopher, &numbers[i]);
    (gdb) s
    [New Thread 32622 (manager thread)]
    [New Thread 32621 (initial thread)]
    [New Thread 32623]
    187         for (i = 0; i < num_philosophers; i++)
    (gdb) info thread
      3 Thread 32623  0xfe094c0 in __syscall_rt_sigsuspend () at soinit.c:59
    * 2 Thread 32621 (initial thread)  main (argc=1, argv=0x7ffffd04)
	at /ocotillo1/kev/sourceware/src/gdb/testsuite/gdb.threads/linux-dp.c:187
      1 Thread 32622 (manager thread)  0xfe08178 in kill () at soinit.c:59
    (gdb) print num_philosophers
    $1 = 5
    (gdb) n
      _ 0 _
      ! 0 _
    189             numbers[i] = i;
    (gdb)
    191             pthread_create (&philosophers[i], &ta, philosopher, &numbers[i]);
    (gdb)
    [New Thread 32624]
	  _ 1 _
	  ! 1 _
	  ! 1 !
	  _ 1 _
    187         for (i = 0; i < num_philosophers; i++)

The thing to notice in the above run is that we make it through several
calls of pthread_create().  (If I would've sent you the rest of my trace
you'd see that it makes it through all five calls successfully.)

Also... I doubt that it'll matter, but I've fixed a few bugs in the last
several days.  (I'm now seeing only 14 testsuite failures.)  You may wish
to download a newer version.

One last thing... could you do "rpm -q -f /lib/libpthread-0.8.so" and tell
me what the output is?  Here's what happens when I try it:

    [kev@arroyo kev]$ rpm -q -f /lib/libpthread-0.8.so
    glibc-2.1.1-6c

Kevin

--
Kevin Buettner
kev@primenet.com, kevinb@redhat.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
