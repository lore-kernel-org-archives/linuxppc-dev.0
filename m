From: Brad Boyer <flar@cegt201.bradley.edu>
Message-Id: <199905070442.XAA11076@cegt201.bradley.edu>
Subject: Question about SMP
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 6 May 1999 23:42:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I've been trying to get SMP working on my PowerMac for some time now,
and it just never seems to work.  I've tried compiling my own kernels,
as well as compiling my own, and I've never had a working SMP system.
I just tried to compile a 2.2.7 kernel from the rsync code on
samba.anu.edu.au and got a better result than I have in a while, but
still not good.  It starts up fine, but then fails as soon as it has
to start using the scheduler.  It prints out the first line in
rc.sysinit, which is the comment about starting swap, tries to run
swapon, and then just starts printing messages to the console about
spin_lock and write_lock, I believe it was.  I wrote down the
addresses it had in the errors, and looked them up in the System.map.
The first one was in schedule() with a pointer to scheduler_lock, and
the other one only gave a pointer, which was waitqueue_lock.

I started looking at kernel/sched.c which is where most of this stuff
is, and I didn't see anything obvious, but I did notice a few things
that seemed odd.  Do spinlocks only exist in an SMP kernel?  I ask
because there is a spinlock where the matching unlock is in an #ifdef
__SMP__ which seemed like a bad idea.  If anyone can help me get this
running, I'd appreciate it.  I'm more than willing to fiddle around
with the code if someone can give me some hints on this stuff.

	 Brad Boyer
	 flar@cegt201.bradley.edu

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
