Message-Id: <v03010d01b33561985f76@[209.96.179.5]>
In-Reply-To: <19990410145303.1090.qmail@associate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 10 Apr 1999 16:19:08 -0400
To: LinuxPPC-Dev@associate.com, linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Subject: Re: Lock-up while building mod_perl
Cc: root@associate.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I backported linuxthreads-0.7 (part of glibc) to glibc 1.99 and submitted a
patch to Gary for inclusion into glibc 1.99 which he did in the form of
version 1p.  Unfortunately, linuxthreads-0.7 has some problems with the
sparse array structures used to store thread-specific data (I found this
when testing with JDK 1.2 native threads).  I have a fix, but I want to do
some more testing before releasing it.  The best solution right now for
programs that work with linuxthreads (native threads) like the JDK, MySQL
and probably mod-perl is to drop back to glibc (1o) with liuxthreds 0.5 for
now.  I will try and track down and fix all of the problems with
linuxthreads 0.7 and ppc and get a new threads update patch ready for glibc
1q or later.

Sorry about that, the fault was mine.

Kevin

At 2:53 PM +0000 4/10/99, LinuxPPC-Dev@associate.com wrote:
>Hi,
>
>Yesterday while trying to build/compile the mod_perl RPM from
>ftp://rawhide.redhat.com/SRPMS/SRPMS/mod_perl-1.18-5.src.rpm
>I experienced a total lock-up/freeze/crash.  It's been a LONG while
>since anything like that happened, so I thought I'd pass the new on here.
>I have a suspicion that this may be connected to the glibc-p release,
>which I recently upgraded to - this glibc also caused MySQL to stop working,
>even when compiled against the new glibc.
>
>Has anyone else seen this kind of problem (compiling mod_perl)?
>
>I'm running on a 7200/90 updated with all the latest R4 stuff.
>
>glen_stewart@associate.com




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
