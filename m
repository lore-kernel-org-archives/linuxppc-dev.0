Return-Path: <cody@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DF832C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 10:54:07 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 16 Jan 2014 16:54:04 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 333073E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 16:54:01 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0GLpb2E4915506
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 22:51:37 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0GNs0sx029742
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 16:54:01 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 0/8] Add support for PowerPC Hypervisor supplied performance
 counters
Date: Thu, 16 Jan 2014 15:53:46 -0800
Message-Id: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add basic pmus for 2 powerpc hypervisor interfaces to obtain
performance counters: gpci ("get performance counter info") and 24x7.

The counters supplied by these interfaces are continually counting and never
need to be (and cannot be) disabled or enabled. They additionally do not
generate any interrupts. This makes them in some regards similar to software
counters, and as a result their implimentation shares some common code (which
an initial patch exposes) with the sw counters.

There is ongoing work to support transactions for each of these pmus.

Cody P Schafer (8):
  perf: add PMU_RANGE_ATTR() helper for use by sw-like pmus
  perf core: export swevent hrtimer helpers
  powerpc: add hvcalls for 24x7 and gpci (get performance counter info)
  powerpc: add hv_gpci interface header
  powerpc: add 24x7 interface header
  powerpc/perf: add support for the hv gpci (get performance counter
    info) interface
  powerpc/perf: add support for the hv 24x7 interface
  powerpc/perf: add kconfig option for hypervisor provided counters

 arch/powerpc/include/asm/hv_24x7.h     | 239 ++++++++++++++++
 arch/powerpc/include/asm/hv_gpci.h     | 490 +++++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/hvcall.h      |   6 +-
 arch/powerpc/perf/Makefile             |   2 +
 arch/powerpc/perf/hv-24x7.c            | 354 ++++++++++++++++++++++++
 arch/powerpc/perf/hv-gpci.c            | 235 ++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |   6 +
 include/linux/perf_event.h             |  22 +-
 kernel/events/core.c                   |   8 +-
 9 files changed, 1356 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/asm/hv_24x7.h
 create mode 100644 arch/powerpc/include/asm/hv_gpci.h
 create mode 100644 arch/powerpc/perf/hv-24x7.c
 create mode 100644 arch/powerpc/perf/hv-gpci.c

-- 
1.8.5.2
