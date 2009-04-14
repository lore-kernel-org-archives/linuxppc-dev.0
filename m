Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38AD0DE08A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 10:09:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18915.54309.632699.346771@cargo.ozlabs.ibm.com>
Date: Tue, 14 Apr 2009 10:09:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix bug in __futex_atomic_op
Cc: Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Richard Henderson pointed out that the powerpc __futex_atomic_op has a
bug: it will write the wrong value if the stwcx. fails and it has to
retry the lwarx/stwcx. loop, since 'oparg' will have been overwritten
by the result from the first time around the loop.  This happens
because it uses the same register for 'oparg' (an input) as it uses
for the result.

This fixes it by using separate registers for 'oparg' and 'ret'.

Cc: stable@kernel.org
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
Can anyone see any reason why the FUTEX_OP_SET case can't just do a
__put_user?

diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index 6d406c5..9696cc3 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -27,7 +27,7 @@
 	PPC_LONG "1b,4b,2b,4b\n" \
 	".previous" \
 	: "=&r" (oldval), "=&r" (ret) \
-	: "b" (uaddr), "i" (-EFAULT), "1" (oparg) \
+	: "b" (uaddr), "i" (-EFAULT), "r" (oparg) \
 	: "cr0", "memory")
 
 static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
@@ -47,19 +47,19 @@ static inline int futex_atomic_op_inuser (int encoded_op, int __user *uaddr)
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("mr %1,%4\n", ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("add %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("add %1,%0,%4\n", ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("or %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("or %1,%0,%4\n", ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("andc %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("andc %1,%0,%4\n", ret, oldval, uaddr, oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("xor %1,%0,%1\n", ret, oldval, uaddr, oparg);
+		__futex_atomic_op("xor %1,%0,%4\n", ret, oldval, uaddr, oparg);
 		break;
 	default:
 		ret = -ENOSYS;
