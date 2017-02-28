Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXMHj65KXzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 13:01:05 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id s67so2874706pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 18:01:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 0/3 v2] MCE handler for POWER9
Date: Tue, 28 Feb 2017 12:00:45 +1000
Message-Id: <20170228020048.8862-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a minimal implementation of the POWER9 MCE handler that
should be suitable for backport if necessary.

Moving this to firmware may be the right long term solution, but
we need a P9 Linux handler for existing kernels and firmwares.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/64s: fix handling of non-synchronous machine checks
  powerpc/64s: allow machine check handler to set severity and initiator
  powerpc/64s: POWER9 machine check handler

 arch/powerpc/include/asm/bitops.h     |   4 +
 arch/powerpc/include/asm/mce.h        | 108 +++++++++++++++-
 arch/powerpc/kernel/cputable.c        |   3 +
 arch/powerpc/kernel/mce.c             |  88 ++++++++++++-
 arch/powerpc/kernel/mce_power.c       | 237 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal.c |  21 +--
 6 files changed, 443 insertions(+), 18 deletions(-)

-- 
2.11.0
