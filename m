Message-ID: <37163753.D2022EDD@natinst.com>
Date: Thu, 15 Apr 1999 14:00:36 -0500
From: Dean Luick <dean@natinst.com>
MIME-Version: 1.0
To: costabel@wanadoo.fr, linuxppc-dev@lists.linuxppc.org
Subject: Re:[Patch]linuxppc gnuplot segfaults in save
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Here is a minimal example, adapted from the gnuplot sources. If used
as
> "a.out foo.gnu", it segfaults for me. Compiler is egcs-2.91.66
19990314
> (egcs-1.1.2 release) (PowerPC GNU/Linux), glibc-2.1.1-3a.
> gbd backtrace gives

Using egcs 1.0.2 prelease, it looks like egcs is messing up how it
pushes
arguements on the stack.  In partiuclar, egcs should be filling all of
the integer
argument registers, r3-r10.  Instead, it places what should to in r8 in
r10, and placing
what should be in r9 and r10 on the stack.  This leave r8 and r9
completely random, plus
pushes the final two integer arguments (which should be on the stack) 8
bytes off from
their correct position.

Assuming that fprintf correctly interprets the format string, it is no
wonder that
it crashes.

Dean



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
