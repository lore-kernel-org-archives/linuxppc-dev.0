Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3rvV22VlzDsQM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Dec 2017 03:49:41 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id s10so14580329plj.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 08:49:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/2] sreset driven panic/oops message printing fixes
Date: Sun, 24 Dec 2017 02:49:21 +1000
Message-Id: <20171223164923.10587-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's a couple of fixes that should go into 4.15 and possibly
stable kernels as well. Most of the time when you hit the system
reset button, either you're a developer with xmon enabled or
customer with a crash dumper enabled. But if neither is the case,
then the result is currently pretty useless. After these patches
we get nice oops trace on each CPU.

Nicholas Piggin (2):
  powerpc: System reset avoid interleaving oops using die
    synchronisation
  powerpc/pseries,ps3: panic flush kernel messages before halting system

 arch/powerpc/include/asm/bug.h         |  3 ++-
 arch/powerpc/kernel/traps.c            | 26 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/opal.c  | 18 ++++--------------
 arch/powerpc/platforms/ps3/setup.c     |  1 +
 arch/powerpc/platforms/pseries/setup.c |  8 +++++++-
 5 files changed, 39 insertions(+), 17 deletions(-)

-- 
2.15.0
