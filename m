To: linuxppc-dev@lists.linuxppc.org
Cc: debian-powerpc@lists.debian.org
Subject: pty troubles (TIOCSETP) with Linux PPC 2.4 kernels
From: Jered Floyd <jered@mit.edu>
Date: 16 Sep 2001 21:42:32 -0400
Message-ID: <s56wv2yegon.fsf@vice-grips.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The short version:

xterm -xrm 'xterm*eightBitInput: false'  yields
xterm: fatal pty error 23 (errno=22) on tty /dev/pts/4

on at least the stock Debian PPC kernel (2.4.4), the latest BitKeeper
tree (2.4.10-pre8), and 2.4.9-benh0.  This problem does not occur on
the i386 architecture.


The somewhat longer version:

I have the 'eightBitInput: false' resource set in my .Xresources, so
that when I ssh to other machines, meta works properly in xterm. (Yes,
yes, I realize that 'metaSendsEscape: true' will do this too, but I want
Alt, Super, Hyper, etc to work as well.)  This does not work with any
linux-ppc kernel that I have tried; I get the error above.

errno 22 is EINVAL, and 23 refers to the error occuring on a TIOCSETP
call (which looking at the xterm code could also mean that a TCSETA
call failed).

I've tried to debug this, but I started looking at the xterm code and
kernel termios and my brain leapt out through my ear and is currently
cowering under the bed.  I've been trying to lure it out with treats,
but have thus far been unsuccessful.

The only notable change that this Xresource should cause is setting
CS7 instead of CS8 in the termios control mode flags, in a TCSETA call.
I have been unsuccessful in trying to replicate this failure in a small
test program, however.

Has anyone else encountered this?  For that matter, why is termbits.h
different from i386 to ppc in the same kernel?  I can't think of any
plausible reason.

--Jered
jered@mit.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
