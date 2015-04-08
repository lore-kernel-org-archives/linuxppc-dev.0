Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D62D31A0AAA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 10:35:12 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Apr 2015 20:35:09 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 8D07D6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 20:26:55 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t380Z5gj32178278
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Apr 2015 00:35:05 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t380Z54L016469
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 20:35:05 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 peterz@infradead.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 0/5] perf: Implement event group read using txn interface
Date: Tue,  7 Apr 2015 17:34:54 -0700
Message-Id: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Thanks to Peter Zijlstra for his input.

Changelog [v2]
	- Use the transaction interface unconditionally to avoid special-case
	  code. Architectures/PMUs that don't need the READ transaction types
	  simply ignore the ->start_txn() and ->commit_txn() calls.

Sukadev Bhattiprolu (5):
  perf: Add a flags parameter to pmu txn interfaces
  perf: Split perf_event_read() and perf_event_count()
  perf: Rename perf_event_read_value to perf_event_compute_values
  perf: Define PMU_TXN_READ interface
  powerpc/perf/hv-24x7: Use PMU_TXN_READ interface

 arch/powerpc/perf/core-book3s.c  |   16 +++-
 arch/powerpc/perf/hv-24x7.c      |  165 ++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/perf_cpum_cf.c  |   15 +++-
 arch/sparc/kernel/perf_event.c   |   15 +++-
 arch/x86/kernel/cpu/perf_event.c |   15 +++-
 arch/x86/kvm/pmu.c               |    6 +-
 include/linux/perf_event.h       |   17 +++-
 kernel/events/core.c             |   83 ++++++++++++++-----
 8 files changed, 292 insertions(+), 40 deletions(-)

-- 
1.7.9.5
