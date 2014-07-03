Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FF7A1A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 16:12:50 +1000 (EST)
Received: by mail-pa0-f53.google.com with SMTP id ey11so13724604pad.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jul 2014 23:12:48 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 0/3] POWER8 PMU bugfixes
Date: Thu,  3 Jul 2014 15:42:33 +0930
Message-Id: <1404367956-19515-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These three patches are required for correct operation of perf counters on
POWER8 boxes when running KVM guests. There were two bugs; not clearing MMCR2
and writing over the saved value when entering a guest. However the first
obscured the second.

Thanks to who mpe helped diagnose the issue and pointed out the fix.

Joel Stanley (3):
  powerpc/kvm: Remove redundant save of SIER AND MMCR2
  powerpc/perf: Add PPMU_ARCH_207S define
  powerpc/perf: Clear MMCR2 when enabling PMU

 arch/powerpc/include/asm/perf_event_server.h | 3 +--
 arch/powerpc/kvm/book3s_hv_interrupts.S      | 5 -----
 arch/powerpc/perf/core-book3s.c              | 9 ++++++---
 arch/powerpc/perf/power8-pmu.c               | 2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.0.0
