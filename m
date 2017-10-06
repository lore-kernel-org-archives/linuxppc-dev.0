Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7fPl2MH4zDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 17:10:18 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id o1so16113072pga.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 23:10:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] some boot/shutdown improvements
Date: Fri,  6 Oct 2017 16:10:02 +1000
Message-Id: <20171006061005.29891-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These are a couple of improvements to powernv/opal boot and
shutdown paths. Also a patch to move smp_send_stop over to
use NMI IPIs, which gives us a significantly better chance to
stop secondaries on platforms which support it (pSeries and
PowerNV POWER9 so far).

Patch 1 in particular it would be good if people could take
a look at. I *think* it's okay wrt kexec, but I could miss
something or some old firmware might do the wrong thing.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc/powernv: Avoid the secondary hold spinloop for OPAL boot
  powerpc/powernv: Always stop secondaries before reboot/shutdown
  powerpc: use NMI IPI for smp_send_stop

 arch/powerpc/include/asm/opal.h             |  2 +-
 arch/powerpc/kernel/head_64.S               |  4 +++-
 arch/powerpc/kernel/setup_64.c              | 14 ++++++++++++--
 arch/powerpc/kernel/smp.c                   |  9 +++++----
 arch/powerpc/platforms/powernv/opal-flash.c | 28 +---------------------------
 arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
 6 files changed, 27 insertions(+), 45 deletions(-)

-- 
2.13.3
