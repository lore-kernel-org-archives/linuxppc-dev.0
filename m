Return-Path: <srs0=m9cn=as=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvwXk6C0dzDrnq
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xvwXk3sngz8v8G
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 14:05:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xvwXj0qhMz9sRm
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 14:05:40 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8H44ZN6014090
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:38 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d0vwg4kme-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Sep 2017 00:05:38 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 16 Sep 2017 22:05:38 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] powerpc/vas: cleanup and optimizations
Date: Sat, 16 Sep 2017 21:05:18 -0700
Message-Id: <1505621128-23877-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sanitize cpu/chip id to VAS id mapping, improve vas_win_close()
performance and add a check for return of credits.

Also, fix up couple of initializations/error checks and cleanup
some comments and debug code.

Sukadev Bhattiprolu (10):
  powerpc/vas: init missing fields from [rt]xattr
  powerpc/vas: Validate window credits
  powerpc/vas: Cleanup some debug code
  powerpc/vas: Drop poll_window_cast_out().
  powerpc/vas: Use helper to unpin/close window
  powerpc/vas: Reduce polling interval for busy state
  powerpc/vas: Save configured window credits
  powerpc/vas: poll for return of window credits
  powerpc/vas: Create cpu to vas id mapping
  powerpc/vas, nx-842: Define and use chip_to_vas_id()

 arch/powerpc/include/asm/vas.h              |   9 ++
 arch/powerpc/platforms/powernv/vas-window.c | 133 +++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/vas.c        |  25 +++++-
 arch/powerpc/platforms/powernv/vas.h        |  61 ++++---------
 drivers/crypto/nx/nx-842-powernv.c          |  18 +---
 5 files changed, 154 insertions(+), 92 deletions(-)

-- 
2.7.4
