Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5147E1A09E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 23:18:58 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 27 Nov 2014 17:48:54 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id D85473940057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:48:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sARCJPDL63701178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:49:25 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sARCIniW013379
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 17:48:49 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [RFC PATCH 2/2]powerpc: rewrite local_* to use CR5 flag
Date: Thu, 27 Nov 2014 17:48:41 +0530
Message-Id: <1417090721-25298-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1417090721-25298-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, rusty@rustcorp.com.au,
 paulus@samba.org, anton@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch re-write the current local_* functions to CR5 based one.
Base flow for each function is 

{
	set cr5(eq)
	load
	..
	store
	clear cr5(eq)
}

Above set of instructions are followed by a fixup section which points
to the entry of the function incase of interrupt in the flow. If the 
interrupt happens to be after the store, we just continue to last 
instruction in that block. 

Currently only asm/local.h has been rewrite, and local64 is TODO.
Also the entire change is only for PPC64.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/local.h | 306 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 306 insertions(+)

diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
index b8da913..a26e5d3 100644
--- a/arch/powerpc/include/asm/local.h
+++ b/arch/powerpc/include/asm/local.h
@@ -11,6 +11,310 @@ typedef struct
 
 #define LOCAL_INIT(i)	{ ATOMIC_LONG_INIT(i) }
 
+#ifdef	CONFIG_PPC64
+
+static __inline__ long local_read(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:	crclr   22\n"
+"4:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,3b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (&(l->a.counter)));
+
+	return t;
+}
+
+static __inline__ void local_set(local_t *l, long i)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:"	PPC405_ERR77(0,%2)
+"4:"	PPC_STL" %0,0(%2)\n"
+"5:	crclr   22\n"
+"6:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,5b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (&(i)), "r" (&(l->a.counter)));
+}
+
+static __inline__ void local_add(long i, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%2)\n"
+"3:	add     %0,%1,%0\n"
+"4:"	PPC405_ERR77(0,%2)
+"5:"	PPC_STL" %0,0(%2)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+}
+
+static __inline__ void local_sub(long i, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%2)\n"
+"3:	subf    %0,%1,%0\n"
+"4:"	PPC405_ERR77(0,%2)
+"5:"	PPC_STL" %0,0(%2)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (i), "r" (&(l->a.counter)));
+}
+
+static __inline__ long local_add_return(long a, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%2)\n"
+"3:	add     %0,%1,%0\n"
+"4:"	PPC405_ERR77(0,%2)
+"5:"	PPC_STL "%0,0(%2)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+
+#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
+
+static __inline__ long local_sub_return(long a, local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%2)\n"
+"3:	subf    %0,%1,%0\n"
+"4:"	PPC405_ERR77(0,%2)
+"5:"	PPC_STL "%0,0(%2)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (a), "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+static __inline__ long local_inc_return(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:	addic   %0,%0,1\n"
+"4:"	PPC405_ERR77(0,%1)
+"5:"	PPC_STL "%0,0(%1)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "xer", "memory");
+
+	return t;
+}
+
+/*
+ * local_inc_and_test - increment and test
+ * @l: pointer of type local_t
+ *
+ * Atomically increments @l by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+#define local_inc_and_test(l) (local_inc_return(l) == 0)
+
+static __inline__ long local_dec_return(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset   22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:	addic   %0,%0,-1\n"
+"4:"	PPC405_ERR77(0,%1)
+"5:"	PPC_STL "%0,0(%1)\n"
+"6:	crclr   22\n"
+"7:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,6b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "xer", "memory");
+
+	return t;
+}
+
+#define local_inc(l)	local_inc_return(l)
+#define local_dec(l)	local_dec_return(l)
+
+#define local_cmpxchg(l, o, n) \
+	(cmpxchg_local(&((l)->a.counter), (o), (n)))
+#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
+
+/**
+ * local_add_unless - add unless the number is a given value
+ * @l: pointer of type local_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @l, so long as it was not @u.
+ * Returns non-zero if @l was not @u, and zero otherwise.
+ */
+static __inline__ int local_add_unless(local_t *l, long a, long u)
+{
+	long t;
+
+	__asm__ __volatile__ (
+"1:	crset 22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:	cmpw    0,%0,%3 \n"
+"4:	beq-    9f \n"
+"5:	add     %0,%2,%0 \n"
+"6:"	PPC405_ERR77(0,%1)
+"7:"	PPC_STL" %0,0(%1) \n"
+"8:	subf    %0,%2,%0 \n"
+"9:	crclr   22\n"
+"10:\n"
+"	.section __ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,1b\n"
+	PPC_LONG "7b,1b\n"
+	PPC_LONG "8b,8b\n"
+	PPC_LONG "9b,9b\n"
+"	.previous\n"
+	: "=&r" (t)
+	: "r" (&(l->a.counter)), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
+
+#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
+#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
+
+/*
+ * Atomically test *l and decrement if it is greater than 0.
+ * The function returns the old value of *l minus 1.
+ */
+static __inline__ long local_dec_if_positive(local_t *l)
+{
+	long t;
+
+	__asm__ __volatile__(
+"1:	crset 22\n"
+"2:"	PPC_LL" %0,0(%1)\n"
+"3:	cmpwi   %0,1\n"
+"4:	addi    %0,%0,-1\n"
+"5:	blt-    8f\n"
+"6:"	PPC405_ERR77(0,%1)
+"7:"	PPC_STL "%0,0(%1)\n"
+"8:	crclr   22\n"
+"9:\n"
+"	.section__ex_table,\"a\"\n"
+	PPC_LONG_ALIGN "\n"
+	PPC_LONG "2b,1b\n"
+	PPC_LONG "3b,1b\n"
+	PPC_LONG "4b,1b\n"
+	PPC_LONG "5b,1b\n"
+	PPC_LONG "6b,1b\n"
+	PPC_LONG "7b,1b\n"
+	PPC_LONG "8b,8b\n"
+"	.previous\n"
+	: "=&b" (t)
+	: "r" (&(l->a.counter))
+	: "cc", "memory");
+
+	return t;
+}
+
+#else
+
 #define local_read(l)	atomic_long_read(&(l)->a)
 #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
 
@@ -162,6 +466,8 @@ static __inline__ long local_dec_if_positive(local_t *l)
 	return t;
 }
 
+#endif
+
 /* Use these for per-cpu local_t variables: on some archs they are
  * much more efficient than these naive implementations.  Note they take
  * a variable, not an address.
-- 
1.9.1
