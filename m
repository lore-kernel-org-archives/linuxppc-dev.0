Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5092FB6F9F
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2012 04:00:09 +1100 (EST)
Received: from [195.242.97.150] (qore.networks.above.net [195.242.97.150] (may
 be forged)) (authenticated bits=0)
 by mika.eatserver.nl (8.13.8/8.13.8) with ESMTP id q04GJ49U009483
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Jan 2012 17:19:05 +0100
Received: from localhost (localhost.localhost [127.0.0.1])
 by router38.aimvalley.nl (Postfix) with ESMTP id E13F2818203
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jan 2012 17:19:04 +0100 (CET)
Received: from mail3.aimsys.nl (mail.aimsys.nl [10.10.0.114])
 by router38.aimvalley.nl (Postfix) with ESMTP id 4A1DA818202
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Jan 2012 17:19:04 +0100 (CET)
Message-ID: <4F047BF8.7090400@aimvalley.nl>
Date: Wed, 04 Jan 2012 17:19:04 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Cannot wake-up from standby with MPC8313
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


after entering:

echo standby > /sys/power/state

I'm unable to wake up the MPC8313 (on our custom designed
MPC8313 board).

I need it to wake up through GPIO IRQ.
I cause multiple GPIO interrupts (all properly handled by an isr),
but the MPC8313 does not wake up.

How should one wake up via GPGIO IRQ ?

I'm using v2.6.29 and I wonder whether this is related to
our custom 8313 board and/or v2.6.29 and/or missing kernel
patches or maybe this never worked ?

Also, I do not understand line 220 of arch/powerpc/platforms/83xx/suspend.c

219         } else {
220                 out_be32(&pmc_regs->mask, PMCER_PMCI);
221
222                 mpc6xx_enter_standby();

How can wake up ever work if TSEC/GPIO/TIMER/etc.. wake up events
are disabled ?

changing this into "out_be32(&pmc_regs->mask, PMCER_PMCI|PMCER_GPIO);"
gives same result.

MPC8313 is in PCI HOST mode and here's a relevant part
of the DTS:

         pmc: power@b00 {
             compatible = "fsl,mpc8313-pmc", "fsl,mpc8349-pmc";
             reg = <0xb00 0x100 0xa00 0x100>;
             interrupts = <80 8>;
             interrupt-parent = <&ipic>;
             fsl,mpc8313-wakeup-timer = <&gtm1>;

             /* Remove this (or change to "okay") if you have
              * a REVA3 or later board, if you apply one of the
              * workarounds listed in section 8.5 of the board
              * manual, o if you are adapting this device treeSE=
              * to a different board.
              */
             status = "okay";
         };

         gtm1: timer@500 {
             compatible = "fsl,mpc8313-gtm", "fsl,gtm";
             reg = <0x500 0x100>;
             interrupts = <90 8 78 8 84 8 72 8>;
             interrupt-parent = <&ipic>;
         };


Any help/advice/answer is more than welcome.

---
NvBolhuis
