Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40DWxB2RsLzF20w
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Apr 2018 20:36:29 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id 60-v6so559938plc.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Apr 2018 03:36:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: [PATCH 0/3] stop secondaries for reboot/shutdown
Date: Sun,  1 Apr 2018 20:36:12 +1000
Message-Id: <20180401103615.15454-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm rebasing and resending this series because the hard
lockup messages are being seen in the field.

Since last time, one of the patches was merged, and patches
were split and reordered a bit. No major changes.

This still hasn't been tested with the FSP firmware update.

Thanks,
Nick

Nicholas Piggin (3):
  powerpc: use NMI IPI for smp_send_stop
  powerpc: hard disable irqs in smp_send_stop loop
  powerpc/powernv: Always stop secondaries before reboot/shutdown

 arch/powerpc/include/asm/opal.h             |  2 +-
 arch/powerpc/kernel/smp.c                   | 13 +++++++++++--
 arch/powerpc/platforms/powernv/opal-flash.c | 28 +---------------------------
 arch/powerpc/platforms/powernv/setup.c      | 15 +++++----------
 4 files changed, 18 insertions(+), 40 deletions(-)

-- 
2.16.3
