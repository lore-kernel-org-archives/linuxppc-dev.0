Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nsgC5kj3zF0Pl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 14:36:06 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id u6-v6so5706835pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 21:36:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/3] further reduce warnings and watchdogs in crash/shutdown
 paths
Date: Sat, 19 May 2018 14:35:51 +1000
Message-Id: <20180519043554.26640-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patches 1 and 3 are more of the same, just upgrading local_irq_disable
to hard_irq_disable in places.

Patch 2 fixes a warning people have been hitting in crash testing on
busy systems.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/64: hard disable irqs in panic_smp_self_stop
  powerpc: smp_send_stop do not offline stopped CPUs
  powerpc/64: hard disable irqs on the panic()ing CPU

 arch/powerpc/kernel/setup-common.c | 12 ++++++++++--
 arch/powerpc/kernel/setup_64.c     |  8 ++++++++
 arch/powerpc/kernel/smp.c          |  6 ------
 3 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.17.0
