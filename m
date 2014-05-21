Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB5B51A0822
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:44 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 21 May 2014 16:32:42 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 79E303578055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L6WOB06947282
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:25 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L6WdCa015759
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:32:39 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: benh@au1.ibm.com
Subject: [PATCH 0/3] powerpc: fix regression of per-CPU DSCR setting
Date: Wed, 21 May 2014 16:32:36 +1000
Message-Id: <cover.1400652868.git.sam.bobroff@au1.ibm.com>
Cc: aik@ozlabs.ru, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This patch corrects a regression on PowerPC CPUs that causes their
per-CPU DSCR SPR value (exposed via /sys/devices/system/cpuN/dscr) to
be quickly lost during context switching, effectively meaning that the
DSCR can no longer be set on a per-CPU basis.

My intent is to restore the functionality of the per-CPU value in a
way that is compatible with the newer global default and task-specific
DSCR setting system.  Users of either the old or new systems should
now get pretty much what they expect.

A couple of notes:

I've split an existing "ifdef CONFIG_PPC_STD_MMU_64" block in
paca_struct into two parts because it allows dscr_default to be placed
into a cache line hole. (This seems be the case even without
CONFIG_PPC_STD_MMU_64 being defined.) Comments or ideas on alternative
placements are welcome.

PowerPC context switching is touched but there should not be any
performance cost; if anything it should get slightly faster due to the
per-CPU value being easier to access than the old global default.

Sam Bobroff (3):
  powerpc: Split __SYSFS_SPRSETUP macro
  powerpc: fix regression of per-CPU DSCR setting
  powerpc: Document sysfs DSCR interface

 Documentation/ABI/stable/sysfs-devices-system-cpu |   25 ++++++++++
 arch/powerpc/include/asm/paca.h                   |    3 ++
 arch/powerpc/kernel/asm-offsets.c                 |    1 +
 arch/powerpc/kernel/entry_64.S                    |    9 +---
 arch/powerpc/kernel/sysfs.c                       |   51 +++++++++++++--------
 arch/powerpc/kernel/tm.S                          |   16 ++-----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S           |    3 +-
 7 files changed, 67 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-devices-system-cpu

-- 
1.7.10.4
