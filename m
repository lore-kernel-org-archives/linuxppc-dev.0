Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts43-srv.bellnexxia.net (tomts43.bellnexxia.net
	[209.226.175.110]) by ozlabs.org (Postfix) with ESMTP id 9C1FEDDECB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 11:17:20 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.205.181])
	by tomts43-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20061221001717.BXKC11361.tomts43-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 19:17:17 -0500
Date: Wed, 20 Dec 2006 19:12:04 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Christoph Hellwig <hch@infradead.org>, paulus@samba.org
Subject: [PATCH 7/9] atomic.h : powerpc
Message-ID: <20061221001204.GM28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061221000351.GF28643@Krystal>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

64 bits cmpxchg, xchg and add_unless for powerpc.


Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/include/asm-powerpc/atomic.h
+++ b/include/asm-powerpc/atomic.h
@@ -165,7 +165,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define atomic_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
 #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
 
 /**
@@ -411,6 +412,44 @@ static __inline__ long atomic64_dec_if_p
 	return t;
 }
 
+#define atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
+#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+
+/**
+ * atomic64_add_unless - add unless the number is a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as it was not @u.
+ * Returns non-zero if @v was not @u, and zero otherwise.
+ */
+static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
+{
+	long t;
+
+	__asm__ __volatile__ (
+	LWSYNC_ON_SMP
+"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
+	cmpd	0,%0,%3 \n\
+	beq-	2f \n\
+	add	%0,%2,%0 \n"
+	PPC405_ERR77(0,%2)
+"	stdcx.	%0,0,%1 \n\
+	bne-	1b \n"
+	ISYNC_ON_SMP
+"	subf	%0,%2,%0 \n\
+2:"
+	: "=&r" (t)
+	: "r" (&v->counter), "r" (a), "r" (u)
+	: "cc", "memory");
+
+	return t != u;
+}
+
+#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
+
 #endif /* __powerpc64__ */
 
 #include <asm-generic/atomic.h>

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
