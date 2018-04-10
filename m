Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L58N5c6hzDqyW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 21:50:28 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c78so8084931pfj.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 04:50:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] Fix RTC and NVRAM OPAL_BUSY loops
Date: Tue, 10 Apr 2018 21:49:30 +1000
Message-Id: <20180410114933.24581-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a couple of important fixes broken out of the series
"first step of standardising OPAL_BUSY handling", that prevents
the kernel from locking up if the NVRAM or RTC hardware does not
respond.

Another one, the console driver, has a similar problem that has
also been hit in testing, but that requires larger fixes to the
opal console and hvc tty driver that won't make it for 4.17.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/powernv: define a standard delay for OPAL_BUSY type retry
    loops
  powerpc/powernv: Fix OPAL RTC driver OPAL_BUSY loops
  powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops

 arch/powerpc/include/asm/opal.h             |  3 ++
 arch/powerpc/platforms/powernv/opal-nvram.c |  7 +++-
 arch/powerpc/platforms/powernv/opal-rtc.c   |  8 +++--
 drivers/rtc/rtc-opal.c                      | 37 +++++++++++++--------
 4 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.17.0
