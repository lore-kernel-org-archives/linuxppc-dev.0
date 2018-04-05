Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0047.outbound.protection.outlook.com [104.47.33.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H8g70zFVzF1rw
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 03:18:26 +1000 (AEST)
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Klimov <klimov.linux@gmail.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Date: Thu,  5 Apr 2018 20:17:55 +0300
Message-Id: <20180405171800.5648-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kick_all_cpus_sync() is used to broadcast IPIs to all online CPUs to force
them synchronize caches, TLB etc. It is called only 3 times - from mm/slab
arm64 and powerpc code.

We can delay synchronization work for CPUs in extended quiescent state
(idle or nohz_full userspace). 

As Paul E. McKenney wrote: 

--

Currently, IPIs are used to force other CPUs to invalidate their TLBs
in response to a kernel virtual-memory mapping change.  This works, but 
degrades both battery lifetime (for idle CPUs) and real-time response
(for nohz_full CPUs), and in addition results in unnecessary IPIs due to
the fact that CPUs executing in usermode are unaffected by stale kernel
mappings.  It would be better to cause a CPU executing in usermode to
wait until it is entering kernel mode to do the flush, first to avoid
interrupting usemode tasks and second to handle multiple flush requests
with a single flush in the case of a long-running user task.

--

v2 is big rework to address comments in v1:
 - rcu_eqs_special() declaration in public header is dropped, it is not
   used in new implementation. Though, I hope Paul will pick it in his
   tree;
 - for arm64, few isb() added to ensure kernel text synchronization
   (patches 1-4);
 - rcu_get_eqs_cpus() introduced and used to mask EQS CPUs before 
   generating broadcast IPIs;
 - RCU_DYNTICK_CTRL_MASK is not touched because memory barrier is
   implicitly issued in EQS exit path;
 - powerpc is not an exception anymore. I think it's safe to delay
   synchronization for it as well, and I didn't get comments from ppc
   community.
v1:
  https://lkml.org/lkml/2018/3/25/109

Based on next-20180405

Yury Norov (5):
  arm64: entry: isb in el1_irq
  arm64: entry: introduce restore_syscall_args macro
  arm64: ISB early at exit from extended quiescent state
  rcu: arm64: add rcu_dynticks_eqs_exit_sync()
  smp: Lazy synchronization for EQS CPUs in kick_all_cpus_sync()

 arch/arm64/kernel/Makefile  |  2 ++
 arch/arm64/kernel/entry.S   | 52 +++++++++++++++++++++++++++++++--------------
 arch/arm64/kernel/process.c |  7 ++++++
 arch/arm64/kernel/rcu.c     |  8 +++++++
 include/linux/rcutiny.h     |  2 ++
 include/linux/rcutree.h     |  1 +
 kernel/rcu/tiny.c           |  9 ++++++++
 kernel/rcu/tree.c           | 27 +++++++++++++++++++++++
 kernel/smp.c                | 21 +++++++++++-------
 9 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/kernel/rcu.c

-- 
2.14.1
