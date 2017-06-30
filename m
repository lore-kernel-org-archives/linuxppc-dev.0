Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzGsl2R9QzDr5g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 10:01:46 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TNx6xC020694
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:01:44 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd4ar17ev-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:01:44 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 29 Jun 2017 20:01:43 -0400
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com,
 akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net,
 manfred@colorfullife.com, tj@kernel.org, arnd@arndb.de,
 linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org,
 stern@rowland.harvard.edu, parri.andrea@gmail.com,
 torvalds@linux-foundation.org,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH RFC 21/26] powerpc: Remove spin_unlock_wait() arch-specific
 definitions
Date: Thu, 29 Jun 2017 17:01:29 -0700
In-Reply-To: <20170629235918.GA6445@linux.vnet.ibm.com>
References: <20170629235918.GA6445@linux.vnet.ibm.com>
Message-Id: <1498780894-8253-21-git-send-email-paulmck@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no agreed-upon definition of spin_unlock_wait()'s semantics,
and it appears that all callers could do just as well with a lock/unlock
pair.  This commit therefore removes the underlying arch-specific
arch_spin_unlock_wait().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/powerpc/include/asm/spinlock.h | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 8c1b913de6d7..d256e448ea49 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -170,39 +170,6 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
 	lock->slock = 0;
 }
 
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	arch_spinlock_t lock_val;
-
-	smp_mb();
-
-	/*
-	 * Atomically load and store back the lock value (unchanged). This
-	 * ensures that our observation of the lock value is ordered with
-	 * respect to other lock operations.
-	 */
-	__asm__ __volatile__(
-"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
-"	stwcx. %0, 0, %2\n"
-"	bne- 1b\n"
-	: "=&r" (lock_val), "+m" (*lock)
-	: "r" (lock)
-	: "cr0", "xer");
-
-	if (arch_spin_value_unlocked(lock_val))
-		goto out;
-
-	while (lock->slock) {
-		HMT_low();
-		if (SHARED_PROCESSOR)
-			__spin_yield(lock);
-	}
-	HMT_medium();
-
-out:
-	smp_mb();
-}
-
 /*
  * Read-write spinlocks, allowing multiple readers
  * but only one writer.
-- 
2.5.2
