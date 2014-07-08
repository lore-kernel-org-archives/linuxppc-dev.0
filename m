Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FD8A1A002E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 16:38:37 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id bj1so6712327pad.23
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jul 2014 23:38:35 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH v2 0/3] POWER8 PMU bugfixes
Date: Tue,  8 Jul 2014 16:08:19 +0930
Message-Id: <1404801502-4663-1-git-send-email-joel@jms.id.au>
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

V2:
 Add comment from mpe

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
