Message-Id: <v03010d05b2d23dd9198b@[209.96.179.28]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 25 Jan 1999 10:32:00 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>
Subject: Re: Help from Kernel Gurus needed!!!
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Nothing like answering your own question.  I never saw my post make it back
to me, but if anyone runs into the same problem here is my solution.  I
figured this out from looking at the stack inside a signal handler with gdb
so I may be wrong but this seems to work:

>From inside a signal handler, to check on old signal masks or register
contents right before the signal was delivered:


#include <asm/sigcontext.h>

    /* get the value of r1 (the stack pointer) */
    long * p;
    struct sigcontext_struct * scp;
    __asm__ ( "addi %0,1,0" : "=r" (p) : /* no inputs */ );
    /* follow it back up the chain */
    p = *p;
    /* from here the sigcontext struct is 64 bytes away */
    p = p + 16;
    scp = (struct sigcontext_struct *)p;

I hope this helps.  If it looks wrong to anyone out there please let me
know ASAP.

Thanks,

Kevin


----------------------------------------------------------
Kevin B. Hendricks
Associate Professor, Operations & Information Technology
School of Business, College of William & Mary
Williamsburg, VA 23187, kbhend@dogwood.tyler.wm.edu
http://business.tyler.wm.edu



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
