Message-ID: <36D32363.80607464@pixo.com>
Date: Tue, 23 Feb 1999 16:53:39 -0500
From: Mike Lockwood <lockwood@pixo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Possible problem with wait() in 2.2.1 kernel
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I am in the process of trying to figure out why multithreaded debugging
is broken on linuxppc preR5.  I ran into a few problems in gdb related
to changes in signal numbering.  I think I have that fixed, but now I
have a problem that appears to be in the kernel.

I am running the 2.2.1 kernel from samba.anu.edu.au, glibc glibc-2.1-1
from RPMS on mirror.linuxppc.org, and a gdb I built from gdb-4.17 plus
the gdb 4.17.0.11 patch.

On line 90 of gdb/infarg.c, gdb calls the wait() system call to receive
a signal from the program being debugged or one of its clones.  The
problem is, wait always returns the main pid of the program being
debugged, even if the signal occured in one of the clones created by the
pthread library.  Because of this, gdb does not know anything about any
of the threads created by my program, and gets very confused when it
hits exceptions or breakpoints in one of the other threads.  

I am running the 2.2.1 kernel and gdb 4.17.0.10 on an intel box and
multithreaded debugging is working fine there.  Does anyone know of any
differences between the intel and ppc 2.2.1 kernels that could explain
this behavior?

thanks,
Mike

-- 
Mike Lockwood
Pixo, Inc.
lockwood@pixo.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
