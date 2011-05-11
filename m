Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id E89621007FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:44 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:43:57 -0500
Subject: [PATCH 00/37] fix paca memory usage and NR_CPU loops,
	factor ipi and simplify irq code
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series represents a somewhat ordered, somewhat meandering series
development series of patches I've been working on for the past few weeks.

It starts with memory corruption fixes that need to go back to stable
relating to slave cpu searches and paca allocation.  After refactoring
and taking into consideration of patches merged upstream, I think this
is just the first 4, but the next 3 are related.

  powerpc: fix memory corruption from unallocated slaves
  powerpc: don't search for paca in freed memory
  powerpc/kdump64:  Don't reference freed memory as pacas
  powerpc/iseries: cleanup and fix secondary startup

  powerpc: Respect nr_cpu_ids when calling set_cpu_possible and set_cpu_present
  powerpc: use nr_cpu_ids in initial paca allocation
  powerpc: call no-longer static setup_nr_cpu_ids instead of replicating it

A search for NR_CPUS found that MSG_ALL_BUT_SELF was only used to enter
the debugger, but caused special code loops in all smp_ops,
so I pulled that code for a bit more path length in the loop to enter
the debugger or kexec.  I then simplified the mpic code and factored
out common code in ipi interrupt multiplexing.   That allowed an
easy change to remove a set of lwarx/stwcx. in the ipi send path.

  powerpc: mpic: limit NR_CPUS loop to 32 bit
  powerpc: mpic: break cpumask abstraction earlier
  powerpc: remove call sites of MSG_ALL_BUT_SELF
  powerpc: remove checks for MSG_ALL and MSG_ALL_BUT_SELF
  linux/smp.h: remove unused MSG_ flags
  powerpc/mpic: simplify ipi cpu mask handling
  powerpc: remove powermac/pic.h
  powerpc: remove alloc_maybe_bootmem for zalloc version
  powerpc: remove stubbed beat smp support
  powerpc cell: use smp_request_message_ipi  [ patchwork 3780 ]
  powerpc: move smp_ops_t from machdep.h to smp.h
  powerpc: consolidate ipi message mux and demux
  powerpc: add kconfig for muxed smp ipi support
  powerpc: use bytes instead of bitops in smp ipi multiplexing

I then got sidetracked with Grant's quest to create irq_domains from the
irq_host code.  I started going through the irq_host implementations in
arch/powerpc, removing some code that was redundant or not called, tring
to simplify the interfaces before we export them.  Also standardizing
the use of the per-irq chip data and handler data.

  powerpc: xics: cleanup xics_host_map and ipi
  powerpc: radix trees are available before init_IRQ
  powerpc: return early if irq_host lookup type is wrong
  powerpc: remove trival irq_host_ops.unmap
  powerpc: remove i8259 irq_host_ops->unmap
  powerpc fsl_msi: don't abuse platform_data for driver_data
  powerpc: fsl_msi: use chip_data not handler_data
  powerpc: mpc5121_ads_cpld: remove use of NO_IRQ_IGNORE
  powerpc: mpc62xx_pic: fix get_irq handling of NO_IRQ
  powerpc: psurge: create a irq_host for secondary cpus
  powerpc: remove irq_host_ops->remap hook
  powerpc: spider-pic: get pic from chip_data instead of irq_map
  powerpc: axon_msi: validate msi irq via chip_data
  powerpc: add virq_is_host to reduce virq_to_host usage
  powerpc: remove virq_to_host
  powerpc: make IRQ_NOREQUEST last to clear, first to set

My vision is irq_host (or irq_domain) becomes a small wrapper layer
around the irq_desc layer.  irq_host details are not needed beyond
that layer; the irq_host is a opaque pointer.

Populating reverse mappings (hwirq to virq) will become part of the
irq_host layer and happen at create_irq or irq_alloc_virt.

The return value of the reverse map functions will be the irqdesc and
ppc_md.get_irq will return the irqdesc.  There is no reason to follow
up the radix tree lookup of hwirq to irq only to use that in another
radix-tree lookup to get the irqdesc that we need.  (The only remaining
user of NO_IRQ_IGNORE is iSeries, and that special return is the only
holdup.)

I already have patches that replace the irq_map.host pointer with a
per-irq_host NR_IRQ bitmap (but they are entangled with Grant's series
to switch to irq_alloc as the primary allocator).  As long as you have
fewer than BITS_PER_LONG irq_hosts that will be a win, and the only
path that might be slower is searching for the irq_host at unmap time.

For small irq count controllers that want to map all interrupts to
linux interrupts (including the legacy irq host), we can replace that
bitmap with an irq range.

The irq_host.hostdata field will become a parameter to alloc_irq_host,
and will be set as the irq's chip_data before calling ->map.  The map
routine is free to change this later (ps3 uses per-cpu data, xics now
uses the ics sub-ops as chipdata).  This allows a irq_host to have
several irq_chips for different flows but a driver can have multiple
irq_hosts for multiple instances of a given chip, distinguished
by chip_data.

My current thinking is the device node pointer stored in the host will
become generic match data, still used by the of wrapper to irq_domains
as a device node for default matching.  Both the match data and the
chip data will be availible to the match routine.  (This allows us to
keep the default of device node = match data without standardizing
a match struct inside each irq_hosts chipdata that we have to undo
every irq).

After doing a bunch of grep's on arch/sh, I think the interesting
parts of super8 interrupt handling that Thomas referred to are in
drivers/sh/intc.  For some reason they populate the radix tree first
with a descriptor of their common interrupt controler abstraction
then walk the tree, replacing the tagged elements with the pointer
to their equivalent to irq_map.  I do not yet understand the purpose
of this two phase allocation.

All patches are being sent to linuxppc-dev, a few have additional
cc's.

All patches were compiled for 3 configs: a smp 32 bit classic, a 32
bit book-e smp, and a 64 bit server, each had most platforms enabled.
I restricted many of my grep searches to arch/powerpc.   I boot tested
using bml.

 arch/powerpc/include/asm/dbell.h                 |    3 +-
 arch/powerpc/include/asm/irq.h                   |    5 +-
 arch/powerpc/include/asm/machdep.h               |   21 ----
 arch/powerpc/include/asm/smp.h                   |   33 +++++-
 arch/powerpc/include/asm/system.h                |    2 -
 arch/powerpc/include/asm/xics.h                  |    2 +-
 arch/powerpc/kernel/crash.c                      |    2 +-
 arch/powerpc/kernel/dbell.c                      |   65 ++----------
 arch/powerpc/kernel/head_64.S                    |   13 ++-
 arch/powerpc/kernel/irq.c                        |  112 ++++----------------
 arch/powerpc/kernel/kgdb.c                       |    2 +-
 arch/powerpc/kernel/misc_64.S                    |   13 ++-
 arch/powerpc/kernel/paca.c                       |   17 +--
 arch/powerpc/kernel/pci_dn.c                     |    3 +-
 arch/powerpc/kernel/setup-common.c               |   14 ++--
 arch/powerpc/kernel/smp.c                        |  118 ++++++++++++++-------
 arch/powerpc/lib/alloc.c                         |    8 --
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |    6 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        |    4 +-
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c     |    8 --
 arch/powerpc/platforms/85xx/smp.c                |    6 +-
 arch/powerpc/platforms/Kconfig                   |   11 ++-
 arch/powerpc/platforms/Kconfig.cputype           |    2 +
 arch/powerpc/platforms/cell/Makefile             |    1 -
 arch/powerpc/platforms/cell/axon_msi.c           |    3 +-
 arch/powerpc/platforms/cell/beat_interrupt.c     |   27 -----
 arch/powerpc/platforms/cell/beat_interrupt.h     |    3 -
 arch/powerpc/platforms/cell/beat_smp.c           |  123 ----------------------
 arch/powerpc/platforms/cell/celleb_pci.c         |    6 +-
 arch/powerpc/platforms/cell/celleb_setup.c       |    4 -
 arch/powerpc/platforms/cell/interrupt.c          |   27 ++----
 arch/powerpc/platforms/cell/smp.c                |   18 +---
 arch/powerpc/platforms/cell/spider-pic.c         |   13 ++-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c |    7 --
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    |    7 --
 arch/powerpc/platforms/iseries/Kconfig           |    1 +
 arch/powerpc/platforms/iseries/exception.S       |   59 ++++++----
 arch/powerpc/platforms/iseries/irq.c             |    3 +-
 arch/powerpc/platforms/iseries/setup.c           |    5 +
 arch/powerpc/platforms/iseries/smp.c             |   39 +-------
 arch/powerpc/platforms/iseries/smp.h             |    6 -
 arch/powerpc/platforms/powermac/Kconfig          |   11 ++-
 arch/powerpc/platforms/powermac/pic.c            |   13 +--
 arch/powerpc/platforms/powermac/pic.h            |   11 --
 arch/powerpc/platforms/powermac/pmac.h           |    1 +
 arch/powerpc/platforms/powermac/smp.c            |   87 +++++++++-------
 arch/powerpc/platforms/ps3/interrupt.c           |    6 -
 arch/powerpc/platforms/ps3/smp.c                 |   22 +----
 arch/powerpc/platforms/pseries/smp.c             |    3 +-
 arch/powerpc/sysdev/fsl_msi.c                    |   10 +-
 arch/powerpc/sysdev/i8259.c                      |   13 ---
 arch/powerpc/sysdev/mpic.c                       |   52 +++-------
 arch/powerpc/sysdev/xics/icp-hv.c                |   26 +----
 arch/powerpc/sysdev/xics/icp-native.c            |   26 +----
 arch/powerpc/sysdev/xics/xics-common.c           |   42 ++------
 arch/powerpc/xmon/xmon.c                         |    2 +-
 include/linux/smp.h                              |   10 --
 57 files changed, 363 insertions(+), 794 deletions(-)
 delete mode 100644 arch/powerpc/platforms/cell/beat_smp.c
 delete mode 100644 arch/powerpc/platforms/iseries/smp.h
 delete mode 100644 arch/powerpc/platforms/powermac/pic.h
