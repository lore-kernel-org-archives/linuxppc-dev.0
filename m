Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KK0g6GYPzDqfk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Apr 2018 15:41:07 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so4495192plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Apr 2018 22:41:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/6] improve OPAL cosole flushing and locking
Date: Mon,  9 Apr 2018 15:40:50 +1000
Message-Id: <20180409054056.27292-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series of patches aims to improve the robustness of the OPAL
console by simplifying and removing locks. If this code is interrupted
due to a panic or xmon request, it may block the xmon IO or panic
console flush because they use the opal console too.

So reducing locking and relaxing atomicity requirements is important
for improving kernel debugging.

Nicholas Piggin (6):
  powerpc/powernv: opal-kmsg use flush fallback from console code
  powerpc/powernv: Implement and use opal_flush_console
  powerpc/powernv: Remove OPALv1 support from opal console driver
  powerpc/powernv: move opal console flushing to udbg
  powerpc/powernv: implement opal_put_chars_nonatomic
  drivers/tty/hvc: remove unexplained "just in case" spin delay

 arch/powerpc/include/asm/opal.h            |   2 +
 arch/powerpc/platforms/powernv/opal-kmsg.c |  38 +-----
 arch/powerpc/platforms/powernv/opal.c      | 141 ++++++++++++++-------
 drivers/tty/hvc/hvc_opal.c                 |  17 ++-
 4 files changed, 106 insertions(+), 92 deletions(-)

-- 
2.17.0
