Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why ack interrupt before calling handler?
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: Kent Borg <kentborg@borg.org>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030606142939.B15725@borg.org>
References: <20030606142939.B15725@borg.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 11 Jun 2003 12:33:42 +0200
Message-Id: <1055327622.26152.70.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-06-06 at 20:29, Kent Borg wrote:
>
> I am confused by something in ppc_irq_dispatch_handler().  It looks to
> me that the interrupt is ack-ed before the handler is called.  Maybe I
> am misunderstanding, but doesn't the ack only reset the interrupt
> controller?  If so, the interrupting hardware could still be
> presenting a level-triggered interrupt.  Wouldn't it make more sense
> to let the interrupt routine get service the hardware first, then
> reset the interrupt controller?
>

I don't know what code you are looking at but generally you want to
first ack to avoid the race condition that would otherwise be present if
you first run your interrupt routine then ack. How would you know that
it was in fact not a new interrupt condition that you have not taken
care of you just removed.

ps. and never ever use edge triggered interrupts

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
