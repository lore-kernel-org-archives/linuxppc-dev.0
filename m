Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94B141A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 15:00:02 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3810B140D93
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 15:00:02 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 8 Oct 2015 14:00:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EEDAF357805C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2015 14:59:57 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t983xbOu721210
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:46 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t983xOGc022642
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2015 14:59:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v2 0/8] EEH Improvement and Cleanup
Date: Thu,  8 Oct 2015 14:58:51 +1100
Message-Id: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PATCH[1] of this series skips unfreezing PHB PE after reset during
recovery because that's unnecessary. PATCH[2] makes the hotplug criterion
more realistic by validating all required error handlers. PATCH[3] fixes
the issue that reset isn't issued when the error handler (error_detected())
of device driver doesn't expect reset during recovery, leading to the error
can't be recovered. PATCH[4] fixes the issue of enabling IO path that has
been enabled on pSeries platform. PATCH[5-8] cleans up eeh_pseries.c and
eeh-powernv.c without introducing logical changes.

Gavin Shan (8):
  powerpc/eeh: Don't unfreeze PHB PE after reset
  powerpc/eeh: More relexed hotplug criterion
  powerpc/eeh: Force reset on fenced PHB
  powerpc/eeh: More relxed condition for enabled IO path
  powerpc/pseries: Cleanup on pseries_eeh_get_state()
  powerpc/powernv: Cleanup on EEH comments
  powerpc/powernv: Remove pnv_eeh_cap_start()
  powerpc/powernv: Simplify pnv_eeh_set_option()

 arch/powerpc/kernel/eeh.c                    |  2 +-
 arch/powerpc/kernel/eeh_driver.c             | 27 +++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 83 +++++++++++-----------------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 60 +++++++++-----------
 4 files changed, 81 insertions(+), 91 deletions(-)

-- 
2.1.0
