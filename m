Return-Path: <yan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D7F51A0179
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:54:06 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <yan@linux.vnet.ibm.com>;
 Thu, 10 Jul 2014 23:54:01 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2F25B3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:54:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6ADVNa566519110
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:31:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6ADrwJa032267
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:53:59 +1000
From: Guo Chao <yan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] powerpc/powernv: Support M64 window
Date: Thu, 10 Jul 2014 21:53:40 +0800
Message-Id: <1405000426-1016-1-git-send-email-yan@linux.vnet.ibm.com>
Cc: Guo Chao <yan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, all MMIO resources, including 64-bits MMIO resources are hooked
to PHB 32-bits MMIO BAR, which has limited space. If there're PCI devices
with large 64-bits MMIO BAR (could reach 1GB), we're running out of MMIO
resources (as well as PE numbers) quickly. The patchset reuses the M32
infrastructure to support M64:

   * The last M64 BAR covers all M64 aperatus and that's shared by all PEs.
   * Reuse ppc_md.pcibios_window_alignment() to affect resource assignment
     in PCI core so that we can get well segmented 64-bits window of PCI
     bridges.
   * One PCI bus might require multiple discrete M64 segment. We invent
     if we're going to unfreeze any one in the group.

The patchset requires corresponding changes from firmware. And we don't
support M64 for P7 yet. That's something to do in future.

Gavin Shan (5):
  powerpc/powernv: Allows to freeze PE
  powerpc/powernv: Split ioda_eeh_get_state()
  powerpc/powernv: handle compound PE
  powerpc/powernv: Handle compound PE for EEH
  powerpc/powernv: Handle compound PE in config accessors

Guo Chao (1):
  powerpc/powernv: Enable M64 aperatus for PHB3

 arch/powerpc/include/asm/opal.h                |  17 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 293 ++++++++++-------
 arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c      | 432 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c           |  87 +++--
 arch/powerpc/platforms/powernv/pci.h           |  23 ++
 6 files changed, 685 insertions(+), 169 deletions(-)

-- 
1.8.3.1
