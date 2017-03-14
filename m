Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8SM2ZBdzDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:03 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 77so23196292pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 0/8] idle fixes and changes for POWER8 and POWER9
Date: Tue, 14 Mar 2017 19:23:41 +1000
Message-Id: <20170314092349.10981-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a resend of the previous idle series, with the addition that
I accounted for Gautham's feedback, and also re-introduced the feature
to avoid full state restore by counting winkles rather than special
HSPRG0 bit.

The two big things we get from this, is no longer messing with HSPRG0
in the idle wakeup path on POWER8, and not crashing on POWER9 machine
check from power saving mode (tested in mambo according to ISA specs,
but have not triggered it on real hardware).

I only added the reviewed-by for patches which were not significantly
chaged since last time.

Thanks,
Nick

Nicholas Piggin (8):
  powerpc/64s: move remaining system reset idle code into idle_book3s.S
  powerpc/64s: stop using bit in HSPRG0 to test winkle
  powerpc/64s: use alternative feature patching
  powerpc/64s: fix POWER9 machine check handler from stop state
  powerpc/64s: use PACA_THREAD_IDLE_STATE only in POWER8
  powerpc/64s: idle expand usable core idle state bits
  powerpc/64s: idle do not hold reservation longer than required
  powerpc/64s: idle POWER8 avoid full state loss recovery when possible

 arch/powerpc/include/asm/cpuidle.h       |  32 +++++-
 arch/powerpc/include/asm/exception-64s.h |  13 +--
 arch/powerpc/include/asm/paca.h          |  12 +-
 arch/powerpc/include/asm/reg.h           |   1 +
 arch/powerpc/kernel/exceptions-64s.S     | 112 ++++++------------
 arch/powerpc/kernel/idle_book3s.S        | 189 ++++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/idle.c    |  13 ---
 7 files changed, 202 insertions(+), 170 deletions(-)

-- 
2.11.0
