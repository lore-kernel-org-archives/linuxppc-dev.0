Date: Fri, 15 Jan 1999 14:31:22 +1100
Message-Id: <199901150331.OAA01845@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.981115182106.10912A-100000@pacific.pht.com>
	(message from Brad Midgley on Sun, 15 Nov 1998 18:27:09 -0700 (MST))
Subject: Re: floppy driver bug: write-protect
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.981115182106.10912A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> is this a known bug?

well, I didn't know about it. :-)

> on intel linux, if you try to mount a write-protected floppy disk
> read-write, the mount succeeds but is demoted to read-only. 

Do you have access to an intel-linux box?  Could you do an strace on
the mount command on a write-protected floppy and see whether mount
does two mount system calls (the first failing with EROFS), or if it
does some other ioctl to check whether the disk is write-protected?

> the current pmac kernel will mount the disk read-write and will allow
> "writes" to the disk. the writes even appear to succeed and the mounted

OK, I need to check the write-protect status in the floppy_write
routine in swim3.c.

I have recently looked at the floppy driver source code in MkLinux,
which looks like it is derived from macos sources.  It looks like
there are a few tweaks which I need to do to the Linux/PPC driver.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
