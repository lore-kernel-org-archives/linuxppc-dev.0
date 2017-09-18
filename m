Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwfJ84v1wzDrT1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 18:27:20 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id v5so4896379pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 01:27:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/5] More NMI IPI enablement work
Date: Mon, 18 Sep 2017 18:27:01 +1000
Message-Id: <20170918082706.6485-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Here is the NMI IPI enablement for powernv, which requires
supported firmware and hardware:

https://lists.ozlabs.org/pipermail/skiboot/2017-September/009111.html

And some preceeding patches that fix issues I ran into when
testing it.

Thanks,
Nick

Nicholas Piggin (5):
  powerpc/watchdog: do not panic from locked CPU's IPI handler
  powerpc/watchdog: do not backtrace locked CPUs twice if allcpus
    backtrace is enabled
  powerpc/watchdog: do not trigger SMP crash from touch_nmi_watchdog
  powerpc/xmon: avoid tripping SMP hardlockup watchdog
  powerpc/powernv: implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET

 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 ++
 arch/powerpc/kernel/irq.c                      | 43 +++++++++++++++++++---
 arch/powerpc/kernel/watchdog.c                 | 29 ++++++++-------
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/powernv.h       |  1 +
 arch/powerpc/platforms/powernv/setup.c         |  3 ++
 arch/powerpc/platforms/powernv/smp.c           | 50 ++++++++++++++++++++++++++
 arch/powerpc/xmon/xmon.c                       | 17 ++++++---
 9 files changed, 127 insertions(+), 20 deletions(-)

-- 
2.13.3
