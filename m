Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17844.42263.560909.443673@cargo.ozlabs.ibm.com>
Date: Mon, 22 Jan 2007 22:50:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

The full log messages are below.  The bulk of it, in terms of lines
changed, is the defconfig update.  There are also five bugfixes and a
documentation update.

Thanks,
Paul.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    6 +
 arch/powerpc/boot/dts/lite5200.dts                 |    6 +
 arch/powerpc/boot/dts/lite5200b.dts                |    6 +
 arch/powerpc/configs/cell_defconfig                |    6 -
 arch/powerpc/configs/chrp32_defconfig              |  161 ++++++++++----
 arch/powerpc/configs/g5_defconfig                  |  237 +++++++++++++++-----
 arch/powerpc/configs/iseries_defconfig             |  132 +++++++----
 arch/powerpc/configs/linkstation_defconfig         |  111 ++++++---
 arch/powerpc/configs/lite5200_defconfig            |   39 ++-
 arch/powerpc/configs/maple_defconfig               |   91 ++++++--
 arch/powerpc/configs/mpc7448_hpc2_defconfig        |  175 +++++++++++----
 arch/powerpc/configs/mpc834x_itx_defconfig         |  187 +++++++++++++---
 arch/powerpc/configs/mpc834x_mds_defconfig         |   97 +++++++-
 arch/powerpc/configs/mpc8360emds_defconfig         |  105 +++++++--
 arch/powerpc/configs/mpc8540_ads_defconfig         |   89 ++++++--
 arch/powerpc/configs/mpc8560_ads_defconfig         |   96 ++++++--
 arch/powerpc/configs/mpc85xx_cds_defconfig         |   96 ++++++--
 arch/powerpc/configs/mpc8641_hpcn_defconfig        |   98 ++++++--
 arch/powerpc/configs/pmac32_defconfig              |  202 ++++++++++++-----
 arch/powerpc/configs/ppc64_defconfig               |    5 
 arch/powerpc/configs/ps3_defconfig                 |   39 +++
 arch/powerpc/configs/pseries_defconfig             |  224 +++++++++++++++----
 arch/powerpc/kernel/pci_32.c                       |    5 
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    2 
 arch/powerpc/platforms/83xx/mpc8360e_pb.c          |    2 
 arch/powerpc/platforms/pseries/iommu.c             |    3 
 arch/powerpc/sysdev/mmio_nvram.c                   |   40 ++-
 include/asm-powerpc/atomic.h                       |    8 -
 28 files changed, 1698 insertions(+), 570 deletions(-)

commit e89debcd18a3ef74b27894e479d6b9e658fc6de6
Author: Paul Mackerras <paulus@samba.org>
Date:   Mon Jan 22 22:39:24 2007 +1100

    [POWERPC] Update defconfigs
    
    Mostly took the defaults, except tried to get the netfilter options
    more or less as they were before.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 434f98c48fc1d2a1f562a28a1562a7b53e940957
Author: Robert Jennings <rcj@linux.vnet.ibm.com>
Date:   Wed Jan 17 10:50:20 2007 -0600

    [POWERPC] atomic_dec_if_positive sign extension fix
    
    On 64-bit machines, if an atomic counter is explicitly set to a
    negative value, the atomic_dec_if_positive function will decrement and
    store the next smallest value in the atomic counter, contrary to its
    intended operation.
    
    The comparison to determine if the decrement will make the result
    negative was done by the "addic." instruction, which operates on a
    64-bit value, namely the zero-extended word loaded from the atomic
    variable.  This patch uses an explicit word compare (cmpwi) and
    changes the addic. to an addi (also changing "=&r" to "=&b" so that r0
    isn't used, and addi doesn't become li).
    
    This also fixes a bug for both 32-bit and 64-bit in that previously
    0x80000000 was considered positive, since the result after
    decrementing is positive.  Now it is considered negative.
    
    Also, I clarify the return value in the comments just to make it clear
    that the value returned is always the decremented value, even if that
    value is not stored back to the atomic counter.
    
    Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 06cd9396778d5b70ba27fa8158db78d6bc0f007b
Author: Li Yang <leoli@freescale.com>
Date:   Wed Jan 17 14:42:22 2007 +0800

    [POWERPC] Fix OF node refcnt underflow in 836x and 832x platform code
    
    Incorrect use of of_find_node_by_name() causes of_node_put()
    on a node which has already been put.  It causes the refcount of
    the node to underflow, which triggers the WARN_ON in kref_get
    for 836x and 832x.  This fixes it.
    
    Signed-off-by: Li Yang <leoli@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 121361f72ca93cb6710e368bb89f9d976b1da443
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Fri Jan 19 00:00:14 2007 -0700

    [POWERPC] Make it blatantly clear; mpc5200 device tree is not yet stable
    
    Documentation-only change.  The 5200 device tree layout has not yet
    stablized, so nobody should depend on the layout of the tree.
    
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
    Acked-by: Sylvain Munaut <tnt@246tNt.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 77319254f109963213f33cbb15e0103f2e81a64a
Author: Linas Vepstas <linas@austin.ibm.com>
Date:   Wed Jan 10 19:16:29 2007 -0600

    [POWERPC] Fix broken DMA on non-LPAR pSeries
    
    It appears that the iommu table address is never stored, and thus
    never found, on non-lpar systems. Thus, for example, during boot:
    
    <7>[   93.067916] PCI: Scanning bus 0001:41
    <7>[   93.068542] PCI: Found 0001:41:01.0 [8086/100f] 000200 00
    <7>[   93.068550] PCI: Calling quirk c0000000007822e0 for 0001:41:01.0
    <7>[   93.069815] PCI: Fixups for bus 0001:41
    <4>[   93.070167] iommu: Device 0001:41:01.0 has no iommu table
    <7>[   93.070251] PCI: Bus scan for 0001:41 returning with max=41
    
    No iommu table? How can that be? Well, circa line 471 of
    arch/powerpc/platforms/pseries/iommu.c we see the code:
    
       while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
          dn = dn->parent;
    
    and a few lines later is the surprising print statement about
    the missing table.  Seems that this loop ran unto the end, never
    once finding a non-null PCI_DN(dn)->iommu_table.
    
    The problem can be found a few lines earlier: it sems that the
    value of PCI_DN(dn)->iommu_table is never ever set. Thus, the
    patch sets it.
    
    The patch was tested on a Power4 system running in full system
    partition mode, which is where I saw the problem. It works; I've
    not done any wider testing. Had a brief discussion on this on irc.
    
    Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6984ee797a8798128e94ab2447c8ed91f0156eb5
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Jan 11 16:08:41 2007 +1100

    [POWERPC] Fix cell's mmio nvram to properly parse device tree
    
    The mmio nvram driver (used by cell only atm) isn't properly parsing
    the device-tree, meaning that nvram isn't found correctly on the new
    Cell blades.  It works ok for old blades where the nvram is at the
    root of the device tree but fails on Malta and CAB when it's hanging
    off axon.  This fixes it by using the proper OF parsing functions.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 4ef6e68117e93111590d9d4ada1a282304241169
Author: Benjamin Herrenschmidt <benh@au1.ibm.com>
Date:   Thu Jan 11 16:38:22 2007 +1100

    [POWERPC] Remove bogus sanity check in pci -> OF node code
    
    The new implementation of pci_device_to_OF_node() on ppc32 has a bogus
    sanity check in it that can cause oopses at boot when no device node is
    present, and might hit correct cases with older/weird apple device-trees
    where they have the type "vci" for the chaos bridge.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
