From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15753.7943.294858.151802@argo.ozlabs.ibm.com>
Date: Thu, 19 Sep 2002 10:49:11 +1000 (EST)
To: markc@mail.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: undefined IRQs in request_irq
In-Reply-To: <200209181039.47488.markc@mail.com>
References: <200209181039.47488.markc@mail.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark Chambers writes:

> I wrote a driver for our custom MPC860 platform that we've ported linux 2.4.19
> to.  When I insmod'd the driver it produced a kernel panic.  I traced it to
> request_irq() in ppc8xx_pic.c, where the code calls panic() if the requested
> irq is anything other than IDEx_INTERRUPT.  I fixed my problem by just adding
> another case.
>
> First, it seems extreme to me to crash the system instead of just refusing the
> request.  Am I missing something?

No.  IMO the current request_8xxirq / request_irq stuff is completely
bogus.  I can understand it as a temporary construction while
debugging stuff, but it has long outlived its usefulness.  We should
just use request_irq for everything, request_8xxirq should die.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
