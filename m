Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryklZ2d8FzDrFc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:30 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6PEnXbM010880
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:28 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4nr7kq4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:53:28 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 26 Jul 2016 00:53:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 69A462CE802D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6PErMJb30867582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:22 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6PErLi9012743
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 00:53:22 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [RFC PATCH 9/9] powerpc: rewrite local_t using soft_irq
Date: Mon, 25 Jul 2016 20:22:22 +0530
In-Reply-To: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1469458342-26233-10-git-send-email-maddy@linux.vnet.ibm.com>
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

But this patch uses Benjamin Herrenschmidt suggestion of arch_local_irq_disable_var() to soft_disable
interrupts (including PMIs). After finishing the "op", arch_local_irq_restore()
called and correspondingly interrupts are replayed if any occured.

patch re-write the current local_* functions to use arch_local_irq_disbale.
Base flow for each function is

 {
	arch_local_irq_disable_var(2)
	load
	..
	store
	arch_local_irq_restore()
 }

Currently only asm/local.h has been rewrite, and also
the entire change is tested only in PPC64 (pseries guest)

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

Local_t		Without Patch		With Patch

_inc			28		8
_add			28		8
_read			3		3
_add_return		28		7

Tested the patch in a
 - pSeries LPAR (with perf record)

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 91 +++++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da91363864..afd3dabd92cb 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -14,24 +14,50 @@ typedef struct
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
+	flags = arch_local_irq_disable_var(2);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	add     %0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	arch_local_irq_restore(flags);
+}
+
+static __inline__ void local_sub(long i, local_t *l)
+{
+	long t;
+	unsigned long flags;
+
+	flags = arch_local_irq_disable_var(2);
+	__asm__ __volatile__(
+	PPC_LL" %0,0(%2)\n\
+	subf    %0,%1,%0\n"
+	PPC_STL" %0,0(%2)\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+	arch_local_irq_restore(flags);
+}
 
 static __inline__ long local_add_return(long a, local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	flags = arch_local_irq_disable_var(2);
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
+	arch_local_irq_restore(flags);
 
 	return t;
 }
@@ -41,16 +67,18 @@ static __inline__ long local_add_return(long a, local_t *l)
 static __inline__ long local_sub_return(long a, local_t *l)
 {
 	long t;
+	unsigned long flags;
+
+	flags = arch_local_irq_disable_var(2);
 
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
+	arch_local_irq_restore(flags);
 
 	return t;
 }
@@ -58,16 +86,17 @@ static __inline__ long local_sub_return(long a, local_t *l)
 static __inline__ long local_inc_return(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	flags = arch_local_irq_disable_var(2);
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
+	arch_local_irq_restore(flags);
 
 	return t;
 }
@@ -85,20 +114,24 @@ static __inline__ long local_inc_return(local_t *l)
 static __inline__ long local_dec_return(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	flags = arch_local_irq_disable_var(2);
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
+	arch_local_irq_restore(flags);
 
 	return t;
 }
 
+#define local_inc(l)	local_inc_return(l)
+#define local_dec(l)	local_dec_return(l)
+
 #define local_cmpxchg(l, o, n) \
 	(cmpxchg_local(&((l)->a.counter), (o), (n)))
 #define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
@@ -115,20 +148,21 @@ static __inline__ long local_dec_return(local_t *l)
 static __inline__ int local_add_unless(local_t *l, long a, long u)
 {
 	long t;
+	unsigned long flags;
 
+	flags = arch_local_irq_disable_var(2);
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
+	arch_local_irq_restore(flags);
 
 	return t != u;
 }
@@ -145,19 +179,20 @@ static __inline__ int local_add_unless(local_t *l, long a, long u)
 static __inline__ long local_dec_if_positive(local_t *l)
 {
 	long t;
+	unsigned long flags;
 
+	flags = arch_local_irq_disable_var(2);
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
+	arch_local_irq_restore(flags);
 
 	return t;
 }
-- 
2.7.4
