Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0085.outbound.protection.outlook.com [104.47.32.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408PvJ3mbyzF1tX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 04:50:31 +1100 (AEDT)
From: Yury Norov <ynorov@caviumnetworks.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] smp: don't kick CPUs running idle or nohz_full tasks 
Date: Sun, 25 Mar 2018 20:50:02 +0300
Message-Id: <20180325175004.28162-1-ynorov@caviumnetworks.com>
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
them sync caches, TLB etc. It is is called only 3 times - from mm/slab,
arm64 and powerpc code.

With framework introduced in patch b8c17e6664c46 ("rcu: Maintain special
bits at bottom of ->dynticks counter") we can delay synchrosization work
for CPUs in extended quiescent state (idle or nohz_full userspace). 

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

For mm/slab and arm64 it looks safe to delay synchronization. This is done
in patch #2 by introducing kick_active_cpus_sync() function. For powerpc -
I'm not sure, and I'd like to ask powerpc people, is it safe to do same
also for that code? If so, we can completely drop kick_all_cpus_sync().

Yury Norov (2):
  rcu: declare rcu_eqs_special_set() in public header
  smp: introduce kick_active_cpus_sync()

 arch/arm64/kernel/insn.c |  2 +-
 include/linux/rcutree.h  |  1 +
 include/linux/smp.h      |  2 ++
 kernel/smp.c             | 24 ++++++++++++++++++++++++
 mm/slab.c                |  2 +-
 5 files changed, 29 insertions(+), 2 deletions(-)

-- 
2.14.1
