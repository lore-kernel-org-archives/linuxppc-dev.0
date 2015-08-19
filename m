Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E93E1A04EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2015 12:01:54 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E287140327
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 12:01:53 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 19 Aug 2015 07:31:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 46992394005B
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 07:31:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7J21lBK47120616
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 07:31:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7J21kGf027265
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2015 07:31:47 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V4 0/6] Redesign SR-IOV on PowerNV
Date: Wed, 19 Aug 2015 10:01:38 +0800
Message-Id: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

 arch/powerpc/include/asm/pci-bridge.h     |    7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  328 +++++++++++++++--------------
 2 files changed, 175 insertions(+), 160 deletions(-)

-- 
1.7.9.5
