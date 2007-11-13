Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 6F307DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 07:49:36 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: (beginner) Kernel fail during local_irq_enable()
Date: Tue, 13 Nov 2007 12:46:14 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73C9F@corpexc01.corp.networkrobots.com>
References: <mailman.2590.1194951904.3099.linuxppc-embedded@ozlabs.org> 
From: "Siva Prasad" <sprasad@bivio.net>
To: <fabien.fb@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,=20

Some thing similar happened for me before. After I set the IRQ enable
bits, it resulted in an exception. After analyzing the exception and
SRR1 bits set, I was able to take care of it.

Other reason can be...
Immediately after you enable interrupts, any interrupt (which are
already enabled) can cause the system to take a different path of
servicing those interrupts. If some thing happens in that service
routine, you are in for a surprise.

If you have a JTAG emulator, after system hangs, just halt it and see
where it is executing. That may give a clue of what might have happened.
Or, you can look at the stack, based on the register contents, to see
the call back (difficult, but possible).

Good Luck.

- Siva


------------------------------

Date: Tue, 13 Nov 2007 12:04:59 +0100
From: fabien <fabien.fb@gmail.com>
Subject: (beginner) Kernel fail during local_irq_enable()
To: linuxppc-embedded@ozlabs.org

I work on a custom board based on MPC8xx.

The bootloader on it is a ppcboot 1.1.5. I'm a beginner with Linux port

and ppc.
 I'm trying to pass the board working with a 2.4.4 kernel to a 2.6.19
kernel

from denx.
 The kernel hang when trying to enable interrupt in local_irq_enable()

in init/main.c.
 Nothing happened after. Look at the printk log dumped from __log_buf
adresse with md ppcboot command.
