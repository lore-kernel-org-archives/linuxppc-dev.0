Date: Mon, 10 Dec 2001 15:31:23 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: unkillable zombies from using gdb and kernel 2.4.15 and higher?
Message-ID: <20011210153123.A11283@nevyn.them.org>
References: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CF1E527E-ED77-11D5-8C12-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 10, 2001 at 09:11:30AM -0500, Kevin Hendricks wrote:
>
> Hi,
>
> I have been debugging a glibc-2.2.4 issue that involves forking and
> reaping and threads using gdb.  Unfortunately, every time I run things
> under gdb I create an "unkillable" zombie process that (even after gdb
> has gone away) is impossible to remove.

This should never happen.

There is a known bug in the kernel, for which Mark Kettenis has sent
patches several times but they keep slipping through cracks, which
makes exited threads live until the GDB controlling them exits.  I can
send you the patch if you need it.

> ps -Af | grep idlc
> kbhend   25532     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25529     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25541     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25543     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25540     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25552     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25554     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25551     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   14796 10716  0 09:11 pts/4    00:00:00 grep idlc

Have you tried rebooting and repeating?  Could your init be fried?  It
ought to reap them.

Also check /proc/pid/status on a zombie.  What does it say?


> [root@localhost program]# kill -9 25530 25532 25529
> [root@localhost program]# ps -Af | grep idlc
> ....
> kbhend   25530     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25532     1  0 Dec08 ?        00:00:00 [idlc]
> kbhend   25529     1  0 Dec08 ?        00:00:00 [idlc]
>
> So these zombies are ignoring kill -9  signals which I thought was a big
> no-no?
>
> Did something change in signal handling lately that allows this to
> happen?

You're not sending them signals.  They're already dead :P

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
