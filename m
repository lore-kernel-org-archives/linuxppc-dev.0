Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC7Dx14BYzDrTq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 16:59:29 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o88so5435522pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 23:59:28 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH v2 0/3] machine check handling improvements
Date: Wed, 19 Jul 2017 16:59:09 +1000
Message-Id: <20170719065912.19183-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a few patches to improve machine check reporting
and recovery.

Since last time:

- improved patch 1 according to review comments:
  https://patchwork.ozlabs.org/patch/785240/

- In patch 3 be a bit smarter about when to use die() and
  when to go straight to firmware reboot.

Nicholas Piggin (3):
  powerpc/powernv: handle the platform error reboot in ppc_md.restart
  powerpc/powernv: machine check use kernel crash path
  powerpc: machine check interrupt is a non-maskable interrupt

 arch/powerpc/include/asm/bug.h            |   1 +
 arch/powerpc/include/asm/fadump.h         |   2 +
 arch/powerpc/include/asm/opal.h           |   2 +-
 arch/powerpc/kernel/fadump.c              |   9 ++-
 arch/powerpc/kernel/traps.c               |  31 +++++++-
 arch/powerpc/platforms/powernv/opal-hmi.c |  22 +-----
 arch/powerpc/platforms/powernv/opal.c     | 121 +++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/powernv.h  |   2 +
 8 files changed, 122 insertions(+), 68 deletions(-)

-- 
2.11.0
