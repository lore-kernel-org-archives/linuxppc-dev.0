Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413dl71DFSzF0xv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 00:27:13 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5AENu92013006
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 10:27:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jguuw6hyu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 10:27:09 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 10 Jun 2018 15:27:08 +0100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 0/2] constraints for power9 l2/l3 bus events
Date: Sun, 10 Jun 2018 19:57:00 +0530
Message-Id: <1528640822-4800-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds constraints for power9 l2/l3 bus event.
In previous generation processors, both bus events and direct
events of performance monitoring unit can be individually
programmabled and monitored in PMCs.

But in Power9, L2/L3 bus events are always available as a
"bank" of events. To obtain the counts for any of the
l2/l3 bus events in a given bank, the user will have to
program PMC4 with corresponding l2/l3 bus event for that
bank.

Patch enforce two contraints incase of L2/L3 bus events.

1)Any L2/L3 event when programmed is also expected to program corresponding
PMC4 event from that group.
2)PMC4 event should always been programmed first due to group constraint
logic limitation

For ex. consider these L3 bus events

PM_L3_PF_ON_CHIP_MEM (0x460A0),
PM_L3_PF_MISS_L3 (0x160A0),
PM_L3_CO_MEM (0x260A0),
PM_L3_PF_ON_CHIP_CACHE (0x360A0),

1) This is an INVALID group for L3 Bus event monitoring,
since it is missing PMC4 event.
	perf stat -e "{r160A0,r260A0,r360A0}" < >

And this is a VALID group for L3 Bus events:
	perf stat -e "{r460A0,r160A0,r260A0,r360A0}" < >

2) This is an INVALID group for L3 Bus event monitoring,
since it is missing PMC4 event.
	perf stat -e "{r260A0,r360A0}" < >

And this is a VALID group for L3 Bus events:
	perf stat -e "{r460A0,r260A0,r360A0}" < >

3) This is an INVALID group for L3 Bus event monitoring,
since it is missing PMC4 event.
	perf stat -e "{r360A0}" < >

And this is a VALID group for L3 Bus events:
	perf stat -e "{r460A0,r360A0}" < >

Patch 2 of this series removes the l2 bus events added
to hw cache event array.

Madhavan Srinivasan (2):
  powerpc/perf: Add constraints for power9 l2/l3 bus events
  powerpc/perf: Remove l2 bus events from HW cache event array

 arch/powerpc/include/asm/perf_event_server.h |  2 ++
 arch/powerpc/perf/core-book3s.c              | 20 +++++++++++++++-----
 arch/powerpc/perf/isa207-common.c            | 28 ++++++++++++++++++----------
 arch/powerpc/perf/isa207-common.h            |  5 +++++
 arch/powerpc/perf/power9-pmu.c               | 10 ++++------
 5 files changed, 44 insertions(+), 21 deletions(-)

-- 
2.7.4
