Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HB04yJPzDsPN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:00 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id y192so117375pgd.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:29:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/6] More NMI IPI enablement work
Date: Fri, 29 Sep 2017 13:29:36 +1000
Message-Id: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last post, the first 4 patches are unchanged.

Split the last patch into 2, tidied up a few things, and removed
the DD1 workarounds because firmware is not going to support DD1.

Then re-tested with upstream firmware which has now merged support
for OPAL_SIGNAL_SYSTEM_RESET on POWER9 DD2.


Nicholas Piggin (6):
  powerpc/watchdog: do not panic from locked CPU's IPI handler
  powerpc/watchdog: do not backtrace locked CPUs twice if allcpus
    backtrace is enabled
  powerpc/watchdog: do not trigger SMP crash from touch_nmi_watchdog
  powerpc/xmon: avoid tripping SMP hardlockup watchdog
  powerpc/64s: Implement system reset idle wakeup reason
  powerpc/powernv: implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET

 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/kernel/irq.c                      | 41 ++++++++++++++++++--
 arch/powerpc/kernel/watchdog.c                 | 29 ++++++++------
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/setup.c         |  1 +
 arch/powerpc/platforms/powernv/smp.c           | 52 ++++++++++++++++++++++++++
 arch/powerpc/xmon/xmon.c                       | 17 +++++++--
 8 files changed, 125 insertions(+), 19 deletions(-)

-- 
2.13.3
