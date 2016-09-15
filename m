Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZdr05KZ0zDsYn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:56 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FCxMm0084607
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 09:02:54 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25ftr6w15s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 09:02:54 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 23:02:50 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 726312CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:48 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FD2mh61573326
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:48 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FD2lv6032084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 23:02:48 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au
Cc: anton@samba.org, paulus@samba.org, npiggin@gmail.com,
 linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 13/13] powerpc: rewrite local_t using soft_irq
Date: Thu, 15 Sep 2016 18:32:03 +0530
In-Reply-To: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1473944523-624-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Local atomic operations are fast and highly reentrant per CPU counters.
Used for percpu variable updates. Local atomic operations only guarantee
variable modification atomicity wrt the CPU which owns the data and
these needs to be executed in a preemption safe way.

Here is the design of this patch. Since local_* operations
are only need to be atomic to interrupts (IIUC), we have two options.
Either replay the "op" if interrupted or replay the interrupt after
the "op". Initial patchset posted was based on implementing local_* operation
based on CR5 which replay's the "op". Patchset had issues in case of
rewinding the address pointor from an array. This make the slow patch
really slow. Since CR5 based implementation proposed using __ex_table to find
the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.

https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html

But this patch uses, local_irq_pmu_save to soft_disable
interrupts (including PMIs). After finishing the "op", local_irq_pmu_restore()
called and correspondingly interrupts are replayed if any occured.

patch re-write the current local_* functions to use arch_local_irq_disbale.
Base flow for each function is

{
	local_irq_pmu_save(flags)
	load
	..
	store
	local_irq_pmu_restore(flags)
}

Reason for the approach is that, currently l[w/d]arx/st[w/d]cx.
instruction pair is used for local_* operations, which are heavy
on cycle count and they dont support a local variant. So to
see whether the new implementation helps, used a modified
version of Rusty's benchmark code on local_t.

https://lkml.org/lkml/2008/12/16/450

Modifications to Rusty's benchmark code:
- Executed only local_t test

Here are the values with the patch.

Time in ns per iteration

Local_t             Without Patch           With Patch

_inc                        28              8
_add                        28              8
_read                       3               3
_add_return         28              7

Currently only asm/local.h has been rewrite, and also
the entire change is tested only in PPC64 (pseries guest)
and PPC64 host (LE)

TODO:
	- local_cmpxchg and local_xchg needs modification.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 94 ++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da91363864..fb5728abb4e9 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -3,6 +3,9 @@
 
 #include <linux/percpu.h>
 #include <linux/atomic.h>
+#include <linux/irqflags.h>
+
+#include <asm/hw_irq.h>
 
 typedef struct
 {
@@ -14,24 +17,50 @@ typedef struct
 #define local_read(l)	atomic_long_read(&(l)->a)
 #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
 
-#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
-#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
-#define local_inc(l)	atomic_long_inc(&(l)->a)
-#define local_dec(l)	atomic_long_dec(&(l)->a)
+static __inline__ void local_add(long i, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	add     %0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	local_irq_pmu_restore(flags);
+}
+
+static __inline__ void local_sub(long i, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	local_irq_pmu_save(flags);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	subf    %0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	local_irq_pmu_restore(flags);
+}
 
 static __inline__ long local_add_return(long a, local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	local_irq_pmu_save(flags);
 	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%2,0) "			# local_add_return\n\
+	PPC_LL" %0,0(%2)\n\
 	add	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%2 \n\
-	bne-	1b"
+	PPC_STL	"%0,0(%2)\n"
 	: "=&r" (t)
 	: "r" (a), "r" (&(l->a.counter))
 	: "cc", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -41,16 +70,18 @@ static __inline__ long local_add_return(long a, local_t *l)
 static __inline__ long local_sub_return(long a, local_t *l)
 {
 	long t;
+	unsigned long flags;
+
+	local_irq_pmu_save(flags);
 
 	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%2,0) "			# local_sub_return\n\
+"1:"	PPC_LL" %0,0(%2)\n\
 	subf	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%2 \n\
-	bne-	1b"
+	PPC_STL	"%0,0(%2)\n"
 	: "=&r" (t)
 	: "r" (a), "r" (&(l->a.counter))
 	: "cc", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -58,16 +89,17 @@ static __inline__ long local_sub_return(long a, local_t *l)
 static __inline__ long local_inc_return(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	local_irq_pmu_save(flags);
 	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_inc_return\n\
+"1:"	PPC_LL" %0,0(%1)\n\
 	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1 \n\
-	bne-	1b"
+	PPC_STL "%0,0(%1)\n"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
 	: "cc", "xer", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t;
 }
@@ -85,20 +117,24 @@ static __inline__ long local_inc_return(local_t *l)
 static __inline__ long local_dec_return(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	local_irq_pmu_save(flags);
 	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_return\n\
+	PPC_LL" %0,0(%1)\n\
 	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1\n\
-	bne-	1b"
+	PPC_STL "%0,0(%1)\n"
 	: "=&r" (t)
 	: "r" (&(l->a.counter))
 	: "cc", "xer", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t;
 }
 
+#define local_inc(l)	local_inc_return(l)
+#define local_dec(l)	local_dec_return(l)
+
 #define local_cmpxchg(l, o, n) \
 	(cmpxchg_local(&((l)->a.counter), (o), (n)))
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
@@ -115,20 +151,21 @@ static __inline__ long local_dec_return(local_t *l)
 static __inline__ int local_add_unless(local_t *l, long a, long u)
 {
 	long t;
+	unsigned long flags;
 
+	local_irq_pmu_save(flags);
 	__asm__ __volatile__ (
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_add_unless\n\
+	PPC_LL" %0,0(%1)\n\
 	cmpw	0,%0,%3 \n\
 	beq-	2f \n\
 	add	%0,%2,%0 \n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%1 \n\
-	bne-	1b \n"
+	PPC_STL" %0,0(%1) \n"
 "	subf	%0,%2,%0 \n\
 2:"
 	: "=&r" (t)
 	: "r" (&(l->a.counter)), "r" (a), "r" (u)
 	: "cc", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t != u;
 }
@@ -145,19 +182,20 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 static __inline__ long local_dec_if_positive(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	local_irq_pmu_save(flags);
 	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_if_positive\n\
+	PPC_LL" %0,0(%1)\n\
 	cmpwi	%0,1\n\
 	addi	%0,%0,-1\n\
 	blt-	2f\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1\n\
-	bne-	1b"
+	PPC_STL "%0,0(%1)\n"
 	"\n\
 2:"	: "=&b" (t)
 	: "r" (&(l->a.counter))
 	: "cc", "memory");
+	local_irq_pmu_restore(flags);
 
 	return t;
 }
-- 
2.7.4
