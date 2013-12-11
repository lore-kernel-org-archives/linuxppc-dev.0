Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A109B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Dec 2013 08:59:23 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 11 Dec 2013 14:59:21 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 0FC811FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 14:58:57 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBBJvQYY64618548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 20:57:26 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rBBM2GHi016508
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 15:02:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v6 tip/core/locking 8/8] powerpc: Full barrier for
 smp_mb__after_unlock_lock()
Date: Wed, 11 Dec 2013 13:59:11 -0800
Message-Id: <1386799151-2219-8-git-send-email-paulmck@linux.vnet.ibm.com>
In-Reply-To: <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20131211215850.GA810@linux.vnet.ibm.com>
 <1386799151-2219-1-git-send-email-paulmck@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, laijs@cn.fujitsu.com, edumazet@google.com,
 peterz@infradead.org, fweisbec@gmail.com, josh@joshtriplett.org,
 rostedt@goodmis.org, oleg@redhat.com, dhowells@redhat.com, sbw@mit.edu,
 niv@us.ibm.com, mathieu.desnoyers@efficios.com, darren@dvhart.com,
 akpm@linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

The powerpc lock acquisition sequence is as follows:

	lwarx; cmpwi; bne; stwcx.; lwsync;

Lock release is as follows:

	lwsync; stw;

If CPU 0 does a store (say, x=1) then a lock release, and CPU 1 does a
lock acquisition then a load (say, r1=y), then there is no guarantee of
a full memory barrier between the store to 'x' and the load from 'y'.
To see this, suppose that CPUs 0 and 1 are hardware threads in the same
core that share a store buffer, and that CPU 2 is in some other core,
and that CPU 2 does the following:

	y = 1; sync; r2 = x;

If 'x' and 'y' are both initially zero, then the lock acquisition and
release sequences above can result in r1 and r2 both being equal to
zero, which could not happen if unlock+lock was a full barrier.

This commit therefore makes powerpc's smp_mb__after_unlock_lock() be a
full barrier.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/spinlock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 5f54a744dcc5..f6e78d63fb6a 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -28,6 +28,8 @@
 #include <asm/synch.h>
 #include <asm/ppc-opcode.h>
 
+#define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
+
 #define arch_spin_is_locked(x)		((x)->slock != 0)
 
 #ifdef CONFIG_PPC64
-- 
1.8.1.5
