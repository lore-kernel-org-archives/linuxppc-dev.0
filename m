Message-ID: <3685BC4F.EB0D2158@jlc.net>
Date: Sat, 26 Dec 1998 23:49:19 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Need ld.so help
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I discovered the problem I am having with the embedded 8xx
processors and cache is that there are several assumptions
about cache block size in various functions.  The 8xx processors
have a 4 word (16 byte) cache line while other PPCs have
a 8 word line.  This causes problems when trying to flush and
invalidate caches.

One place this is done is dynamic linking functions of ld.so,
where it is assumed a cache line is 8 words.  Unfortunately,
I have been unable to build ld.so from the glibc SRPM.  I am
using the 961212-1h SRPM from the linuxppc.org server, and
the appropriate egcs and binutils.  All of the other libraries
I build from this SRPM are fine.  From looking at the RPM of
the same version, all of the resulting *.so files appear to be
nearly identical, except for ld.so which is much larger than
found in the RPM.

The details....I have tracked it down to the elf_get_dynamic_info()
function, called from _dl_start().  The failure occurs following
the 'while' loop.  It appears info[DT_RELA] is OK, or at least
not NULL.  However, info[DT_RELAENT] is NULL, causing the
program to segfault at this point.

I don't understand enough about the libraries to know where to
look from here, so I need some help :-)

Oh yeah, the SRPM didn't build quite right.  I had to hand patch
stdlib/exit.c.....

Thanks.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
