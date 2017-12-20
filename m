Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gvS6RjvzF08Q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:57:08 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sZuM072870
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:57:05 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyecfm926-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:57:05 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:57:03 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 16/17] powerpc: use generic atomic implementation for
 local_t
Date: Wed, 20 Dec 2017 09:25:56 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-17-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc implements local_t with atomic operations. There is already
an asm-generic implementation which does this using atomic_t.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 171 +--------------------------------------
 1 file changed, 1 insertion(+), 170 deletions(-)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index 600a68bd77f5..cfbcc31d43ad 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -2,175 +2,6 @@
 #ifndef _ARCH_POWERPC_LOCAL_H
 #define _ARCH_POWERPC_LOCAL_H
 
-#include <linux/percpu.h>
-#include <linux/atomic.h>
-
-typedef struct
-{
-	atomic_long_t a;
-} local_t;
-
-#define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
-
-#define local_read(l)	atomic_long_read(&(l)->a)
-#define local_set(l,i)	atomic_long_set(&(l)->a, (i))
-
-#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
-#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
-#define local_inc(l)	atomic_long_inc(&(l)->a)
-#define local_dec(l)	atomic_long_dec(&(l)->a)
-
-static __inline__ long local_add_return(long a, local_t *l)
-{
-	long t;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%2,0) "			# local_add_return\n\
-	add	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t)
-	: "r" (a), "r" (&(l->a.counter))
-	: "cc", "memory");
-
-	return t;
-}
-
-#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
-
-static __inline__ long local_sub_return(long a, local_t *l)
-{
-	long t;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%2,0) "			# local_sub_return\n\
-	subf	%0,%1,%0\n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%2 \n\
-	bne-	1b"
-	: "=&r" (t)
-	: "r" (a), "r" (&(l->a.counter))
-	: "cc", "memory");
-
-	return t;
-}
-
-static __inline__ long local_inc_return(local_t *l)
-{
-	long t;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_inc_return\n\
-	addic	%0,%0,1\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1 \n\
-	bne-	1b"
-	: "=&r" (t)
-	: "r" (&(l->a.counter))
-	: "cc", "xer", "memory");
-
-	return t;
-}
-
-/*
- * local_inc_and_test - increment and test
- * @l: pointer of type local_t
- *
- * Atomically increments @l by 1
- * and returns true if the result is zero, or false for all
- * other cases.
- */
-#define local_inc_and_test(l) (local_inc_return(l) == 0)
-
-static __inline__ long local_dec_return(local_t *l)
-{
-	long t;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_return\n\
-	addic	%0,%0,-1\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1\n\
-	bne-	1b"
-	: "=&r" (t)
-	: "r" (&(l->a.counter))
-	: "cc", "xer", "memory");
-
-	return t;
-}
-
-#define local_cmpxchg(l, o, n) \
-	(cmpxchg_local(&((l)->a.counter), (o), (n)))
-#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
-
-/**
- * local_add_unless - add unless the number is a given value
- * @l: pointer of type local_t
- * @a: the amount to add to v...
- * @u: ...unless v is equal to u.
- *
- * Atomically adds @a to @l, so long as it was not @u.
- * Returns non-zero if @l was not @u, and zero otherwise.
- */
-static __inline__ int local_add_unless(local_t *l, long a, long u)
-{
-	long t;
-
-	__asm__ __volatile__ (
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_add_unless\n\
-	cmpw	0,%0,%3 \n\
-	beq-	2f \n\
-	add	%0,%2,%0 \n"
-	PPC405_ERR77(0,%2)
-	PPC_STLCX	"%0,0,%1 \n\
-	bne-	1b \n"
-"	subf	%0,%2,%0 \n\
-2:"
-	: "=&r" (t)
-	: "r" (&(l->a.counter)), "r" (a), "r" (u)
-	: "cc", "memory");
-
-	return t != u;
-}
-
-#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
-
-#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
-#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
-
-/*
- * Atomically test *l and decrement if it is greater than 0.
- * The function returns the old value of *l minus 1.
- */
-static __inline__ long local_dec_if_positive(local_t *l)
-{
-	long t;
-
-	__asm__ __volatile__(
-"1:"	PPC_LLARX(%0,0,%1,0) "			# local_dec_if_positive\n\
-	cmpwi	%0,1\n\
-	addi	%0,%0,-1\n\
-	blt-	2f\n"
-	PPC405_ERR77(0,%1)
-	PPC_STLCX	"%0,0,%1\n\
-	bne-	1b"
-	"\n\
-2:"	: "=&b" (t)
-	: "r" (&(l->a.counter))
-	: "cc", "memory");
-
-	return t;
-}
-
-/* Use these for per-cpu local_t variables: on some archs they are
- * much more efficient than these naive implementations.  Note they take
- * a variable, not an address.
- */
-
-#define __local_inc(l)		((l)->a.counter++)
-#define __local_dec(l)		((l)->a.counter++)
-#define __local_add(i,l)	((l)->a.counter+=(i))
-#define __local_sub(i,l)	((l)->a.counter-=(i))
+#include <asm-generic/local.h>
 
 #endif /* _ARCH_POWERPC_LOCAL_H */
-- 
2.7.4
