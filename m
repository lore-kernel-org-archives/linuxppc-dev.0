Date: Mon, 29 Mar 1999 12:25:14 +1000
Message-Id: <199903290225.MAA02518@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: hozer@drgw.net
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.04.9903281816160.17542-100000@narn.local.drgw.net>
	(message from Troy Benjegerdes on Sun, 28 Mar 1999 18:24:43 -0600
	(CST))
Subject: Re: Samba and shared mem trouble
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.04.9903281816160.17542-100000@narn.local.drgw.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes <hozer@drgw.net> wrote:

> samba 2.0.3 seems not to work on glibc-2.1 and kernel 2.2.4 vger.
> 
> This appears to be related to shared memory somehow.. Does anyone have
> any ideas on what's going on? I'd like to have some suggestions on where
> to look before I go off on a wild goose chase bug hunt.

I asked Tridge about the problem and he says it wouldn't be using
shared memory if it's using mmap.  Is your /var/lock/samba in an NFS
partition perhaps?  Some people have reported problems in mmap'ing
files over NFS.

You can recompile samba to use SysV shared memory by changing a little
bit of code in source/include/includes.h.  You'll see a comment about
Linux and the speed of fcntl locking vs. SysV semaphores.  In fact for
linux 2.2, SysV semaphores are faster than fcntl locks.  If you change
it to use SysV semaphores it will also use SysV shared memory and
hopefully your mmap problems will go away.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
