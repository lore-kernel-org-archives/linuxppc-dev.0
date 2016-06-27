Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdVWB1WgCzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 23:43:02 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5RDYEb4060437
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:00 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sp1np9f2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 09:43:00 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 27 Jun 2016 07:42:59 -0600
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
 mpe@ellerman.id.au, paulus@samba.org, benh@kernel.crashing.org,
 Waiman.Long@hpe.com, boqun.feng@gmail.com, will.deacon@arm.com,
 dave@stgolabs.net, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
Date: Mon, 27 Jun 2016 13:41:29 -0400
In-Reply-To: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to fix some holder preemption issues. Spinning at one
vcpu which is preempted is meaningless.

Kernel need such interfaces, So lets support it.

We also should suooprt both the shared and dedicated mode.
So add lppaca_dedicated_proc macro in lppaca.h

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h   |  6 ++++++
 arch/powerpc/include/asm/spinlock.h | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index d0a2a2f..0a263d3 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -111,12 +111,18 @@ extern struct lppaca lppaca[];
  * we will have to transition to something better.
  */
 #define LPPACA_OLD_SHARED_PROC		2
+#define LPPACA_OLD_DEDICATED_PROC      (1 << 6)
 
 static inline bool lppaca_shared_proc(struct lppaca *l)
 {
 	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
+static inline bool lppaca_dedicated_proc(struct lppaca *l)
+{
+	return !!(l->__old_status & LPPACA_OLD_DEDICATED_PROC);
+}
+
 /*
  * SLB shadow buffer structure as defined in the PAPR.  The save_area
  * contains adjacent ESID and VSID pairs for each shadowed SLB.  The
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 523673d..ae938ee 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -52,6 +52,21 @@
 #define SYNC_IO
 #endif
 
+/* For fixing some spinning issues in a guest.
+ * kernel would check if vcpu is preempted during a spin loop.
+ * we support that.
+ */
+#define arch_vcpu_is_preempted arch_vcpu_is_preempted
+static inline bool arch_vcpu_is_preempted(int cpu)
+{
+	struct lppaca *lp = &lppaca_of(cpu);
+
+	if (unlikely(!(lppaca_shared_proc(lp) ||
+			lppaca_dedicated_proc(lp))))
+		return false;
+	return !!(be32_to_cpu(lp->yield_count) & 1);
+}
+
 static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 {
 	return lock.slock == 0;
-- 
2.4.11
