Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89A0D1A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:46 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 10:15:46 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 11C37357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H0FXB748168960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:42 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H0F8FR001569
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:15:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc/powernv: Avoid compound PE for VF
Date: Fri, 17 Jul 2015 10:14:41 +1000
Message-Id: <1437092083-20672-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the VF BAR size is equal to 128MB or bigger than that, the IOV BAR
is extended to cover number of maximal VFs supported by the PF, not 256.
Also, one PHB's M64 BAR is picked to cover VF BARs for 4 continous VFs,
but the PHB's M64 BAR is configured as being owned by single PE. Eventually,
those 4 VFs have 4 separate PEs from the perspective of PCI config or DMA,
but single shared PE from MMIO's perspective. Once we have compound PE, all
those 4 VFs included in the compound PE can't be passed to separate guests
with VFIO infrastructure.

The above gate (128MB) was choosen based on the assumption: one IOV BAR can
consume 1/4 of PHB's M64 window, which is 16GB. However, it can consume as
much as half of that (32GB) when the PF seats behind the root port. Accordingly,
the gate can be doubled to be 256MB in order to avoid compound PE as we can.


Gavin Shan (2):
  powerpc/powernv: Fix alignment for IOV BAR
  powerpc/powernv: Double VF BAR size for compound PE

 arch/powerpc/platforms/powernv/pci-ioda.c | 56 +++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 11 deletions(-)

-- 
2.1.0
