Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmlhY1YBJzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:02:05 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id g2so18063614pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Mar 2017 23:02:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: [PATCH 0/7][v3] idle fixes and changes for POWER8 and POWER9
Date: Mon, 20 Mar 2017 16:01:45 +1000
Message-Id: <20170320060152.1016-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:

- Commented machine check handler wakeup to describe why registers are
  not lost.
- Dropped patch to make PACA_THREAD_IDLE_STATE POWER8-only because
  Gautham will use it for POWER9 DD1.
- Removed some leftover debug cruft noticed by Gautham, and re-tested
  on POWER8. Added some extra comments to hopefully try to illustrate
  the idle state changes a bit better.
  
Needs:
- Ack from Gautham for patch 7
- Ack from Mahesh for patch 4

Thanks,
Nick

Nicholas Piggin (7):
  powerpc/64s: move remaining system reset idle code into idle_book3s.S
  powerpc/64s: stop using bit in HSPRG0 to test winkle
  powerpc/64s: use alternative feature patching
  powerpc/64s: fix POWER9 machine check handler from stop state
  powerpc/64s: idle expand core idle state bits
  powerpc/64s: idle do not hold reservation longer than required
  powerpc/64s: idle POWER8 avoid full state loss recovery where possible

 arch/powerpc/include/asm/cpuidle.h       |  32 ++++-
 arch/powerpc/include/asm/exception-64s.h |  13 +-
 arch/powerpc/include/asm/reg.h           |   1 +
 arch/powerpc/kernel/exceptions-64s.S     | 123 +++++++----------
 arch/powerpc/kernel/idle_book3s.S        | 227 ++++++++++++++++++++++---------
 arch/powerpc/platforms/powernv/idle.c    |  13 --
 6 files changed, 242 insertions(+), 167 deletions(-)

-- 
2.11.0
