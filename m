Message-ID: <36BD5515.885304BB@wanadoo.fr>
Date: Sun, 07 Feb 1999 09:55:49 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Gnuplot-3.7 and fprintf format string length
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

the new gnuplot-3.7 compiles out of the box on both R4 and pre-R5. It
runs OK, but there is a bug, initially detected by Pascal Denis:

The commands 'save' or 'save set' give segmentation faults. This does
not happen on Solaris, so it is Linuxppc related, although it might be
an egcs problem. More likely, it is a glibc problem, but it appears on
both glibc-961212 and glibc-2.0.111.

I tracked the problem down to a fprintf with a long format string that
writes 10 lines of output. If I break it up into 2 fprintf calls writing
5 lines each, the problem goes away. In gnuplot-3.6, the corresponding
code contained 10 fprintf statements writing 1 line each, and there was
no problem.

So my question is: Is there somewhere a limit to the length of a format
string or to the number of variables that can be printed with a single
fprintf command? 

The gdb backtrace on the glibc-2.0.111 version starts with
#0  0x1431030 in strlen () at soinit.c:59
#1  0x1415510 in _IO_vfprintf () at vfprintf.c:1529
but in the glibc sources where I looked for soinit.c, I couldn't see any
mention of strlen().

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
