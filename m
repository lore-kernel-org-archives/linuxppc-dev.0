Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4rKZ1LbTzDvNY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:54 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S4Nu8d044330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:25:52 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bvc1sxpu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:25:52 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 14:25:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DFC502CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:46 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S4Pkr43801366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:46 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S4Pifd021854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:25:46 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM
Subject: [PATCH v6 05/11] s390/spinlock: Provide vcpu_is_preempted
Date: Fri, 28 Oct 2016 04:11:21 -0400
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Message-Id: <1477642287-24104-6-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christian Borntraeger <borntraeger@de.ibm.com>

this implements the s390 backend for commit
"kernel/sched: introduce vcpu preempted check interface"
by reworking the existing smp_vcpu_scheduled into
arch_vcpu_is_preempted. We can then also get rid of the
local cpu_is_preempted function by moving the
CIF_ENABLED_WAIT test into arch_vcpu_is_preempted.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/include/asm/spinlock.h |  8 ++++++++
 arch/s390/kernel/smp.c           |  9 +++++++--
 arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 7e9e09f..7ecd890 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -23,6 +23,14 @@ _raw_compare_and_swap(unsigned int *lock, unsigned int old, unsigned int new)
 	return __sync_bool_compare_and_swap(lock, old, new);
 }
 
+#ifndef CONFIG_SMP
+static inline bool arch_vcpu_is_preempted(int cpu) { return false; }
+#else
+bool arch_vcpu_is_preempted(int cpu);
+#endif
+
+#define vcpu_is_preempted arch_vcpu_is_preempted
+
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 35531fe..b988ed1 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -368,10 +368,15 @@ int smp_find_processor_id(u16 address)
 	return -1;
 }
 
-int smp_vcpu_scheduled(int cpu)
+bool arch_vcpu_is_preempted(int cpu)
 {
-	return pcpu_running(pcpu_devices + cpu);
+	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
+		return false;
+	if (pcpu_running(pcpu_devices + cpu))
+		return false;
+	return true;
 }
+EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
 void smp_yield_cpu(int cpu)
 {
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e5f50a7..e48a48e 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -37,15 +37,6 @@ static inline void _raw_compare_and_delay(unsigned int *lock, unsigned int old)
 	asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
 }
 
-static inline int cpu_is_preempted(int cpu)
-{
-	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
-		return 0;
-	if (smp_vcpu_scheduled(cpu))
-		return 0;
-	return 1;
-}
-
 void arch_spin_lock_wait(arch_spinlock_t *lp)
 {
 	unsigned int cpu = SPINLOCK_LOCKVAL;
@@ -62,7 +53,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
 			continue;
 		}
 		/* First iteration: check if the lock owner is running. */
-		if (first_diag && cpu_is_preempted(~owner)) {
+		if (first_diag && arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 			continue;
@@ -81,7 +72,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
 		 * yield the CPU unconditionally. For LPAR rely on the
 		 * sense running status.
 		 */
-		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
+		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 		}
@@ -108,7 +99,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, unsigned long flags)
 			continue;
 		}
 		/* Check if the lock owner is running. */
-		if (first_diag && cpu_is_preempted(~owner)) {
+		if (first_diag && arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 			continue;
@@ -127,7 +118,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, unsigned long flags)
 		 * yield the CPU unconditionally. For LPAR rely on the
 		 * sense running status.
 		 */
-		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
+		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 		}
@@ -165,7 +156,7 @@ void _raw_read_lock_wait(arch_rwlock_t *rw)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -211,7 +202,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw, unsigned int prev)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -241,7 +232,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -285,7 +276,7 @@ void arch_lock_relax(unsigned int cpu)
 {
 	if (!cpu)
 		return;
-	if (MACHINE_IS_LPAR && !cpu_is_preempted(~cpu))
+	if (MACHINE_IS_LPAR && !arch_vcpu_is_preempted(~cpu))
 		return;
 	smp_yield_cpu(~cpu);
 }
-- 
2.4.11
