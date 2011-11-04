Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E8601B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2011 04:36:07 +1100 (EST)
Message-ID: <4EB4229C.1050403@embedded-sol.com>
Date: Fri, 04 Nov 2011 19:36:28 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: chenhui.zhao@freescale.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/7] powerpc/85xx: add sleep and deep sleep support
References: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1320410014-14453-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/html; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    Hi Zhao,<br>
    <blockquote cite="mid:4EB41B95.2080508@embedded-sol.com" type="cite">
      <pre>From: Li Yang &lt;<a moz-do-not-send="true" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">leoli at freescale.com</a>&gt;

Some Freescale chips like MPC8536 and P1022 has deep sleep PM mode
in addtion to the sleep PM mode.

In sleep PM mode, the clocks of e500 core and unused IP blocks is
turned off. IP blocks which are allowed to wake up the processor
are still running

While in deep sleep PM mode, additionally, the power supply is
removed from e500 core and most IP blocks. Only the blocks needed
to wake up the chip out of deep sleep are ON.

This patch supports 32-bit and 36-bit address space.

The deep sleep mode is equal to the Suspend-to-RAM state of Linux
Power Management.

Command to enter deep sleep mode.
  echo mem &gt; /sys/power/state

</pre>
    </blockquote>
    <br>
    Thanks a lot for bringing this code to mainline. I was recently
    involved in enabling<br>
    deep sleep on a custom P1022 board, and would like to make some
    remarks based<br>
    on this experience.<br>
    <br>
    1. I think 85xx deep sleep code would be more complete if you also
    port FSL<br>
    &nbsp;&nbsp;&nbsp; BSP code that saves eLBC configuration before entering deep
    sleep and <br>
    &nbsp;&nbsp;&nbsp; restores it afterwards. Otherwise all eLBC customization done by
    u-boot is lost.<br>
    <br>
    2. You should implement fsl_deep_sleep() routine for 85xx. The
    default implementation<br>
    &nbsp;&nbsp;&nbsp; in include/linux/fsl_devices.h always returns 0. The routine is
    used by FSL USB host <br>
    &nbsp;&nbsp;&nbsp; driver, drivers/usb/host/ehci-fsl.c to restore USB hardware
    state after deep sleep. <br>
    &nbsp;&nbsp;&nbsp; With default implementation USB is dead on 85xx after deep sleep
    if USB PHY is <br>
    &nbsp;&nbsp;&nbsp; powered down completely.<br>
    <br>
    Felix.<br>
  </body>
</html>
