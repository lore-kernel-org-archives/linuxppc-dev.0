Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18134.44726.426680.221570@cargo.ozlabs.ibm.com>
Date: Thu, 30 Aug 2007 21:49:10 +1000
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

There are a couple more bug fixes for Cell plus one from Kumar, and
defconfig updates.

Paul.

 arch/powerpc/configs/celleb_defconfig           |  196 +----
 arch/powerpc/configs/chrp32_defconfig           |  220 ++----
 arch/powerpc/configs/ebony_defconfig            |  190 +----
 arch/powerpc/configs/g5_defconfig               |  208 ++---
 arch/powerpc/configs/holly_defconfig            |  203 ++---
 arch/powerpc/configs/iseries_defconfig          |  210 +----
 arch/powerpc/configs/linkstation_defconfig      |  219 ++----
 arch/powerpc/configs/lite5200_defconfig         |  191 +----
 arch/powerpc/configs/maple_defconfig            |  189 +----
 arch/powerpc/configs/mpc7448_hpc2_defconfig     |  202 +----
 arch/powerpc/configs/mpc8272_ads_defconfig      |  193 ++---
 arch/powerpc/configs/mpc8313_rdb_defconfig      |  224 ++----
 arch/powerpc/configs/mpc832x_mds_defconfig      |  209 ++---
 arch/powerpc/configs/mpc832x_rdb_defconfig      |  211 ++----
 arch/powerpc/configs/mpc834x_itx_defconfig      |  206 ++---
 arch/powerpc/configs/mpc834x_itxgp_defconfig    |  203 ++---
 arch/powerpc/configs/mpc834x_mds_defconfig      |  205 ++---
 arch/powerpc/configs/mpc836x_mds_defconfig      |  209 ++---
 arch/powerpc/configs/mpc8540_ads_defconfig      |  183 +----
 arch/powerpc/configs/mpc8544_ds_defconfig       |  459 +++++++++++-
 arch/powerpc/configs/mpc8560_ads_defconfig      |  196 +----
 arch/powerpc/configs/mpc8568mds_defconfig       |   43 -
 arch/powerpc/configs/mpc85xx_cds_defconfig      |  198 ++---
 arch/powerpc/configs/mpc8641_hpcn_defconfig     |  880 ++++++++++++++++++-----
 arch/powerpc/configs/mpc866_ads_defconfig       |  174 +----
 arch/powerpc/configs/mpc885_ads_defconfig       |  174 +----
 arch/powerpc/configs/pasemi_defconfig           |  225 ++----
 arch/powerpc/configs/pmac32_defconfig           |  237 ++----
 arch/powerpc/configs/ppc64_defconfig            |  220 ++----
 arch/powerpc/configs/prpmc2800_defconfig        |  213 ++----
 arch/powerpc/configs/pseries_defconfig          |  205 ++---
 arch/powerpc/kernel/process.c                   |    6 
 arch/powerpc/platforms/cell/spu_manage.c        |    8 
 arch/powerpc/platforms/cell/spufs/backing_ops.c |    3 
 arch/powerpc/platforms/cell/spufs/run.c         |    6 
 arch/powerpc/platforms/ps3/setup.c              |    3 
 36 files changed, 2846 insertions(+), 4275 deletions(-)

commit fc43dca9e75b87d24a16d5be7b497e83837d9d31
Author: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Date:   Wed Aug 29 20:30:25 2007 +0900

    [POWERPC] PS3: Fix bug where the major version part is not compared
    
    Fix the bug that the major version part of the firmware version number
    is ignored in the comparison done by ps3_compare_firmware_version
    because the difference of two 64-bit quantities is returned as an int.
    
    Signed-off-by: Masakazu Mokuno <mokuno@sm.sony.co.jp>
    Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 13a6976afdb10d54ac5ad344aa0c588bc0bd8b0a
Author: Paul Mackerras <paulus@samba.org>
Date:   Thu Aug 30 16:51:51 2007 +1000

    [POWERPC] Update defconfigs
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ada83daab31c3ec35845785482124373a62f430c
Author: Andre Detsch <adetsch@br.ibm.com>
Date:   Tue Aug 21 10:06:22 2007 +0800

    [POWERPC] spufs: Don't call spu_run_init from spu_reacquire_runnable
    
    This fixes a major bug which was happening when a SPU thread advances
    its execution right after being restored to a SPU.  A potentially
    outdated NPC value was being (re)written to the SPU.
    
    So, spu_run_init, in this case, was either not doing anything relevant,
    or breaking the execution of the SPU thread.
    
    This fixes a common problem of losing a mailbox write when it was done
    to a saved context.
    
    Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 62ee68e3bcb0d056aae5b36dea0388ca25572cdf
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Aug 21 10:06:22 2007 +0800

    [POWERPC] spufs: Fix update of mailbox status register during backed wbox write
    
    When a process writes into the inbound spu mailbox (wbox) while the
    context is saved, we accidentally break the contents of the mb_stat_R
    register by clearing other entries of the mailbox status register. This
    can cause the user side to hang.
    
    This change fixes the problem by only altering the appropriate bits
    of the mailbox status register during a backing-store write.
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit aac2e68481681a362ab6f44fc515034e2a4c7f2c
Author: Christian Krafft <krafft@de.ibm.com>
Date:   Thu Aug 30 01:33:53 2007 +0200

    [POWERPC] spu_manage: fix spu_unit_number for celleb device tree
    
    This fixes a regression introduced with 2.6.23-rc4 after on some
    confusion about the device tree interfaces.
    
    IBM QS21 device trees provide "physical-id", so we changed the code to
    run on that and remain compatible with all IBM machines.
    
    However, the Toshiba Celleb device tree provides the "unit-id" property,
    which was in the Linux code, but never used in this way on IBM hardware.
    
    Legacy device tree used the reg property for the physical id of an spe.
    This patch fixes find_spu_unit_number to look for the spu id in that order.
    The length is checked to avoid misinterpretation in case the attributes
    unit-id or reg do not contain the id.
    
    Signed-off-by: Christian Krafft <krafft@de.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Cc: Jeremy Kerr <jk@ozlabs.org>

commit 5cc44e086d7a4e20035997ec612678ca91f426e7
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue Aug 28 21:46:53 2007 -0500

    [POWERPC] Update defconfigs
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 0ee6c15e7ba7b36a217cdadb292eeaf32a057a59
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue Aug 28 21:15:53 2007 -0500

    [POWERPC] Flush registers to proper task context
    
    When we flush register state for FP, Altivec, or SPE in flush_*_to_thread
    we need to respect the task_struct that the caller has passed to us.
    
    Most cases we are called with current, however sometimes (ptrace) we may
    be passed a different task_struct.
    
    This showed up when using gdbserver debugging a simple program that used
    floating point. When gdb tried to show the FP regs they all showed up as
    0, because the child's FP registers were never properly flushed to memory.
    
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
