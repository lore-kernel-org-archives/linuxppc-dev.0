Date: Tue, 6 Nov 2001 19:39:24 -0500
Message-Id: <200111070039.fA70dO228613@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: How to debug glibc library functions in glibc...
To: @popmail.space.net (No recipients specified)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have an application that's dynamically linked, running and it has the
problem where:

void foo(double x, double y)
{
  fprintf(stdout, "Values are %f, %f\n", x, y);
}

doesn't produce anywhere near the expected output.  We've fired up gdb
and used the remote target on it(since the application is running on
the embledded ppc board), and since libc is dynamically linked in, I
told gdb that glibc symbols are at:

(gdb) add-symbol-file ....../libc.so.6 0x30000000
(gdb) dir ...../glibc-2.2.2/stdio-common/

then we can get to fprintf.  (I picked 0x30000000 since from somewhere
I remember that's where the library starts linking itself in).
Unfortunately that address(and the ones folloing it) look like an
array of stub instructions to branch off to the funcstions in glibc.
If I 'stepi', I'm off in code the looks like fprintf, but I don't have
any symbols to match to that address.

Unfortunately I don't have a clue how to go further from here.

Does anybody have an idea what magic incantation(s) I need to throw at
gdb to get it to be able to use the library source and allow me to set
breakpoints in libc.so.6 and other sub-libraries that glibc is fond of
linking in on the fly so I can figure out why fprintf() is producing
the incorrect output???

Thanks in advance,

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
