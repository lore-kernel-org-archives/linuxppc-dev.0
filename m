Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83AD31A024E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 14:43:14 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 27 May 2014 22:43:11 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id F2E221FF003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 22:43:07 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4S2dmjK9044470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 04:39:48 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4S4h7IQ010310
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 22:43:08 -0600
Subject: [PATCH 0/6] ppc, kvm,
 cpuidle: Allow offline and kvm standby threads to enter fastsleep
To: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 svaidyan@in.ibm.com, paulus@samba.org,
 srivatsa.bhat@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 28 May 2014 10:08:34 +0530
Message-ID: <20140528043703.15676.58580.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fast sleep is a deep idle state on Power8. The support for the state was
added in commit 0d94873011. Today the idle threads in the host can
potentially be put to fast sleep. But when we launch guests using kvm,
the secondary threads are required to be offline and the offline threads
are put to nap. Besides this case, when secondary threads are woken up
to run guests and eventually go idle or when the guest is killed, they
enter nap. So when the entire core goes idle in both the above scenarios,
the maximum power savings that we can obtain is as much as we can get from
napping the cpus. This patchset adds support in the above two cases
for the threads to enter fast sleep.
---

Srivatsa S. Bhat (6):
      powernv, cpuidle: Move the flags used for idle state discovery to powernv core
      powerpc, powernv, CPU hotplug: Put offline CPUs in Fast-Sleep instead of Nap
      KVM: PPC: Book3S HV: Enable CPUs to run guest after waking up from fast-sleep
      KVM: PPC: Book3S HV: Consolidate the idle-state enter sequence in KVM
      KVM: PPC: Book3S HV: Put KVM standby hwthreads to fast-sleep instead of nap
      ppc,book3s: Go back to same idle state after handling machine check interrupt


 arch/powerpc/include/asm/processor.h    |   12 ++++
 arch/powerpc/kernel/exceptions-64s.S    |   51 +++++++++------
 arch/powerpc/kernel/idle.c              |   52 ++++++++++++++++
 arch/powerpc/kernel/idle_power7.S       |    2 -
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  103 ++++++++++++++++++++++++-------
 arch/powerpc/platforms/powernv/smp.c    |   12 +++-
 drivers/cpuidle/cpuidle-powernv.c       |    7 +-
 7 files changed, 190 insertions(+), 49 deletions(-)
