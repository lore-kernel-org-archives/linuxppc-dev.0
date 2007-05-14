Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97833DDED9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 May 2007 15:03:03 +1000 (EST)
From: "Lorenz Kolb" <linuxppcemb@lkmail.de>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: [Fwd: [alsa-devel] embedded sound architecture question]
Date: Mon, 14 May 2007 07:02:15 +0200
Message-ID: <000101c795e5$0af92ce0$9602a8c0@lorenzulm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi leonid,

To be precise, I am the guy in question, who has to do the hardware-part and
You guessed it: The board is an ML403.
So what are the problems:
- DMA (whenever an DMA transfer is issued the CPU is put to soem sort of
"freeze", as the bus is occupied, whenever the CPU writes to memory it is
also busy: that solution is not really good, occupying the CPU some sort of
twice)
+ possible solution: some sort of multiport memory controller (or our idea:
own memory directly attached to the ac'97 controller) using BRAM.

> If I were you, I would chose one of sound cards which have ALSA
> drivers implemented (the list can be found on ALSA site) and
> mimicked their behavior in your VHDL.

Actually a bunch of theses drivers rely on PCI or ISA.
The few left do all require DMA, what is only an option, if it is some sort
of faked DMA, so the CPU writes directly into the controller's memory as we
intend to stay as independent as possible from Xilinx' IP Cores.
The question was: is that a good (and practicable) idea?

Greetings,

Lorenz Kolb
