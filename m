Return-Path: <leon.woestenberg@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id AE6FBDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 07:33:38 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so790340hsz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 14:33:37 -0700 (PDT)
Message-ID: <c384c5ea0809291433j10619a49xe713415f6bb90204@mail.gmail.com>
Date: Mon, 29 Sep 2008 23:33:37 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: How to prevent embedded ppc reset deadlock? (MPC83xx/85xx)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

not Linux related per se*, but I wonder how your board designs deal
with the reset circuitry for embedded PowerPC processors (MPC8313E in
my case).
My requirement is that both a processor-external hard reset and
processor-internal hard reset must both reset the boot device NOR
FlashROM, so that it does not remain in write mode (if it is).

Given those processor pins:

PORESET# (input pin to the processor, power on reset)
HRESET# (bidirectional pin on the processor, asserted by processor on
hard reset such as watchdog)

I see many designs (even the Freescale reference designs) where the
HRESET# resets some of the board, but not the FlashROM, and where
PORESET# resets the FlashROM. This can cause a deadlock in the case
where the watchdog resets during writing to FlashROM, as the FlashROM
is not reset and remains in write mode, not allowing the processor to
boot from it.

I am thinking of using this approach: PORESET# -> processor <-->
HRESET# -> board reset.

Would that work? or why not?

Regards,
-- 
Leon

* to make this Linux related: suppose MTD is writing new firmware to
your NOR FlashROM and then /dev/wdg is not petted due to some
programmer bug in the firmware update code.
