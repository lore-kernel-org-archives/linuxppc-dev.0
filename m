Date: Tue, 21 Sep 1999 20:13:10 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Compiling 2.3.18
In-reply-to: <37E5B2EA.9C266862@netx4.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9909211959400.1386-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




I am now able to run make dep using different board type (I have not
tested them all, and I do not know which type will be the closer
to my target; is there a description somewhere?).

Compiling (make zImage) fails :-(

It stops when doing sched.c with an error basically saying that
NR_8259_INTS is undefined.

I dig into the problem and found that the chain of defines/includes
is sched.c -> kernel_stat.h -> irq.h -> mpc8xx.h -> board_specific.h

kernel_stat uses NR_IRQS
irq.h defines NR_IRQS using NR_8259_INTS
board_specific.h defines NR_8259_INTS

the problem is that irq.h includes mpc8xx.h AFTER it uses NR_8259_INTS

Is it ok to move the mpc8xx.h inclusion statement earlier in the
irq.h file? Is there a reason for it to be late in the file?

Claude 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
