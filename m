Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C4AE1A050C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 22:49:53 +1100 (AEDT)
Received: by mail-lb0-f179.google.com with SMTP id z11so2273446lbi.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 03:49:49 -0800 (PST)
Message-ID: <5475BE5A.4090503@linux.com>
Date: Wed, 26 Nov 2014 14:49:46 +0300
From: Alexander Popov <alex.popov@linux.com>
Reply-To: alex.popov@linux.com
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Disabled LocalPlus Controller (LPC) clock on MPC512x
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

My Freescale TWR-MPC5125 board instantly reboots if I touch
any physical address on the LocalPlus Bus (LPB) for the first time
when Linux has already booted.

This effect is reproduced by using /dev/mem or loading a kernel module
which works with any peripherals on LPB.

It took me some time to find out that such crash is caused by
clk_disable_unused() in drivers/clk/clk.c, which disables
LocalPlus Controller (LPC) clock if I don't touch LPB addresses in the
previous initcalls. So starting Linux with clk_ignore_unused bootparam
or inserting dummy LPB reading to some initcall is a temporary fix.

Is it correct to gate LPC clock? If yes, how to avoid the mentioned
crashes properly?

There's a piece of code in arch/powerpc/platforms/512x/clock-commonclk.c
which is doubtful for me:

/*
  * pre-enable those "internal" clock items which never get
  * claimed by any peripheral driver, to not have the clock
  * subsystem disable them late at startup
  */
clk_prepare_enable(clks[MPC512x_CLK_DUMMY]);
clk_prepare_enable(clks[MPC512x_CLK_E300]);    /* PowerPC CPU */
clk_prepare_enable(clks[MPC512x_CLK_DDR]);    /* DRAM */
clk_prepare_enable(clks[MPC512x_CLK_MEM]);    /* SRAM */
clk_prepare_enable(clks[MPC512x_CLK_IPS]);    /* SoC periph */
clk_prepare_enable(clks[MPC512x_CLK_LPC]);    /* boot media */

Does it mean that these clocks should be registered with
CLK_IGNORE_UNUSED flag?

Thanks a lot.
Best regards,
Alexander
