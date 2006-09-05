Return-Path: <SRS0+fdd23b9c115b88e530f5+1108+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAEE367BB3
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 14:53:24 +1000 (EST)
Subject: Re: [PATCH] Unwire set/get_robust_list
From: David Woodhouse <dwmw2@infradead.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17660.48525.873588.173047@cargo.ozlabs.ibm.com>
References: <jeodtvfn4x.fsf@sykes.suse.de>
	<1157409148.2473.209.camel@shinybook.infradead.org>
	<17660.48525.873588.173047@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 21:53:14 -0700
Message-Id: <1157431994.2413.6.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-05 at 09:58 +1000, Paul Mackerras wrote:
> Don't we need an access_ok() test in there?  Otherwise, looks fine to
> me. 

Oops, good point. Like this then...

Do we actually need the memory clobber, btw? We're not using this for
locking in kernel space.

[PATCH] Implement PowerPC futex_atomic_cmpxchg_inatomic().

The sys_[gs]et_robust_list() syscalls were wired up on PowerPC but 
didn't work correctly because futex_atomic_cmpxchg_inatomic() wasn't
implemented. Implement it, based on __cmpxchg_u32()

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

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
+        : "cc", "memory");
+
+        return prev;
 }
 
 #endif /* __KERNEL__ */

-- 
dwmw2
