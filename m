Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B7AB1A002D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 16:12:57 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kq14so13856593pab.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jul 2014 23:12:55 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: paulus@samba.org,
	benh@kernel.crashing.org,
	mpe@ellerman.id.au
Subject: [PATCH 3/3] powerpc/perf: Clear MMCR2 when enabling PMU
Date: Thu,  3 Jul 2014 15:42:36 +0930
Message-Id: <1404367956-19515-4-git-send-email-joel@jms.id.au>
In-Reply-To: <1404367956-19515-1-git-send-email-joel@jms.id.au>
References: <1404367956-19515-1-git-send-email-joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER8 when switching to a KVM guest we set bits in MMCR2 to freeze
the PMU counters. Aside from on boot they are then never reset,
resulting in stuck perf counters for any user in the guest or host.

We now set MMCR2 to 0 whenever enabling the PMU, which provides a sane
state for perf to use the PMU counters under either the guest or the
host.

This was manifesting as a bug with ppc64_cpu --frequency:

    $ sudo ppc64_cpu --frequency
    WARNING: couldn't run on cpu 0
    WARNING: couldn't run on cpu 8
      ...
    WARNING: couldn't run on cpu 144
    WARNING: couldn't run on cpu 152
    min:    18446744073.710 GHz (cpu -1)
    max:    0.000 GHz (cpu -1)
    avg:    0.000 GHz

The command uses a perf counter to measure CPU cycles over a fixed
amount of time, in order to approximate the frequency of the machine.
The counters were returning zero once a guest was started, regardless of
weather it was still running or had been shut down.

By dumping the value of MMCR2, it was observed that once a guest is
running MMCR2 is set to 1s - which stops counters from running:

    $ sudo sh -c 'echo p > /proc/sysrq-trigger'
    CPU: 0 PMU registers, ppmu = POWER8 n_counters = 6
    PMC1:  5b635e38 PMC2: 00000000 PMC3: 00000000 PMC4: 00000000
    PMC5:  1bf5a646 PMC6: 5793d378 PMC7: deadbeef PMC8: deadbeef
    MMCR0: 0000000080000000 MMCR1: 000000001e000000 MMCRA: 0000040000000000
    MMCR2: fffffffffffffc00 EBBHR: 0000000000000000
    EBBRR: 0000000000000000 BESCR: 0000000000000000
    SIAR:  00000000000a51cc SDAR:  c00000000fc40000 SIER:  0000000001000000

This is done unconditionally in book3s_hv_interrupts.S upon entering the
guest, and the original value is only save/restored if the host has
indicated it was using the PMU. This is okay, however the user of the
PMU needs to ensure that it is in a defined state when it starts using
it.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/perf/core-book3s.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a2ff1bd..bae697c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1300,6 +1300,9 @@ static void power_pmu_enable(struct pmu *pmu)
 
 	write_mmcr0(cpuhw, mmcr0);
 
+	if (ppmu->flags & PPMU_ARCH_207S)
+		mtspr(SPRN_MMCR2, 0);
+
 	/*
 	 * Enable instruction sampling if necessary
 	 */
-- 
2.0.0
