Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E19B8A9.4F1F82E0@imc-berlin.de>
Date: Mon, 06 Jan 2003 18:11:05 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: request_irq, MPX8xx, IDE, PCMCIA, ...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

last year ide-cs was working on MPC8xx platforms.

It was necessary to define

	define ide_request_irq(irq,hand,flg,dev,id)
request_8xxirq((irq),(hand),(flg),(dev),(id))

in the board specific header file.

I just relalised that on December 16 code in ide-probe was changed!!!

-               if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name,
hwgroup)) {
+               if (request_irq(hwif->irq,&ide_intr,sa,hwif->name,hwgroup)) {

Now it crashes with a "Kernel panic: request_irq".

What is the status of the request_8xxirq() vs request_irq() stuff?

BTW: Is the patch changing IN_BYTE() to hwif->INB() etc. working on MPC8xx
platforms?

Thanks a million,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
