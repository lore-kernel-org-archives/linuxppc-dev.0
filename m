Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 53DE81A0418
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:08:00 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 17:07:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 365ED2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:07:57 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s916hdk88126842
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 16:43:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9177tJt004708
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 17:07:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/6] powerpc/eeh: Refactor config accessors
Date: Wed,  1 Oct 2014 17:07:48 +1000
Message-Id: <1412147274-28770-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When EEH errors are detected on some particular PCI adapters, one of
which is shown as follows, the PCI config space of thoese PCI adapters
(PE) should be blocked. Otherwise, we will run into fenced PHB when
collecting EEH logs (part of recovery). The patchset fixes this issue.
Also, EEH_PE_RESET is replaced with EEH_PE_CFG_BLOCKED to indicate its
usage. It's bad idea to allow PCI config access even EEH_PE_CFG_BLOCKED
flag is set for the corresponding PE because it potentially triggers
recursive EEH error. The patchset also blocks config request from EEH
backend if necessary.

Gavin Shan (6):
  powerpc/eeh: Fix condition for isolated state
  powerpc/eeh: Rename flag EEH_PE_RESET to EEH_PE_CFG_BLOCKED
  powerpc/powernv: Drop config requests in EEH accessors
  powerpc/pseries: Drop config requests in EEH accessors
  powerpc/eeh: Block PCI config access upon frozen PE
  powerpc/eeh: Don't collect logs on PE with blocked config space

 arch/powerpc/include/asm/eeh.h               |  3 +-
 arch/powerpc/kernel/eeh.c                    | 19 +++++++---
 arch/powerpc/kernel/eeh_driver.c             | 12 +++---
 arch/powerpc/kernel/eeh_pe.c                 | 10 ++++-
 arch/powerpc/kernel/rtas_pci.c               | 30 ++++++---------
 arch/powerpc/platforms/powernv/eeh-ioda.c    |  2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 56 +++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c         |  2 +-
 8 files changed, 97 insertions(+), 37 deletions(-)

-- 
1.8.3.2
