From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: How to keep gcc haifa from moving userlevel thread lock function?
Date: Tue, 1 Feb 2000 22:26:18 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00020122402100.07553@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

The green_threads implementation of the JDK sets a schedule lock that prevents
any green thread (not a linuxthread) from yielding (think of green_threads
as userland cooperative threads that run in a single process).

Here is the routine:

/*
 * Lock the thread scheduler
 */
void
_sched_lock()
{
    ++_scheduling_lock;
}

where _scheduling_lock is a global integer.

The problem is that the calls to _sched_lock seems to be moved by the haifa
scheduler just enough to force me to compile many things with -O0 to prevent
problems.

I *think* gcc is inlining the call and then the haifa scheduler seems to want
to move this around abit since it does not directly impact the code around it.

What is the correct way to keep the gcc (haifa) from moving this around?

I have already tried:

 "-O2 -fno-schedule-insns -fno-schedule-insns2"

but that does not seem to do the trick.

I am sure there must be some indicator (like volatile) that I should be using.

Any help would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
