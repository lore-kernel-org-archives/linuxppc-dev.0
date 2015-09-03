Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D55C1A1E3D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 11:30:11 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 3 Sep 2015 07:00:06 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 34B71E0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 06:59:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t831U0Nd35127424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 07:00:00 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t831Txeg009234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Sep 2015 06:59:59 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, mpe@ellerman.id.au,
 benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 0/6] Redesign SR-IOV on PowerNV
Date: Thu,  3 Sep 2015 09:29:46 +0800
Message-Id: <1441243792-2074-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In original design, it tries to group VFs to enable more number of VFs in the
system, when VF BAR is bigger than 64MB. This design has a flaw in which one
error on a VF will interfere other VFs in the same group.

This patch series change this design by using M64 BAR in Single PE mode to
cover only one VF BAR. By doing so, it gives absolute isolation between VFs.

v5:
   * rebase on top of v4.2, with commit 68230242cdb "net/mlx4_core: Add port
     attribute when tracking counters" reverted
   * test ssh from guest to host via VF passed and then shutdown the guest
   * no code change
v4:
   * rebase the code on top of v4.2-rc7
   * switch back to use the dynamic version of pe_num_map and m64_map
   * split the memory allocation and PE assignment of pe_num_map to make it
     more easy to read
   * check pe_num_map value before free PE.
   * add the rename reason for pe_num_map and m64_map in change log
v3:
   * return -ENOSPC when a VF has non-64bit prefetchable BAR
   * rename offset to pe_num_map and define it staticly
   * change commit log based on comments
   * define m64_map staticly
v2:
   * clean up iov bar alignment calculation
   * change m64s to m64_bars
   * add a field to represent M64 Single PE mode will be used
   * change m64_wins to m64_map
   * calculate the gate instead of hard coded
   * dynamically allocate m64_map
   * dynamically allocate PE#
   * add a case to calculate iov bar alignment when M64 Single PE is used
   * when M64 Single PE is used, compare num_vfs with M64 BAR available number 
     in system at first

Wei Yang (6):
  powerpc/powernv: don't enable SRIOV when VF BAR has non
    64bit-prefetchable BAR
  powerpc/powernv: simplify the calculation of iov resource alignment
  powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
  powerpc/powernv: replace the hard coded boundary with gate
  powerpc/powernv: boundary the total VF BAR size instead of the
    individual one
  powerpc/powernv: allocate sparse PE# when using M64 BAR in Single PE
    mode

 arch/powerpc/include/asm/pci-bridge.h     |   7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 328 ++++++++++++++++--------------
 2 files changed, 175 insertions(+), 160 deletions(-)

-- 
2.5.0
