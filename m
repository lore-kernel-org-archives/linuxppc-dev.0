Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE013DDEE0
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 17:34:52 +1000 (EST)
Subject: Updates to powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2008 17:34:41 +1000
Message-Id: <1215588881.8970.358.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've pushed some updates to my version of powerpc.git.

The tree itself is at:

﻿  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

It contains 3 branches:

  - merge  : this is for merging with the current stable and doesn't
             currently contain anything interesting

  - master : this is our current "powerpc.git" tree, it may contain
             various experimental stuff that may or may not go upstream
             or may contain dependent patches that we rely on but that
             are to be merged via some other tree.

  - next   : this is the candidate stuff for linux-next and the next
             merge window

(Andrew, you -may- want to pull that instead of paulus one until
he's back from vacation).

Until today, master and next pointed to the same commit, which was
the same as paulus master and powerpc-next branches. Tonight, I've
pushed some patches to master that I intend to have in next, but
I'd like to let them sit in master for a couple of days to make sure
nothing is badly broken mostly and make sure I didn't screw up in
my various patch monkeying operations.

Here are the newly applied patches:

Benjamin Herrenschmidt (1):
      powerpc: Use new printk extension %pS to print symbols on oops

Dave Kleikamp (5):
      mm: Allow architectures to define additional protection bits
      powerpc/mm: Define flags for Strong Access Ordering
      powerpc/mm: Add SAO Feature bit to the cputable
      powerpc/mm: Add Strong Access Ordering support
      powerpc/mm: Don't clear _PAGE_COHERENT when _PAGE_SAO is set

Geoff Levand (1):
      powerpc/ps3: Quiet system bus match output

Grant Erickson (1):
      ibm_newemac: Parameterize EMAC Multicast Match Handling

Jeremy Kerr (4):
      powerpc/spufs: avoid magic numbers for mapping sizes
      powerpc/spufs: allow spufs files to specify sizes
      powerpc/spufs: add sizes for context files
      powerpc/spufs: only add ".ctx" file with "debug" mount option

Luke Browning (2):
      powerpc/spufs: provide context debug file
      powerpc/spufs: don't extend time time slice if context is not in spu_run

Mark Nelson (4):
      powerpc/dma: Add struct iommu_table argument to iommu_map_sg()
      powerpc/dma: implement new dma_*map*_attrs() interfaces
      powerpc/cell: cell_dma_dev_setup_iommu() return the iommu table
      powerpc: move device_to_mask() to dma-mapping.h

Maxim Shchetynin (1):
      powerpc/spufs: add atomic busy_spus counter to struct cbe_spu_info

Michael Neuling (2):
      powerpc: fix swapcontext backwards compat. with VSX ucontext changes
      powerpc: remove unused variable in emulate_fp_pair

Mike Mason (1):
      powerpc/eeh: PERR/SERR bit settings during EEH device recovery

Paul Gortmaker (1):
      powerpc/ibmebus: more meaningful variable name

Srinivasa Ds (1):
      powerpc: Implement task_pt_regs() accessor
