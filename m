Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17654.26321.851991.285528@cargo.ozlabs.ibm.com>
Date: Thu, 31 Aug 2006 14:34:25 +1000
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

to get some more PowerPC updates for 2.6.18.

I have included the full commit messages this time.  There are
(unfortunately) quite a few commits, because:

* People have been finding bugs. :P  This includes the fix for Olaf's
  problem where time wasn't advancing, plus one found recently where
  memcpy not returning the correct value was causing an oops in the
  ipsec code.
* Some of the embedded board maintainers have only just caught up with
  Ben H's irq rework that went in near the end of the merge window.
  Since their platforms don't compile without the fixes, and changes
  in their code aren't going to affect a lot of users, I put them in.
* I have included some "device tree source" files, which are
  essentially documentation as far as the kernel is concerned.  They
  don't directly affect any kernel code, but can be useful as a
  reference when reading the code.  (They would normally be compiled
  to a binary form and supplied by board firmware to the kernel at boot.)

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt      |    6 
 arch/powerpc/Kconfig                              |   20 -
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |  190 ++++++
 arch/powerpc/boot/dts/mpc8349emds.dts             |  328 +++++++++++
 arch/powerpc/configs/mpc834x_mds_defconfig        |    0 
 arch/powerpc/kernel/fpu.S                         |    5 
 arch/powerpc/kernel/irq.c                         |   84 ++-
 arch/powerpc/kernel/pci_64.c                      |   11 
 arch/powerpc/kernel/ppc_ksyms.c                   |    4 
 arch/powerpc/kernel/prom_init.c                   |   10 
 arch/powerpc/kernel/prom_parse.c                  |   17 -
 arch/powerpc/kernel/smp-tbsync.c                  |    5 
 arch/powerpc/kernel/time.c                        |   25 -
 arch/powerpc/lib/memcpy_64.S                      |   11 
 arch/powerpc/mm/44x_mmu.c                         |    4 
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |   49 --
 arch/powerpc/platforms/83xx/mpc834x_sys.c         |   56 --
 arch/powerpc/platforms/83xx/mpc83xx.h             |    1 
 arch/powerpc/platforms/83xx/pci.c                 |    9 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   26 -
 arch/powerpc/platforms/86xx/pci.c                 |    3 
 arch/powerpc/platforms/embedded6xx/Kconfig        |    1 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 
 arch/powerpc/sysdev/Makefile                      |    4 
 arch/powerpc/sysdev/ipic.c                        |  303 +++++++---
 arch/powerpc/sysdev/ipic.h                        |   23 +
 arch/powerpc/sysdev/mpic.c                        |  223 +++++--
 arch/ppc/kernel/smp-tbsync.c                      |    7 
 arch/ppc/syslib/Makefile                          |    2 
 arch/ppc/syslib/ipic.c                            |  646 +++++++++++++++++++++
 arch/ppc/syslib/ipic.h                            |   47 ++
 include/asm-powerpc/io.h                          |    7 
 include/asm-powerpc/ipic.h                        |   12 
 include/asm-powerpc/mpc86xx.h                     |    3 
 include/asm-powerpc/mpic.h                        |  125 ++++
 include/asm-powerpc/prom.h                        |    4 
 include/asm-powerpc/time.h                        |    4 
 37 files changed, 1934 insertions(+), 343 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc7448hpc2.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8349emds.dts
 rename arch/powerpc/configs/{mpc834x_sys_defconfig => mpc834x_mds_defconfig} (100%)
 create mode 100644 arch/ppc/syslib/ipic.c
 create mode 100644 arch/ppc/syslib/ipic.h


commit d0027bf09f09d95a23b8f476ba8cea28f2576781
Author: Paul Mackerras <paulus@samba.org>
Date:   Thu Aug 31 13:22:58 2006 +1000

    [POWERPC] Fix return value from memcpy
    
    As pointed out by Herbert Xu <herbert@gondor.apana.org.au>, our
    memcpy implementation didn't return the destination pointer as its
    return value, and there is code in the kernel that expects that.
    This fixes it.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e7498656b5e2e9e3806d263fecc90b2707d02093
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Wed Aug 30 17:11:34 2006 +1000

    [POWERPC] iseries: Define insw et al. so libata/ide will compile
    
    These are build fixes that enable (for example) libata and the ide
    code to actually build on iSeries.  The associated hardware will never
    be supported on legacy iSeries, so the code paths don't actually need
    to work, but it is useful (especially for a combined kernel) if the
    code can build.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 467c37801c453849a2fe243c3226476ee3985868
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Aug 30 16:10:47 2006 +1000

    [POWERPC] Fix irq enable/disable in smp_generic_take_timebase
    
    Eran Ben-Avi <eranpublic@yahoo.com> pointed out that the arch/ppc version
    of smp_generic_take_timebase disables interrupts on entry but exits without
    restoring them.  However, both it and the arch/powerpc version have another
    problem, which is that they use local_irq_disable/enable rather than
    local_irq_save/restore, and they are called with interrupts disabled.
    
    This fixes both problems; it changes a return to a break in the arch/ppc
    version, and changes both versions to use local_irq_save/restore.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e0d872d536bb93335d5905b09fe374a163486d43
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Aug 30 15:55:32 2006 +1000

    [POWERPC] Fix problem with time not advancing on 32-bit platforms
    
    This fixes a problem introduced in 5db9fa9593e2ff69f2b95f9d59229dc4faaa564d.
    The last_jiffy per-cpu variable is only 32 bits on 32-bit machines, but it
    was being compared with a 64-bit quantity (tb_next_jiffy), which resulted in
    time not advancing.
    
    This fixes it by changing last_jiffy to be 64 bits on all platforms.  With
    this, we no longer need tb_last_stamp as a 32-bit version of tb_last_jiffy,
    so this gets rid of tb_last_stamp and we just use tb_last_jiffy instead.
    This also fixes a bug when the boot cpu is not online, because using
    tb_last_stamp could have caused the wrong timebase origin value to be used
    when calculating the time of day.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fea23bfefb4e98efd3c36f00ccc0b60281dc99da
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Aug 30 14:45:35 2006 +1000

    [POWERPC] Restore copyright notice in arch/powerpc/kernel/fpu.S
    
    This code got moved from head.S but the copyright notice on head.S didn't
    get transferred with it.  Noticed by Cort Dougan <cort@fsmlabs.com>.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 11e9ed43ca8a741c2858c33d12120cf8817d3bff
Author: Will Schmidt <will_schmidt@vnet.ibm.com>
Date:   Fri Aug 25 15:46:59 2006 -0500

    [POWERPC] Fix up ibm_architecture_vec definition
    
    This problem was noticed by one of the Phyp firmware folks.
    Our ibm,client-architecture-support call was failing.
    This corrects the vector length parameters being passed in.
    
    Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 006b64de607f895de2ba1e21d3179cddf059128f
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Fri Aug 25 14:46:23 2006 +1000

    [POWERPC] Make OF irq map code detect more error cases
    
    Device-tree bugs on js20 with some versions of SLOF were causing the
    interrupt for IDE to not be parsed correctly and fail to boot. This
    patch adds a bit more sanity checking to the parser to detect some of
    those errors and fail instead of returning bogus information.  The
    powerpc PCI code can then trigger a fallback that works on those
    machines.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 7233593b7844c2db930594ee9c0c872a6900bfcc
Author: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Date:   Fri Aug 25 14:16:30 2006 +1000

    [POWERPC] Support for "weird" MPICs and fixup mpc7448_hpc2
    
    This adds a new hardware information table for mpic. This enables
    the mpic code to deal with mpic controllers with different register
    layouts and hardware behaviours.
    
    This introduces CONFIG_MPIC_WEIRD.  For boards with non standard mpic
    controllers, select CONFIG_MPIC_WEIRD and add its hardware information
    in the mpic_infos[] array.
    
    TSI108/109 PIC takes the first index of weird hardware information
    table.  :)  The table can be extended. The Tsi108/109 PIC looks like
    standard OpenPIC but, in fact, is different in register mapping and
    behavior.
    
    The patch does not affect the behavior of standard mpic.  If
    CONFIG_MPIC_WEIRD is not defined, the code is essentially identical to
    the current code.
    
    [benh@kernel.crashing.org:
    This patch is a slightly cleaned up version of Zang Roy's support for
    the TSI108 MPIC variant. It also fixes up MPC7448_hpc2 to use the new
    version of the type macros and changes the way MPIC is selected in
    Kconfig to better match what is done for other system devices.
    ]
    
    Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 3efbdd136e52ee4028b5bb5b848a6043cf61cd6e
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Aug 30 08:58:00 2006 +1000

    [POWERPC] Fix MPIC sense codes in documentation
    
    The booting-without-of.txt had incorrect definition for the sense codes
    for an OpenPIC controller
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8ec8f2e85c6b88b4a1641eb3902275bcf2c6d60a
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon Aug 28 11:17:37 2006 +1000

    [POWERPC] Fix performance regression in IRQ radix tree locking
    
    When reworking the powerpc irq code, I figured out that we were using
    the radix tree in a racy way. As a temporary fix, I put a spinlock in
    there. However, this can have a significant impact on performances. This
    patch reworks that to use a smarter technique based on the fact that
    what we need is in fact a rwlock with extremely rare writers (thus
    optimized for the read path).
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 4b3afca9345f5beb9c607faeb2aef4f91dd91a13
Author: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Date:   Fri Aug 25 16:43:25 2006 +0800

    [POWERPC] Add mpc7448hpc2 device tree source file
    
    This patch adds the mpc7448hpc2 device tree source file.
    
    Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 1b9a93eb4638dcde0c3af42fd6c05e3911baa7db
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Tue Aug 29 18:13:31 2006 -0500

    [POWERPC] Add MPC8349E MDS device tree source file to arch/powerpc/boot/dts
    
    Add MPC8349E MDS device tree source file to arch/powerpc/boot/dts
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f1f17716d13bfb709809a3f5c84bda105b646b9e
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Fri Aug 25 11:59:22 2006 -0500

    [POWERPC] modify mpc83xx platforms to use new IRQ layer
    
    This fixes MPC834x MDS (formerly SYS) and ITX platform code to get IRQ data (including PCI) from the device tree, and to use the new IPIC code.
    
    renamed defconfig (sys -> mds), left one redundant NULL assignment in mpc83xx_pcibios_fixup to keep the compiler happy.
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Li Yang <leoli@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b9f0f1bb2bcaae96dd3267f6bd3ad1ca44a1f5ad
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Fri Aug 25 11:59:07 2006 -0500

    [POWERPC] Adapt ipic driver to new host_ops interface, add set_irq_type to set IRQ sense
    
    This converts ipic code to Benh's IRQ mods.  For the IPIC, IRQ sense values in the device tree equal those in include/linux/irq.h; that's 8 for low assertion (most internal IRQs on mpc83xx), and 2 for high-to-low change.
    
    spinlocks added to [un]mask, ack operations; default handler and type now set in host_map; and redundant condition check eliminated.
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Li Yang <leoli@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit bf4152dd7ccb6c060d786200a893dfe30193a07f
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Fri Aug 25 11:58:53 2006 -0500

    [POWERPC] back up old school ipic.[hc] to arch/ppc
    
    Keep from breaking 83xx arch/ppc build.  Back up old school arch/powerpc/sysdev/ipic.[hc] to arch/ppc/syslib.
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c85c41ad73c6db4cf4cc98c595cc5e2fdbdb53d5
Author: Jon Loeliger <jdl@freescale.com>
Date:   Thu Aug 17 14:27:57 2006 -0500

    [POWERPC] Use mpc8641hpcn PIC base address from dev tree.
    
    After going through the trouble of setting up the PIC base
    address in the pic@40000 device tree node, use it instead
    of the obsolete hard-coded value.
    
    Signed-off-by: Jon Loeliger <jdl@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5dc599c206ad50e1b190edfbc98b7cf8ce361003
Author: Jon Loeliger <jdl@freescale.com>
Date:   Tue Aug 15 16:19:02 2006 -0500

    [POWERPC] Allow MPC8641 HPCN to build with CONFIG_PCI disabled too.
    
    Signed-off-by: Jon Loeliger <jdl@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 054389f114fc55d525926b55e82b473b783a7d77
Author: Matt Porter <mporter@embeddedalley.com>
Date:   Fri Aug 4 11:44:01 2006 -0500

    [POWERPC] Fix powerpc 44x_mmu build
    
    The PIN_SIZE definition name changed, update 44x_mmu.c accordingly.
    
    Signed-off-by: Matt Porter <mporter@embeddedalley.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit af07ac276af6eec5111a6567cb7eaf4d222bd332
Author: Matt Porter <mporter@embeddedalley.com>
Date:   Fri Aug 4 11:41:51 2006 -0500

    [POWERPC] Remove flush_dcache_all export
    
    Removes the flush_dcache_all export for non coherent platforms.
    We removed the last in-kernel user of this years ago in arch/ppc
    so it no longer serves a purpose. Plus, it breaks the build
    at the moment.
    
    Signed-off-by: Matt Porter <mporter@embeddedalley.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
