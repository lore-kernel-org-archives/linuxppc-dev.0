Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40E381A0DEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 17:06:00 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 1 May 2015 03:05:57 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 231196E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 02:57:43 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4175sk539256234
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 07:05:54 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4175qSs027349
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 May 2015 03:05:53 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC][PATCH 0/4] perf: Enable symbolic event names
Date: Fri,  1 May 2015 00:05:37 -0700
Message-Id: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement ability to specify Power PMU events by their symbolic event
names rather than raw codes. This approach pulls tables of the Power7
and Power8 PMU events into the perf source tree and uses these tables
to create aliases for the PMU events. With these aliases users can run:

	perf stat -e PM_1PLUS_PPC_CMPL:ku sleep 1
or
	perf stat -e cpu/PM_VSU_SINGLE/ sleep 1

This is an early POC patchset based on discussions with Jiri Olsa,
Michael Ellerman and Ingo Molnar. Lightly tested on Power7 and Power8.

Can other architectures can implement arch_get_events_table() and similarly 
use symoblic event names?

I am also assuming that if the header files like power8-events.h are
easily readable, we don't need the JSON files anymore?

TODO:
	- Maybe translate event names to lower-case?
	- Allow perf to process event descriptions (need Andi Kleen's patch)


Sukadev Bhattiprolu (4):
  perf: Create a table of Power7 PMU events
  perf: Create a table of Power8 PMU events
  perf/powerpc: Move mfspr and friends to header file
  perf: Create aliases for Power PMU events

 tools/perf/arch/powerpc/util/Build           |    2 +-
 tools/perf/arch/powerpc/util/header.c        |    9 +-
 tools/perf/arch/powerpc/util/header.h        |    9 +
 tools/perf/arch/powerpc/util/pmu-events.c    |   52 +
 tools/perf/arch/powerpc/util/pmu-events.h    |   17 +
 tools/perf/arch/powerpc/util/power7-events.h | 3315 +++++++++++++
 tools/perf/arch/powerpc/util/power8-events.h | 6408 ++++++++++++++++++++++++++
 tools/perf/util/pmu.c                        |   77 +
 tools/perf/util/pmu.h                        |   10 +
 9 files changed, 9890 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/util/header.h
 create mode 100644 tools/perf/arch/powerpc/util/pmu-events.c
 create mode 100644 tools/perf/arch/powerpc/util/pmu-events.h
 create mode 100644 tools/perf/arch/powerpc/util/power7-events.h
 create mode 100644 tools/perf/arch/powerpc/util/power8-events.h

-- 
1.7.9.5
