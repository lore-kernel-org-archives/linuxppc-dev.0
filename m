Message-Id: <199902171603.KAA28972@wolfram.com>
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: bugs building stuff.. somewhere.. (was: back to gcc under pre-R5)
In-reply-to: <XFMail.990217133431.gdt@linuxppc.org> 
References: <XFMail.990217133431.gdt@linuxppc.org>
Date: Wed, 17 Feb 1999 10:03:54 -0600
From: Brian Downing <bdowning@wolfram.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Feb 1999 13:34:31 -0000 (GMT), Gary Thomas writes:
 > There are no current RPMs for GCC to my knowledge.  The last ones I made
 > nearly two years ago and gave up on shortly thereafter because EGCS was
 > much superior.
 > 
 > What bug in EGCS is so terrible that you are considering this move?
 > Which version of EGCS have you tried?
 > 
 > There will be EGCS-1.1.2 in the very near future which has many PowerPC
 > problems fixed, perhaps you can wait.

I've had similar problems building software.  I'm not sure where the
problem is, but I cannot compile this software statically.  I wouldn't
care, but for it to be useful, it must be able to run on all PPC
platforms.

When I link dynamically, everything works fine, everywhere that I've
built it - unfortunately binary portability is a little low.

When I try to link it statically, I get a bunch of ld errors from
libc.a about "tried to relocate __pthread_mutex_lock" and other various
__pthread_* calls.  No binary is generated.  I tried to compile a
non-reentrant version of glibc with no linuxthreads (since I'm building
statically and the software isn't threaded I figured it was worth a try).
Unfortunately glibc doesn't appear to build without linuxthreads anymore
- even with --disable-sanity-checks.  I've even gone so far as to ifdef
out the offending calls in glibc (for testing), and other similar errors
show up for different places in glibc.  I don't have the exact errors
on hand right now, but I can get them if anyone thinks they would help.

Of course, I've tried compiling on MkLinux, and it builds fine, but a
different component dumps core when built there.  Of course, the same
component when compiled statically on LinuxPPC-pre-r5, will run on
MkLinux, but NOT LinuxPPC-r4 (Illegal Instruction).

So maybe I should ask the evil question:  Just how binary compatible
are the various PPC kernels and distributions.

(Built on a PowerBook G3 266, with linuxppc-pre-r5, with egcs-1.1.1 and
the latest snapshot I could build, with glibc-2.0.108 and glibc-2.1,
and with some other variations made for the heck of it.)

So anyway, sorry for the sob story, but in the last two weeks I've seen
more failed builds for dumb reasons... :)

-bcd
--
**               Brian Downing
**  UNIX Systems Administrator
**        bdowning@wolfram.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
