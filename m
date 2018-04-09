Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KJdl1PpmzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:24:42 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c78so5212684pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:24:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/9] first step of standardising OPAL_BUSY handling 
Date: Mon,  9 Apr 2018 15:24:22 +1000
Message-Id: <20180409052431.26405-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since v1:
- Added console and opal-kmsg
- Fix a missing case in opal_shutdown that would delay even if
  OPAL_SUCCESS was returned.

Thanks,
Nick

Nicholas Piggin (9):
  powerpc/powernv: define a standard delay for OPAL_BUSY type retry
    loops
  powerpc/powernv: OPAL RTC driver standardise OPAL_BUSY loops
  powerpc/powernv: opal_put_chars partial write fix
  powerpc/powernv: OPAL console standardise OPAL_BUSY loops
  powerpc/powernv: OPAL platform standardise OPAL_BUSY loops
  powerpc/powernv: OPAL NVRAM driver standardise OPAL_BUSY delays
  powerpc/powernv: OPAL dump support standardise OPAL_BUSY delays
  powerpc/xive: standardise OPAL_BUSY delays
  powerpc/powernv: opal-kmsg standardise OPAL_BUSY handling

 arch/powerpc/include/asm/opal.h             |   3 +
 arch/powerpc/platforms/powernv/opal-dump.c  |   6 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c  |  24 ++-
 arch/powerpc/platforms/powernv/opal-nvram.c |   7 +-
 arch/powerpc/platforms/powernv/opal-rtc.c   |   6 +-
 arch/powerpc/platforms/powernv/opal.c       |  46 +++--
 arch/powerpc/platforms/powernv/setup.c      |  16 +-
 arch/powerpc/sysdev/xive/native.c           | 193 +++++++++++---------
 drivers/rtc/rtc-opal.c                      |  33 ++--
 9 files changed, 203 insertions(+), 131 deletions(-)

-- 
2.17.0
