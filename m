Message-ID: <B0001822784@icamail.ica.net>
Subject: [LinuxPPC] cross compiler, compiling
Date: Sun, 28 Mar 99 01:49:03 -0400
From: Trevor Woerner <twoerner@ica.net>
To: "Users LinuxPPC" <linuxppc-user@lists.linuxppc.org>,
        "Developer LinuxPPC" <linuxppc-dev@lists.linuxppc.org>,
        "Fred Fish" <fnf@cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Friends,

following is a log i created for myself while compiling a powerpc
cross compiler on an i586. i used:

   binutils-2.9.1
   egcs-1.1.1
   newlib-1.8.1

also, i was wondering, i compiled newlib (as indicated above) but
i was wondering if i should also compile glib for this cross compiler?
if i did compile both wouldn't the second one overwrite the files
from the first one?

i know you're all rather busy, but could someone *please* comment
on the errors, especially the last (fourth) one.

here's the log:

>*** (1) *********************************************************************
>first error from "make cross" trying to build cross-egcs
>
>../../../egcs-1.1.1/libiberty/strerror.c:461: conflicting types for 
>`sys_errlist'
>/usr/local/ppc/powerpc-linux/sys-include/stdio.h:216: previous declaration 
>of `sys_errlist'
>
>--- file: strerror.c -------- line 458 ----------------------------
>#ifndef HAVE_SYS_ERRLIST
>
>static int sys_nerr;
>static const char **sys_errlist;
>
>#else
>
>--- file: stdio.h ----------- line 276 ----------------------------
>#ifdef  __USE_BSD
>extern int sys_nerr;
>extern const char *const sys_errlist[];
>#endif
>#ifdef  __USE_GNU
>extern int _sys_nerr;
>extern const char *const _sys_errlist[];
>#endif
>
>first off, why (in stdio.h) am i getting code from inside a #ifdef
>block for __USE_BSD? shouldn't __USE_BSD be undefined and instead
>shouldn't __USE_GNU be defined?
>
>in my ignorance i change strerror.c to match what is in stdio.h
>
>this leads to more problems so i reverse the changes and leave
>strerror.c the way it was and modify stdio.h
>this seems to fix that problem, compile continues...
>
>*** (2) *********************************************************************
>second error
>
>../../../egcs-1.1.1/libiberty/strsignal.c: In function `psignal':
>../../../egcs-1.1.1/libiberty/strsignal.c:589: argument `signo' doesn't 
>match prototype
>/usr/local/ppc/powerpc-linux/sys-include/signal.h:83: prototype declaration
>../../../egcs-1.1.1/libiberty/strsignal.c:589: argument `message' doesn't 
>match prototype
>/usr/local/ppc/powerpc-linux/sys-include/signal.h:83: prototype declaration
>
>
>--- file: strsignal.c ------- line 585 ----------------------------
>void
>psignal (signo, message)
>  unsigned signo;
>    char *message;
>
>
>--- file: signal.h ---------- line 083 ----------------------------
>extern void psignal __P ((int __sig, __const char *__s));
>
>changed signal.h
>
>compile continues...
>
>*** (3) *********************************************************************
>In file included from ../../../egcs-1.1.1/libio/iolibio.h:1,
>                 from ../../../egcs-1.1.1/libio/libioP.h:40,
>                 from ../../../egcs-1.1.1/libio/iogetline.c:26:
>../../../egcs-1.1.1/libio/libio.h:168: stdio-lock.h: No such file or 
>directory
>
>file found in ${INCLUDE_DIR}/g++, copy (-i) most everything from g++ subdir
>to its parent
>
>compile continues... SUCCESS!!
>
>*** (4) *********************************************************************
>problems installing: (make install LANGUAGES="c c++")
>
>powerpc-linux-ranlib: error in loading shared libraries
>libc.so.6: ELF file data encoding not little-endian
>
>so i'm not sure if it was installed sufficiently


best regards and thank you very much,
   trevor woerner

------------------------------------------------------------

...Senior, for his first selection, will play "A Cup Of
   Coffee, A Sandwich, And You" from the opera: Aida

                             --- Groucho Marx
                                 The Cocoanuts, 1929


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
