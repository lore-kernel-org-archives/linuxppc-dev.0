Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E80B6DE4F7
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 06:40:09 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/5] powerpc: remove mpc8xx-ide driver
Date: Thu, 12 Jun 2008 22:38:43 +0200
References: <20080610142702.354823071@arndb.de>
	<200806102101.20156.bzolnier@gmail.com>
	<325FF1AB-AFFA-45EE-9796-25D5004F27BB@kernel.crashing.org>
In-Reply-To: <325FF1AB-AFFA-45EE-9796-25D5004F27BB@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806122238.43946.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 12 June 2008, Kumar Gala wrote:
> 
> On Jun 10, 2008, at 2:01 PM, Bartlomiej Zolnierkiewicz wrote:
> > Thanks, applied.
> >
> Acked-by: Kumar Gala <galak@kernel.crashing.org>

Ok, I've updated my git tree again, to remove this one and
the commproc.h changes that have gone into the m68k-nommu
tree.

The patches remain now, and are still available for powerpc-next at

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git ppc-removal-more

	Arnd <><

---
commit 2c2732c402532e6be26d58f38abd39f56070d569
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jun 10 15:55:40 2008 +0200

    powerpc/mtd: remove dead platform specific maps

    It is no longer possible to select compilation of these
    drivers with arch/powerpc, so the code should be removed.

    New platforms should use physmap_of.

    Cc: linux-mtd@lists.infradead.org
    Cc: David Woodhouse <dwmw2@infradead.org>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 drivers/mtd/maps/Kconfig            |   57 --------
 drivers/mtd/maps/Makefile           |    6 -
 drivers/mtd/maps/mbx860.c           |  100 -------------
 drivers/mtd/maps/ocotea.c           |  154 ---------------------
 drivers/mtd/maps/redwood.c          |  176 -----------------------
 drivers/mtd/maps/rpxlite.c          |   66 ---------
 drivers/mtd/maps/tqm8xxl.c          |  261 -----------------------------------
 drivers/mtd/maps/wr_sbc82xx_flash.c |  180 ------------------------
 8 files changed, 0 insertions(+), 1000 deletions(-)

commit 41f911f000f3935ba85adb571cb9eb54ee9bed68
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jun 10 15:45:11 2008 +0200

    powerpc: remove references to dead platforms

    The SPRUCE, LOPEC, SANDPOINT, PPC_GEN550 and PPLUS Kconfig
    symbols were only defined for platforms in arch/ppc that are
    no longer there with arch/powerpc. All compile time
    switches based on these symbols can now be removed.

    Cc: linux-input@vger.kernel.org
    Cc: linux-m68k@lists.linux-m68k.org
    Cc: linux-pcmcia@lists.infradead.org
    Cc: Vitaly Bordug <vitb@kernel.crashing.org>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 arch/powerpc/Kconfig              |    4 -
 arch/powerpc/Kconfig.debug        |    2 +-
 drivers/ide/pci/sl82c105.c        |    4 -
 drivers/input/serio/i8042-ppcio.h |   75 --------------------
 drivers/net/Kconfig               |    3 +-
 drivers/net/fec.c                 |   35 +---------
 drivers/net/smc91x.h              |   37 +----------
 drivers/pcmcia/m8xx_pcmcia.c      |  136 -------------------------------------
 include/asm-powerpc/ide.h         |   12 ---
 9 files changed, 4 insertions(+), 304 deletions(-)

commit d790ca4b21f14ee1943d9193808f3b8a980b650e
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jun 10 15:32:56 2008 +0200

    powerpc: remove hdpu drivers

    The CONFIG_HDPU option is gone with the removal of arch/ppc,
    so the drivers have become dead code that can be removed.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 drivers/misc/Makefile                 |    1 -
 drivers/misc/hdpuftrs/Makefile        |    1 -
 drivers/misc/hdpuftrs/hdpu_cpustate.c |  249 ---------------------------------
 drivers/misc/hdpuftrs/hdpu_nexus.c    |  150 --------------------
 4 files changed, 0 insertions(+), 401 deletions(-)
