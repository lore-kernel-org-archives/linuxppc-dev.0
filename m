Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BD8B1A06EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 15:36:24 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Add smp_mb()s to arch_spin_unlock_wait()
Date: Thu,  7 Aug 2014 15:36:18 +1000
Message-Id: <1407389778-6793-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1407389778-6793-1-git-send-email-mpe@ellerman.id.au>
References: <1407389778-6793-1-git-send-email-mpe@ellerman.id.au>
Cc: paulmck@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to the previous commit which described why we need to add a
barrier to arch_spin_is_locked(), we have a similar problem with
spin_unlock_wait().

We need a barrier on entry to ensure any spinlock we have previously
taken is visibly locked prior to the load of lock->slock.

It's also not clear if spin_unlock_wait() is intended to have ACQUIRE
semantics. For now be conservative and add a barrier on exit to give it
ACQUIRE semantics.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/locks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 0c9c8d7d0734..170a0346f756 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -70,12 +70,16 @@ void __rw_yield(arch_rwlock_t *rw)
 
 void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
+	smp_mb();
+
 	while (lock->slock) {
 		HMT_low();
 		if (SHARED_PROCESSOR)
 			__spin_yield(lock);
 	}
 	HMT_medium();
+
+	smp_mb();
 }
 
 EXPORT_SYMBOL(arch_spin_unlock_wait);
-- 
1.9.1
