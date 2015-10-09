Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1202A1A0297
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 13:47:48 +1100 (AEDT)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 55DBD140DA8
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 13:47:47 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 08:17:44 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0E7673940060
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 08:17:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t992ld6J58327182
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 08:17:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t992lcnP012594
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 08:17:39 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V5 0/6] Redesign SR-IOV on PowerNV
Date: Fri,  9 Oct 2015 10:46:50 +0800
Message-Id: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
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
   * add some reason in change log of Patch 1
   * make the pnv_pci_iov_resource_alignment() more easy to read
   * initialize pe_num_map[] just after it is allocated
   * test ssh from guest to host via VF passed and then shutdown the guest
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 329 ++++++++++++++++--------------
 2 files changed, 175 insertions(+), 161 deletions(-)

-- 
2.5.0
