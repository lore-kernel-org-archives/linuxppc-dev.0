Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18023.65355.665622.62201@cargo.ozlabs.ibm.com>
Date: Thu, 7 Jun 2007 22:51:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git master branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

There is a series of bug-fixes for the Cell port, plus a boot wrapper
fix from me, a pasemi fix from Olof and a couple of documentation
updates.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |   59 +++++++++-
 arch/powerpc/boot/crt0.S                     |    1 
 arch/powerpc/kernel/of_platform.c            |    2 
 arch/powerpc/platforms/cell/cbe_cpufreq.c    |   33 ++++-
 arch/powerpc/platforms/cell/spufs/context.c  |    4 -
 arch/powerpc/platforms/cell/spufs/file.c     |   57 +++++----
 arch/powerpc/platforms/cell/spufs/inode.c    |   62 ++++------
 arch/powerpc/platforms/cell/spufs/sched.c    |  161 +++++++++++++-------------
 arch/powerpc/platforms/cell/spufs/spufs.h    |    2 
 arch/powerpc/platforms/celleb/Makefile       |    2 
 arch/powerpc/platforms/pasemi/iommu.c        |    8 -
 11 files changed, 224 insertions(+), 167 deletions(-)

commit f40e524eaec9697d1515564fd5b961d839d2dc4f
Author: Paul Mackerras <paulus@samba.org>
Date:   Thu Jun 7 22:21:31 2007 +1000

    [POWERPC] Fix building of COFF zImages
    
    The COFF zImage (for booting oldworld powermacs) wasn't being built
    correctly because the procedure descriptor in crt0.S for the zImage
    entry point wasn't declared as .globl, and therefore wasn't getting
    pulled in from wrapper.a by the linker.  This adds the necessary
    .globl statement.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 87873c86802ba7ff9d9550d06459a6e99d72c5eb
Author: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Date:   Wed Jun 6 14:03:58 2007 +1000

    [POWERPC] spufs: Fix error handling in spufs_fill_dir()
    
    The error path in spufs_fill_dir() is broken. If d_alloc_name() or
    spufs_new_file() fails, spufs_prune_dir() is getting called. At this time
    dir->inode is not set and a NULL pointer is dereferenced by mutex_lock().
    This bugfix replaces spufs_prune_dir() with a shorter version that does
    not touch dir->inode but simply removes all children.
    
    Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5e1e9ba690a2e2135a8f997242f9c46d2b8ac033
Author: Stuart Yoder <stuart.yoder@freescale.com>
Date:   Wed Jun 6 04:29:14 2007 +1000

    [POWERPC] Add table of contents to booting-without-of.txt
    
    Add table of contents.
    
    Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e5c0b9ec538a86433ddd725f675e0a5a2117b9ed
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jun 5 11:25:59 2007 +1000

    [POWERPC] spufs: Don't yield nosched context
    
    Nosched context sould never be scheduled out, thus we must not
    deactivate them in spu_yield ever.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d30ac1242bf842fe28501a78a460a43910ef2dba
Author: Stuart Yoder <stuart.yoder@freescale.com>
Date:   Tue Jun 5 07:16:15 2007 +1000

    [POWERPC] Fix typo in booting-without-of-txt section numbering
    
    Fix typo in section numbering.
    
    Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
    Acked-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6dcbf164dcf4042bcbe9f56d94f65acd10b0e1f6
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Jun 5 04:14:41 2007 +1000

    [POWERPC] scc_sio: Fix link failure
    
    scc_sio.o should only be built if the txx9 serial driver is actually
    built into the kernel.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    
    --
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 1552cb923efcd0f5499104256010d2ace437581d
Author: Thomas Renninger <trenn@suse.de>
Date:   Tue Jun 5 04:14:40 2007 +1000

    [POWERPC] cbe_cpufreq: Limit frequency via cpufreq notifier chain
    
    ... and get rid of cpufreq_set_policy call that caused a build
    failure due interfering commits.
    
    Signed-off-by: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Christian Krafft <krafft@de.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e7c40012b84f670ba57fe4a3f453ddecc8813e9b
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Tue Jun 5 04:14:39 2007 +1000

    [POWERPC] Fix pci_setup_phb_io_dynamic for pci_iomap
    
    We had a problem on a system with only dynamically allocated
    PCI buses (using of_pci_phb_driver) in combination with libata.
    This setup ended up having no "primary" phb, which means
    that pci_io_base never got initialized and all IO port
    numbers are 64 bit numbers, which is larger than the
    PIO_MASK limit.
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit bb5db29aa0379f0f3ef857a3a3715f17261c611b
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs scheduler: Fix wakeup races
    
    Fix the race between checking for contexts on the runqueue and actually
    waking them in spu_deactive and spu_yield.
    
    The guts of spu_reschedule are split into a new helper called
    grab_runnable_context which shows if there is a runnable thread below
    a specified priority and if yes removes if from the runqueue and uses
    it.  This function is used by the new __spu_deactivate hepler shared
    by preemption and spu_yield to grab a new context before deactivating
    a specified priority and if yes removes if from the runqueue and uses
    it.  This function is used by the new __spu_deactivate hepler shared
    by preemption and spu_yield to grab a new context before deactivating
    the old one.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 47d3a5faa3f72186f769ed9579c630afb8433f2b
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs: Synchronize pte invalidation vs ps close
    
    Make sure the mapping_lock also protects access to the various address_space
    pointers used for tearing down the ptes on a spu context switch.
    
    Because unmap_mapping_range can sleep we need to turn mapping_lock from
    a spinlock into a sleeping mutex.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 89df00855beabfa700f9a9ed52f0983bdc4b021d
Author: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs: Free mm if spufs_fill_dir() failed
    
    In case spufs_fill_dir() fails only put_spu_context()
    gets called for cleanup and the acquired mm_struct never gets freed.
    
    Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 877907d37da9694a34adc9dc3e2ce09400148cb5
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs: Fix gang destroy leaks
    
    Previously, closing a SPE gang that still has contexts would trigger
    a WARN_ON, and leak the allocated gang.
    
    This change fixes the problem by using the gang's reference counts to
    destroy the gang instead. The gangs will persist until their last
    reference (be it context or open file handle) is gone.
    
    Also, avoid using statements with side-effects in a WARN_ON().
    
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ce92987baba60bc082b9eedddfaf4ae3f8435dac
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs: Hook up spufs_release_mem
    
    Currently spufs_mem_release and the mem file doesn't have any release
    method hooked up, leading to leaks everytime is used.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8f18a158192ef6dc63a572bdbbdf5613cfbbe2e4
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Mon Jun 4 23:26:51 2007 +1000

    [POWERPC] spufs: Refuse to load the module when not running on cell
    
    As noticed by David Woodhouse, it's currently possible to mount
    spufs on any machine, which means that it actually will get
    mounted by fedora.
    This refuses to load the module on platforms that have no
    support for SPUs.
    
    Cc: David Woodhouse <dwmw2@infradead.org>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6291ed3c04d5c83c26e77d4fa47e06d0416be81d
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Jun 4 10:49:05 2007 +1000

    [POWERPC] pasemi: Fix iommu + 64K PAGE_SIZE bug
    
    The powerpc iommu code was refactored by Linas back in the 2.6.20 time
    frame to map 4K pages from the generic code, but I had forgotten to go
    back and fix my platform driver before submitting it.
    
    Signed-off-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
