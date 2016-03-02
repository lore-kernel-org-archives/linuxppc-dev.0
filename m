Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0B4A1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:29:55 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 12:29:54 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5BA1C2BB005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 13:29:51 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u222TgEA24182880
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:29:51 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u222TIUV004213
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 13:29:18 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] powerpc/eeh: Enhancement to EEH for VF
Date: Wed,  2 Mar 2016 13:28:49 +1100
Message-Id: <1456885732-23070-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Those patches are based on the series of patches supporting EEH for VF,
which is pending for merging: https://patchwork.ozlabs.org/patch/581315/

This series of patches fixes couple of issue that resides in previous
patchset:

   * The error handlers provided by vfio-pci driver shouldn't be called.
     Otherwise, the guest is simply killed.
   * When we have partially hoplug in error recovery, we shouldn't remove
     those passed-through devices. Otherwise, the guest will be brought
     to undefined situation.
   * When we have errors detected on PF PE, hold VF PE that has been passed
     through to guest until the recovery on PF PE is done

Changelog
=========
v2:
   * Add Russell's comments to eeh_pe_get_state().

Gavin Shan (3):
  powerpc/eeh: Don't propagate error to guest
  powerpc/eeh: Don't remove passed VFs
  powerpc/eeh: Synchronize recovery in host/guest

 arch/powerpc/kernel/eeh.c        | 11 +++++++++++
 arch/powerpc/kernel/eeh_driver.c | 13 ++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.1.0
