Message-ID: <393704B5.6B809CE6@embeddededge.com>
Date: Thu, 01 Jun 2000 20:49:57 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Tarr <tarr@lucent.com>
CC: LINUX-PPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Motorola MPC8260-ADS Boot hassel
References: <3936790D.9BD7680E@lucent.com> <3936F0F2.DDA90328@embeddededge.com> <3936A547.7C34A0BF@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Tarr wrote:
>
> Sorry for the confusion. I am not familiar with the
> Linux PANIC messages.

You will be soon :-).

> 1. NIP 0xC0010D90 is in wake_up_process()

> 3. Disasembling sched.o gave me a file offset of 0x1dc0 for
> wake_up_process(). The failing

Thanks, this was good and it all makes sense now......


>     1dd4:   7c 7e 1b 78     mr  r30,r3

>  >> 1e00:   81 3e 00 3c     lwz r9,60(r30)

>     Note: r30 is loaded from the paramenter passed in, r3.

Yep.

> 4. I made a seemingly foolish assumption that the TRAP: 0300
>    was the exception vector. Hence that it was a DSI exception.

Not foolish, that's correct.

>    Looking at the register dump shows r30 = 0xc0100000. Hence
>    my question.

Mistake.  R30 is zero.  Null pointer.  Decimal 60 is the offset 0x3c.
The wake_up_process() was passed a NULL task pointer.  Track it down
through the stack backtrace.

> 5. The SUNI-lite is an SDH/ATM framer for the Fiber that uses FCC2.

Cool.  That shouldn't be causing any trouble at this point.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
