Return-Path: <Yuri.Norov@cavium.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0046.outbound.protection.outlook.com [104.47.33.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408PwZ3VkyzF1wg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 04:51:42 +1100 (AEDT)
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
Subject: [PATCH 1/2] rcu: declare rcu_eqs_special_set() in public header
Date: Sun, 25 Mar 2018 20:50:03 +0300
Message-Id: <20180325175004.28162-2-ynorov@caviumnetworks.com>
In-Reply-To: <20180325175004.28162-1-ynorov@caviumnetworks.com>
References: <20180325175004.28162-1-ynorov@caviumnetworks.com>
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

rcu_eqs_special_set() is declared only in internal header
kernel/rcu/tree.h and stubbed in include/linux/rcutiny.h.

This patch declares rcu_eqs_special_set() in include/linux/rcutree.h, so
it can be used in non-rcu kernel code.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/rcutree.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index fd996cdf1833..448f20f27396 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -74,6 +74,7 @@ static inline void synchronize_rcu_bh_expedited(void)
 void rcu_barrier(void);
 void rcu_barrier_bh(void);
 void rcu_barrier_sched(void);
+bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
 unsigned long get_state_synchronize_sched(void);
-- 
2.14.1
