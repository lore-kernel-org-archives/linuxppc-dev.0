Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2ACAA1A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 11:25:36 +1000 (AEST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7539C140285
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2015 11:25:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 5 Aug 2015 06:55:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2A87EE006D
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2015 06:59:42 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t751PMrK52429002
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2015 06:55:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t751PN1Q016973
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2015 06:55:23 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: aik@ozlabs.ru, gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V2 0/6] Redesign SR-IOV on PowerNV
Date: Wed,  5 Aug 2015 09:24:57 +0800
Message-Id: <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20150731020148.GA6151@richard>
References: <20150731020148.GA6151@richard>
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
  powerpc/powernv: don't enable SRIOV when VF BAR contains non M64 BAR
  powerpc/powernv: simplify the calculation of iov resource
  powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
  powerpc/powernv: replace the hard coded boundary with gate
  powerpc/powernv: boundary the total vf bar size instead of the
    individual one
  powerpc/powernv: allocate discrete PE# when using M64 BAR in Single
    PE mode

 arch/powerpc/include/asm/pci-bridge.h     |    7 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  311 +++++++++++++++--------------
 2 files changed, 163 insertions(+), 155 deletions(-)

-- 
1.7.9.5
