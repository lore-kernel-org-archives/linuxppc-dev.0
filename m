Message-ID: <3D871678.9070309@uab.ericsson.se>
Date: Tue, 17 Sep 2002 13:48:08 +0200
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: mlocke@mvista.com,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx PCMCIA: request_irq vs. request_8xxirq ?
References: <3D86E622.4FE462B0@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I ran into the same problem trying to bring up a flashdisk with an IDE
interface connected to the 8260 localbus on our custom board.

init_irq in ide-probe.c calls ide_request_irq which is defined in
asm-ppc/ide.h as request_irq which calls panic.

I changed the request_irq routine in m8260_setup.c to call
request_8xxirq. Doing so I got the disk to work.

But what's the real solution?

Cheers,
Hans

On 09/17/02 10:21 AM, Steven Scholz wrote:

> Otherwise I get a kernel panic when a module (let's say  3c589_cs.o) tries to
> request an IRQ since the wrong request_irq() gets called!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
