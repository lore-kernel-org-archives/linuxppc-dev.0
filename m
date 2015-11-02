Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 941131A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:25:02 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 2 Nov 2015 15:25:00 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 1635B6E8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 15:13:08 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA2KOuIe55115828
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 20:24:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA2KOubX027141
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Nov 2015 15:24:56 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] powerpc/perf: Export Power8 PMU events in sysfs
Date: Mon,  2 Nov 2015 12:22:21 -0800
Message-Id: <1446495745-24001-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For consistency with Power7, export Power8 PMU events in sysfs.
This would also allow users to specify the PMU events by name:

	perf stat -e 'cpu/PM_VSU1_FPSCR/' sleep 1

Sukadev Bhattiprolu (4):
  powerpc/perf: Remove PME_ prefix for power7 events
  powerpc/perf: Export Power8 generic and cache events in sysfs
  perf/powerpc: Rename some Power8 events
  powerpc/perf: Export all Power8 PMU events in sysfs

 arch/powerpc/include/asm/perf_event_server.h |    2 +-
 arch/powerpc/perf/power7-pmu.c               |   18 +-
 arch/powerpc/perf/power8-events-list.h       | 1077 ++++++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c               |   82 +-
 4 files changed, 1128 insertions(+), 51 deletions(-)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

-- 
2.5.3
