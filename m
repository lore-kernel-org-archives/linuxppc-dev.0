Message-Id: <v03010d05b2d1936a8f9b@[209.96.179.197]>
In-Reply-To: <l03130300b2d0a1474a03@[172.16.10.14]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 24 Jan 1999 22:31:59 -0500
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <kbhend@dogwood.tyler.wm.edu>
Subject: Help from Kernel Gurus needed!!!
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I could really use some help from you kernel gurus out there.  In Sun's JDK
1.2 green_threads implementation, their signal handlers are passed a
pointer to a  context structure that allows them to see what the signal
mask was immediately before the signal was delivered.

We need to do the same thing in the ppc port.  So in a signal handler I
would like some way of knowing the address of the sigcontext structure
where the old mask is stored.

I have looked in arch/ppc/kernel/signal.c and I can find the place where
the structure is built, I just can't figure out a way to find it easily on
the stack.

This same info is easy to find on x86 since it is on the stack right before
the value of sig (the signal number) which is passed on the stack.

Any ideas here?  I could do a sigsetjmp to easily get the values of r1 and
lr if either of those can be used to find the location of the sigcontext
structure on the stack by working backwards.

Any help of ideas here would be greatly appreciated.

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
