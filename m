Return-Path: <hughd@google.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BBB3B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2012 01:58:14 +1000 (EST)
Received: by dajt11 with SMTP id t11so1598452daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 May 2012 08:58:12 -0700 (PDT)
Date: Mon, 7 May 2012 08:57:51 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: linux-next oops in windfarm startup
Message-ID: <alpine.LSU.2.00.1205070851020.1416@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

3.4.0-rc5-next-20120504 and 3.4.0-rc6-next-20120507
crash while booting the PowerMac G5: I have to revert
your commit e326b30fda9985a2e7fda6fb9212b86bf025c39
powerpc/pmac: Convert windfarm_smu_sat to new i2c probing
to get a working system.

Actual oops message scrolled off screen, and I didn't note the registers.
NIP [c000000000376964] of_get_next_child+0x68/0x70
LR [c000000000376928] of_get_next_child+0x2c/0x70
Call Trace:
of_get_next_child
wf_sat_probe
i2c_device_probe
driver_probe_device
bus_for_each_drv
device_attach
i2c_new_device
i2c_powermac_probe
platform_drv_probe
driver_probe_device
__driver_attach
bus_for_each_dev
driver_attach
bus_add_driver
driver_register
platform_driver_register
i2c_powermac_driver_init
do_one_initcall
kernel_init
kernel_thread
Instruction dump:
ebff0040 e87e8008 480b86e9 60000000 38210090 7fe3fb78 e8010010 eba1ffe8
ebc1fff0 ebe1fff8 7c0803a6 4e800020 <ebfd0038> 4bffffd0 7c0802a6 fbe1fff8

Hugh
