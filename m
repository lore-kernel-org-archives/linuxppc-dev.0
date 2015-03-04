Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C6471A08CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 19:35:54 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 4 Mar 2015 01:35:52 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3522738C8026
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 03:35:49 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t248ZnSP28901606
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 08:35:49 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t248ZlV9011087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Mar 2015 03:35:48 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 peterz@infradead.org
Subject: [PATCH 0/4] perf: Implement event group read using txn interface
Date: Wed,  4 Mar 2015 00:35:04 -0800
Message-Id: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unlike normal hardware PMCs, the 24x7 counters[1] in Power8 are stored in
memory and accessed via a hypervisor call (HCALL).  A major aspect of the
HCALL is that it allows retireving _SEVERAL_ counters at once (unlike
regular PMCs, which are read one at a time). By reading several counters
at once, we can get a more consistent snapshot of the system.

This patchset explores the possibility of using the transaction interface
to accomplish submitting several "events" to the PMU and have the PMU read
them all at once. User is expected to submit the set of events they want
to read as an "event group".

In the kernel, we submit each event to the PMU using the following logic
(from Peter Zijlstra).
	
	pmu->start_txn(pmu, PMU_TXN_READ);

	leader->read();
	for_each_sibling()
		sibling->read();
	pmu->commit_txn();

where:
	- the ->read()s queue events to be submitted to the hypervisor, and,
	- the ->commit_txn() issues the HCALL, retrieves the result and
	  updates the event count.

Since the ->commit_txn() updates the event count, perf subsystem can use
the event count directly and skip the a ->read() call immediately after
the transaction.

TODO: 
	- Lightly tested on Powerpc; Needs more testing on Power and x86.
	- Need to review/update txn and perf_event_read_value() interfaces
	  for other architectures.

Thanks to Peter Zijlstra for his input.

Sukadev Bhattiprolu (4):
  perf: Add 'flags' parameter to pmu txn interfaces
  perf: Split perf_event_read() and perf_event_count()
  perf: Add 'update' parameter to perf_event_read_value()
  perf/powerpc: Implement group_read() txn interface for 24x7 counters

 arch/powerpc/perf/core-book3s.c  |  15 +++-
 arch/powerpc/perf/hv-24x7.c      | 171 +++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/perf_event.c |  15 +++-
 arch/x86/kvm/pmu.c               |   2 +-
 include/linux/perf_event.h       |  17 +++-
 kernel/events/core.c             |  93 ++++++++++++++++-----
 6 files changed, 281 insertions(+), 32 deletions(-)

-- 
1.8.3.1
