Message-ID: <0B0A39652BB0D411BCCF00508B9512EC0F768190@tx14exm05.ftw.mot.com>
From: Hawkes Steve-FSH016 <Steve.Hawkes@motorola.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8540 board hangs console when running with Linux 2.4.20 kernel us
	ing latest SPS TSEC multicast Ethernet drivers
Date: Tue, 6 Apr 2004 17:52:45 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm running a Linux 2.4.20 kernel on a custom PPC 8540 board and am
encountering a problem which causes the console, and eventually the entire
system, to hang during bring-up of our primary application.

When using a kernel using the standard Ethernet drivers delivered in a
Metrowerks or Montavista ADS board distribution, everything appears to work
fine. We pulled in the latest Ethernet drivers from SPS (gianfar*, etc.) to
pick up multicast support, which is required for OSPF, and started running
into problems, but the problems don't have any obvious relationship to the
new drivers. When I bring up our applications on the board from the console
tty, the console stops responding at a random point during application
initialization (which is a fairly CPU-intensive sequence involving many
processes and threads).

We are running the root file system via NFS, so I've been able to examine
/var/log/*, etc., remotely, but see no error messages. Likewise, the console
shows no error messages or output once it stops responding.

Usually when this occurs I am still able to ping the board for some period
of time. Eventually it stops responding. Occasionally the board is entirely
unresponsive to pings when it hangs.

Oddly enough, when I enabled telnet on the board and connected to it before
starting our application, the telnet session survived the console hang. I'm
able to run ps, gdb, etc., from the telnet session for a considerable period
of time even though the main application appears to have stopped in the
middle of its initialization. What is really odd is that ps -aux shows no
change in CPU% for all processes from the time of the hang forward--it's
like all measurement of CPU utilization froze at the time of the hang. The
'top' command also freezes at this point. If I try to start it after the
hang, 'top' never does anything; that is, it displays no output and does not
return.

I cranked up gdb on what I believe was the last process started within our
application and see the following in several threads within the process:

Thread 4 (Thread 32771 (LWP 1201)):
#0  0x0f191ff8 in select () at <stdin>:2
#1  0x0f191fd8 in select () at <stdin>:2
#2  0x0f9d72f4 in selectProc ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#3  0x0f9d2900 in serviceJobs ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#4  0x0f9de798 in threadEntry ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#5  0x0f046b8c in pthread_start_thread (arg=0x4) at manager.c:300
#6  0x0f198dc8 in clone ()
    at ../sysdeps/unix/sysv/linux/powerpc/powerpc32/clone.S:78

Thread 3 (Thread 16386 (LWP 1200)):
#0  0x0f04d210 in nanosleep () at <stdin>:2
#1  0x0f04d1fc in nanosleep () at <stdin>:2
#2  0x0f049320 in __pthread_timedsuspend_new (self=0xfffffdfc, abstime=0x0)
    at pthread.c:1288
#3  0x0f045fe0 in pthread_cond_timedwait_relative (cond=0xf9f69b0,
    mutex=0xf9f6a28, abstime=0x305bf9d0) at restart.h:45
#4  0x0f9df8a8 in srkWaitForCond ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#5  0x0f9d52c8 in threadWatchMonitor ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#6  0x0f9de798 in threadEntry ()
   from /home/visitor/linux-8540/active/lib/LINUX/libgosrk.so
#7  0x0f046b8c in pthread_start_thread (arg=0xfffffdfc) at manager.c:300
#8  0x0f198dc8 in clone ()
    at ../sysdeps/unix/sysv/linux/powerpc/powerpc32/clone.S:78

Perplexed by the number of threads waiting in nanosleep, I compiled and ran
a program which simply calls nanosleep with a timeout of one second. When
run before the hang, it sleeps for a second, then continues (of course).
When run after the hang, it sleeps forever (or as long as I am willing to
wait).

As far as I can determine, the only difference between a set-up that works
and one that doesn't is the change from the standard 8540 Ethernet drivers
to the bleeding-edge ones from SPS. An examination of the changes in the
drivers with our limited driver expertise shows nothing suspicious.

Any helpful pointers to troubleshoot this problem would be appreciated.

Steve Hawkes
Motorola

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
