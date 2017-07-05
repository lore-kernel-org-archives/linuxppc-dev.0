Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2RrT6XfczDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 13:56:41 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c24so18424084pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 20:56:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 0/3] sreset debugging improvements
Date: Wed,  5 Jul 2017 13:56:24 +1000
Message-Id: <20170705035627.19563-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:
- Fixed bug in the fadump patch noticed by Mahesh.
- Removed ppc_md.panic completely.

Nicholas Piggin (3):
  powerpc: do not call ppc_md.panic in fadump panic notifier
  powerpc/pseries/le: work around a firmware quirk
  powerpc: do not send system reset request through the oops path

 arch/powerpc/include/asm/machdep.h     |  1 -
 arch/powerpc/include/asm/setup.h       |  1 -
 arch/powerpc/kernel/fadump.c           | 22 ++++++++++++++++
 arch/powerpc/kernel/setup-common.c     | 27 -------------------
 arch/powerpc/kernel/traps.c            | 47 ++++++++++++++++++++++------------
 arch/powerpc/platforms/ps3/setup.c     | 15 -----------
 arch/powerpc/platforms/pseries/ras.c   | 15 +++++++++++
 arch/powerpc/platforms/pseries/setup.c |  1 -
 8 files changed, 68 insertions(+), 61 deletions(-)

-- 
2.11.0
