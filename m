Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB28F2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:16:59 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Mon, 19 Nov 2012 11:46:56 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAJ6Grea26935470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 11:46:53 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAJBinn7007718
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 22:44:50 +1100
Message-ID: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [RFC PATCH powerpc ] Protect smp_processor_id() in
 arch_spin_unlock_wait()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 19 Nov 2012 14:16:39 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch tries to disable preemption for using smp_processor_id() in arch_spin_unlock_wait(), 
to avoid following report:

[   17.279377] BUG: using smp_processor_id() in preemptible [00000000] code: autorun/1024
[   17.279407] caller is .arch_spin_unlock_wait+0x34/0x80
[   17.279415] Call Trace:
[   17.279423] [c00000000911fb30] [c000000000015230] .show_stack+0x70/0x1c0 (unreliable)
[   17.279441] [c00000000911fbe0] [c0000000003e13b0] .debug_smp_processor_id+0x110/0x130
[   17.279455] [c00000000911fc80] [c00000000004c2b4] .arch_spin_unlock_wait+0x34/0x80
[   17.279470] [c00000000911fd00] [c0000000000b0e50] .task_work_run+0x80/0x160
[   17.279482] [c00000000911fdb0] [c000000000018744] .do_notify_resume+0x94/0xa0
[   17.279495] [c00000000911fe30] [c000000000009d1c] .ret_from_except_lite+0x48/0x4c

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/lib/locks.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index bb7cfec..7a7c31b 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -72,8 +72,10 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
 	while (lock->slock) {
 		HMT_low();
+		preempt_disable();
 		if (SHARED_PROCESSOR)
 			__spin_yield(lock);
+		preempt_enable();
 	}
 	HMT_medium();
 }
-- 
1.7.9.5
