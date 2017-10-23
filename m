Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL88b5fhXzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 19:05:19 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b85so16513089pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 01:05:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/3] avoid secondary hold spinloop when possible
Date: Mon, 23 Oct 2017 18:05:04 +1000
Message-Id: <20171023080507.21974-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've made this series only avoid the secondary spinloop on powernv.
pSeries is a little bit more complicated, some cases in kexec the
secondaries will be at 0x60. I haven't had time to get all that
sorted out for this merge window, so OPAL-only this time.

Nicholas Piggin (3):
  powerpc/powernv: Always stop secondaries before reboot/shutdown
  powerpc: use NMI IPI for smp_send_stop
  powerpc/powernv: Avoid waiting for secondary hold spinloop with OPAL

 arch/powerpc/include/asm/opal.h             |  2 +-
 arch/powerpc/kernel/head_64.S               | 16 +++++++++++-----
 arch/powerpc/kernel/setup_64.c              | 10 +++++++++-
 arch/powerpc/kernel/smp.c                   |  9 +++++----
 arch/powerpc/platforms/powernv/opal-flash.c | 28 +---------------------------
 arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
 6 files changed, 32 insertions(+), 48 deletions(-)

-- 
2.13.3
