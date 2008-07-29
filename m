Return-Path: <temerkhanov@yandex.ru>
Received: from webmail22.yandex.ru (webmail22.yandex.ru [213.180.223.146])
	by ozlabs.org (Postfix) with ESMTP id F178DDDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 22:36:32 +1000 (EST)
Received: from YAMAIL (webmail22) by mail.yandex.ru id S4473784AbYG2L6Q for
	<linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 15:58:16 +0400
From: Sergey Temerkhanov <temerkhanov@yandex.ru>
To: linuxppc-dev@ozlabs.org
Subject: Level IRQ handling on Xilinx INTC with ARCH=powerpc
MIME-Version: 1.0
Message-Id: <360961217332693@webmail22.yandex.ru>
Date: Tue, 29 Jul 2008 15:58:13 +0400
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, all!

I'm currently in process of development of Xilinx I2C IP core driver and I've run into the problem: the ISR for level-based IRQ is called twice.

It looks like level IRQ handling on Xilinx INTC with ARCH=powerpc is currently broken as Xilinx INTC requires IRQ acknowledge with IRQ signal deasserted (i.e. after ISR call). ISR is supposed to acknowledge level IRQ in the core which asserted it thus deasserting appropriate IRQ signal.
And handle_level_irq() which is currently used as high-level IRQ handler for Xilinx INTC only tries to acknowledge IRQ before ISR call. So that the IRQ remains asserted in INTC and after the call to desc->chip->unmask() causes spurious attempt to process the same IRQ again. However, call to desc->chip->ack() this time finishes the required procedure of IRQ acknowledge.

I see a few ways to resolve this:
1. Change high-level handler to __do_IRQ() (as for ARCH=ppc) with proper methods modification (which is deprecated).
2. Change handle_level_irq() so that it calls desc->chip->ack() or desc->chip->end() (and set chip->end to point to xilinx_intc_ack() for Xilinx INTC) before desc->chip->unmask() (may potentially cause breakage for other arches. But I've tried it and it works).
3. Acknowledge IRQ at INTC in ISR (quick'n'dirty hack).

Regards, Sergey Temerkhanov
