Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GwdC5DjZzF1pk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 18:15:58 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id u11-v6so18115773plq.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 01:15:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH 0/6] first step of standardising OPAL_BUSY handling
Date: Thu,  5 Apr 2018 18:15:41 +1000
Message-Id: <20180405081547.13266-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch 1 explains most of the reasoning.
Patch 1+2 and possibly 4 (just that we've seen a bug caused by the
RTC driver but not yet one caused by NVRAM) could be backported as
bugfixes, in most other cases the changes are inconsequential or
unlikely to be a problem.

Thanks,
Nick

Nicholas Piggin (6):
  powerpc/powernv: define a standard delay for OPAL_BUSY type retry
    loops
  powerpc/powernv: OPAL RTC driver standardise OPAL_BUSY loops
  powerpc/powernv: OPAL platform standardise OPAL_BUSY loops
  powerpc/powernv: OPAL NVRAM driver standardise OPAL_BUSY delays
  powerpc/powernv: OPAL dump support standardise OPAL_BUSY delays
  powerpc/xive: standardise OPAL_BUSY delays

 arch/powerpc/include/asm/opal.h             |   3 +
 arch/powerpc/platforms/powernv/opal-dump.c  |   4 +-
 arch/powerpc/platforms/powernv/opal-nvram.c |   7 +-
 arch/powerpc/platforms/powernv/opal-rtc.c   |   6 +-
 arch/powerpc/platforms/powernv/opal.c       |   8 +-
 arch/powerpc/platforms/powernv/setup.c      |  16 ++-
 arch/powerpc/sysdev/xive/native.c           | 193 ++++++++++++++++------------
 drivers/rtc/rtc-opal.c                      |  33 +++--
 8 files changed, 163 insertions(+), 107 deletions(-)

-- 
2.16.3
