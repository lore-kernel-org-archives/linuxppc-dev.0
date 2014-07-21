Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93B8F1A036C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:43:08 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 21 Jul 2014 14:43:07 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5E2292BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6L4Ji5t4522276
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:19:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6L4gWlt011921
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 14:42:33 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/6] Support M64 Window
Date: Mon, 21 Jul 2014 14:42:29 +1000
Message-Id: <1405917755-28830-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: yan@linux.vnet.ibm.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This version is rebased on top of Gavin's patches of EEH support for guest and
related fixes which are supposed to be merged in 3.17.

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

Changelog
=========
v2 -> v3:
	* Use separate OPAL API to freeze PE.
v1 -> v2:
	* Avoid overwritting PE flags.
	* Don't return segment alignment if M64 is not supported.
	* Output M64 total size and segment size together with M32 and IO

Gavin Shan (5):
  powerpc/powernv: Allow to freeze PE
  powerpc/powernv: Split ioda_eeh_get_state()
  powerpc/powernv: Handle compound PE
  powerpc/powernv: Handle compound PE for EEH
  powerpc/powernv: Handle compound PE in config accessors

Guo Chao (1):
  powerpc/powernv: Enable M64 aperatus for PHB3

 arch/powerpc/include/asm/opal.h                |  17 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c      | 291 +++++++++-------
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      | 444 +++++++++++++++++++++++--
 arch/powerpc/platforms/powernv/pci.c           |  87 +++--
 arch/powerpc/platforms/powernv/pci.h           |  23 ++
 6 files changed, 694 insertions(+), 169 deletions(-)

-- 
1.8.3.2
