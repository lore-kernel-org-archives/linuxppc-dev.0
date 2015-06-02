Return-Path: <tipbot@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414331A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 18:48:55 +1000 (AEST)
Date: Tue, 2 Jun 2015 00:52:07 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-a76ff6884bfedfafcbb0d9c84c7a6b6a546cba6d@git.kernel.org>
Cc: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/rcu] powerpc: Fix smp_mb__before_spinlock()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  a76ff6884bfedfafcbb0d9c84c7a6b6a546cba6d
Gitweb:     http://git.kernel.org/tip/a76ff6884bfedfafcbb0d9c84c7a6b6a546cba6d
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 1 Apr 2015 08:19:59 -0700
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Wed, 27 May 2015 12:58:01 -0700

powerpc: Fix smp_mb__before_spinlock()

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
index a3bf5be..1124f59 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -89,5 +89,6 @@ do {									\
 
 #define smp_mb__before_atomic()     smp_mb()
 #define smp_mb__after_atomic()      smp_mb()
+#define smp_mb__before_spinlock()   smp_mb()
 
 #endif /* _ASM_POWERPC_BARRIER_H */
