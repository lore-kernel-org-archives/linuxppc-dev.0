Message-ID: <3E4361C2.8010007@imc-berlin.de>
Date: Fri, 07 Feb 2003 08:35:30 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: was: FEC on MPC860T & race condition
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com> <3E3A3EE9.7000608@imc-berlin.de> <20030203210959.GA7857@ip68-0-152-218.tc.ph.cox.net> <3E3F7C29.8030807@imc-berlin.de> <20030204160401.GA30936@ip68-0-152-218.tc.ph.cox.net> <3E3FE6D0.1010600@imc-berlin.de> <20030204193224.GB3522@ip68-0-152-218.tc.ph.cox.net> <3E401AC9.9090703@embeddededge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek schrieb:
> Tom Rini wrote:
>
>> I believe this is wrong, in that trying to udelay() here is a bad idea.
>
>
> I agree.  All of the MII communcation is interrupt driven.  This is easy
> and the way everything should work on the 8xx.  The link interrupt is
> more challenging because the interrupt from that depends upon the phy
> type and the board design.  The link interrupts are either real interrupts
> or managed with a timed thread.
>
> If you need to wait before installing the link interrupt (which I still
> don't understand why), this should be done as part of the phy discovery
> interrupt.  For example, add an indirect function pointer and if it isn't
> NULL, call it at that time to do anything that must wait until the phy
> is discovered and initialized.

I understand what you mean. And certanly you're right.
I moved the request_irq into 3 but my board still hanges from time to time. At a
different place in a different way though.

I have to admit that I don't understand this mii_queue stuff.
Please, Dan, would you please give me a small hint!
I assume by "add an indirect function pointer" you mean "add something to
mii_queue"... Is that right?

Thanks!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
