To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Static linking /Shared Library Application Errors. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 05 Aug 2003 06:11:12 PDT."
             <20030805131112.59750.qmail@web8007.mail.in.yahoo.com>
Date: Tue, 05 Aug 2003 15:21:20 +0200
Message-Id: <20030805132125.82BB9C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030805131112.59750.qmail@web8007.mail.in.yahoo.com> you wrote:
>
> I am trying to execute certain fileutils application
> like cp ,ls ..
> These applications are compiled using the Glibc 2.2.3
>
> The problem is if i compile the applications
> Statically
> and try to execute the command cp,ls ..i get the
> segmentation fault error.Please let me know the proper
> compiler options  for static linking.

Please explain which toolchain you are yusing, which  libraries,  and
which versions of the tools listed above.

> OBJS = cat.o chgrp.o chmod.o chown.o cmp.o cp.o dd.o
> grep.o l.o ln.o ls.o \
>         mkdir.o mkfifo.o mknod.o more.o mv.o rm.o
> rmdir.o sync.o touch.o vi.o

Where did you get these object files from?

I have a suspicion that these are  in  fact  parets  of  the  busybox
toolbox.  If  this  is  correct,  then  why  don't you simply use the
Makefile that comes with busybox?

> Then i tried to eliminate the problem by using shared
> library that is put the ld.so.1 file and libc.so.6
> file in the /lib directory of the ramdisk .
> The problem is the library files are too big in size.
> libc is 5.1mb and ld.so.1 is .5mb

You can strip the shared libraries for the target.

> inorder to create a ramdisk image i have used the
> initrd.sudo scrip file form the denx SELF package.
> : ${IRD_SIZE:=4096k}
>
> dd if=/dev/zero of=$IMAGE bs=$IRD_SIZE count=1
> 2>/dev/null

Again, I have the suspicion  that  this  code  comes  from  our  SELF
package.  The  scripts provided by SELF take care of all the problems
you are running in.

> 1.should i use statick linking

No, this will most probably just increasy your memory footprint.

> 2.shared library ..

Yes.

What I don't understand: there is a working set of tools and scripts.
You rip it apart, omit essential parts, and then complain that it  is
not working any more.

What else did you expect?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is surely a great calamity for  a  human  being  to  have  no  ob-
sessions.                                                - Robert Bly

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
