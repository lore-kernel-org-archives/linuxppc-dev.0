Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B41161A1D90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 16:51:15 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 00:51:13 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2E7083E40048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:11 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E6oVIT42336410
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2015 23:50:32 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E6pAUq027061
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 00:51:10 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 0/8] perf: Implement group-read of events using txn
 interface
Date: Thu, 13 Aug 2015 23:49:33 -0700
Message-Id: <1439534981-7937-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unlike normal hardware PMCs, the 24x7 counters in Power8 are stored in
memory and accessed via a hypervisor call (HCALL).  A major aspect of the
HCALL is that it allows retireving _several_ counters at once (unlike
regular PMCs, which are read one at a time). By reading several counters
at once, we can get a more consistent snapshot of the system.

This patchset extends the transaction interface to accomplish submitting
several events to the PMU and have the PMU read them all at once. User is
expected to submit the set of events they want to read as an "event group".

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

Architectures/PMUs that don't need/implement PMU_TXN_READ type of transactions,
simply ignore the ->start_txn() and ->commit_txn() and continue to read the
counters one at a time in the ->read() call.

Compile/touch tested on x86. Need help testing on s390 and Sparc.

Thanks to Peter Zijlstra for his input/code.

Changelog[v5]
	- Invert the sibling-child loop nesting in perf-read-group (re-org
	  code and drop the patch that defined perf_event_aggregate()).

Changelog[v4]
	- Ensure all the transactions operations happen on the same CPU so PMUs
	  can use per-CPU buffers for the transaction.
	- Add lockdep assert and fix a locking issue in perf_read_group().

Changelog [v3]
	- Simple changes/reorg of patchset to split/rename functions
	- [Peter Zijlstra] Save the transaction flags in ->start_txn() and
	  drop the flags parameter from ->commit_txn() and ->cancel_txn().
	- [Peter Zijlstra] The nop txn interfaces don't need to disable/enable
	  PMU for PERF_PMU_TXN_READ transactions.

Changelog [v2]
        - Use the transaction interface unconditionally to avoid special-case
          code. Architectures/PMUs that don't need the READ transaction types
          simply ignore the ->start_txn() and ->commit_txn() calls.



Peter Zijlstra (2):
  perf: Add group reads to perf_event_read()
  perf: Invert perf_read_group() loops

Peter Zijlstra (Intel) (1):
  perf: Rename perf_event_read_{one,group}, perf_read_hw

Sukadev Bhattiprolu (5):
  perf: Add a flags parameter to pmu txn interfaces
  perf: Split perf_event_read() and perf_event_count()
  perf: Add return value for perf_event_read().
  Define PERF_PMU_TXN_READ interface
  powerpc/perf/hv-24x7: Use PMU_TXN_READ interface

 arch/powerpc/perf/core-book3s.c  |   25 ++++-
 arch/powerpc/perf/hv-24x7.c      |  166 +++++++++++++++++++++++++++++-
 arch/s390/kernel/perf_cpum_cf.c  |   24 ++++-
 arch/sparc/kernel/perf_event.c   |   19 +++-
 arch/x86/kernel/cpu/perf_event.c |   27 ++++-
 arch/x86/kernel/cpu/perf_event.h |    1 +
 include/linux/perf_event.h       |   15 ++-
 kernel/events/core.c             |  210 +++++++++++++++++++++++++++++---------
 8 files changed, 429 insertions(+), 58 deletions(-)

-- 
1.7.9.5
