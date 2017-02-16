Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPMrF3q4hzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:01:33 +1100 (AEDT)
Received: by mail-pg0-x22a.google.com with SMTP id v184so7667321pgv.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 09:01:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC[PATCH 0/4] POWER9 machine check handler
Date: Fri, 17 Feb 2017 03:01:10 +1000
Message-Id: <20170216170114.25247-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So far I've only got this tested in mambo simulator, but
some recoverable and unrecoverable events seem to work.

Thanks,
Nick

Nicholas Piggin (4):
  powerpc: machine check allow handler to set severity and initiator
  powerpc/powernv: machine check rework recovery flushing
  powerpc/powernv: cope with non-synchronous machine checks
  powerpc/powernv: handle POWER9 machine checks

 arch/powerpc/include/asm/bitops.h     |   4 +
 arch/powerpc/include/asm/mce.h        | 108 +++++++++++-
 arch/powerpc/kernel/cputable.c        |   3 +
 arch/powerpc/kernel/mce.c             |  90 +++++++++-
 arch/powerpc/kernel/mce_power.c       | 324 +++++++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/opal.c |  19 +-
 6 files changed, 465 insertions(+), 83 deletions(-)

-- 
2.11.0
