Message-ID: <36988FF6.A4E4AB1B@pop.agri.ch>
Date: Sun, 10 Jan 1999 12:33:17 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Multiple recipients of list <linux-pmac@samba.anu.edu.au>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: header confusions 2.1.24vs. 2.1.131
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

it comes again, I didn't found a clear solution about my problem. Only a dirty hack.

I tried to compile the ACE package from: www.cs.wustl.edu/~schmidt/ACE.html.
Under R4 I managed it also now under pre-5, but I'm not happy with the solution.
The problem has to do with the 'fb_set' struct and its member fds_bits. The
definition of it is in the select.h/ types.h. In R4 there is a definition of
the struct in <linux/posix_types.h>
like this:

"typedef struct fd_set {
"			unsigned long fds_bits [__FDSET_LONGS];
"} __kernel_fd_set;

in pre-R5 it looks like this (also in <linux/posix_types.h>) :

"typedef struct {  // without the fd_set!!
"			unsigned long fds_bits [__FDSET_LONGS];
"} __kernel_fd_set;

Changing the pre-5 definition in the R4 definition doesn't help.

When I compile it under pre-5 with the latest egcs 1.1.1.c, I get an error
which complains about fds_bits is not member of the struct fd_set.
A look at the corresponding code line shows me, that a operation on fds_bits
is done.

Modifying this fds_bits into __fds_bits in code works, the compiler is
satiesfied. (If the code really works is another question.) 

My question, what is going wrong and why do the locations and definitions of
the header files change from 2.1.24 to 2.1.131?


Any hints are welcome

Thanks
Andreas

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
