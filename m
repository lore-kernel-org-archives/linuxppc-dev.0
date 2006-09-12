Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17671.15625.76850.349526@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 09:04:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Unwire set/get_robust_list
In-Reply-To: <je8xkzfbx2.fsf@sykes.suse.de>
References: <jeodtvfn4x.fsf@sykes.suse.de>
	<1157409148.2473.209.camel@shinybook.infradead.org>
	<je8xkzfbx2.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> Thanks, sucessfully tested on 32bit (with the nptl testsuite of glibc).
> Will do some 64bit testing tomorrow.

Did you do that testing?  What was the result?

Could you test David's latest patch without the memory clobber?  For
reference, here it is.

Thanks,
Paul.

diff --git a/include/asm-powerpc/futex.h b/include/asm-powerpc/futex.h
index f1b3c00..936422e 100644
--- a/include/asm-powerpc/futex.h
+++ b/include/asm-powerpc/futex.h
@@ -84,7 +84,33 @@ static inline int futex_atomic_op_inuser
 static inline int
 futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 {
-	return -ENOSYS;
+	int prev;
+
+	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
+		return -EFAULT;
+
+        __asm__ __volatile__ (
+        LWSYNC_ON_SMP
+"1:     lwarx   %0,0,%2         # futex_atomic_cmpxchg_inatomic\n\
+        cmpw    0,%0,%3\n\
+        bne-    3f\n"
+        PPC405_ERR77(0,%2)
+"2:     stwcx.  %4,0,%2\n\
+        bne-    1b\n"
+        ISYNC_ON_SMP
+"3:	.section .fixup,\"ax\"\n\
+4:	li	%0,%5\n\
+	b	3b\n\
+	.previous\n\
+	.section __ex_table,\"a\"\n\
+	.align 3\n\
+	" PPC_LONG "1b,4b,2b,4b\n\
+	.previous" \
+        : "=&r" (prev), "+m" (*uaddr)
+        : "r" (uaddr), "r" (oldval), "r" (newval), "i" (-EFAULT)
+        : "cc");
+
+        return prev;
 }
 
 #endif /* __KERNEL__ */
