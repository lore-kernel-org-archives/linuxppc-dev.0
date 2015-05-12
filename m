Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 788981A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 07:46:01 +1000 (AEST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 12 May 2015 15:45:58 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D0D9E1FF0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 15:37:05 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t4CLjUxo41746456
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 14:45:30 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4CLjpob001764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 15:45:55 -0600
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH tip/core/rcu 09/15] powerpc: Fix smp_mb__before_spinlock()
Date: Tue, 12 May 2015 14:38:15 -0700
Message-Id: <1431466701-653-9-git-send-email-paulmck@linux.vnet.ibm.com>
In-Reply-To: <1431466701-653-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150512213756.GA32729@linux.vnet.ibm.com>
 <1431466701-653-1-git-send-email-paulmck@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, laijs@cn.fujitsu.com, bobby.prani@gmail.com,
 peterz@infradead.org, fweisbec@gmail.com, dvhart@linux.intel.com,
 josh@joshtriplett.org, rostedt@goodmis.org, oleg@redhat.com,
 dhowells@redhat.com, edumazet@google.com, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Currently, smp_mb__before_spinlock() is defined to be smp_wmb()
in core code, but this is not sufficient on PowerPC.  This patch
therefore supplies an override for the generic definition to
strengthen smp_mb__before_spinlock() to smp_mb(), as is needed
on PowerPC.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/include/asm/barrier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index a3bf5be111ff..1124f59b8df4 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -89,5 +89,6 @@ do {									\
 
 #define smp_mb__before_atomic()     smp_mb()
 #define smp_mb__after_atomic()      smp_mb()
+#define smp_mb__before_spinlock()   smp_mb()
 
 #endif /* _ASM_POWERPC_BARRIER_H */
-- 
1.8.1.5
