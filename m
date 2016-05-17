Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r88fF46J0zDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 17:51:17 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Tue, 17 May 2016 13:21:11 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E65713940068
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:21:08 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4H7p8Tn39649308
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:21:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4H7p2HT018380
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 13:21:07 +0530
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, mnipxh@163.com, boqun.feng@gmail.com,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v2 5/6] pv-qspinlock: use cmpxchg_release in
 __pv_queued_spin_unlock
Date: Tue, 17 May 2016 15:49:46 +0800
Message-Id: <1463471387-5115-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1463471387-5115-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cmpxchg_release is lighter, we can gain a better performace then.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 kernel/locking/qspinlock_paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index a5b1248..2bbffe4 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -614,7 +614,7 @@ __visible void __pv_queued_spin_unlock(struct qspinlock *lock)
 	 * unhash. Otherwise it would be possible to have multiple @lock
 	 * entries, which would be BAD.
 	 */
-	locked = cmpxchg(&l->locked, _Q_LOCKED_VAL, 0);
+	locked = cmpxchg_release(&l->locked, _Q_LOCKED_VAL, 0);
 	if (likely(locked == _Q_LOCKED_VAL))
 		return;
 
-- 
1.9.1
