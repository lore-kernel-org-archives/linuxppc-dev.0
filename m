From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Kernel Gurus please help!!!
Date: Thu, 11 Nov 1999 23:08:41 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99111123202100.23181@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I need a kernel gurus help here.  The native threads jdk code hangs because a
non-rt signal is pending and never gets delivered to a thread that
is in sigsuspend waiting for a real time signal (in pthread_mutex_lock) but the
signal mask atomically swapped in does not block the non-rt signal in any way.

The non-rt signal is not blocked (as shown by the /proc info and it is shown as
being pending in the thread that is waiting in rt_sigsupend).  Since it is
pending it should eventually be delivered in the do_signal() call right?  

What could keep a non-rt signal that is being pending from being delivered to a
thread that is in rt_sigsuspend?  Basically something is different about 
rt_sigsuspend in arch/ppc/kernel/signal.c  and the old sigsuspend syscall but I
am not sure what.

The only difference between the ppc port and the i386 port in signal.c that I
could immediately see is that sys_rt_sigreturn has not been implemented yet for
ppc but does exist for x86 (this is in Paul's 2.2.13 kernel rsynced yesterday),
sparc, etc.

Could this be the source of my problem?

Does anyone have an implementation for sys_rt_sigreturn I could test with.

Any help here would be greatly appreciated?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
