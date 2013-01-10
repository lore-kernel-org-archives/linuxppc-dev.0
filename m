Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BABF72C0216
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 20:00:35 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Thu, 10 Jan 2013 14:29:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D1B681258051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 14:30:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0A90Q7u34406464
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 14:30:26 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0A90QDt026160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 20:00:28 +1100
Message-ID: <1357808418.10378.16.camel@ThinkPad-T5421.cn.ibm.com>
Subject: [PATCH powerpc ] Avoid debug_smp_processor_id() check in
 arch_spin_unlock_wait()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 10 Jan 2013 17:00:18 +0800
In-Reply-To: <1357797726.4838.89.camel@pasglop>
References: <1353305799.3694.9.camel@ThinkPad-T5421.cn.ibm.com>
 <1357797726.4838.89.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use local_paca directly in arch_spin_unlock_wait(), as all processors have the
same value for the field shared_proc, so we don't need care racy here.

Reported-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/lib/locks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index bb7cfec..850bea6 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -72,7 +72,7 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
 {
 	while (lock->slock) {
 		HMT_low();
-		if (SHARED_PROCESSOR)
+		if (local_paca->lppaca_ptr->shared_proc)
 			__spin_yield(lock);
 	}
 	HMT_medium();
-- 
1.7.9.5
