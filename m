Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A5821A180A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:19 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
Date: Wed,  1 Oct 2014 15:27:46 +0200
Message-Id: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic Linux framework to power off the machine is a function pointer
called pm_power_off. The trick about this pointer is that device drivers can
potentially implement it rather than board files.

Today on PowerPC we set pm_power_off to invoke our generic full machine power
off logic which then calls ppc_md.power_off to invoke machine specific power
off.

However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
this card house falls apart. That driver only registers itself if pm_power_off
is NULL to ensure it doesn't override board specific logic. However, since we
always set pm_power_off to the generic power off logic (which will just not
power off the machine if no ppc_md.power_off call is implemented), we can't
implement power off via the generic GPIO power off driver.

To fix this up, let's get rid of the ppc_md.power_off logic and just always use
pm_power_off as was intended. Then individual drivers such as the GPIO power off
driver can implement power off logic via that function pointer.

With this patch set applied and a few patches on top of QEMU that implement a
power off GPIO on the virt e500 machine, I can successfully turn off my virtual
machine after halt.


Alex

Alexander Graf (20):
  powerpc: Support override of pm_power_off
  powerpc/xmon: Support either ppc_md.power_off or pm_power_off
  powerpc/47x: Use pm_power_off rather than ppc_md.power_off
  powerpc/52xx/efika: Use pm_power_off rather than ppc_md.power_off
  powerpc/mpc8349emitx: Use pm_power_off rather than ppc_md.power_off
  powerpc/corenet: Use pm_power_off rather than ppc_md.power_off
  powerpc/85xx/sgy_cts1000: Use pm_power_off rather than
    ppc_md.power_off
  powerpc/celleb: Use pm_power_off rather than ppc_md.power_off
  powerpc/cell/qpace: Use pm_power_off rather than ppc_md.power_off
  powerpc/cell: Use pm_power_off rather than ppc_md.power_off
  powerpc/chrp: Use pm_power_off rather than ppc_md.power_off
  powerpc/6xx/gamecube: Use pm_power_off rather than ppc_md.power_off
  powerpc/6xx/linkstation: Use pm_power_off rather than ppc_md.power_off
  powerpc/6xx/wii: Use pm_power_off rather than ppc_md.power_off
  powerpc/maple: Use pm_power_off rather than ppc_md.power_off
  powerpc/powermac: Use pm_power_off rather than ppc_md.power_off
  powerpc/powernv: Use pm_power_off rather than ppc_md.power_off
  powerpc/ps3: Use pm_power_off rather than ppc_md.power_off
  powerpc/pseries: Use pm_power_off rather than ppc_md.power_off
  powerpc: Remove ppc_md.power_off

 arch/powerpc/include/asm/machdep.h               |   1 -
 arch/powerpc/kernel/setup-common.c               |   6 +-
 arch/powerpc/platforms/44x/ppc476.c              |   2 +-
 arch/powerpc/platforms/52xx/efika.c              |   3 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c   |   8 +-
 arch/powerpc/platforms/85xx/corenet_generic.c    |   2 +-
 arch/powerpc/platforms/85xx/sgy_cts1000.c        |   4 +-
 arch/powerpc/platforms/cell/celleb_setup.c       |   4 +-
 arch/powerpc/platforms/cell/qpace_setup.c        |   3 +-
 arch/powerpc/platforms/cell/setup.c              |   2 +-
 arch/powerpc/platforms/chrp/setup.c              |   3 +-
 arch/powerpc/platforms/embedded6xx/gamecube.c    |   3 +-
 arch/powerpc/platforms/embedded6xx/linkstation.c |   3 +-
 arch/powerpc/platforms/embedded6xx/wii.c         |   3 +-
 arch/powerpc/platforms/maple/setup.c             |   4 +-
 arch/powerpc/platforms/powermac/setup.c          | 147 ++++++++++++-----------
 arch/powerpc/platforms/powernv/setup.c           |   4 +-
 arch/powerpc/platforms/ps3/setup.c               |   3 +-
 arch/powerpc/platforms/pseries/setup.c           |  59 ++++-----
 arch/powerpc/sysdev/fsl_soc.c                    |   2 +-
 arch/powerpc/xmon/xmon.c                         |   3 +-
 21 files changed, 139 insertions(+), 130 deletions(-)

-- 
1.8.1.4
