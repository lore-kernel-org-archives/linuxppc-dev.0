Content-Type: text/plain;
  charset="us-ascii"
From: Mark Chambers <markc@mail.com>
Reply-To: markc@mail.com
To: linuxppc-dev@lists.linuxppc.org
Subject: undefined IRQs in request_irq
Date: Wed, 18 Sep 2002 10:39:47 -0400
MIME-Version: 1.0
Message-Id: <200209181039.47488.markc@mail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wrote a driver for our custom MPC860 platform that we've ported linux 2.4.19
to.  When I insmod'd the driver it produced a kernel panic.  I traced it to
request_irq() in ppc8xx_pic.c, where the code calls panic() if the requested
irq is anything other than IDEx_INTERRUPT.  I fixed my problem by just adding
another case.

First, it seems extreme to me to crash the system instead of just refusing the
request.  Am I missing something?

Second, a suggested improvement:  How about having the individual board.h
files include #defines like ENABLE_SIU_LEVEL1, etc. that could be used like
the 'well known' IDEx_INTERRUPTs in request_irq()?

Mark Chambers
Microfirst, Inc.
mchambers@microfirst.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
