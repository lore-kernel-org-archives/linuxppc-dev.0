Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18130.4987.328561.254876@cargo.ozlabs.ibm.com>
Date: Mon, 27 Aug 2007 09:57:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

There are 4 bug fixes for Cell and a cell_defconfig update from Arnd,
and a bug fix each from Olof Johansson, Olaf Hering and myself.

Thanks,
Paul.

 arch/powerpc/configs/cell_defconfig       |  220 ++++++++++-------------------
 arch/powerpc/mm/slb.c                     |   36 ++++-
 arch/powerpc/platforms/cell/cbe_regs.h    |    8 +
 arch/powerpc/platforms/cell/cbe_thermal.c |    6 -
 arch/powerpc/platforms/cell/pervasive.c   |   26 +++
 arch/powerpc/platforms/cell/spu_manage.c  |    2 
 arch/powerpc/platforms/pasemi/iommu.c     |    6 -
 arch/powerpc/sysdev/axonram.c             |   46 +-----
 drivers/macintosh/adb.c                   |    4 -
 drivers/macintosh/via-pmu.c               |   34 ++--
 include/linux/pmu.h                       |    2 
 11 files changed, 172 insertions(+), 218 deletions(-)

commit 175587cca7447daf5a13e4a53d32360ed8cba804
Author: Paul Mackerras <paulus@samba.org>
Date:   Sat Aug 25 13:14:28 2007 +1000

    [POWERPC] Fix SLB initialization at boot time
    
    This partially reverts edd0622bd2e8f755c960827e15aa6908c3c5aa94.
    
    It turns out that the part of that commit that aimed to ensure that we
    created an SLB entry for the kernel stack on secondary CPUs when
    starting the CPU didn't achieve its aim, and in fact caused a
    regression, because get_paca()->kstack is not initialized at the point
    where slb_initialize is called.
    
    This therefore just reverts that part of that commit, while keeping
    the change to slb_flush_and_rebolt, which is correct and necessary.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e120e8d03a263cf75f2abc0f8b3a03a65cfd3b88
Author: Olaf Hering <olaf@aepfle.de>
Date:   Sat Aug 25 05:42:01 2007 +1000

    [POWERPC] Fix undefined reference to device_power_up/resume
    
    Current Linus tree fails to link on pmac32:
    
    drivers/built-in.o: In function `pmac_wakeup_devices':
    via-pmu.c:(.text+0x5bab4): undefined reference to `device_power_up'
    via-pmu.c:(.text+0x5bb08): undefined reference to `device_resume'
    drivers/built-in.o: In function `pmac_suspend_devices':
    via-pmu.c:(.text+0x5c260): undefined reference to `device_power_down'
    via-pmu.c:(.text+0x5c27c): undefined reference to `device_resume'
    make[1]: *** [.tmp_vmlinux1] Error 1
    
    changing CONFIG_PM > CONFIG_PM_SLEEP leads to:
    
    drivers/built-in.o: In function `pmu_led_set':
    via-pmu-led.c:(.text+0x5cdca): undefined reference to `pmu_sys_suspended'
    via-pmu-led.c:(.text+0x5cdce): undefined reference to `pmu_sys_suspended'
    drivers/built-in.o: In function `pmu_req_done':
    via-pmu-led.c:(.text+0x5ce3e): undefined reference to `pmu_sys_suspended'
    via-pmu-led.c:(.text+0x5ce42): undefined reference to `pmu_sys_suspended'
    drivers/built-in.o: In function `adb_init':
    (.init.text+0x4c5c): undefined reference to `pmu_register_sleep_notifier'
    make[1]: *** [.tmp_vmlinux1] Error 1
    
    So change even more places from PM to PM_SLEEP to allow linking.
    
    Signed-off-by: Olaf Hering <olaf@aepfle.de>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b22ddc703c5daa603d8d53881b530da3cab94cd4
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Thu Aug 23 03:09:17 2007 +1000

    [POWERPC] cell: Update cell_defconfig for 2.6.23
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b0e81ebb1062eba20fbcbe459662c0a6ec6075f7
Author: Maxim Shchetynin <maxim@de.ibm.com>
Date:   Thu Aug 23 03:01:28 2007 +1000

    [POWERPC] axonram: Do not delete gendisks queue in error path
    
    On exit do not delete gendisk's queue because this is already done by
    del_gendisk(). Doing it twice may cause memory damage.
    
    Signed-off-by: Maximilian <maxim@de.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fedcd2c53d838e7a69df699ce2a14e45d34d7f7f
Author: Maxim Shchetynin <maxim@de.ibm.com>
Date:   Thu Aug 23 03:01:27 2007 +1000

    [POWERPC] axonram: Module modification for latest firmware API changes
    
    Firmware would not deliver two interrupt numbers in device-tree any more
    but only one, for correctable ECC, because uncorrectable ECC from now
    is handled by firmware itself.
    Changes in the axonram module are necessary because in the old version, if
    it is not allowed to fetch the second interrupt number from device-tree,
    it interpretes this as an error case and exits.
    
    Signed-off-by: Maximilian <maxim@de.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 3addf55c9415f9da039947b33d064332137e49fe
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Aug 23 03:01:26 2007 +1000

    [POWERPC] cell: Support pinhole-reset on IBM cell blades
    
    The Cell Broadband Engine has a method of injecting a
    system-reset-exception from an external source into the
    operating system, which should trigger the regular behaviour
    of entering xmon or kdump.
    
    Unfortunately, the exception handler cannot distinguish it from
    other interrupt causes by the SRR1 register, which gets used
    for this on Power 6 and others.
    
    IBM Blade servers that want to support triggering the
    system reset exception using a pinhole button in the front
    panel therefore use an extra register to determine the
    reset cause.
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    
    --
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fa7f374bbf6d8e5fc7dd281a62498041066aaf43
Author: Christian Krafft <krafft@de.ibm.com>
Date:   Thu Aug 23 03:01:25 2007 +1000

    [POWERPC] spu_manage: Use newer physical-id attribute
    
    Legacy device tree used the reg property for the physical id of an
    spe.  On newer device tree layouts the reg property contains the
    "correct" value in the reg attribute.  So there has been intoduced the
    "physical-id" on newer devicetree layouts.  The id is stored by
    spu_manage into the spu struct as spe_id.  cbe_thermal has been
    changed to use the spu->spe_id.  There's no need for the thermal code
    to check devicetree attributes for itself.
    
    Signed-off-by: Christian Krafft <krafft@de.ibm.com>
    Cc: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit dfa70f81a05fa857fb1428ac2a88da84ecd50dd9
Author: Olof Johansson <olof@lixom.net>
Date:   Fri Aug 17 13:57:39 2007 +1000

    [POWERPC] pasemi: Another IOMMU bugfix for 64K PAGE_SIZE
    
    More fallout from the switch from PAGE_SIZE based IOMMU to the native page
    size for the driver. By pure luck it happened to work most of the time, since
    we end up invalidating the wrong entries in the TLB.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
