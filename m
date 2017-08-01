Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMFK56TfLzDrMP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 22:01:13 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u185so2401621pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Aug 2017 05:01:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] powerpc: improve accounting of non maskable interrupts
Date: Tue,  1 Aug 2017 22:00:50 +1000
Message-Id: <20170801120054.3447-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the same as the last patch, but broken out and in the
process of making ifdefs nicer, also found and fixed a watchdog
build bug in patch 2.

Patches 1-2 are fixes that should go to 4.13.
Patches 3-4 are probably simple enough they could also go to 4.13.

Nicholas Piggin (4):
  powerpc/64s: fix mce accounting for powernv
  powerpc: fix powerpc-specific watchdog build configuration
  powerpc: add irq accounting for system reset interrupts
  powerpc: add irq accounting for watchdog interrupts

 arch/powerpc/Kconfig                 | 11 +++++++++++
 arch/powerpc/include/asm/hardirq.h   |  4 ++++
 arch/powerpc/kernel/Makefile         |  2 +-
 arch/powerpc/kernel/exceptions-64s.S |  6 +++---
 arch/powerpc/kernel/irq.c            | 16 ++++++++++++++++
 arch/powerpc/kernel/traps.c          |  9 +++++++++
 arch/powerpc/kernel/watchdog.c       |  3 +++
 7 files changed, 47 insertions(+), 4 deletions(-)

-- 
2.11.0
