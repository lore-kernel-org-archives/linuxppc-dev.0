Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18108.22529.340205.626742@cargo.ozlabs.ibm.com>
Date: Fri, 10 Aug 2007 22:20:17 +1000
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

to get another batch of bug-fixes for powerpc.  I have included the
full log messages this time.  The changes for spu_base.c and
spu_manage.c are mostly code movement that was needed so that a
PS3-only config would build, so the real change isn't as large as the
diffstat might seem to indicate.

Thanks,
Paul.

 arch/powerpc/configs/ps3_defconfig        |  200 +++++++++--------------------
 arch/powerpc/kernel/head_64.S             |   16 +-
 arch/powerpc/kernel/pci_64.c              |    1 
 arch/powerpc/mm/slb.c                     |   45 ++-----
 arch/powerpc/mm/slice.c                   |    2 
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 
 arch/powerpc/platforms/cell/spu_base.c    |  141 --------------------
 arch/powerpc/platforms/cell/spu_manage.c  |  163 ++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/Kconfig        |   10 +
 arch/powerpc/platforms/ps3/device-init.c  |   37 +++--
 arch/powerpc/platforms/ps3/spu.c          |    6 +
 include/asm-powerpc/dma-mapping.h         |    2 
 include/asm-powerpc/spu_priv1.h           |    7 +
 16 files changed, 295 insertions(+), 339 deletions(-)

commit d1f5a77f2c9db5b8a565eabdf8b534b02e32cc44
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Aug 8 15:44:15 2007 +1000

    [POWERPC] Fix size check for hugetlbfs
    
    My "slices" address space management code that was added in the 2.6.22
    implementation of get_unmapped_area() doesn't properly check that the
    size is a multiple of the requested page size.  This allows userland to
    create VMAs that aren't a multiple of the huge page size with hugetlbfs
    (since hugetlbfs entirely relies on get_unmapped_area() to do that
    checking) which leads to a kernel BUG() when such areas are torn down.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8f2ea1fd3f97ab7a809e939b5b9005a16f862439
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Aug 7 08:05:10 2007 +1000

    [POWERPC] Fix initialization and usage of dma_mask
    
    powerpc has a couple of bugs in the usage of dma_masks that tend to
    break when drivers explicitly try to set a 32-bit mask for example.
    
    First, the code that generates the pci devices from the OF device-tree
    doesn't initialize the mask properly, then our implementation of
    set_dma_mask() was trying to validate the -previous- mask value, not the
    one passed in as an argument.
    
    This fixes these problems.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 939e60f6808a9ffd3a4e5f145057379c138c89aa
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Jul 31 16:44:13 2007 +1000

    [POWERPC] Fix more section mismatches in head_64.S
    
    WARNING: vmlinux.o(.text+0x8174): Section mismatch: reference to .init.text:.prom_init (between '.__boot_from_prom' and '.__after_prom_start')
    WARNING: vmlinux.o(.text+0x8498): Section mismatch: reference to .init.text:.early_setup (between '.start_here_multiplatform' and '.start_here_common')
    WARNING: vmlinux.o(.text+0x8514): Section mismatch: reference to .init.text:.setup_system (between '.start_here_common' and 'system_call_common')
    WARNING: vmlinux.o(.text+0x8530): Section mismatch: reference to .init.text:.start_kernel (between '.start_here_common' and 'system_call_common')
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 3c5ede8cc6c75c3d85e46a5c20f106bcec933347
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Thu Jul 26 17:25:12 2007 -0500

    [POWERPC] Revert "[POWERPC] Add 'mdio' to bus scan id list for platforms with QE UEC"
    
    This reverts commit 3baee955953957be5496cd28e9c544d9db214262.
    
    That commit was a mistake from the start; I added mdio type to the
    bus scan list early on in my ucc_geth migrate to phylib development,
    which is just pure wrong (the ucc_geth_mii driver creates the mii
    bus and the PHY layer handles PHY enumeration without translation).
    
    This follows on from commit 77926826f301fbd8ed96d3cd9ff17a5b59560dfb:
    
     Revert "[POWERPC] Don't complain if size-cells == 0 in prom_parse()"
    
    which was basically trying to hide a symptom of the original mistake
    this revert fixes.
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit bd948b0377e7ab93559a80f68d38749bcc2e9a77
Author: geoffrey.levand@am.sony.com <geoffrey.levand@am.sony.com>
Date:   Tue Aug 7 20:31:22 2007 -0700

    [POWERPC] PS3: Update ps3_defconfig
    
    Update ps3_defconfig.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 332a7b3e93c6521219be0a72ebfe2eee795a8345
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Wed Aug 8 09:39:02 2007 -0700

    [POWERPC] PS3: Remove text saying PS3 support is incomplete
    
    Remove the Kconfig message that indicates the PS3 platform support is
    incomplete.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit edd2a9d185799354db255de62c3ed1f2b1c6b0f4
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Wed Aug 8 11:01:21 2007 -0700

    [POWERPC] PS3: Fix storage probe logic
    
    Fix the PS3 storage probe logic to properly find device regions on cold
    startup.
    
     o Change the storage probe event mask from notify_device_ready
       to notify_region_update.
     o Improve the storage probe error handling.
     o Change ps3_storage_wait_for_device() to use a temporary variable to hold
       the buffer address.
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f5996449e3244524cab0ba709a4bd87047a8175f
Author: Andre Detsch <adetsch@br.ibm.com>
Date:   Fri Aug 3 18:53:46 2007 -0700

    [POWERPC] cell: Move SPU affinity init to spu_management_of_ops
    
    This patch moves affinity initialization code from spu_base.c to a
    new spu_management_of_ops function (init_affinity), which is empty
    in the case of PS3. This fixes a linking problem that was happening
    when compiling for PS3.
    Also, some small code style changes were made.
    
    Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit edd0622bd2e8f755c960827e15aa6908c3c5aa94
Author: Paul Mackerras <paulus@samba.org>
Date:   Fri Aug 10 21:04:07 2007 +1000

    [POWERPC] Fix potential duplicate entry in SLB shadow buffer
    
    We were getting a duplicate entry in the SLB shadow buffer in
    slb_flush_and_rebolt() if the kernel stack was in the same segment
    as PAGE_OFFSET, which on POWER6 causes the hypervisor to terminate
    the partition with an error.  This fixes it.
    
    Also we were not creating an SLB entry (or an SLB shadow buffer
    entry) for the kernel stack on secondary CPUs when starting the
    CPU.  This isn't a major problem, since an appropriate entry will
    be created on demand, but this fixes that also for consistency.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>
