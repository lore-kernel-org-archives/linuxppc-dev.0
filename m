Return-Path: <sithglan@stud.informatik.uni-erlangen.de>
Received: from faui03.informatik.uni-erlangen.de
	(faui03.informatik.uni-erlangen.de [131.188.30.103])
	by ozlabs.org (Postfix) with ESMTP id 69F66DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Jun 2007 22:33:06 +1000 (EST)
Date: Thu, 21 Jun 2007 14:33:03 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linuxppc-embedded@ozlabs.org
Subject: start_kernel does not get called on Virtex 4 FX 12 ppc 405
Message-ID: <20070621123303.GD27854@cip.informatik.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
I still have the problem that embedded kernel boot loader "load_kernel"
is working but "start_kernel" is never reached AFAIT.  The last message
that I see is: "Now booting the kernel".

So I turned some LEDs on the Development board off in "load_kernel" and
tried to turn them back on in "start_kernel" I would like to know if
that still works. Or is not possible because the IO addresses are not
mapped via the MMU at the time. When I try to turn them back on in
"start_kernel"?

I used the following code:

*(volatile unsigned int *) (0x40000000 + 4) = 0x0;
__asm__ volatile ("eieio");
*(volatile unsigned int *) (0x40000000 + 0) = 0x0;
__asm__ volatile ("eieio");

First memory mapped io is direction register and the second call turns the leds
on/off. It works in the "load_kernel" routine.

        Thomas
