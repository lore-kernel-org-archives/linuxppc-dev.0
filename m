Message-Id: <199911161114.MAA18127@appel.flower>
To: linuxppc-dev@lists.linuxppc.org
Subject: /dev/fd0 close () hangs -- how to debug?
Date: Tue, 16 Nov 1999 12:14:57 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've never gotten my floppy drive to work under Linuxppc, it works fine
under MacOS.  When accessing the floppy, it sounds ok, but the close ()
system call doesn't return.  After this, the fd0 device can't be accessed
again because it's busy.  The process can't be killed.

I've got no experience with kernel-debugging, how to proceed?
Can you give me some pointers?

Greetings,

Jan.

My machine is a beige G3 powermac, linuxppc R5.

Linux appel.flower 2.2.6-15apmac #1 Fri Apr 30 12:52:03 EDT 1999 ppc unknown
glibc-2.1.1-6c
egcs-1.1.2-12f

But with 2.3.23 (can't get > 24 kernels to work: 'copying of device tree...
done.' --- nothing; 24 has video mode problems) and glibc-2.1.3-0b 
(ftp://dev.linuxppc.org/users/fsirl/R5/SRPMS/) yield the same result.

Here's an example gdb session using dd, linked statically to home-made
glibc-2.1.3, with debug info.

[root@appel src]# gdb dd
GNU gdb 4.17.0.11 with Linux support
(gdb) break cleanup
Breakpoint 1 at 0x1800704: file dd.c, line 375.
(gdb) r if=x of=/dev/fd0
Starting program: /usr/src/redhat/BUILD/fileutils-4.0/src/dd if=x of=/dev/fd0

Breakpoint 1, cleanup () at dd.c:375
375       print_stats ();
(gdb) l
370     }
371
372     static void
373     cleanup (void)
374     {
375       print_stats ();
376       if (close (input_fd) < 0)
377         error (1, errno, "%s", input_file);
378       if (close (output_fd) < 0)
379         error (1, errno, "%s", output_file);
(gdb) n
41+1 records in
41+1 records out
376       if (close (input_fd) < 0)
(gdb) n
378       if (close (output_fd) < 0)
(gdb) s

...

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien/      | http://www.lilypond.org/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
