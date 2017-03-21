Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnL6T5kLczDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:53:05 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 81so15257162pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 21:53:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC][PATCH 0/2] process interrupts from idle wakeup
Date: Tue, 21 Mar 2017 14:52:52 +1000
Message-Id: <20170321045254.21384-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Just wanted to get some opinions on this approach. I will wait until
current batch of idle fixes are merged before submitting properly,
and still need to test on POWER9, but on POWER8 the speedup is
quite good.

Thanks,
Nick

Nicholas Piggin (2):
  powerpc/powernv: process interrupts from system reset wakeup
  powerpc/64s: msgclr when handling doorbell exceptions

 arch/powerpc/include/asm/dbell.h      | 13 +++++++++++++
 arch/powerpc/include/asm/machdep.h    |  1 -
 arch/powerpc/include/asm/ppc-opcode.h |  3 +++
 arch/powerpc/include/asm/processor.h  |  1 +
 arch/powerpc/kernel/dbell.c           |  9 +++++++++
 arch/powerpc/platforms/powernv/idle.c | 11 ++++++++---
 drivers/cpuidle/cpuidle-powernv.c     | 35 +++++++++++++++++++++++++++++++++--
 7 files changed, 67 insertions(+), 6 deletions(-)

-- 
2.11.0
